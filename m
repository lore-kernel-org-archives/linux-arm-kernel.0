From: soren.brinkmann@xilinx.com (Soren Brinkmann)
Date: Thu, 27 Nov 2014 17:26:31 -0800
Subject: [PATCH v2 5/7] ARM: zynq: Enable pinctrl
In-Reply-To: <1417137993-8337-1-git-send-email-soren.brinkmann@xilinx.com>
References: <1417137993-8337-1-git-send-email-soren.brinkmann@xilinx.com>
Message-ID: <1417137993-8337-6-git-send-email-soren.brinkmann@xilinx.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Select pinctrl and the Zynq pinctrl driver.

Signed-off-by: Soren Brinkmann <soren.brinkmann@xilinx.com>
Tested-by: Andreas F?rber <afaerber@suse.de>
---
Changes since RFC v2:
 - separate mach-zynq changes in their own patch
---
 arch/arm/mach-zynq/Kconfig | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/arch/arm/mach-zynq/Kconfig b/arch/arm/mach-zynq/Kconfig
index aaa5162c1509..78e5e007f52d 100644
--- a/arch/arm/mach-zynq/Kconfig
+++ b/arch/arm/mach-zynq/Kconfig
@@ -9,6 +9,8 @@ config ARCH_ZYNQ
 	select HAVE_ARM_TWD if SMP
 	select ICST
 	select MFD_SYSCON
+	select PINCTRL
+	select PINCTRL_ZYNQ
 	select SOC_BUS
 	help
 	  Support for Xilinx Zynq ARM Cortex A9 Platform
-- 
2.1.3.1.ge241007
