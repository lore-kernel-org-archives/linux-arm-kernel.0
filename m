From: fabio.estevam@nxp.com (Fabio Estevam)
Date: Tue, 6 Sep 2016 12:53:13 -0300
Subject: [PATCH 7/9] ARM: dts: imx27: Fix cpu node build warnings with W=1
In-Reply-To: <1473177196-29371-1-git-send-email-fabio.estevam@nxp.com>
References: <1473177196-29371-1-git-send-email-fabio.estevam@nxp.com>
Message-ID: <1473177196-29371-7-git-send-email-fabio.estevam@nxp.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Fix the following build warnings with W=1:

Warning (unit_address_vs_reg): Node /cpus/cpu at 0 has a unit name, but no reg property

Signed-off-by: Fabio Estevam <fabio.estevam@nxp.com>
---
 arch/arm/boot/dts/imx27.dtsi | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/arch/arm/boot/dts/imx27.dtsi b/arch/arm/boot/dts/imx27.dtsi
index 9d8b596..b76879e 100644
--- a/arch/arm/boot/dts/imx27.dtsi
+++ b/arch/arm/boot/dts/imx27.dtsi
@@ -63,8 +63,9 @@
 		#size-cells = <0>;
 		#address-cells = <1>;
 
-		cpu: cpu at 0 {
+		cpu at 0 {
 			device_type = "cpu";
+			reg = <0>;
 			compatible = "arm,arm926ej-s";
 			operating-points = <
 				/* kHz uV */
-- 
1.9.1
