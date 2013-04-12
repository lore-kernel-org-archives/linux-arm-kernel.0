From: rpimentel.silva@gmail.com (Rogerio Pimentel)
Date: Fri, 12 Apr 2013 15:49:09 -0300
Subject: [PATCH v2 3/4] ARM: dts: mx53qsb: Add support for parallel display
In-Reply-To: <1365520643.4023.52.camel@pizza.hi.pengutronix.de>
References: <1365516452-1287-1-git-send-email-rogerio.pimentel@freescale.com>
 <1365516452-1287-3-git-send-email-rogerio.pimentel@freescale.com>
 <1365520643.4023.52.camel@pizza.hi.pengutronix.de>
Message-ID: <CAOkaPuV2xNR=Vxsa6tPdnPS34Q5ffV9-f8DefhcJfvVvXWOADQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Apr 9, 2013 at 12:17 PM, Philipp Zabel <p.zabel@pengutronix.de> wrote:
> Am Dienstag, den 09.04.2013, 11:07 -0300 schrieb Rogerio Pimentel:
>> Add support for CLAA WVGA display for i.MX53 QSB.
>>
>> Signed-off-by: Rogerio Pimentel <rogerio.pimentel@freescale.com>
>> ---
>> Changes since v1:
>> Changed the label disp1 to disp0 to correctly match the display pins
>>  arch/arm/boot/dts/imx53-qsb.dtsp |   26 ++++++++++++++++++++++++++
>>  arch/arm/boot/dts/imx53.dtsip    |   35 +++++++++++++++++++++++++++++++++++
>>  2 files changed, 61 insertions(+)
>>
>> diff --git a/arch/arm/boot/dts/imx53-qsb.dtsp b/arch/arm/boot/dts/imx53-qsb.dtsp
>> index dae8d9f..6086a3c 100644
>> --- a/arch/arm/boot/dts/imx53-qsb.dtsp
>> +++ b/arch/arm/boot/dts/imx53-qsb.dtsp
>> @@ -21,6 +21,32 @@
>>               reg = <0x70000000 0x40000000>;
>>       };
>>
>> +     display at di0 {
>> +             compatible = "fsl,imx-parallel-display";
>> +             crtcs = <&ipu 0>;
>> +             interface-pix-fmt = "rgb565";
>> +             pinctrl-names = "default";
>> +             pinctrl-0 = <&pinctrl_ipu_disp0_1>;
>> +             display-timings {
>> +                     claawvga {
>> +                             native-mode;
>> +                             clock-frequency = <27000000>;
>> +                             hactive = <800>;
>> +                             vactive = <480>;
>> +                             hback-porch = <40>;
>> +                             hfront-porch = <60>;
>> +                             vback-porch = <10>;
>> +                             vfront-porch = <10>;
>> +                             hsync-len = <20>;
>> +                             vsync-len = <10>;
>> +                             hsync-active = <0>;
>> +                             vsync-active = <0>;
>> +                             de-active = <1>;
>> +                             pixelclk-active = <0>;
>> +                     };
>> +             };
>> +     };
>> +
>
> This clashes with the MCIMXHDMICARD daughter module, which has a sii902x
> HDMI encoder connected to DISP0 for i.MX53-QSB. Would it make sense to
> add all possible options to the device tree but mark them with
> status = "disabled" by default?
>
> regards
> Philipp
>
I'm planning to add support for MCIMXHDMICARD later because it will also
require support for sii902x. I'd like to add the parallel display that
we have available
today and after that add the support for sii902x. What do you think?

Rgds
Rogerio
>>       gpio-keys {
>>               compatible = "gpio-keys";
>>
>> diff --git a/arch/arm/boot/dts/imx53.dtsip b/arch/arm/boot/dts/imx53.dtsip
>> index 845982e..a5f9d68 100644
>> --- a/arch/arm/boot/dts/imx53.dtsip
>> +++ b/arch/arm/boot/dts/imx53.dtsip
>> @@ -444,6 +444,41 @@
>>                                       };
>>                               };
>>
>> +                             ipu_disp0 {
>> +                                     pinctrl_ipu_disp0_1: ipudisp0grp-1 {
>> +                                             fsl,pins = <
>> +                                             MX53_PAD_DI0_DISP_CLK__IPU_DI0_DISP_CLK 0x5
>> +                                             MX53_PAD_DI0_PIN15__IPU_DI0_PIN15 0x5
>> +                                             MX53_PAD_DI0_PIN2__IPU_DI0_PIN2 0x5
>> +                                             MX53_PAD_DI0_PIN3__IPU_DI0_PIN3  0x5
>> +                                             MX53_PAD_DISP0_DAT0__IPU_DISP0_DAT_0 0x5
>> +                                             MX53_PAD_DISP0_DAT1__IPU_DISP0_DAT_1 0x5
>> +                                             MX53_PAD_DISP0_DAT2__IPU_DISP0_DAT_2 0x5
>> +                                             MX53_PAD_DISP0_DAT3__IPU_DISP0_DAT_3 0x5
>> +                                             MX53_PAD_DISP0_DAT4__IPU_DISP0_DAT_4 0x5
>> +                                             MX53_PAD_DISP0_DAT5__IPU_DISP0_DAT_5 0x5
>> +                                             MX53_PAD_DISP0_DAT6__IPU_DISP0_DAT_6 0x5
>> +                                             MX53_PAD_DISP0_DAT7__IPU_DISP0_DAT_7 0x5
>> +                                             MX53_PAD_DISP0_DAT8__IPU_DISP0_DAT_8 0x5
>> +                                             MX53_PAD_DISP0_DAT9__IPU_DISP0_DAT_9 0x5
>> +                                             MX53_PAD_DISP0_DAT10__IPU_DISP0_DAT_10 0x5
>> +                                             MX53_PAD_DISP0_DAT11__IPU_DISP0_DAT_11 0x5
>> +                                             MX53_PAD_DISP0_DAT12__IPU_DISP0_DAT_12 0x5
>> +                                             MX53_PAD_DISP0_DAT13__IPU_DISP0_DAT_13 0x5
>> +                                             MX53_PAD_DISP0_DAT14__IPU_DISP0_DAT_14 0x5
>> +                                             MX53_PAD_DISP0_DAT15__IPU_DISP0_DAT_15 0x5
>> +                                             MX53_PAD_DISP0_DAT16__IPU_DISP0_DAT_16 0x5
>> +                                             MX53_PAD_DISP0_DAT17__IPU_DISP0_DAT_17 0x5
>> +                                             MX53_PAD_DISP0_DAT18__IPU_DISP0_DAT_18 0x5
>> +                                             MX53_PAD_DISP0_DAT19__IPU_DISP0_DAT_19 0x5
>> +                                             MX53_PAD_DISP0_DAT20__IPU_DISP0_DAT_20 0x5
>> +                                             MX53_PAD_DISP0_DAT21__IPU_DISP0_DAT_21 0x5
>> +                                             MX53_PAD_DISP0_DAT22__IPU_DISP0_DAT_22 0x5
>> +                                             MX53_PAD_DISP0_DAT23__IPU_DISP0_DAT_23 0x5
>> +                                             >;
>> +                                     };
>> +                             };
>> +
>>                               owire {
>>                                       pinctrl_owire_1: owiregrp-1 {
>>                                               fsl,pins = <
>
>
>
> _______________________________________________
> linux-arm-kernel mailing list
> linux-arm-kernel at lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
