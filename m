From: ben.dooks@codethink.co.uk (Ben Dooks)
Date: Fri, 30 Aug 2013 20:10:44 +0100
Subject: [PATCH 08/20] highbank: enable big-endian
In-Reply-To: <1377889856-9447-1-git-send-email-ben.dooks@codethink.co.uk>
References: <1377889856-9447-1-git-send-email-ben.dooks@codethink.co.uk>
Message-ID: <1377889856-9447-9-git-send-email-ben.dooks@codethink.co.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Apart from a xgmac driver issue, the highbank seems to work correctly in
big-endian mode. Allow the selection of big-endian in the system.

Signed-off-by: Ben Dooks <ben.dooks@codethink.co.uk>
---
 arch/arm/mach-highbank/Kconfig |    2 ++
 1 file changed, 2 insertions(+)

diff --git a/arch/arm/mach-highbank/Kconfig b/arch/arm/mach-highbank/Kconfig
index cd9fcb1..f82bd88 100644
--- a/arch/arm/mach-highbank/Kconfig
+++ b/arch/arm/mach-highbank/Kconfig
@@ -2,6 +2,7 @@ config ARCH_HIGHBANK
 	bool "Calxeda ECX-1000/2000 (Highbank/Midway)" if ARCH_MULTI_V7
 	select ARCH_HAS_CPUFREQ
 	select ARCH_HAS_OPP
+	select ARCH_SUPPORTS_BIG_ENDIAN
 	select ARCH_WANT_OPTIONAL_GPIOLIB
 	select ARM_AMBA
 	select ARM_GIC
@@ -18,3 +19,4 @@ config ARCH_HIGHBANK
 	select PL320_MBOX
 	select SPARSE_IRQ
 	select USE_OF
+
-- 
1.7.10.4
