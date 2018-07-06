From: icenowy@aosc.io (Icenowy Zheng)
Date: Fri, 06 Jul 2018 17:03:57 +0800
Subject: [PATCH 08/10] arm64: dts: allwinner: a64: NanoPi-A64: Fix PortE
 voltage
In-Reply-To: <20180706085210.17952-9-andre.przywara@arm.com>
References: <20180706085210.17952-1-andre.przywara@arm.com>
 <20180706085210.17952-9-andre.przywara@arm.com>
Message-ID: <F0738E28-2523-41EF-94AE-049C6C436F55@aosc.io>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org



? 2018?7?6? GMT+08:00 ??4:52:08, Andre Przywara <andre.przywara@arm.com> ??:
>VCC-PE is driven the AXP's ALDO1 regulator, and is connected to the I2C
>pins on the RPi2 header. One would expect 3.3 V there, so enable this
>regulator and set it to this voltage.

However, 3.3V will break the DVP camera (although not yet
supported).

>
>Signed-off-by: Andre Przywara <andre.przywara@arm.com>
>---
> arch/arm64/boot/dts/allwinner/sun50i-a64-nanopi-a64.dts | 7 +++++++
> 1 file changed, 7 insertions(+)
>
>diff --git a/arch/arm64/boot/dts/allwinner/sun50i-a64-nanopi-a64.dts
>b/arch/arm64/boot/dts/allwinner/sun50i-a64-nanopi-a64.dts
>index bd35a093e6cd..0439cff685d6 100644
>--- a/arch/arm64/boot/dts/allwinner/sun50i-a64-nanopi-a64.dts
>+++ b/arch/arm64/boot/dts/allwinner/sun50i-a64-nanopi-a64.dts
>@@ -126,6 +126,13 @@
> 
> #include "axp803.dtsi"
> 
>+&reg_aldo1 {
>+	regulator-always-on;
>+	regulator-min-microvolt = <3300000>;
>+	regulator-max-microvolt = <3300000>;
>+	regulator-name = "vcc-pe";
>+};
>+
> &reg_aldo2 {
> 	regulator-always-on;
> 	regulator-min-microvolt = <1800000>;
