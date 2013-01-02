From: laurent.cans@gmail.com (Laurent CANS)
Date: Wed, 2 Jan 2013 09:41:12 +0100
Subject: [PATCH] Add apf51 basic support
In-Reply-To: <20121219203936.GG26326@pengutronix.de>
References: <1355694591-7084-1-git-send-email-laurent.cans@gmail.com>
 <20121219203936.GG26326@pengutronix.de>
Message-ID: <CAA1eMkEoaJ14WOjciCD-zN4BqPEZ=14M_U7DSqxRoRA0XPLh0g@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

2012/12/19 Sascha Hauer <s.hauer@pengutronix.de>:
> On Sun, Dec 16, 2012 at 10:49:51PM +0100, Laurent Cans wrote:
>> Signed-off-by: Laurent Cans <laurent.cans@gmail.com>
>> Signed-off-by: Gwenhael Goavec-Merou <gwenhael.goavec-merou@armadeus.com>
>> ---
>> +     clocks {
>> +             #address-cells = <1>;
>> +             #size-cells = <0>;
>> +
>> +             ckih1 {
>> +                     compatible = "fsl,imx-ckih1", "fixed-clock";
>> +                     clock-frequency = <0>;
>> +             };
>> +
>> +             osc {
>> +                     compatible = "fsl,imx-osc", "fixed-clock";
>> +                     clock-frequency = <33554432>;
>> +             };
>
> These compatible properties shouldn't be necessary, right?

Yes you are right. I will correct that.

>
>> +     };
>> +     soc {
>> +             aips at 70000000 { /* aips-1 */
>> +                     spba at 70000000 {
>> +                             uart3: serial at 7000c000 {
>> +                                     pinctrl-names = "default";
>> +                                     pinctrl-0 = <&pinctrl_uart3_2>;
>> +                                     status = "okay";
>> +                             };
>> +                     };
>> +             };
>
> This (and the other nodes) can more eaasily be written as:
>
> &uart3 {
>         ...
> };
>
> see arch/arm/boot/dts/omap5-evm.dts for a good example.
>
> This has the advantage that you don't have to resemble the SoC layout
> in your board file.

I will send v2 version of the patch during the week written with this
new layout.

Thanks for the comments

>
> Sascha
>
> --
> Pengutronix e.K.                           |                             |
> Industrial Linux Solutions                 | http://www.pengutronix.de/  |
> Peiner Str. 6-8, 31137 Hildesheim, Germany | Phone: +49-5121-206917-0    |
> Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-5555 |
