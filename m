From: computersforpeace@gmail.com (Brian Norris)
Date: Wed, 18 Mar 2015 18:23:42 -0700
Subject: [PATCH 5/5] ARM: dts: brcmstb: add nodes for SATA controller and PHY
In-Reply-To: <1426728222-8197-1-git-send-email-computersforpeace@gmail.com>
References: <1426728222-8197-1-git-send-email-computersforpeace@gmail.com>
Message-ID: <1426728222-8197-5-git-send-email-computersforpeace@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Signed-off-by: Brian Norris <computersforpeace@gmail.com>
---
Light dependency on:
  http://lists.infradead.org/pipermail/linux-arm-kernel/2015-March/331921.html
for the surrounding text.

 arch/arm/boot/dts/bcm7445.dtsi | 36 ++++++++++++++++++++++++++++++++++++
 1 file changed, 36 insertions(+)

diff --git a/arch/arm/boot/dts/bcm7445.dtsi b/arch/arm/boot/dts/bcm7445.dtsi
index 9eaeac8dce1b..7a7c4d8c2afe 100644
--- a/arch/arm/boot/dts/bcm7445.dtsi
+++ b/arch/arm/boot/dts/bcm7445.dtsi
@@ -108,6 +108,42 @@
 			brcm,int-map-mask = <0x25c>, <0x7000000>;
 			brcm,int-fwd-mask = <0x70000>;
 		};
+
+		sata at f045a000 {
+			compatible = "brcm,bcm7445-ahci", "brcm,sata3-ahci";
+			reg-names = "ahci", "top-ctrl";
+			reg = <0x45a000 0xa9c>, <0x458040 0x24>;
+			interrupts = <GIC_SPI 30 0>;
+			#address-cells = <1>;
+			#size-cells = <0>;
+
+			sata0: sata-port at 0 {
+				reg = <0>;
+				phys = <&sata_phy 0>;
+			};
+
+			sata1: sata-port at 1 {
+				reg = <1>;
+				phys = <&sata_phy 1>;
+			};
+		};
+
+		sata_phy: sata-phy at f0458100 {
+			compatible = "brcm,bcm7445-sata-phy", "brcm,phy-sata3";
+			reg = <0x458100 0x1e00>, <0x45804c 0x10>;
+			reg-names = "phy", "port-ctrl";
+			#phy-cells = <1>;
+			#address-cells = <0x1>;
+			#size-cells = <0x0>;
+
+			sata-phy at 0 {
+				reg = <0>;
+			};
+
+			sata-phy at 1 {
+				reg = <1>;
+			};
+		};
 	};
 
 	smpboot {
-- 
1.9.1
