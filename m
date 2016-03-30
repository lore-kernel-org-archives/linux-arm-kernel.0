From: gregory.clement@free-electrons.com (Gregory CLEMENT)
Date: Wed, 30 Mar 2016 19:35:20 +0200
Subject: [PATCH 5/5] arm64: dts: marvell: add XOR node for Armada 3700 SoC
In-Reply-To: <1459359320-12638-1-git-send-email-gregory.clement@free-electrons.com>
References: <1459359320-12638-1-git-send-email-gregory.clement@free-electrons.com>
Message-ID: <1459359320-12638-6-git-send-email-gregory.clement@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Marcin Wojtas <mw@semihalf.com>

Armada 3700 SoC comprise one dual-channel XOR engine and this
patch adds its according representation.

Signed-off-by: Marcin Wojtas <mw@semihalf.com>
Signed-off-by: Gregory CLEMENT <gregory.clement@free-electrons.com>
---
 arch/arm64/boot/dts/marvell/armada-37xx.dtsi | 13 +++++++++++++
 1 file changed, 13 insertions(+)

diff --git a/arch/arm64/boot/dts/marvell/armada-37xx.dtsi b/arch/arm64/boot/dts/marvell/armada-37xx.dtsi
index ba9df7ff2a72..932783d82ea9 100644
--- a/arch/arm64/boot/dts/marvell/armada-37xx.dtsi
+++ b/arch/arm64/boot/dts/marvell/armada-37xx.dtsi
@@ -112,6 +112,19 @@
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
 			sata at e0000 {
 				compatible = "marvell,armada-3700-ahci";
 				reg = <0xe0000 0x2000>;
-- 
2.5.0
