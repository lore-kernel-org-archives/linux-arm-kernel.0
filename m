From: antoine.tenart@free-electrons.com (=?UTF-8?q?Antoine=20T=C3=A9nart?=)
Date: Mon, 12 May 2014 11:16:56 +0200
Subject: [PATCH v2 5/6] ARM: berlin: add the AHCI node for the BG2Q
In-Reply-To: <1399886217-20474-1-git-send-email-antoine.tenart@free-electrons.com>
References: <1399886217-20474-1-git-send-email-antoine.tenart@free-electrons.com>
Message-ID: <1399886217-20474-6-git-send-email-antoine.tenart@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The BG2Q has an AHCI SATA controller. Add the corresponding nodes
(AHCI, SATA PHY) in its device tree.

Signed-off-by: Antoine T?nart <antoine.tenart@free-electrons.com>
---
 arch/arm/boot/dts/berlin2q.dtsi | 14 ++++++++++++++
 1 file changed, 14 insertions(+)

diff --git a/arch/arm/boot/dts/berlin2q.dtsi b/arch/arm/boot/dts/berlin2q.dtsi
index 07452a7483fa..99338a2d11a6 100644
--- a/arch/arm/boot/dts/berlin2q.dtsi
+++ b/arch/arm/boot/dts/berlin2q.dtsi
@@ -183,6 +183,20 @@
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
+			#phy-cells = <1>;
+			status = "disabled";
+		};
+
 		apb at fc0000 {
 			compatible = "simple-bus";
 			#address-cells = <1>;
-- 
1.9.1
