From: walter@vanguardiasur.com.ar (Walter Lozano)
Date: Mon, 16 Mar 2015 10:10:45 -0300
Subject: [PATCH v2] ARM: socfpga: dts: Add adxl34x
In-Reply-To: <20150105092153.GJ13070@pengutronix.de>
References: <1419462712-14151-1-git-send-email-walter@vanguardiasur.com.ar>
 <20150105092153.GJ13070@pengutronix.de>
Message-ID: <CABxpGwCbFF+pJ0H_sMjqk6c9awdRuxi6j0CL_d3mH5z4Qht+ng@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Jan 5, 2015 at 6:21 AM, Steffen Trumtrar
<s.trumtrar@pengutronix.de> wrote:
> Hi!
>
> On Wed, Dec 24, 2014 at 08:11:52PM -0300, Walter Lozano wrote:
>> This patch adds the DTS bindings for the adxl34x digital
>> accelerometer.
>>
>> Signed-off-by: Walter Lozano <walter@vanguardiasur.com.ar>
>> ---
>>  arch/arm/boot/dts/socfpga_cyclone5_sockit.dts |   16 ++++++++++++++++
>>  1 file changed, 16 insertions(+)
>>
>> diff --git a/arch/arm/boot/dts/socfpga_cyclone5_sockit.dts b/arch/arm/boot/dts/socfpga_cyclone5_sockit.dts
>> index 16ea6f5..d343e03 100644
>> --- a/arch/arm/boot/dts/socfpga_cyclone5_sockit.dts
>> +++ b/arch/arm/boot/dts/socfpga_cyclone5_sockit.dts
>> @@ -60,6 +60,22 @@
>>       rxc-skew-ps = <2000>;
>>  };
>>
>> +&gpio2 {
>> +     status = "okay";
>> +};
>> +
>> +&i2c1 {
>> +     status = "okay";
>> +
>> +     accel1: accelerometer at 53 {
>> +             compatible = "adxl34x";
>> +             reg = <0x53>;
>> +
>> +             interrupt-parent = <&portc>;
>> +             interrupts = <3 2>;
>> +     };
>> +};
>> +
>>  &mmc0 {
>>       vmmc-supply = <&regulator_3_3v>;
>>       vqmmc-supply = <&regulator_3_3v>;
>
> I just gave it a short spin. I get some interrupts and the position property
> changes, so it seems to work:
>
>         Acked-by: Steffen Trumtrar <s.trumtrar@pengutronix.de>
>
> Regards,
> Steffen
>
> --
> Pengutronix e.K.                           |                             |
> Industrial Linux Solutions                 | http://www.pengutronix.de/  |
> Peiner Str. 6-8, 31137 Hildesheim, Germany | Phone: +49-5121-206917-0    |
> Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-5555 |

Ping?
How should this continue?

Regards,

Walter

-- 
Walter Lozano, VanguardiaSur
www.vanguardiasur.com.ar
