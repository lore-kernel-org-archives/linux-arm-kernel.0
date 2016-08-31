From: leo.yan@linaro.org (Leo Yan)
Date: Wed, 31 Aug 2016 16:50:15 +0800
Subject: [PATCH 1/3] clk: Hi6220: enable stub clock driver for ARCH_HISI
In-Reply-To: <1472633417-9330-1-git-send-email-leo.yan@linaro.org>
References: <1472633417-9330-1-git-send-email-leo.yan@linaro.org>
Message-ID: <1472633417-9330-2-git-send-email-leo.yan@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

In current kernel config 'CONFIG_STUB_CLK_HI6220' is disabled by
default, as result stub clock driver has not been registered and
CPUFreq driver cannot work.

This patch is to enable stub clock driver in config for ARCH_HISI.

Reported-by: Dietmar Eggemann <dietmar.eggemann@arm.com>
Signed-off-by: Leo Yan <leo.yan@linaro.org>
---
 drivers/clk/hisilicon/Kconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/clk/hisilicon/Kconfig b/drivers/clk/hisilicon/Kconfig
index 3f537a0..9e0a95e 100644
--- a/drivers/clk/hisilicon/Kconfig
+++ b/drivers/clk/hisilicon/Kconfig
@@ -23,5 +23,6 @@ config RESET_HISI
 config STUB_CLK_HI6220
 	bool "Hi6220 Stub Clock Driver"
 	depends on COMMON_CLK_HI6220 && MAILBOX
+	default ARCH_HISI
 	help
 	  Build the Hisilicon Hi6220 stub clock driver.
-- 
1.9.1
