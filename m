From: shawnguo@kernel.org (Shawn Guo)
Date: Mon, 13 Jul 2015 16:11:15 +0800
Subject: [PATCH] rtc: snvs: select option REGMAP_MMIO
Message-ID: <1436775075-15037-1-git-send-email-shawnguo@kernel.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Select REGMAP_MMIO to fix the following build error seen with x86_64
randconfig.

  drivers/built-in.o: In function `snvs_rtc_probe':
rtc-snvs.c:(.text+0x567730): undefined reference to `devm_regmap_init_mmio_clk'

Reported-by: kbuild test robot <fengguang.wu@intel.com>
Signed-off-by: Shawn Guo <shawnguo@kernel.org>
---
This is a fix to patch "rtc: snvs: use syscon to access register",
which I queued on IMX tree for 4.3.  So I will apply it to the same
branch.

Shawn

 drivers/rtc/Kconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/rtc/Kconfig b/drivers/rtc/Kconfig
index 83b4b89b9d5a..533bfa3b6039 100644
--- a/drivers/rtc/Kconfig
+++ b/drivers/rtc/Kconfig
@@ -1523,6 +1523,7 @@ config RTC_DRV_MXC
 
 config RTC_DRV_SNVS
 	tristate "Freescale SNVS RTC support"
+	select REGMAP_MMIO
 	depends on HAS_IOMEM
 	depends on OF
 	help
-- 
1.9.1
