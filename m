From: arnd@arndb.de (Arnd Bergmann)
Date: Sat,  1 Oct 2011 22:03:50 +0200
Subject: [PATCH 18/26] ARM: pxa: MTD_XIP is not actually working any more
In-Reply-To: <1317499438-14058-1-git-send-email-arnd@arndb.de>
References: <1317499438-14058-1-git-send-email-arnd@arndb.de>
Message-ID: <1317499438-14058-19-git-send-email-arnd@arndb.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The headers files required for XIP support have moved around
over the last few years, and the code no longer builds.
Until someone fixes this, let's just disable support, leaving
sa1100 as the only platform still supporting xip.

Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
 arch/arm/Kconfig |    1 -
 1 files changed, 0 insertions(+), 1 deletions(-)

diff --git a/arch/arm/Kconfig b/arch/arm/Kconfig
index 570c9fd..71b0ccb 100644
--- a/arch/arm/Kconfig
+++ b/arch/arm/Kconfig
@@ -619,7 +619,6 @@ config ARCH_PNX4008
 config ARCH_PXA
 	bool "PXA2xx/PXA3xx-based"
 	depends on MMU
-	select ARCH_MTD_XIP
 	select ARCH_HAS_CPUFREQ
 	select CLKDEV_LOOKUP
 	select CLKSRC_MMIO
-- 
1.7.5.4
