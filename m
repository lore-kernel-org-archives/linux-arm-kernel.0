From: swarren@wwwdotorg.org (Stephen Warren)
Date: Tue,  1 Apr 2014 14:13:17 -0600
Subject: [PATCH 3/3] dt: tegra: remove non-existent clock IDs
In-Reply-To: <1396383197-5979-1-git-send-email-swarren@wwwdotorg.org>
References: <1396383197-5979-1-git-send-email-swarren@wwwdotorg.org>
Message-ID: <1396383197-5979-3-git-send-email-swarren@wwwdotorg.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Stephen Warren <swarren@nvidia.com>

The Tegra124 clock DT binding currently provides 3 clocks that don't
actually exist; 2 for NAND and one for UART5/UARTE. Delete these. While
this is technically an incompatible DT ABI change, nothing could have
used these clock IDs for anything practical, since the HW doesn't exist.

Cc: <stable@vger.kernel.org>
Signed-off-by: Stephen Warren <swarren@nvidia.com>
---
This depends on the previous 2 patches. Either all the patches can be
taken through the same tree with acks, or we can hold of applying this
patch until the other two make it into Linus' tree.
---
 include/dt-bindings/clock/tegra124-car.h | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/include/dt-bindings/clock/tegra124-car.h b/include/dt-bindings/clock/tegra124-car.h
index 8c1603b10665..433528ab5161 100644
--- a/include/dt-bindings/clock/tegra124-car.h
+++ b/include/dt-bindings/clock/tegra124-car.h
@@ -29,7 +29,7 @@
 /* 10 (register bit affects spdif_in and spdif_out) */
 #define TEGRA124_CLK_I2S1 11
 #define TEGRA124_CLK_I2C1 12
-#define TEGRA124_CLK_NDFLASH 13
+/* 13 */
 #define TEGRA124_CLK_SDMMC1 14
 #define TEGRA124_CLK_SDMMC4 15
 /* 16 */
@@ -83,7 +83,7 @@
 
 /* 64 */
 #define TEGRA124_CLK_UARTD 65
-#define TEGRA124_CLK_UARTE 66
+/* 66 */
 #define TEGRA124_CLK_I2C3 67
 #define TEGRA124_CLK_SBC4 68
 #define TEGRA124_CLK_SDMMC3 69
@@ -97,7 +97,7 @@
 #define TEGRA124_CLK_TRACE 77
 #define TEGRA124_CLK_SOC_THERM 78
 #define TEGRA124_CLK_DTV 79
-#define TEGRA124_CLK_NDSPEED 80
+/* 80 */
 #define TEGRA124_CLK_I2CSLOW 81
 #define TEGRA124_CLK_DSIB 82
 #define TEGRA124_CLK_TSEC 83
-- 
1.8.1.5
