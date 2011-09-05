From: ben@decadent.org.uk (Ben Hutchings)
Date: Mon, 05 Sep 2011 04:12:56 +0100
Subject: [PATCH] arm: ixp4xx, u300: Select ARCH_REQUIRE_GPIOLIB, not
	GENERIC_GPIO
Message-ID: <1315192383.3092.260.camel@deadeye>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The GPIO implementations for these two machines depend on gpiolib,
so they must not select GENERIC_GPIO directly.

Signed-off-by: Ben Hutchings <ben@decadent.org.uk>
---
This hould fix the build failure seen here:
https://buildd.debian.org/status/fetch.php?pkg=linux-2.6&arch=armel&ver=3.1.0%7Erc4-1%7Eexperimental.1&stamp=1315007168

However, I have not yet tested it.

Ben.

 arch/arm/Kconfig |    4 ++--
 1 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/arm/Kconfig b/arch/arm/Kconfig
index f23712d..a1dbc4b 100644
--- a/arch/arm/Kconfig
+++ b/arch/arm/Kconfig
@@ -477,7 +477,7 @@ config ARCH_IXP4XX
 	depends on MMU
 	select CLKSRC_MMIO
 	select CPU_XSCALE
-	select GENERIC_GPIO
+	select ARCH_REQUIRE_GPIOLIB
 	select GENERIC_CLOCKEVENTS
 	select HAVE_SCHED_CLOCK
 	select MIGHT_HAVE_PCI
@@ -830,7 +830,7 @@ config ARCH_U300
 	select GENERIC_CLOCKEVENTS
 	select CLKDEV_LOOKUP
 	select HAVE_MACH_CLKDEV
-	select GENERIC_GPIO
+	select ARCH_REQUIRE_GPIOLIB
 	help
 	  Support for ST-Ericsson U300 series mobile platforms.
 
-- 
1.7.5.4


-------------- next part --------------
A non-text attachment was scrubbed...
Name: not available
Type: application/pgp-signature
Size: 828 bytes
Desc: This is a digitally signed message part
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20110905/ab978c83/attachment.sig>
