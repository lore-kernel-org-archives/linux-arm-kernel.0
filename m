From: horms+renesas@verge.net.au (Simon Horman)
Date: Wed, 16 Apr 2014 15:03:44 +0900
Subject: [PATCH 1/8] ARM: shmobile: Update r8a7791 CPU freq to 1500MHz in C
In-Reply-To: <cover.1397627619.git.horms+renesas@verge.net.au>
References: <cover.1397627619.git.horms+renesas@verge.net.au>
Message-ID: <ce4b6a04c49b0b414d537b45ededd9dfd4e48336.1397627619.git.horms+renesas@verge.net.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Magnus Damm <damm@opensource.se>

The correct maximum CPU frequency for r8a7791 is 1500 MHz
so update the r8a7791 SoC C code to reflect this.

Signed-off-by: Magnus Damm <damm@opensource.se>
Signed-off-by: Simon Horman <horms+renesas@verge.net.au>
---
 arch/arm/mach-shmobile/setup-r8a7791.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm/mach-shmobile/setup-r8a7791.c b/arch/arm/mach-shmobile/setup-r8a7791.c
index e28404e..a7e4966 100644
--- a/arch/arm/mach-shmobile/setup-r8a7791.c
+++ b/arch/arm/mach-shmobile/setup-r8a7791.c
@@ -213,7 +213,7 @@ void __init r8a7791_add_standard_devices(void)
 void __init r8a7791_init_early(void)
 {
 #ifndef CONFIG_ARM_ARCH_TIMER
-	shmobile_setup_delay(1300, 2, 4); /* Cortex-A15 @ 1300MHz */
+	shmobile_setup_delay(1500, 2, 4); /* Cortex-A15 @ 1500MHz */
 #endif
 }
 
-- 
1.8.5.2
