From: ben.dooks@codethink.co.uk (Ben Dooks)
Date: Fri,  8 Feb 2013 23:17:33 +0000
Subject: [PATCH 03/17] ARM: fix ARCH_IXP4xx usage of ARCH_SUPPORTS_BIG_ENDIAN
In-Reply-To: <1360365467-25056-1-git-send-email-ben.dooks@codethink.co.uk>
References: <1360365467-25056-1-git-send-email-ben.dooks@codethink.co.uk>
Message-ID: <1360365467-25056-4-git-send-email-ben.dooks@codethink.co.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The Kconfig for arch/arm/mach-ixp4xx has a copy of the
definition of ARCH_SUPPORTS_BIG_ENDIAN which defaults
to yes. This means that if IXP4xx is selected and this
symbol is selected elswhere then an warning is produced.

Clean the following error up by making the symbol be
selected by the main ARCH_IXP4XX definition.

warning: (ARCH_xxx) selects ARCH_SUPPORTS_BIG_ENDIAN which has unmet direct dependencies (ARCH_IXP4XX)
warning: (ARCH_xxx) selects ARCH_SUPPORTS_BIG_ENDIAN which has unmet direct dependencies (ARCH_IXP4XX)
---
 arch/arm/Kconfig             |    1 +
 arch/arm/mach-ixp4xx/Kconfig |    4 ----
 2 files changed, 1 insertion(+), 4 deletions(-)

diff --git a/arch/arm/Kconfig b/arch/arm/Kconfig
index 67874b8..d3f6c4f 100644
--- a/arch/arm/Kconfig
+++ b/arch/arm/Kconfig
@@ -517,6 +517,7 @@ config ARCH_IXP4XX
 	bool "IXP4xx-based"
 	depends on MMU
 	select ARCH_HAS_DMA_SET_COHERENT_MASK
+	select ARCH_SUPPORTS_BIG_ENDIAN
 	select ARCH_REQUIRE_GPIOLIB
 	select CLKSRC_MMIO
 	select CPU_XSCALE
diff --git a/arch/arm/mach-ixp4xx/Kconfig b/arch/arm/mach-ixp4xx/Kconfig
index 73a2d90..72de05f 100644
--- a/arch/arm/mach-ixp4xx/Kconfig
+++ b/arch/arm/mach-ixp4xx/Kconfig
@@ -1,9 +1,5 @@
 if ARCH_IXP4XX
 
-config ARCH_SUPPORTS_BIG_ENDIAN
-	bool
-	default y
-
 menu "Intel IXP4xx Implementation Options"
 
 comment "IXP4xx Platforms"
-- 
1.7.10.4
