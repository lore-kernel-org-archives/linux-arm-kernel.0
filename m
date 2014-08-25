From: horms+renesas@verge.net.au (Simon Horman)
Date: Mon, 25 Aug 2014 10:10:13 +0900
Subject: [PATCH 08/10] ARM: shmobile: r8a7778: Use shmobile_init_delay()
In-Reply-To: <cover.1408927601.git.horms+renesas@verge.net.au>
References: <cover.1408927601.git.horms+renesas@verge.net.au>
Message-ID: <6fe950ebfd3a374c78ce66a335fce258648426a1.1408927601.git.horms+renesas@verge.net.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Magnus Damm <damm+renesas@opensource.se>

Adjust the r8a7778 SoC support code to use shmobile_init_delay()
together with CPU Frequency settings from the DTS. Get rid of the
C code version.

Signed-off-by: Magnus Damm <damm+renesas@opensource.se>
Signed-off-by: Simon Horman <horms+renesas@verge.net.au>
---
 arch/arm/mach-shmobile/setup-r8a7778.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm/mach-shmobile/setup-r8a7778.c b/arch/arm/mach-shmobile/setup-r8a7778.c
index e1a477b..85fe016 100644
--- a/arch/arm/mach-shmobile/setup-r8a7778.c
+++ b/arch/arm/mach-shmobile/setup-r8a7778.c
@@ -574,7 +574,7 @@ void __init r8a7778_init_irq_extpin(int irlm)
 
 void __init r8a7778_init_delay(void)
 {
-	shmobile_setup_delay(800, 1, 3); /* Cortex-A9 @ 800MHz */
+	shmobile_init_delay();
 }
 
 #ifdef CONFIG_USE_OF
-- 
2.0.1
