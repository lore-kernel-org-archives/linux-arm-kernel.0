From: festevam@gmail.com (Fabio Estevam)
Date: Tue, 20 Nov 2018 13:59:42 -0200
Subject: [PATCH 1/4] ARM: dts: imx6ul-ccimx6ulsom: Add memory node to board dts
Message-ID: <1542729585-9330-1-git-send-email-festevam@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Add memory node to board dts.

This is done in preparation of removing the memory node from imx6ul.dtsi. 

Signed-off-by: Fabio Estevam <festevam@gmail.com>
---
 arch/arm/boot/dts/imx6ul-ccimx6ulsom.dtsi | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/arch/arm/boot/dts/imx6ul-ccimx6ulsom.dtsi b/arch/arm/boot/dts/imx6ul-ccimx6ulsom.dtsi
index c41ecee..b5781c3 100644
--- a/arch/arm/boot/dts/imx6ul-ccimx6ulsom.dtsi
+++ b/arch/arm/boot/dts/imx6ul-ccimx6ulsom.dtsi
@@ -7,6 +7,11 @@
  */
 
 / {
+	memory at 80000000 {
+		device_type = "memory";
+		reg = <0x80000000 0>; /* will be filled by U-Boot */
+	};
+
 	reserved-memory {
 		#address-cells = <1>;
 		#size-cells = <1>;
-- 
2.7.4
