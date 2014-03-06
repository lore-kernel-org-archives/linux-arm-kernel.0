From: tushar.behera@linaro.org (Tushar Behera)
Date: Thu,  6 Mar 2014 11:34:44 +0530
Subject: [PATCH 2/2] dt-bindings: clock: Move exynos-audss-clk.h to
 dt-bindings/clock
In-Reply-To: <1394085884-13081-1-git-send-email-tushar.behera@linaro.org>
References: <1394085884-13081-1-git-send-email-tushar.behera@linaro.org>
Message-ID: <1394085884-13081-3-git-send-email-tushar.behera@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Most of the clock related dt-binding header files are located in
dt-bindings/clock folder. It would be good to keep all the similar
header files at a single location.

Signed-off-by: Tushar Behera <tushar.behera@linaro.org>
CC: Kukjin Kim <kgene.kim@samsung.com>
CC: Tomasz Figa <t.figa@samsung.com>
---
 arch/arm/boot/dts/exynos5250.dtsi                  |    2 +-
 arch/arm/boot/dts/exynos5420.dtsi                  |    2 +-
 drivers/clk/samsung/clk-exynos-audss.c             |    2 +-
 .../dt-bindings/{clk => clock}/exynos-audss-clk.h  |    0
 4 files changed, 3 insertions(+), 3 deletions(-)
 rename include/dt-bindings/{clk => clock}/exynos-audss-clk.h (100%)

diff --git a/arch/arm/boot/dts/exynos5250.dtsi b/arch/arm/boot/dts/exynos5250.dtsi
index 8f6300f..2048012 100644
--- a/arch/arm/boot/dts/exynos5250.dtsi
+++ b/arch/arm/boot/dts/exynos5250.dtsi
@@ -20,7 +20,7 @@
 #include "exynos5.dtsi"
 #include "exynos5250-pinctrl.dtsi"
 
-#include <dt-bindings/clk/exynos-audss-clk.h>
+#include <dt-bindings/clock/exynos-audss-clk.h>
 
 / {
 	compatible = "samsung,exynos5250";
diff --git a/arch/arm/boot/dts/exynos5420.dtsi b/arch/arm/boot/dts/exynos5420.dtsi
index 45e2e65..64c7f6d 100644
--- a/arch/arm/boot/dts/exynos5420.dtsi
+++ b/arch/arm/boot/dts/exynos5420.dtsi
@@ -16,7 +16,7 @@
 #include "exynos5.dtsi"
 #include "exynos5420-pinctrl.dtsi"
 
-#include <dt-bindings/clk/exynos-audss-clk.h>
+#include <dt-bindings/clock/exynos-audss-clk.h>
 
 / {
 	compatible = "samsung,exynos5420";
diff --git a/drivers/clk/samsung/clk-exynos-audss.c b/drivers/clk/samsung/clk-exynos-audss.c
index 884187f..13eae14c 100644
--- a/drivers/clk/samsung/clk-exynos-audss.c
+++ b/drivers/clk/samsung/clk-exynos-audss.c
@@ -17,7 +17,7 @@
 #include <linux/module.h>
 #include <linux/platform_device.h>
 
-#include <dt-bindings/clk/exynos-audss-clk.h>
+#include <dt-bindings/clock/exynos-audss-clk.h>
 
 enum exynos_audss_clk_type {
 	TYPE_EXYNOS4210,
diff --git a/include/dt-bindings/clk/exynos-audss-clk.h b/include/dt-bindings/clock/exynos-audss-clk.h
similarity index 100%
rename from include/dt-bindings/clk/exynos-audss-clk.h
rename to include/dt-bindings/clock/exynos-audss-clk.h
-- 
1.7.9.5
