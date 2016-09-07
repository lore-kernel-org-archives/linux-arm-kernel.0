From: Anson.Huang@nxp.com (Anson Huang)
Date: Wed, 7 Sep 2016 18:30:44 +0800
Subject: [PATCH] ARM: imx: build cpuidle-imx6sx.c for imx6ul
Message-ID: <1473244244-8002-1-git-send-email-Anson.Huang@nxp.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Fix build error when CONFIG_SOC_IMX6SX is disabled,
as i.MX6UL reuses i.MX6SX's cpuidle driver.

arch/arm/mach-imx/built-in.o: In function `imx6ul_init_late':
platform-spi_imx.c:(.init.text+0x445c): undefined reference to `imx6sx_cpuidle_init'
make: *** [vmlinux] Error 1

Signed-off-by: Anson Huang <Anson.Huang@nxp.com>
---
 arch/arm/mach-imx/Makefile | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm/mach-imx/Makefile b/arch/arm/mach-imx/Makefile
index 2636adf..cab1289 100644
--- a/arch/arm/mach-imx/Makefile
+++ b/arch/arm/mach-imx/Makefile
@@ -27,6 +27,7 @@ obj-$(CONFIG_SOC_IMX5) += cpuidle-imx5.o
 obj-$(CONFIG_SOC_IMX6Q) += cpuidle-imx6q.o
 obj-$(CONFIG_SOC_IMX6SL) += cpuidle-imx6sl.o
 obj-$(CONFIG_SOC_IMX6SX) += cpuidle-imx6sx.o
+obj-$(CONFIG_SOC_IMX6UL) += cpuidle-imx6sx.o
 endif
 
 ifdef CONFIG_SND_IMX_SOC
-- 
1.9.1
