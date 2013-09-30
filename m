From: fabio.estevam@freescale.com (Fabio Estevam)
Date: Mon, 30 Sep 2013 11:08:25 -0300
Subject: [PATCH] ARM: mach-imx: cpu: Include <linux/err.h>
Message-ID: <1380550105-19372-1-git-send-email-fabio.estevam@freescale.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Commit e709f38cd7 (ARM: imx6: report soc info via soc device) causes the 
following build error on imx_v4_v5_defconfig:

arch/arm/mach-imx/cpu.c: In function 'imx_soc_device_init':
arch/arm/mach-imx/cpu.c:129:2: error: implicit declaration of function 'IS_ERR' [-Werror=implicit-function-declaration]

Include <linux/err.h> to fix it.

Signed-off-by: Fabio Estevam <fabio.estevam@freescale.com>
---
 arch/arm/mach-imx/cpu.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm/mach-imx/cpu.c b/arch/arm/mach-imx/cpu.c
index fae2c9a..c862402 100644
--- a/arch/arm/mach-imx/cpu.c
+++ b/arch/arm/mach-imx/cpu.c
@@ -1,4 +1,5 @@
 
+#include <linux/err.h>
 #include <linux/module.h>
 #include <linux/io.h>
 #include <linux/of.h>
-- 
1.8.1.2
