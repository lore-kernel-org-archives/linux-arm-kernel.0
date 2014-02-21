From: swarren@wwwdotorg.org (Stephen Warren)
Date: Thu, 20 Feb 2014 21:56:33 -0700
Subject: [PATCH] ARM: bcm2835: fix defconfig to select ARCH_BCM
Message-ID: <1392958593-11910-1-git-send-email-swarren@wwwdotorg.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Without this, ARCH_BCM2835 is no longer available, and hence the kernel
won't boot!

Signed-off-by: Stephen Warren <swarren@wwwdotorg.org>
---
I'd expect this to be squashed into "ARM: bcm2835: Move to mach-bcm
directory".

 arch/arm/configs/bcm2835_defconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm/configs/bcm2835_defconfig b/arch/arm/configs/bcm2835_defconfig
index 04dda1e..a442269 100644
--- a/arch/arm/configs/bcm2835_defconfig
+++ b/arch/arm/configs/bcm2835_defconfig
@@ -31,6 +31,7 @@ CONFIG_OPROFILE=y
 CONFIG_JUMP_LABEL=y
 CONFIG_ARCH_MULTI_V6=y
 # CONFIG_ARCH_MULTI_V7 is not set
+CONFIG_ARCH_BCM=y
 CONFIG_ARCH_BCM2835=y
 CONFIG_PREEMPT_VOLUNTARY=y
 CONFIG_AEABI=y
-- 
1.8.3.2
