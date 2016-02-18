From: k.kozlowski@samsung.com (Krzysztof Kozlowski)
Date: Thu, 18 Feb 2016 14:14:19 +0900
Subject: [PATCH 2/3] thermal: exynos: Document number of supported trip-points
In-Reply-To: <1455772460-20684-1-git-send-email-k.kozlowski@samsung.com>
References: <1455772460-20684-1-git-send-email-k.kozlowski@samsung.com>
Message-ID: <1455772460-20684-2-git-send-email-k.kozlowski@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Document the number of configurable temperature thresholds (for
trip-points in interrupt-driven mode).

Signed-off-by: Krzysztof Kozlowski <k.kozlowski@samsung.com>
---
 Documentation/devicetree/bindings/thermal/exynos-thermal.txt | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/Documentation/devicetree/bindings/thermal/exynos-thermal.txt b/Documentation/devicetree/bindings/thermal/exynos-thermal.txt
index 34315d7fbfde..faa62059b5c5 100644
--- a/Documentation/devicetree/bindings/thermal/exynos-thermal.txt
+++ b/Documentation/devicetree/bindings/thermal/exynos-thermal.txt
@@ -44,6 +44,14 @@
 - vtmu-supply: This entry is optional and provides the regulator node supplying
 		voltage to TMU. If needed this entry can be placed inside
 		board/platform specific dts file.
+
+The Exynos TMU supports generating interrupts when reaching given
+temperature thresholds. Number of supported thermal trip points depends
+on the SoC (only first trip points defined in DT will be configured):
+ - most of SoC: 4
+ - samsung,exynos5433-tmu: 8
+ - samsung,exynos7-tmu: 8
+
 Following properties are mandatory (depending on SoC):
 - samsung,tmu_gain: Gain value for internal TMU operation.
 - samsung,tmu_reference_voltage: Value of TMU IP block's reference voltage
-- 
2.5.0
