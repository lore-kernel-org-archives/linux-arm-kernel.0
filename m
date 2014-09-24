From: zhangfei.gao@linaro.org (Zhangfei Gao)
Date: Wed, 24 Sep 2014 23:10:01 +0800
Subject: [PATCH] rc: fix hix5hd2 build issue in 0-DAY kernel build
Message-ID: <1411571401-30664-1-git-send-email-zhangfei.gao@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Add dependence of ARCH_HIX5HD2 to solve build error in arch like ia64
error: implicit declaration of function 'readl_relaxed' & 'writel_relaxed'

Change CONFIG_PM to CONFIG_PM_SLEEP to solve
warning: 'hix5hd2_ir_suspend' & 'hix5hd2_ir_resume' defined but not used

Reported-by: Fengguang Wu <fengguang.wu@intel.com>
Signed-off-by: Zhangfei Gao <zhangfei.gao@linaro.org>
---
 drivers/media/rc/Kconfig      |    2 +-
 drivers/media/rc/ir-hix5hd2.c |    2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/media/rc/Kconfig b/drivers/media/rc/Kconfig
index 01e5f7a..ff5a625 100644
--- a/drivers/media/rc/Kconfig
+++ b/drivers/media/rc/Kconfig
@@ -166,7 +166,7 @@ config IR_ENE
 
 config IR_HIX5HD2
 	tristate "Hisilicon hix5hd2 IR remote control"
-	depends on RC_CORE
+	depends on RC_CORE && ARCH_HIX5HD2
 	help
 	 Say Y here if you want to use hisilicon hix5hd2 remote control.
 	 To compile this driver as a module, choose M here: the module will be
diff --git a/drivers/media/rc/ir-hix5hd2.c b/drivers/media/rc/ir-hix5hd2.c
index 64f8257..c1d8527 100644
--- a/drivers/media/rc/ir-hix5hd2.c
+++ b/drivers/media/rc/ir-hix5hd2.c
@@ -289,7 +289,7 @@ static int hix5hd2_ir_remove(struct platform_device *pdev)
 	return 0;
 }
 
-#ifdef CONFIG_PM
+#ifdef CONFIG_PM_SLEEP
 static int hix5hd2_ir_suspend(struct device *dev)
 {
 	struct hix5hd2_ir_priv *priv = dev_get_drvdata(dev);
-- 
1.7.9.5
