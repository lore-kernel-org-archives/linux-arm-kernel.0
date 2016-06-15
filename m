From: dinguyen@kernel.org (Dinh Nguyen)
Date: Wed, 15 Jun 2016 13:13:26 -0500
Subject: [PATCH] ARM: socfpga: enable PL330 DMA in socfpga_defconfig
Message-ID: <1466014406-28469-1-git-send-email-dinguyen@kernel.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Enable the PL330 DMA on SoCFPGA.

make savedefconfig says CONFIG_FHANDLE is not needed in the defconfig,
remove it.

Signed-off-by: Dinh Nguyen <dinguyen@kernel.org>
---
 arch/arm/configs/socfpga_defconfig | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/arch/arm/configs/socfpga_defconfig b/arch/arm/configs/socfpga_defconfig
index c267137..541a729 100644
--- a/arch/arm/configs/socfpga_defconfig
+++ b/arch/arm/configs/socfpga_defconfig
@@ -1,5 +1,4 @@
 CONFIG_SYSVIPC=y
-CONFIG_FHANDLE=y
 CONFIG_HIGH_RES_TIMERS=y
 CONFIG_IKCONFIG=y
 CONFIG_IKCONFIG_PROC=y
@@ -90,6 +89,8 @@ CONFIG_NOP_USB_XCEIV=y
 CONFIG_USB_GADGET=y
 CONFIG_MMC=y
 CONFIG_MMC_DW=y
+CONFIG_DMADEVICES=y
+CONFIG_PL330_DMA=y
 CONFIG_FPGA=y
 CONFIG_FPGA_MGR_SOCFPGA=y
 CONFIG_EXT2_FS=y
-- 
1.9.1.315.g3f09db0
