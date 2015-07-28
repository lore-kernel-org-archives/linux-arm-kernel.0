From: lftan@altera.com (Ley Foon Tan)
Date: Tue, 28 Jul 2015 18:45:41 +0800
Subject: [PATCH 2/6] arm: mach-socfpga: enable pci support
In-Reply-To: <1438080345-7233-1-git-send-email-lftan@altera.com>
References: <1438080345-7233-1-git-send-email-lftan@altera.com>
Message-ID: <1438080345-7233-3-git-send-email-lftan@altera.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Enable CONFIG_ARCH_SUPPORT_MSI and CONFIG_PCI in SOCFPGA platform.

Signed-off-by: Ley Foon Tan <lftan@altera.com>
---
 arch/arm/mach-socfpga/Kconfig | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/arch/arm/mach-socfpga/Kconfig b/arch/arm/mach-socfpga/Kconfig
index 90efdeb..7ff4576 100644
--- a/arch/arm/mach-socfpga/Kconfig
+++ b/arch/arm/mach-socfpga/Kconfig
@@ -1,6 +1,7 @@
 menuconfig ARCH_SOCFPGA
 	bool "Altera SOCFPGA family" if ARCH_MULTI_V7
 	select ARCH_SUPPORTS_BIG_ENDIAN
+	select ARCH_SUPPORTS_MSI
 	select ARM_AMBA
 	select ARM_GIC
 	select CACHE_L2X0
@@ -9,6 +10,7 @@ menuconfig ARCH_SOCFPGA
 	select HAVE_ARM_SCU
 	select HAVE_ARM_TWD if SMP
 	select MFD_SYSCON
+	select PCI
 
 if ARCH_SOCFPGA
 config SOCFPGA_SUSPEND
-- 
1.8.2.1
