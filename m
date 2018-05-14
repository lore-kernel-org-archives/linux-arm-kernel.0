From: shawnguo@kernel.org (Shawn Guo)
Date: Mon, 14 May 2018 09:11:46 +0800
Subject: [PATCH] ARM: dts: imx: add proper #address-cells/#size-cells for
 ipu_di port nodes
Message-ID: <1526260306-14063-1-git-send-email-shawnguo@kernel.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

It adds proper #address-cells/#size-cells for ipu_di port nodes to fix
the following DTC warnings.

arch/arm/boot/dts/imx6dl-aristainetos_7.dtb: Warning (reg_format): /soc/ipu at 2400000/port at 2/endpoint at 0:reg: property has invalid length (4 bytes) (#address-cells == 2, #size-cells == 1)
arch/arm/boot/dts/imx6dl-aristainetos_7.dtb: Warning (pci_device_bus_num): Failed prerequisite 'reg_format'
arch/arm/boot/dts/imx6dl-aristainetos_7.dtb: Warning (simple_bus_reg): Failed prerequisite 'reg_format'
arch/arm/boot/dts/imx6dl-aristainetos_7.dtb: Warning (avoid_default_addr_size): /soc/ipu at 2400000/port at 2/endpoint at 0: Relying on default #address-cells value
...

Fixes: e6bb17850d1e ("ARM: dts: imx: fix IPU OF graph endpoint node names")
Reported-by: Stephen Rothwell <sfr@canb.auug.org.au>
Cc: Rob Herring <robh@kernel.org>
Signed-off-by: Shawn Guo <shawnguo@kernel.org>
---
 arch/arm/boot/dts/imx6q.dtsi   | 4 ++++
 arch/arm/boot/dts/imx6qdl.dtsi | 4 ++++
 2 files changed, 8 insertions(+)

diff --git a/arch/arm/boot/dts/imx6q.dtsi b/arch/arm/boot/dts/imx6q.dtsi
index 40d85888a6b3..70483ce72ba6 100644
--- a/arch/arm/boot/dts/imx6q.dtsi
+++ b/arch/arm/boot/dts/imx6q.dtsi
@@ -152,6 +152,8 @@
 			};
 
 			ipu2_di0: port at 2 {
+				#address-cells = <1>;
+				#size-cells = <0>;
 				reg = <2>;
 
 				ipu2_di0_disp0: endpoint at 0 {
@@ -180,6 +182,8 @@
 			};
 
 			ipu2_di1: port at 3 {
+				#address-cells = <1>;
+				#size-cells = <0>;
 				reg = <3>;
 
 				ipu2_di1_hdmi: endpoint at 1 {
diff --git a/arch/arm/boot/dts/imx6qdl.dtsi b/arch/arm/boot/dts/imx6qdl.dtsi
index 087379c21842..e50fd1cfaee2 100644
--- a/arch/arm/boot/dts/imx6qdl.dtsi
+++ b/arch/arm/boot/dts/imx6qdl.dtsi
@@ -1284,6 +1284,8 @@
 			};
 
 			ipu1_di0: port at 2 {
+				#address-cells = <1>;
+				#size-cells = <0>;
 				reg = <2>;
 
 				ipu1_di0_disp0: endpoint at 0 {
@@ -1312,6 +1314,8 @@
 			};
 
 			ipu1_di1: port at 3 {
+				#address-cells = <1>;
+				#size-cells = <0>;
 				reg = <3>;
 
 				ipu1_di1_disp1: endpoint at 0 {
-- 
1.9.1
