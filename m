From: thunder.leizhen@huawei.com (Zhen Lei)
Date: Mon, 28 Sep 2015 13:34:37 +0800
Subject: [PATCH 1/2] char/rtc: to allow EFI_RTC can be selected on ARM64
In-Reply-To: <1443418478-8240-1-git-send-email-thunder.leizhen@huawei.com>
References: <1443418478-8240-1-git-send-email-thunder.leizhen@huawei.com>
Message-ID: <1443418478-8240-2-git-send-email-thunder.leizhen@huawei.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Now, ARM64 is also support EFI startup. We hope use EFI runtime services
to get/set current time and date.

Slightly adjust to keep a line not exceed 80 characters.

Signed-off-by: Zhen Lei <thunder.leizhen@huawei.com>
---
 drivers/char/Kconfig | 9 ++++++---
 1 file changed, 6 insertions(+), 3 deletions(-)

diff --git a/drivers/char/Kconfig b/drivers/char/Kconfig
index a043107..7ad3fd1 100644
--- a/drivers/char/Kconfig
+++ b/drivers/char/Kconfig
@@ -280,7 +280,8 @@ if RTC_LIB=n
 config RTC
 	tristate "Enhanced Real Time Clock Support (legacy PC RTC driver)"
 	depends on !PPC && !PARISC && !IA64 && !M68K && !SPARC && !FRV \
-			&& !ARM && !SUPERH && !S390 && !AVR32 && !BLACKFIN && !UML
+			&& !ARM && !ARM64 && !SUPERH && !S390 && !AVR32 \
+			&& !BLACKFIN && !UML
 	---help---
 	  If you say Y here and create a character special file /dev/rtc with
 	  major number 10 and minor number 135 using mknod ("man mknod"), you
@@ -328,7 +329,9 @@ config JS_RTC

 config GEN_RTC
 	tristate "Generic /dev/rtc emulation"
-	depends on RTC!=y && !IA64 && !ARM && !M32R && !MIPS && !SPARC && !FRV && !S390 && !SUPERH && !AVR32 && !BLACKFIN && !UML
+	depends on RTC!=y && !IA64 && !ARM && !ARM64 && !M32R && !MIPS \
+			&& !SPARC && !FRV && !S390 && !SUPERH && !AVR32 \
+			&& !BLACKFIN && !UML
 	---help---
 	  If you say Y here and create a character special file /dev/rtc with
 	  major number 10 and minor number 135 using mknod ("man mknod"), you
@@ -353,7 +356,7 @@ config GEN_RTC_X

 config EFI_RTC
 	bool "EFI Real Time Clock Services"
-	depends on IA64
+	depends on IA64 || ARM64

 config DS1302
 	tristate "DS1302 RTC support"
--
2.5.0
