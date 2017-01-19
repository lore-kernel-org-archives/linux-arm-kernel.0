From: marc_gonzalez@sigmadesigns.com (Marc Gonzalez)
Date: Thu, 19 Jan 2017 15:57:54 +0100
Subject: [PATCH v1 2/3] ARM: dts: tango4: Import MMC nodes
In-Reply-To: <bd989965-fa8a-a175-5e14-8467f01e6d5b@sigmadesigns.com>
References: <bd989965-fa8a-a175-5e14-8467f01e6d5b@sigmadesigns.com>
Message-ID: <b144e52c-396b-b51f-f2f7-16e45f983dc5@sigmadesigns.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Tango4 provides 2 SD/SDIO/eMMC controllers.

Signed-off-by: Marc Gonzalez <marc_gonzalez@sigmadesigns.com>
---
 arch/arm/boot/dts/tango4-common.dtsi      | 16 ++++++++++++++++
 arch/arm/boot/dts/tango4-vantage-1172.dts |  4 ++++
 2 files changed, 20 insertions(+)

diff --git a/arch/arm/boot/dts/tango4-common.dtsi b/arch/arm/boot/dts/tango4-common.dtsi
index dd7eb5f624d9..2eb92a2649ed 100644
--- a/arch/arm/boot/dts/tango4-common.dtsi
+++ b/arch/arm/boot/dts/tango4-common.dtsi
@@ -97,6 +97,22 @@
 			clocks = <&xtal>;
 		};
 
+		mmc0: mmc at 21000 {
+			compatible = "arasan,sdhci-8.9a";
+			reg = <0x21000 0x200>;
+			clock-names = "clk_xin", "clk_ahb";
+			clocks = <&clkgen SDIO_CLK>, <&clkgen SYS_CLK>;
+			interrupts = <60 IRQ_TYPE_LEVEL_HIGH>;
+		};
+
+		mmc1: mmc at 21200 {
+			compatible = "arasan,sdhci-8.9a";
+			reg = <0x21200 0x200>;
+			clock-names = "clk_xin", "clk_ahb";
+			clocks = <&clkgen SDIO_CLK>, <&clkgen SYS_CLK>;
+			interrupts = <8 IRQ_TYPE_LEVEL_HIGH>;
+		};
+
 		eth0: ethernet at 26000 {
 			compatible = "sigma,smp8734-ethernet";
 			reg = <0x26000 0x800>;
diff --git a/arch/arm/boot/dts/tango4-vantage-1172.dts b/arch/arm/boot/dts/tango4-vantage-1172.dts
index e27b4a7801ab..86d8df98802f 100644
--- a/arch/arm/boot/dts/tango4-vantage-1172.dts
+++ b/arch/arm/boot/dts/tango4-vantage-1172.dts
@@ -35,3 +35,7 @@
 		reg = <4>;
 	};
 };
+
+&mmc1 {
+	non-removable; /* eMMC */
+};
-- 
2.10.0
