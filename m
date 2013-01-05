From: olof@lixom.net (Olof Johansson)
Date: Sat,  5 Jan 2013 08:37:33 -0800
Subject: [PATCH] ARM: clps711x: Fix bad merge of clockevents setup
Message-ID: <1357403853-29620-1-git-send-email-olof@lixom.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

I mismerged a previous branch from Alexander, and accidentally left
in ARCH_USES_GETTIMEOFFSET. Remove it.

Signed-off-by: Olof Johansson <olof@lixom.net>
Cc: Alexander Shiyan <shc_work@mail.ru>
---

I have applied this to the fixes branch and will include in the next
upstream pull request.

 arch/arm/Kconfig | 1 -
 1 file changed, 1 deletion(-)

diff --git a/arch/arm/Kconfig b/arch/arm/Kconfig
index f95ba14..ab864d9 100644
--- a/arch/arm/Kconfig
+++ b/arch/arm/Kconfig
@@ -371,7 +371,6 @@ config ARCH_CNS3XXX
 config ARCH_CLPS711X
 	bool "Cirrus Logic CLPS711x/EP721x/EP731x-based"
 	select ARCH_REQUIRE_GPIOLIB
-	select ARCH_USES_GETTIMEOFFSET
 	select AUTO_ZRELADDR
 	select CLKDEV_LOOKUP
 	select COMMON_CLK
-- 
1.7.10.1.488.g05fbf7a
