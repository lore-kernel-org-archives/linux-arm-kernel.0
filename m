From: lee.jones@linaro.org (Lee Jones)
Date: Mon, 11 Jun 2012 16:25:00 +0100
Subject: [PATCH 07/14] mfd: Initialise the AB8500 driver at core_initcall time
In-Reply-To: <1339428307-3850-1-git-send-email-lee.jones@linaro.org>
References: <1339428307-3850-1-git-send-email-lee.jones@linaro.org>
Message-ID: <1339428307-3850-8-git-send-email-lee.jones@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The AB8500 is soon to have its own IRQ domain. For this to be useful
the driver needs to be initialised earlier in the boot sequence. Here
we move initialisation forward from arch_initcall to core_initcall time.

Cc: Samuel Ortiz <sameo@linux.intel.com>
Signed-off-by: Lee Jones <lee.jones@linaro.org>
---
 drivers/mfd/ab8500-core.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/mfd/ab8500-core.c b/drivers/mfd/ab8500-core.c
index dac0e29..4dc5024 100644
--- a/drivers/mfd/ab8500-core.c
+++ b/drivers/mfd/ab8500-core.c
@@ -1484,7 +1484,7 @@ static void __exit ab8500_core_exit(void)
 {
 	platform_driver_unregister(&ab8500_core_driver);
 }
-arch_initcall(ab8500_core_init);
+core_initcall(ab8500_core_init);
 module_exit(ab8500_core_exit);
 
 MODULE_AUTHOR("Mattias Wallin, Srinidhi Kasagar, Rabin Vincent");
-- 
1.7.9.5
