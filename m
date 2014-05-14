From: antoine.tenart@free-electrons.com (=?UTF-8?q?Antoine=20T=C3=A9nart?=)
Date: Wed, 14 May 2014 11:49:01 +0200
Subject: [PATCH v3 5/6] ARM: berlin: add the AHCI node for the BG2Q
In-Reply-To: <1400060942-10588-1-git-send-email-antoine.tenart@free-electrons.com>
References: <1400060942-10588-1-git-send-email-antoine.tenart@free-electrons.com>
Message-ID: <1400060942-10588-6-git-send-email-antoine.tenart@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The BG2Q has an AHCI SATA controller. Add the corresponding nodes
(AHCI, SATA PHYs) in its device tree.

Signed-off-by: Antoine T?nart <antoine.tenart@free-electrons.com>
---
 arch/arm/boot/dts/berlin2q.dtsi | 25 +++++++++++++++++++++++++
 1 file changed, 25 insertions(+)

diff --git a/arch/arm/boot/dts/berlin2q.dtsi b/arch/arm/boot/dts/berlin2q.dtsi
index 07452a7483fa..53f8d9763589 100644
--- a/arch/arm/boot/dts/berlin2q.dtsi
+++ b/arch/arm/boot/dts/berlin2q.dtsi
@@ -183,6 +183,31 @@
 			};
 		};
 
+		ahci: sata at e90000 {
+			compatible = "marvell,berlin-ahci";
+			reg = <0xe90000 0x1000>;
+			interrupts = <GIC_SPI 7 IRQ_TYPE_LEVEL_HIGH>;
+			status = "disabled";
+		};
+
+		sata_phy: phy at e900a0 {
+			compatible = "marvell,berlin-sata-phy";
+			reg = <0xe900a0 0x10>;
+			#address-cells = <1>;
+			#size-cells = <0>;
+			status = "disabled";
+
+			sata_phy0: phy at 0 {
+				#phy-cells = <0>;
+				reg = <0>;
+			};
+
+			sata_phy1: phy at 1 {
+				#phy-cells = <0>;
+				reg = <1>;
+			};
+		};
+
 		apb at fc0000 {
 			compatible = "simple-bus";
 			#address-cells = <1>;
-- 
1.9.1
