From: dinguyen@opensource.altera.com (dinguyen at opensource.altera.com)
Date: Tue, 25 Oct 2016 10:59:19 -0500
Subject: [PATCH] ARM: socfpga_defconfig: Enable HIGHMEM
Message-ID: <1477411159-31558-1-git-send-email-dinguyen@opensource.altera.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Dinh Nguyen <dinguyen@opensource.altera.com>

All of the SoCFPGA boards have at least 1GB of RAM, so enabling HIGHMEM
is necessary to avoid the following warning:

[    0.000000] Truncating RAM at 0x00000000-0x40000000 to -0x30000000
[    0.000000] Consider using a HIGHMEM enabled kernel.

Signed-off-by: Dinh Nguyen <dinguyen@opensource.altera.com>
---
 arch/arm/configs/socfpga_defconfig |    1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm/configs/socfpga_defconfig b/arch/arm/configs/socfpga_defconfig
index 4660506..f5b9bc5 100644
--- a/arch/arm/configs/socfpga_defconfig
+++ b/arch/arm/configs/socfpga_defconfig
@@ -25,6 +25,7 @@ CONFIG_PCIE_ALTERA_MSI=y
 CONFIG_SMP=y
 CONFIG_NR_CPUS=2
 CONFIG_AEABI=y
+CONFIG_HIGHMEM=y
 CONFIG_ZBOOT_ROM_TEXT=0x0
 CONFIG_ZBOOT_ROM_BSS=0x0
 CONFIG_VFP=y
-- 
1.7.9.5
