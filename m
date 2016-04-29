From: gregory.clement@free-electrons.com (Gregory CLEMENT)
Date: Fri, 29 Apr 2016 09:49:09 +0200
Subject: [PATCH v4 5/5] arm64: dts: marvell: add XOR node for Armada 3700 SoC
In-Reply-To: <1461916149-30900-1-git-send-email-gregory.clement@free-electrons.com>
References: <1461916149-30900-1-git-send-email-gregory.clement@free-electrons.com>
Message-ID: <1461916149-30900-6-git-send-email-gregory.clement@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Armada 3700 SoC comprise one dual-channel XOR engine and this
patch adds its according representation.

Signed-off-by: Marcin Wojtas <mw@semihalf.com>
Signed-off-by: Gregory CLEMENT <gregory.clement@free-electrons.com>
---
 arch/arm64/boot/dts/marvell/armada-37xx.dtsi | 13 +++++++++++++
 1 file changed, 13 insertions(+)

diff --git a/arch/arm64/boot/dts/marvell/armada-37xx.dtsi b/arch/arm64/boot/dts/marvell/armada-37xx.dtsi
index 1d4fb4d27787..9e2efb882983 100644
--- a/arch/arm64/boot/dts/marvell/armada-37xx.dtsi
+++ b/arch/arm64/boot/dts/marvell/armada-37xx.dtsi
@@ -113,6 +113,19 @@
 				status = "disabled";
 			};
 
+			xor at 60900 {
+				compatible = "marvell,armada-3700-xor";
+				reg = <0x60900 0x100
+				       0x60b00 0x100>;
+
+				xor10 {
+					interrupts = <GIC_SPI 47 IRQ_TYPE_LEVEL_HIGH>;
+				};
+				xor11 {
+					interrupts = <GIC_SPI 48 IRQ_TYPE_LEVEL_HIGH>;
+				};
+			};
+
 			sata: sata at e0000 {
 				compatible = "marvell,armada-3700-ahci";
 				reg = <0xe0000 0x2000>;
-- 
2.5.0
