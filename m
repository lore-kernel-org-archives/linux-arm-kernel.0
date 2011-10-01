From: arnd@arndb.de (Arnd Bergmann)
Date: Sat,  1 Oct 2011 22:03:54 +0200
Subject: [PATCH 22/26] ARM: pxa: only select SMC91x on xcep when networking is
	enabled
In-Reply-To: <1317499438-14058-1-git-send-email-arnd@arndb.de>
References: <1317499438-14058-1-git-send-email-arnd@arndb.de>
Message-ID: <1317499438-14058-23-git-send-email-arnd@arndb.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The smc91x driver is not strictly required for xcep, but it
can only be enabled if ethernet support is built into the
kernel, so make the dependency more specific.

Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
 arch/arm/mach-pxa/Kconfig |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/arch/arm/mach-pxa/Kconfig b/arch/arm/mach-pxa/Kconfig
index 491c522..ef35ce9 100644
--- a/arch/arm/mach-pxa/Kconfig
+++ b/arch/arm/mach-pxa/Kconfig
@@ -174,7 +174,7 @@ config MACH_XCEP
 	select MTD_CFI_INTELEXT
 	select MTD_CFI
 	select MTD_CHAR
-	select SMC91X
+	select SMC91X if NET_ETHERNET
 	help
 	  PXA255 based Single Board Computer with SMC 91C111 ethernet chip and 64 MB of flash.
 	  Tuned for usage in Libera instruments for particle accelerators.
-- 
1.7.5.4
