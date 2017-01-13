From: martin.blumenstingl@googlemail.com (Martin Blumenstingl)
Date: Fri, 13 Jan 2017 20:50:08 +0100
Subject: [PATCH 4/4] ARM64: dts: meson: meson-gx: add the SAR ADC
In-Reply-To: <2c7996a6-9c55-4cee-75a1-01be8732c42a@gmail.com>
References: <2c7996a6-9c55-4cee-75a1-01be8732c42a@gmail.com>
Message-ID: <CAFBinCC_AYS0ogzdpGVRoeS2ETjcD6fdmzq3kmX_u=9heBu6oA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Heiner,

On Fri, Jan 13, 2017 at 8:32 PM, Heiner Kallweit <hkallweit1@gmail.com> wrote:
> Sorry, I'm not subscribed to the two mailing lists, therefore my reply
> is outside the thread.
>
> I'm currently experimenting with an own rudimentary driver for SAR ADC
> on a Odroid C2 (S905GXBB). So I have some remarks based on my experience.
I hope that we haven't been duplicating too much work!

> Rgds, Heiner
>
>> Add the SAR ADC to meson-gxbb.dtsi and meson-gxl.dtsi. GXBB provides a
>> 10-bit ADC while GXL (and GXM, which uses the same ADC as GXL) provides
>> a 12-bit ADC.
>> Some boards use resistor ladder buttons connected through one of the ADC
>> channels. On newer devices (GXL and GXM) some boards use pull-ups/downs
>> to change the resistance (and thus the ADC value) on of the ADC channels
>> to indicate the board revision.
>>
>> Signed-off-by: Martin Blumenstingl <martin.blumenstingl@xxxxxxxxxxxxxx>
>> ---
>>  arch/arm64/boot/dts/amlogic/meson-gx.dtsi   |  8 ++++++++
>>  arch/arm64/boot/dts/amlogic/meson-gxbb.dtsi | 10 ++++++++++
>>  arch/arm64/boot/dts/amlogic/meson-gxl.dtsi  | 10 ++++++++++
>>  3 files changed, 28 insertions(+)
>>
>> diff --git a/arch/arm64/boot/dts/amlogic/meson-gx.dtsi b/arch/arm64/boot/dts/amlogic/meson-gx.dtsi
>> index cddad8c795ec..ed3bf29eb76a 100644
>> --- a/arch/arm64/boot/dts/amlogic/meson-gx.dtsi
>> +++ b/arch/arm64/boot/dts/amlogic/meson-gx.dtsi
>> @@ -237,6 +237,14 @@
>>                               status = "disabled";
>>                       };
>>
>> +                     saradc: adc at 8680 {
>> +                             compatible = "amlogic,meson-saradc";
>> +                             #io-channel-cells = <1>;
>> +                             status = "disabled";
>> +                             reg = <0x0 0x8680 0x0 0x34>;
>> +                             interrupts = <GIC_SPI 9 IRQ_TYPE_EDGE_RISING>;
> IRQ 9 dosn't work for me, where does this number come from?
> With IRQ 73 interrupt mode is working fine here.
> Of course I can't speak for all other Meson variants.
I think I took the IRQ from the vendor's mesongxbb.dtsi, depending on
whether I'll add IRQ support or not I'll remove or fix this. Thanks
for spotting this!


Regards,
Martin
