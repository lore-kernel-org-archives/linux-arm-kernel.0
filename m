From: pankaj.dubey@samsung.com (Pankaj Dubey)
Date: Wed, 26 Feb 2014 14:24:05 +0900
Subject: [PATCH 1/3] drivers: clk: add samsung common clock config option
In-Reply-To: <1393392247-6247-1-git-send-email-pankaj.dubey@samsung.com>
References: <1393392247-6247-1-git-send-email-pankaj.dubey@samsung.com>
Message-ID: <1393392247-6247-2-git-send-email-pankaj.dubey@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

add samsung common clock config option and let ARCH_EXYNOS or ARCH_S3CXXXX
select this if they want to use samsung common clock infrastructure.

CC: Mike Turquette <mturquette@linaro.org>
Signed-off-by: Pankaj Dubey <pankaj.dubey@samsung.com>
---
 drivers/clk/Kconfig  |   10 ++++++++++
 drivers/clk/Makefile |    2 +-
 2 files changed, 11 insertions(+), 1 deletion(-)

diff --git a/drivers/clk/Kconfig b/drivers/clk/Kconfig
index 7641965..d93a325 100644
--- a/drivers/clk/Kconfig
+++ b/drivers/clk/Kconfig
@@ -23,6 +23,16 @@ config COMMON_CLK
 menu "Common Clock Framework"
 	depends on COMMON_CLK
 
+config COMMON_CLK_SAMSUNG
+	bool "Clock driver for Samsung SoCs"
+	depends on ARCH_S3C64XX || ARCH_S3C24XX || ARCH_EXYNOS || ARM64
+	---help---
+          Supports clocking on Exynos SoCs:
+	  - Exynos5250, Exynos5420 board.
+	  - Exynos4 boards.
+	  - S3C2412, S3C2416, S3C2466 boards.
+	  - S3C64XX boards.
+
 config COMMON_CLK_WM831X
 	tristate "Clock driver for WM831x/2x PMICs"
 	depends on MFD_WM831X
diff --git a/drivers/clk/Makefile b/drivers/clk/Makefile
index a367a98..f1da6ee 100644
--- a/drivers/clk/Makefile
+++ b/drivers/clk/Makefile
@@ -38,7 +38,7 @@ obj-$(CONFIG_PLAT_ORION)		+= mvebu/
 obj-$(CONFIG_ARCH_MXS)			+= mxs/
 obj-$(CONFIG_COMMON_CLK_QCOM)		+= qcom/
 obj-$(CONFIG_ARCH_ROCKCHIP)		+= rockchip/
-obj-$(CONFIG_PLAT_SAMSUNG)		+= samsung/
+obj-$(CONFIG_COMMON_CLK_SAMSUNG)	+= samsung/
 obj-$(CONFIG_ARCH_SHMOBILE_MULTI)	+= shmobile/
 obj-$(CONFIG_ARCH_SIRF)			+= sirf/
 obj-$(CONFIG_ARCH_SOCFPGA)		+= socfpga/
-- 
1.7.9.5
