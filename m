From: horms+renesas@verge.net.au (Simon Horman)
Date: Mon, 25 Aug 2014 10:10:09 +0900
Subject: [PATCH 04/10] ARM: shmobile: sh7372: Use shmobile_init_delay()
In-Reply-To: <cover.1408927601.git.horms+renesas@verge.net.au>
References: <cover.1408927601.git.horms+renesas@verge.net.au>
Message-ID: <39b22e20a3086002c5abe0c569cf11a71bc17faf.1408927601.git.horms+renesas@verge.net.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Magnus Damm <damm+renesas@opensource.se>

Adjust the sh7372 SoC support code to use shmobile_init_delay()
together with CPU Frequency settings from the DTS. Get rid of the
C code version.

Signed-off-by: Magnus Damm <damm+renesas@opensource.se>
Signed-off-by: Simon Horman <horms+renesas@verge.net.au>
---
 arch/arm/mach-shmobile/setup-sh7372.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm/mach-shmobile/setup-sh7372.c b/arch/arm/mach-shmobile/setup-sh7372.c
index 3731ecc..ad7a82d 100644
--- a/arch/arm/mach-shmobile/setup-sh7372.c
+++ b/arch/arm/mach-shmobile/setup-sh7372.c
@@ -984,7 +984,7 @@ void __init sh7372_add_early_devices(void)
 
 void __init sh7372_add_early_devices_dt(void)
 {
-	shmobile_setup_delay(800, 1, 3); /* Cortex-A8 @ 800MHz */
+	shmobile_init_delay();
 
 	sh7372_add_early_devices();
 }
-- 
2.0.1
