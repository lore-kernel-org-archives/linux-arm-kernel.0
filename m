From: hoegeun.kwon@samsung.com (Hoegeun Kwon)
Date: Fri, 08 Sep 2017 15:02:39 +0900
Subject: [PATCH v3 5/6] [media] exynos-gsc: Remove unnecessary compatible
In-Reply-To: <1504850560-27950-1-git-send-email-hoegeun.kwon@samsung.com>
References: <1504850560-27950-1-git-send-email-hoegeun.kwon@samsung.com>
 <CGME20170908060309epcas1p4061542ce39ddfdd385b1b6b51eda2ace@epcas1p4.samsung.com>
Message-ID: <1504850560-27950-6-git-send-email-hoegeun.kwon@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Currently, the compatible('samsung,exynos5-gsc') is not used.
Remove unnecessary compatible.

Signed-off-by: Hoegeun Kwon <hoegeun.kwon@samsung.com>
---
 Documentation/devicetree/bindings/media/exynos5-gsc.txt | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/Documentation/devicetree/bindings/media/exynos5-gsc.txt b/Documentation/devicetree/bindings/media/exynos5-gsc.txt
index daa56d5..1ea05f1 100644
--- a/Documentation/devicetree/bindings/media/exynos5-gsc.txt
+++ b/Documentation/devicetree/bindings/media/exynos5-gsc.txt
@@ -3,9 +3,9 @@
 G-Scaler is used for scaling and color space conversion on EXYNOS5 SoCs.
 
 Required properties:
-- compatible: should be "samsung,exynos5-gsc" (for Exynos 5250, 5420 and
-	      5422 SoCs) or "samsung,exynos5433-gsc" (Exynos 5433)
-	      or "samsung,exynos5250-gsc" or "samsung,exynos5420-gsc"
+- compatible: should be "samsung,exynos5250-gsc", "samsung,exynos5420-gsc"
+	      or "samsung,exynos5433-gsc" (for Exynos 5250, 5420, 5422,
+	      and 5433 SoCs)
 - reg: should contain G-Scaler physical address location and length.
 - interrupts: should contain G-Scaler interrupt number
 
@@ -16,7 +16,7 @@ Optional properties:
 Example:
 
 gsc_0:  gsc at 0x13e00000 {
-	compatible = "samsung,exynos5-gsc";
+	compatible = "samsung,exynos5250-gsc;
 	reg = <0x13e00000 0x1000>;
 	interrupts = <0 85 0>;
 };
-- 
1.9.1
