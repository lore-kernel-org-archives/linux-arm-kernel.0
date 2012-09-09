From: linus.walleij@linaro.org (Linus Walleij)
Date: Sun,  9 Sep 2012 10:12:28 +0200
Subject: [PATCH] ARM: mark kernelmode mem{cpy,set} non-experimental
Message-ID: <1347178348-9522-1-git-send-email-linus.walleij@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This feature was added in 2009, I've been using it off and on and
never had any problems with it on my systems. I cannot see why
it needs to be marked experimental, make it a normal feature and
let us discover its possible shortcomings as people try to turn
it on instead.

Cc: Lennert Buytenhek <kernel@wantstofly.org>
Cc: Nicolas Pitre <nico@fluxnic.net>
Cc: Russell King <linux@arm.linux.org.uk>
Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
---
 arch/arm/Kconfig | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/arm/Kconfig b/arch/arm/Kconfig
index 2f88d8d..e040b47 100644
--- a/arch/arm/Kconfig
+++ b/arch/arm/Kconfig
@@ -1849,8 +1849,8 @@ config ALIGNMENT_TRAP
 	  configuration it is safe to say N, otherwise say Y.
 
 config UACCESS_WITH_MEMCPY
-	bool "Use kernel mem{cpy,set}() for {copy_to,clear}_user() (EXPERIMENTAL)"
-	depends on MMU && EXPERIMENTAL
+	bool "Use kernel mem{cpy,set}() for {copy_to,clear}_user()"
+	depends on MMU
 	default y if CPU_FEROCEON
 	help
 	  Implement faster copy_to_user and clear_user methods for CPU
-- 
1.7.11.4
