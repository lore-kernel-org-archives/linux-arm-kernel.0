From: peron.clem@gmail.com (=?UTF-8?q?Cl=C3=A9ment=20P=C3=A9ron?=)
Date: Thu,  4 Oct 2018 10:54:15 +0200
Subject: [PATCH 3/3] ARM: socfpga: Turn on ARM errata for L2 cache
In-Reply-To: <20181004085415.12925-1-peron.clem@gmail.com>
References: <20181004085415.12925-1-peron.clem@gmail.com>
Message-ID: <20181004085415.12925-3-peron.clem@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Dinh Nguyen <dinguyen@kernel.org>

Turn on these ARM and PL310 errata for SoCFPGA:

ARM_ERRATA_754322
ARM_ERRATA_764369
ARM_ERRATA_775420

PL310_ERRATA_588369
PL310_ERRATA_727915
PL310_ERRATA_753970
PL310_ERRATA_769419

Fixes: 387798b37c8d ("ARM: initial multiplatform support")
Signed-off-by: Dinh Nguyen <dinguyen@kernel.org>
Signed-off-by: Cl?ment P?ron <peron.clem@gmail.com>
---
 arch/arm/mach-socfpga/Kconfig | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/arch/arm/mach-socfpga/Kconfig b/arch/arm/mach-socfpga/Kconfig
index 4adb901dd5eb..a04660918d71 100644
--- a/arch/arm/mach-socfpga/Kconfig
+++ b/arch/arm/mach-socfpga/Kconfig
@@ -11,6 +11,13 @@ menuconfig ARCH_SOCFPGA
 	select HAVE_ARM_TWD if SMP
 	select MFD_SYSCON
 	select PCI_DOMAINS if PCI
+	select ARM_ERRATA_754322
+	select ARM_ERRATA_764369 if SMP
+	select ARM_ERRATA_775420
+	select PL310_ERRATA_588369
+	select PL310_ERRATA_727915
+	select PL310_ERRATA_753970 if PL310
+	select PL310_ERRATA_769419
 
 if ARCH_SOCFPGA
 config SOCFPGA_SUSPEND
-- 
2.17.1
