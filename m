From: robherring2@gmail.com (Rob Herring)
Date: Tue, 11 Feb 2014 15:11:55 -0600
Subject: [PATCH 5/9] ARM: bcm2835: enable V6K instead of plain V6
In-Reply-To: <1392153119-23248-1-git-send-email-robherring2@gmail.com>
References: <1392153119-23248-1-git-send-email-robherring2@gmail.com>
Message-ID: <1392153119-23248-6-git-send-email-robherring2@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Rob Herring <robh@kernel.org>

The bcm2835 is an ARM1176 which has all the V6K extensions except for SMP,
so V6K should be selected instead. Dropping the select will use
the default for ARCH_MULTI_V6 which is V6K.

Signed-off-by: Rob Herring <robh@kernel.org>
Cc: Stephen Warren <swarren@wwwdotorg.org>
---
 arch/arm/mach-bcm2835/Kconfig | 1 -
 1 file changed, 1 deletion(-)

diff --git a/arch/arm/mach-bcm2835/Kconfig b/arch/arm/mach-bcm2835/Kconfig
index 1c0decd..3a36935 100644
--- a/arch/arm/mach-bcm2835/Kconfig
+++ b/arch/arm/mach-bcm2835/Kconfig
@@ -4,7 +4,6 @@ config ARCH_BCM2835
 	select ARM_AMBA
 	select ARM_ERRATA_411920
 	select ARM_TIMER_SP804
-	select CPU_V6
 	select PINCTRL
 	select PINCTRL_BCM2835
 	help
-- 
1.8.3.2
