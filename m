From: fabio.estevam@nxp.com (Fabio Estevam)
Date: Tue, 6 Sep 2016 12:53:09 -0300
Subject: [PATCH 3/9] ARM: dts: imx1: Fix cpu node build warnings with W=1
In-Reply-To: <1473177196-29371-1-git-send-email-fabio.estevam@nxp.com>
References: <1473177196-29371-1-git-send-email-fabio.estevam@nxp.com>
Message-ID: <1473177196-29371-3-git-send-email-fabio.estevam@nxp.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Fix the following build warnings with W=1:

Warning (unit_address_vs_reg): Node /cpus/cpu at 0 has a unit name, but no reg property

Signed-off-by: Fabio Estevam <fabio.estevam@nxp.com>
---
 arch/arm/boot/dts/imx1.dtsi | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/arch/arm/boot/dts/imx1.dtsi b/arch/arm/boot/dts/imx1.dtsi
index b792eee..dd3de38 100644
--- a/arch/arm/boot/dts/imx1.dtsi
+++ b/arch/arm/boot/dts/imx1.dtsi
@@ -43,8 +43,9 @@
 		#size-cells = <0>;
 		#address-cells = <1>;
 
-		cpu: cpu at 0 {
+		cpu at 0 {
 			device_type = "cpu";
+			reg = <0>;
 			compatible = "arm,arm920t";
 			operating-points = <200000 1900000>;
 			clock-latency = <62500>;
-- 
1.9.1
