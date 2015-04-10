From: marcel@ziswiler.com (Marcel Ziswiler)
Date: Fri, 10 Apr 2015 23:35:59 +0200
Subject: [PATCH 4/9] ARM: tegra: add Tegra30 HDA support
In-Reply-To: <cover.1428700856.git.marcel.ziswiler@toradex.com>
References: <cover.1428700856.git.marcel.ziswiler@toradex.com>
Message-ID: <0fd7107ec51f0a359d4c395c243bcd12f8731cd5.1428700856.git.marcel.ziswiler@toradex.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Marcel Ziswiler <marcel.ziswiler@toradex.com>

Add a device node for the HDA controller found on Tegra30.

Signed-off-by: Marcel Ziswiler <marcel.ziswiler@toradex.com>
---
 arch/arm/boot/dts/tegra30.dtsi | 15 +++++++++++++++
 1 file changed, 15 insertions(+)

diff --git a/arch/arm/boot/dts/tegra30.dtsi b/arch/arm/boot/dts/tegra30.dtsi
index db4810d..12a87aa 100644
--- a/arch/arm/boot/dts/tegra30.dtsi
+++ b/arch/arm/boot/dts/tegra30.dtsi
@@ -640,6 +640,21 @@
 		reset-names = "fuse";
 	};
 
+	hda at 70030000 {
+		compatible = "nvidia,tegra30-hda";
+		reg = <0x70030000 0x10000>;
+		interrupts = <GIC_SPI 81 IRQ_TYPE_LEVEL_HIGH>;
+		clocks = <&tegra_car TEGRA30_CLK_HDA>,
+		         <&tegra_car TEGRA30_CLK_HDA2HDMI>,
+			 <&tegra_car TEGRA30_CLK_HDA2CODEC_2X>;
+		clock-names = "hda", "hda2hdmi", "hda2codec_2x";
+		resets = <&tegra_car 125>, /* hda */
+			 <&tegra_car 128>, /* hda2hdmi */
+			 <&tegra_car 111>; /* hda2codec_2x */
+		reset-names = "hda", "hda2hdmi", "hda2codec_2x";
+		status = "disabled";
+	};
+
 	ahub at 70080000 {
 		compatible = "nvidia,tegra30-ahub";
 		reg = <0x70080000 0x200
-- 
1.9.3
