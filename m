From: pebolle@tiscali.nl (Paul Bolle)
Date: Wed, 06 Mar 2013 10:52:33 +0100
Subject: [PATCH] ARM: mach-bcm: drop "select GENERIC_TIME"
Message-ID: <1362563553.16460.166.camel@x61.thuisdomein>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The Kconfig symbol GENERIC_TIME was removed from the kernel in v2.6.36,
with commit 592913ecb87a9e06f98ddb55b298f1a66bf94c6b ("time: Kill off
CONFIG_GENERIC_TIME"). Somehow this select statement still popped up
recently. It's a nop so we can drop it.

Signed-off-by: Paul Bolle <pebolle@tiscali.nl>
---
Tested with "git grep" only.

 arch/arm/mach-bcm/Kconfig | 1 -
 1 file changed, 1 deletion(-)

diff --git a/arch/arm/mach-bcm/Kconfig b/arch/arm/mach-bcm/Kconfig
index bf02471..be4a0a1 100644
--- a/arch/arm/mach-bcm/Kconfig
+++ b/arch/arm/mach-bcm/Kconfig
@@ -7,7 +7,6 @@ config ARCH_BCM
 	select ARM_GIC
 	select CPU_V7
 	select GENERIC_CLOCKEVENTS
-	select GENERIC_TIME
 	select GPIO_BCM
 	select SPARSE_IRQ
 	select TICK_ONESHOT
-- 
1.7.11.7
