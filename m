From: ulf.hansson@stericsson.com (Ulf Hansson)
Date: Wed, 3 Apr 2013 01:06:27 +0200
Subject: [PATCH 3/3] mfd: ab8500: sysctrl: Initialize driver at arch_initcall
In-Reply-To: <1364943987-1338-1-git-send-email-ulf.hansson@stericsson.com>
References: <1364943987-1338-1-git-send-email-ulf.hansson@stericsson.com>
Message-ID: <1364943987-1338-4-git-send-email-ulf.hansson@stericsson.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Ulf Hansson <ulf.hansson@linaro.org>

The abx500-clk driver is initiated at arch_initcall level. Moreover it
is relying on the ab8500-sysctrl API to be available. Therefore move
ab8500-sysctrl to arch_initcall level as well. The device is already
added before the abx500 clk device, thus it will be probed before as
well, which is exactly what we want.

Signed-off-by: Ulf Hansson <ulf.hansson@linaro.org>
Cc: Samuel Ortiz <sameo@linux.intel.com>
---
 drivers/mfd/ab8500-sysctrl.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/mfd/ab8500-sysctrl.c b/drivers/mfd/ab8500-sysctrl.c
index 108fd86..3b65053 100644
--- a/drivers/mfd/ab8500-sysctrl.c
+++ b/drivers/mfd/ab8500-sysctrl.c
@@ -166,7 +166,7 @@ static int __init ab8500_sysctrl_init(void)
 {
 	return platform_driver_register(&ab8500_sysctrl_driver);
 }
-subsys_initcall(ab8500_sysctrl_init);
+arch_initcall(ab8500_sysctrl_init);
 
 MODULE_AUTHOR("Mattias Nilsson <mattias.i.nilsson@stericsson.com");
 MODULE_DESCRIPTION("AB8500 system control driver");
-- 
1.7.10
