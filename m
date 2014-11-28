From: stefan@agner.ch (Stefan Agner)
Date: Fri, 28 Nov 2014 17:43:34 +0100
Subject: [PATCH 1/2] ARM: dts: vf610: add system reset controller (SRC)
In-Reply-To: <1417193015-6033-1-git-send-email-stefan@agner.ch>
References: <1417193015-6033-1-git-send-email-stefan@agner.ch>
Message-ID: <1417193015-6033-2-git-send-email-stefan@agner.ch>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Add device tree property for system reset controller.

Signed-off-by: Stefan Agner <stefan@agner.ch>
---
 arch/arm/boot/dts/vf500.dtsi | 4 ++++
 arch/arm/boot/dts/vfxxx.dtsi | 5 +++++
 2 files changed, 9 insertions(+)

diff --git a/arch/arm/boot/dts/vf500.dtsi b/arch/arm/boot/dts/vf500.dtsi
index de67005..3f38f49 100644
--- a/arch/arm/boot/dts/vf500.dtsi
+++ b/arch/arm/boot/dts/vf500.dtsi
@@ -130,6 +130,10 @@
 	interrupts = <GIC_SPI 86 IRQ_TYPE_LEVEL_HIGH>;
 };
 
+&src {
+	interrupts = <GIC_SPI 96 IRQ_TYPE_LEVEL_HIGH>;
+};
+
 &uart0 {
 	interrupts = <GIC_SPI 61 IRQ_TYPE_LEVEL_HIGH>;
 };
diff --git a/arch/arm/boot/dts/vfxxx.dtsi b/arch/arm/boot/dts/vfxxx.dtsi
index 505969a..5ff9cc5 100644
--- a/arch/arm/boot/dts/vfxxx.dtsi
+++ b/arch/arm/boot/dts/vfxxx.dtsi
@@ -318,6 +318,11 @@
 				clocks = <&clks VF610_CLK_USBC0>;
 				status = "disabled";
 			};
+
+			src: src at 4006e000 {
+				compatible = "fsl,vf610-src";
+				reg = <0x4006e000 0x1000>;
+			};
 		};
 
 		aips1: aips-bus at 40080000 {
-- 
2.1.3
