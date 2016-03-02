From: arnd@arndb.de (Arnd Bergmann)
Date: Wed,  2 Mar 2016 10:48:50 +0100
Subject: [PATCH 1/2] char: PC rtc: replace blacklist with whitelist
Message-ID: <1456912137-1578635-1-git-send-email-arnd@arndb.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Every new architecture has to add itself to the growing list of those
that do not support the legacy PC RTC driver.

This replaces the long list of architectures that don't support it
with a shorter list of those that do.

The list is taken from those architectures that have a non-empty
asm/mc146818rtc.h header file and were not explicitly blacklisted.

Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
 drivers/char/Kconfig | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/char/Kconfig b/drivers/char/Kconfig
index a043107da2af..9716bc36495a 100644
--- a/drivers/char/Kconfig
+++ b/drivers/char/Kconfig
@@ -279,8 +279,7 @@ if RTC_LIB=n
 
 config RTC
 	tristate "Enhanced Real Time Clock Support (legacy PC RTC driver)"
-	depends on !PPC && !PARISC && !IA64 && !M68K && !SPARC && !FRV \
-			&& !ARM && !SUPERH && !S390 && !AVR32 && !BLACKFIN && !UML
+	depends on ALPHA || M32R || M68K || MIPS || MN10300 || PPC || X86
 	---help---
 	  If you say Y here and create a character special file /dev/rtc with
 	  major number 10 and minor number 135 using mknod ("man mknod"), you
-- 
2.7.0
