From: Jason@zx2c4.com (Jason A. Donenfeld)
Date: Wed, 26 Sep 2018 15:51:10 +0200
Subject: [PATCH] arm: support big-endian for the virt architecture
Message-ID: <20180926135110.13061-1-Jason@zx2c4.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This architecture, used for running in QEMU, runs just fine when
compiled in big-endian mode. So enable it. This is enabled in exactly
the same way that it is for other platforms (such as vexpress) that also
support big-endian mode in QEMU successfully.

Signed-off-by: Jason A. Donenfeld <Jason@zx2c4.com>
---
Personally, I'm using this as part of WireGuard's CI, and patching
kernels to include this is a bit annoying. Any chance this can get into
4.19?

 arch/arm/Kconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm/Kconfig b/arch/arm/Kconfig
index e8cd55a5b04c..b8c6062ca0c1 100644
--- a/arch/arm/Kconfig
+++ b/arch/arm/Kconfig
@@ -701,6 +701,7 @@ config ARCH_VIRT
 	select ARM_GIC_V3_ITS if PCI
 	select ARM_PSCI
 	select HAVE_ARM_ARCH_TIMER
+	select ARCH_SUPPORTS_BIG_ENDIAN
 
 #
 # This is sorted alphabetically by mach-* pathname.  However, plat-*
-- 
2.19.0
