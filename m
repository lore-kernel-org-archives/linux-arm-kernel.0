From: nicolas.ferre@atmel.com (Nicolas Ferre)
Date: Thu, 15 Mar 2012 14:00:10 +0100
Subject: [PATCH 2/6] ARM: at91/Kconfig: change at91sam9g45 entry
In-Reply-To: <feb3f4c639fae3f01636ba2017968fac1078ddca.1331816340.git.nicolas.ferre@atmel.com>
References: <feb3f4c639fae3f01636ba2017968fac1078ddca.1331816340.git.nicolas.ferre@atmel.com>
Message-ID: <363ddfb6d06a14366d523c70d4f890f974e7cb80.1331816340.git.nicolas.ferre@atmel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The AT91SAM9G45 entry covers the whole family so we also add the AT91SAM9M10
name and the "families" qualifier. Then, add a comment to explain which SoCs
are supported by this entry: AT91SAM9G45, AT91SAM9G46 but also
AT91SAM9M10 and AT91SAM9M11.

Signed-off-by: Nicolas Ferre <nicolas.ferre@atmel.com>
---
 arch/arm/mach-at91/Kconfig |    5 ++++-
 1 files changed, 4 insertions(+), 1 deletions(-)

diff --git a/arch/arm/mach-at91/Kconfig b/arch/arm/mach-at91/Kconfig
index e55cdcb..5f0fe11 100644
--- a/arch/arm/mach-at91/Kconfig
+++ b/arch/arm/mach-at91/Kconfig
@@ -93,7 +93,7 @@ config ARCH_AT91SAM9G20
 	select AT91_SAM9_ALT_RESET
 
 config ARCH_AT91SAM9G45
-	bool "AT91SAM9G45"
+	bool "AT91SAM9G45 or AT91SAM9M10 families"
 	select CPU_ARM926T
 	select GENERIC_CLOCKEVENTS
 	select HAVE_AT91_USART3
@@ -101,6 +101,9 @@ config ARCH_AT91SAM9G45
 	select HAVE_NET_MACB
 	select HAVE_AT91_DBGU1
 	select AT91_SAM9G45_RESET
+	help
+	  Select this if you are using one of Atmel's AT91SAM9G45 family SoC.
+	  This support covers AT91SAM9G45, AT91SAM9G46, AT91SAM9M10 and AT91SAM9M11.
 
 config ARCH_AT91SAM9X5
 	bool "AT91SAM9x5 family"
-- 
1.7.9
