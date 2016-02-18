From: javier@osg.samsung.com (Javier Martinez Canillas)
Date: Thu, 18 Feb 2016 15:19:09 -0300
Subject: [PATCH 1/3] thermal: exynos: List vtmu-supply as optional property in
 DT binding
In-Reply-To: <1455819551-4666-1-git-send-email-javier@osg.samsung.com>
References: <1455819551-4666-1-git-send-email-javier@osg.samsung.com>
Message-ID: <1455819551-4666-2-git-send-email-javier@osg.samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The Exynos Thermal Management Unit binding says that the vtmu-supply
is optional but is listed in the required properties section. Add an
optional properties section and move the regulator property there.

Signed-off-by: Javier Martinez Canillas <javier@osg.samsung.com>
---

 Documentation/devicetree/bindings/thermal/exynos-thermal.txt | 9 ++++++---
 1 file changed, 6 insertions(+), 3 deletions(-)

diff --git a/Documentation/devicetree/bindings/thermal/exynos-thermal.txt b/Documentation/devicetree/bindings/thermal/exynos-thermal.txt
index faa62059b5c5..70b4c16c7ed8 100644
--- a/Documentation/devicetree/bindings/thermal/exynos-thermal.txt
+++ b/Documentation/devicetree/bindings/thermal/exynos-thermal.txt
@@ -41,9 +41,6 @@
 		for current TMU channel
 	-- "tmu_sclk" clock for functional operation of the current TMU
 		channel
-- vtmu-supply: This entry is optional and provides the regulator node supplying
-		voltage to TMU. If needed this entry can be placed inside
-		board/platform specific dts file.
 
 The Exynos TMU supports generating interrupts when reaching given
 temperature thresholds. Number of supported thermal trip points depends
@@ -65,6 +62,12 @@ Following properties are mandatory (depending on SoC):
 - samsung,tmu_default_temp_offset: Default temperature offset
 - samsung,tmu_cal_type: Callibration type
 
+** Optional properties:
+
+- vtmu-supply: This entry is optional and provides the regulator node supplying
+		voltage to TMU. If needed this entry can be placed inside
+		board/platform specific dts file.
+
 Example 1):
 
 	tmu at 100C0000 {
-- 
2.5.0
