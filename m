From: florian.vaussard@gmail.com (Florian Vaussard)
Date: Sat, 25 Feb 2017 06:54:26 +0100
Subject: [PATCH 3/6] ARM: dts: socfpga: Remove unneeded unit names
In-Reply-To: <1488002069-22404-1-git-send-email-florian.vaussard@heig-vd.ch>
References: <1488002069-22404-1-git-send-email-florian.vaussard@heig-vd.ch>
Message-ID: <1488002069-22404-4-git-send-email-florian.vaussard@heig-vd.ch>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Node eccmgr has a unit name, but do not have a reg property as only the
child nodes do have this property. Likewise the usbphy node do not have
a reg property. This will trigger the following warnings when compiled
with W=1:

Node /soc/eccmgr at ffd08140 has a unit name, but no reg property
Node /soc/usbphy at 0 has a unit name, but no reg property

Remove the superfluous unit names.

Signed-off-by: Florian Vaussard <florian.vaussard@heig-vd.ch>
---
 arch/arm/boot/dts/socfpga.dtsi         | 4 ++--
 arch/arm/boot/dts/socfpga_arria10.dtsi | 4 ++--
 2 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/arch/arm/boot/dts/socfpga.dtsi b/arch/arm/boot/dts/socfpga.dtsi
index 4dda6d8..25a68af 100644
--- a/arch/arm/boot/dts/socfpga.dtsi
+++ b/arch/arm/boot/dts/socfpga.dtsi
@@ -678,7 +678,7 @@
 			status = "disabled";
 		};
 
-		eccmgr: eccmgr at ffd08140 {
+		eccmgr: eccmgr {
 			compatible = "altr,socfpga-ecc-manager";
 			#address-cells = <1>;
 			#size-cells = <1>;
@@ -879,7 +879,7 @@
 			dma-names = "tx", "rx";
 		};
 
-		usbphy0: usbphy at 0 {
+		usbphy0: usbphy {
 			#phy-cells = <0>;
 			compatible = "usb-nop-xceiv";
 			status = "okay";
diff --git a/arch/arm/boot/dts/socfpga_arria10.dtsi b/arch/arm/boot/dts/socfpga_arria10.dtsi
index 0332d51..4e1f653 100644
--- a/arch/arm/boot/dts/socfpga_arria10.dtsi
+++ b/arch/arm/boot/dts/socfpga_arria10.dtsi
@@ -649,7 +649,7 @@
 			reg = <0xffe00000 0x40000>;
 		};
 
-		eccmgr: eccmgr at ffd06000 {
+		eccmgr: eccmgr {
 			compatible = "altr,socfpga-a10-ecc-manager";
 			altr,sysmgr-syscon = <&sysmgr>;
 			#address-cells = <1>;
@@ -806,7 +806,7 @@
 			status = "disabled";
 		};
 
-		usbphy0: usbphy at 0 {
+		usbphy0: usbphy {
 			#phy-cells = <0>;
 			compatible = "usb-nop-xceiv";
 			status = "okay";
-- 
2.7.4
