From: evanluijk@interact.nl (Erik van Luijk)
Date: Wed, 03 Sep 2014 08:09:28 +0200
Subject: [PATCH] ARM: at91/dt: at91sam9m10g45ek add rtc node
In-Reply-To: <20140902183356.7bcfdf84@bbrezillon>
References: <1409655132-17735-1-git-send-email-evanluijk@interact.nl>
 <20140902183356.7bcfdf84@bbrezillon>
Message-ID: <5406B098.6020500@interact.nl>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org


Hi Boris, Nicolas,

Boris BREZILLON schreef op 2-9-2014 om 18:33:
> Hi Erik,
 >
 > On Tue,  2 Sep 2014 12:52:12 +0200
 > Erik van Luijk <evanluijk@interact.nl> wrote:
 >
 >> Signed-off-by: Erik van Luijk <evanluijk@interact.nl>
 >
 > Except for the nitpicks you'll find below, you have my
 >
 > Acked-by: Boris Brezillon <boris.brezillon@free-electrons.com>
 >
 >> ---
 >>  arch/arm/boot/dts/at91sam9g45.dtsi     | 7 +++++++
 >>  arch/arm/boot/dts/at91sam9m10g45ek.dts | 3 +++
 >>  2 files changed, 10 insertions(+)
 >>
 >> diff --git a/arch/arm/boot/dts/at91sam9g45.dtsi 
b/arch/arm/boot/dts/at91sam9g45.dtsi
 >> index 932a669..bf62c18 100644
 >> --- a/arch/arm/boot/dts/at91sam9g45.dtsi
 >> +++ b/arch/arm/boot/dts/at91sam9g45.dtsi
 >> @@ -1070,6 +1070,13 @@
 >>                  status = "disabled";
 >>              };
 >>
 >> +            rtc at fffffdb0 {
 >> +                compatible = "atmel,at91rm9200-rtc";
 >> +                reg = <0xfffffdb0 0x30>;
 >
 > The RTC registers goes from 0xfffffdb0 to 0xfffffdc0, which means the
 > size is 0x10 and not 0x30. This is not important here, because the
 > following region is marked as reserved, but we prefer to keep the DT
 > consistent with the datasheet.

This is an inconsistency in the datasheet of the AT91SAM9G45 (and at 
least also
AT91SAM9G15, AT91SAM9G25, AT91SAM9G35 and AT91SAM9M10).
In the memory map (fig. 5-1) there is room for 16 bytes.
But in the 'Real-time Clock (RTC) User Interface' (table 15-1) there is 
room for
48 bytes (0x30) excluding the Reserved Registers (which don't belong to 
the RTC
on the AT91SAM9M10). Perhaps Nicolas can draw some attention to this at 
Atmel.

>
 >> +                interrupts = <1 IRQ_TYPE_LEVEL_HIGH 7>;
 >> +                status = "disabled";
 >> +            };
 >> +
 >>              spi0: spi at fffa4000 {
 >>                  #address-cells = <1>;
 >>                  #size-cells = <0>;
 >> diff --git a/arch/arm/boot/dts/at91sam9m10g45ek.dts 
b/arch/arm/boot/dts/at91sam9m10g45ek.dts
 >> index 96ccc7d..2dd2347 100644
 >> --- a/arch/arm/boot/dts/at91sam9m10g45ek.dts
 >> +++ b/arch/arm/boot/dts/at91sam9m10g45ek.dts
 >> @@ -70,6 +70,9 @@
 >>
 >>              watchdog at fffffd40 {
 >>                  status = "okay";
 >> +
 >> +            rtc at fffffdb0 {
 >> +                status = "okay";
 >
 > Try to keep SoC and board changes in distinct commits.

Understood.

>
 >>              };
 >>
 >>              mmc0: mmc at fff80000 {
 >
 >
 > Best Regards,
 >
 > Boris
 >

Regards,

Erik
