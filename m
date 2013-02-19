From: horms+renesas@verge.net.au (Simon Horman)
Date: Tue, 19 Feb 2013 11:47:38 +0900
Subject: [PATCH v2 4/8] ARM: shmobile: sh73a0: Remove warning about SMP
In-Reply-To: <1361242062-6957-1-git-send-email-horms+renesas@verge.net.au>
References: <1361242062-6957-1-git-send-email-horms+renesas@verge.net.au>
Message-ID: <1361242062-6957-5-git-send-email-horms+renesas@verge.net.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Remove warning about SMP not working with the
clock initialisation sheme used for reference DT.

This is resolved by not selecting CONFIG_PREEMPT.

Signed-off-by: Simon Horman <horms+renesas@verge.net.au>
---
 arch/arm/mach-shmobile/setup-sh73a0.c |    8 --------
 1 file changed, 8 deletions(-)

diff --git a/arch/arm/mach-shmobile/setup-sh73a0.c b/arch/arm/mach-shmobile/setup-sh73a0.c
index 8f00f3a..00a5e11 100644
--- a/arch/arm/mach-shmobile/setup-sh73a0.c
+++ b/arch/arm/mach-shmobile/setup-sh73a0.c
@@ -823,14 +823,6 @@ void __init sh73a0_add_early_devices(void)
 
 #ifdef CONFIG_USE_OF
 
-/* Please note that the clock initialisation shcheme used in
- * sh73a0_add_early_devices_dt() and sh73a0_add_standard_devices_dt()
- * does not work with SMP as there is a yet to be resolved lock-up in
- * workqueue initialisation.
- *
- * CONFIG_SMP should be disabled when using this code.
- */
-
 void __init sh73a0_add_early_devices_dt(void)
 {
 	shmobile_setup_delay(1196, 44, 46); /* Cortex-A9 @ 1196MHz */
-- 
1.7.10.4
