From: dirk.behme@de.bosch.com (Dirk Behme)
Date: Thu, 16 May 2013 08:51:34 +0200
Subject: [PATCH] i.MX6: Documentation: update from fsl,
 card-wired to non-removable
Message-ID: <1368687094-11385-1-git-send-email-dirk.behme@de.bosch.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

With the commit 7f217794f (mmc: dt: Consolidate DT bindings),
the device tree properties used by various device drivers
for SD/MMC host controllers were standardized.  One of the changes
was that the property "fsl,card-wired", previously used by the
Freescale driver, was replaced with "non-removable". Fix the example
documentation regarding this.

Signed-off-by: Dirk Behme <dirk.behme@de.bosch.com>
---
 Documentation/devicetree/bindings/pinctrl/fsl,imx-pinctrl.txt | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/Documentation/devicetree/bindings/pinctrl/fsl,imx-pinctrl.txt b/Documentation/devicetree/bindings/pinctrl/fsl,imx-pinctrl.txt
index bcfdab5..3a7caf7 100644
--- a/Documentation/devicetree/bindings/pinctrl/fsl,imx-pinctrl.txt
+++ b/Documentation/devicetree/bindings/pinctrl/fsl,imx-pinctrl.txt
@@ -58,7 +58,7 @@ Some requirements for using fsl,imx-pinctrl binding:
 
 Examples:
 usdhc at 0219c000 { /* uSDHC4 */
-	fsl,card-wired;
+	non-removable;
 	vmmc-supply = <&reg_3p3v>;
 	status = "okay";
 	pinctrl-names = "default";
-- 
1.8.2
