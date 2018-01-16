From: dhaval.shah@xilinx.com (Dhaval Shah)
Date: Mon, 15 Jan 2018 22:34:48 -0800
Subject: [PATCH] soc: xilinx: xlnx_vcu: Depends on HAS_IOMEM for xlnx_vcu
In-Reply-To: <201801141754.lROQHRMR%fengguang.wu@intel.com>
References: <201801141754.lROQHRMR%fengguang.wu@intel.com>
Message-ID: <1516084488-16372-1-git-send-email-dshah@xilinx.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

xlnx_vcu driver uses devm_ioremap_nocache, which is included
only when HAS_IOMEM is enabled.

drivers/soc/xilinx/xlnx_vcu.o: In function `xvcu_probe':
   xlnx_vcu.c:(.text+0x116): undefined reference to `devm_ioremap_nocache'
   xlnx_vcu.c:(.text+0x1ae): undefined reference to `devm_ioremap_nocache'

Signed-off-by: Dhaval Shah <dshah@xilinx.com>
---
 drivers/soc/xilinx/Kconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/soc/xilinx/Kconfig b/drivers/soc/xilinx/Kconfig
index 266b50f..bf657ab 100644
--- a/drivers/soc/xilinx/Kconfig
+++ b/drivers/soc/xilinx/Kconfig
@@ -3,6 +3,7 @@ menu "Xilinx SoC drivers"

 config XILINX_VCU
         tristate "Xilinx VCU logicoreIP Init"
+       depends on HAS_IOMEM
         help
           Provides the driver to enable and disable the isolation between the
           processing system and programmable logic part by using the logicoreIP
--
2.7.4

This email and any attachments are intended for the sole use of the named recipient(s) and contain(s) confidential information that may be proprietary, privileged or copyrighted under applicable law. If you are not the intended recipient, do not read, copy, or forward this email message or any attachments. Delete this email message and any attachments immediately.
