From: computersforpeace@gmail.com (Brian Norris)
Date: Tue, 12 May 2015 16:28:23 -0700
Subject: [PATCH v3 5/5] ARM: dts: brcmstb: add nodes for SATA controller and
 PHY
In-Reply-To: <1431473303-18873-1-git-send-email-computersforpeace@gmail.com>
References: <1431473303-18873-1-git-send-email-computersforpeace@gmail.com>
Message-ID: <1431473303-18873-6-git-send-email-computersforpeace@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Signed-off-by: Brian Norris <computersforpeace@gmail.com>
---
v3: no change

v2:
  - fix up some typos
  - account for binding changes in previous patches

 arch/arm/boot/dts/bcm7445.dtsi | 37 +++++++++++++++++++++++++++++++++++++
 1 file changed, 37 insertions(+)

diff --git a/arch/arm/boot/dts/bcm7445.dtsi b/arch/arm/boot/dts/bcm7445.dtsi
index 39ac7840d7ee..ce44a211b05c 100644
--- a/arch/arm/boot/dts/bcm7445.dtsi
+++ b/arch/arm/boot/dts/bcm7445.dtsi
@@ -108,6 +108,43 @@
 			brcm,int-map-mask = <0x25c>, <0x7000000>;
 			brcm,int-fwd-mask = <0x70000>;
 		};
+
+		sata at 45a000 {
+			compatible = "brcm,bcm7445-ahci", "brcm,sata3-ahci";
+			reg-names = "ahci", "top-ctrl";
+			reg = <0x45a000 0xa9c>, <0x458040 0x24>;
+			interrupts = <GIC_SPI 30 0>;
+			#address-cells = <1>;
+			#size-cells = <0>;
+
+			sata0: sata-port at 0 {
+				reg = <0>;
+				phys = <&sata_phy0>;
+			};
+
+			sata1: sata-port at 1 {
+				reg = <1>;
+				phys = <&sata_phy1>;
+			};
+		};
+
+		sata_phy: sata-phy at 458100 {
+			compatible = "brcm,bcm7445-sata-phy", "brcm,phy-sata3";
+			reg = <0x458100 0x1f00>;
+			reg-names = "phy";
+			#address-cells = <0x1>;
+			#size-cells = <0x0>;
+
+			sata_phy0: sata-phy at 0 {
+				reg = <0>;
+				#phy-cells = <0>;
+			};
+
+			sata_phy1: sata-phy at 1 {
+				reg = <1>;
+				#phy-cells = <0>;
+			};
+		};
 	};
 
 	smpboot {
-- 
1.9.1
