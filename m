From: fabio.baltieri@linaro.org (Fabio Baltieri)
Date: Fri, 26 Apr 2013 14:17:15 +0200
Subject: [PATCH 2/5] mfd: ab8500-sysctrl: fix sparse warning
In-Reply-To: <1366978638-967-1-git-send-email-fabio.baltieri@linaro.org>
References: <1366978638-967-1-git-send-email-fabio.baltieri@linaro.org>
Message-ID: <1366978638-967-3-git-send-email-fabio.baltieri@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Fix sparse warning:

drivers/mfd/ab8500-sysctrl.c:26:6: warning: symbol 'ab8500_power_off' was not declared. Should it be static?

Signed-off-by: Fabio Baltieri <fabio.baltieri@linaro.org>
---
 drivers/mfd/ab8500-sysctrl.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/mfd/ab8500-sysctrl.c b/drivers/mfd/ab8500-sysctrl.c
index fbca1ce..640495e 100644
--- a/drivers/mfd/ab8500-sysctrl.c
+++ b/drivers/mfd/ab8500-sysctrl.c
@@ -23,7 +23,7 @@
 
 static struct device *sysctrl_dev;
 
-void ab8500_power_off(void)
+static void ab8500_power_off(void)
 {
 	sigset_t old;
 	sigset_t all;
-- 
1.8.1.3
