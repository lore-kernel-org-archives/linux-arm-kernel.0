From: baruch@tkos.co.il (Baruch Siach)
Date: Mon,  6 Jul 2015 14:41:43 +0300
Subject: [PATCH 1/4] ARM: digicolor: enable watchdog device
In-Reply-To: <cover.1436182214.git.baruch@tkos.co.il>
References: <cover.1436182214.git.baruch@tkos.co.il>
Message-ID: <08bb4d52b29825487958034e41d4a28cd9bf62e5.1436182214.git.baruch@tkos.co.il>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Signed-off-by: Baruch Siach <baruch@tkos.co.il>
---
 arch/arm/boot/dts/cx92755.dtsi | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/arch/arm/boot/dts/cx92755.dtsi b/arch/arm/boot/dts/cx92755.dtsi
index af333261d046..df4c6f1f93f9 100644
--- a/arch/arm/boot/dts/cx92755.dtsi
+++ b/arch/arm/boot/dts/cx92755.dtsi
@@ -88,6 +88,13 @@
 		interrupts = <25>;
 	};
 
+	watchdog at f0000fc0 {
+		compatible = "cnxt,cx92755-wdt";
+		reg = <0xf0000fc0 0x8>;
+		clocks = <&main_clk>;
+		timeout-sec = <15>;
+	};
+
 	uc_regs: syscon at f00003a0 {
 		compatible = "cnxt,cx92755-uc", "syscon";
 		reg = <0xf00003a0 0x10>;
-- 
2.1.4
