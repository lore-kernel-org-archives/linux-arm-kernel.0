From: pankaj.dubey@samsung.com (Pankaj Dubey)
Date: Fri, 25 Apr 2014 20:54:17 +0900
Subject: [PATCH v2 5/5] Documentation: update samsung pmu binding information
In-Reply-To: <1398426857-5097-1-git-send-email-pankaj.dubey@samsung.com>
References: <1396425778-4379-1-git-send-email-pankaj.dubey@samsung.com>
 <1398426857-5097-1-git-send-email-pankaj.dubey@samsung.com>
Message-ID: <1398426857-5097-6-git-send-email-pankaj.dubey@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patch updates samsung pmu (power management unit) binding information.

CC: Leela Krishna Amudala <l.krishna@samsung.com>
CC: Guenter Roeck <linux@roeck-us.net>
CC: Rob Landley <rob@landley.net>
Signed-off-by: Pankaj Dubey <pankaj.dubey@samsung.com>
---
 Documentation/devicetree/bindings/arm/samsung/pmu.txt |    7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/Documentation/devicetree/bindings/arm/samsung/pmu.txt b/Documentation/devicetree/bindings/arm/samsung/pmu.txt
index f1f1552..ac9b45c 100644
--- a/Documentation/devicetree/bindings/arm/samsung/pmu.txt
+++ b/Documentation/devicetree/bindings/arm/samsung/pmu.txt
@@ -2,14 +2,21 @@ SAMSUNG Exynos SoC series PMU Registers
 
 Properties:
  - compatible : should contain two values. First value must be one from following list:
+		   - "samsung,exynos4210-pmu" - for Exynos4210 SoC,
+		   - "samsung,exynos4212-pmu" - for Exynos4212 SoC,
+		   - "samsung,exynos4412-pmu" - for Exynos4412 SoC,
 		   - "samsung,exynos5250-pmu" - for Exynos5250 SoC,
 		   - "samsung,exynos5420-pmu" - for Exynos5420 SoC.
 		second value must be always "syscon".
 
  - reg : offset and length of the register set.
 
+ - samsung,syscon-phandle : reference to syscon node. This property points to syscon node
+		holding the PMU base address.
+
 Example :
 pmu_system_controller: system-controller at 10040000 {
 	compatible = "samsung,exynos5250-pmu", "syscon";
 	reg = <0x10040000 0x5000>;
+	samsung,syscon-phandle = <&pmu_system_controller>;
 };
-- 
1.7.10.4
