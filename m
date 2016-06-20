From: dinguyen@opensource.altera.com (dinguyen at opensource.altera.com)
Date: Mon, 20 Jun 2016 11:05:40 -0500
Subject: [PATCHv2] ARM: socfpga: enable PL330 DMA in socfpga_defconfig
Message-ID: <1466438740-28709-1-git-send-email-dinguyen@opensource.altera.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Dinh Nguyen <dinguyen@opensource.altera.com>

Enable the PL330 DMA and DMATEST on SoCFPGA.

make savedefconfig says CONFIG_FHANDLE is not needed in the defconfig,
remove it.

Signed-off-by: Dinh Nguyen <dinguyen@opensource.altera.com>
---
v2: Also enable DMATEST as a kernel module
---
 arch/arm/configs/socfpga_defconfig |    4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/arch/arm/configs/socfpga_defconfig b/arch/arm/configs/socfpga_defconfig
index e37c18b..9f84be5 100644
--- a/arch/arm/configs/socfpga_defconfig
+++ b/arch/arm/configs/socfpga_defconfig
@@ -1,5 +1,4 @@
 CONFIG_SYSVIPC=y
-CONFIG_FHANDLE=y
 CONFIG_HIGH_RES_TIMERS=y
 CONFIG_IKCONFIG=y
 CONFIG_IKCONFIG_PROC=y
@@ -98,6 +97,9 @@ CONFIG_NOP_USB_XCEIV=y
 CONFIG_USB_GADGET=y
 CONFIG_MMC=y
 CONFIG_MMC_DW=y
+CONFIG_DMADEVICES=y
+CONFIG_PL330_DMA=y
+CONFIG_DMATEST=m
 CONFIG_FPGA=y
 CONFIG_FPGA_MGR_SOCFPGA=y
 CONFIG_EXT2_FS=y
-- 
1.7.9.5
