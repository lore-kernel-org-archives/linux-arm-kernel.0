From: fabio.estevam@freescale.com (Fabio Estevam)
Date: Mon, 25 Mar 2013 09:20:41 -0300
Subject: [PATCH 14/17] ARM: mach-imx: anatop: Include "common.h"
In-Reply-To: <1364214044-13950-1-git-send-email-fabio.estevam@freescale.com>
References: <1364214044-13950-1-git-send-email-fabio.estevam@freescale.com>
Message-ID: <1364214044-13950-14-git-send-email-fabio.estevam@freescale.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Fix the following sparse warnings:

arch/arm/mach-imx/anatop.c:56:6: warning: symbol 'imx_anatop_pre_suspend' was not declared. Should it be static?
arch/arm/mach-imx/anatop.c:62:6: warning: symbol 'imx_anatop_post_resume' was not declared. Should it be static?
arch/arm/mach-imx/anatop.c:68:6: warning: symbol 'imx_anatop_usb_chrg_detect_disable' was not declared. Should it be static?
arch/arm/mach-imx/anatop.c:78:5: warning: symbol 'imx_anatop_get_digprog' was not declared. Should it be static?
arch/arm/mach-imx/anatop.c:86:13: warning: symbol 'imx_anatop_init' was not declared. Should it be static?

Signed-off-by: Fabio Estevam <fabio.estevam@freescale.com>
---
 arch/arm/mach-imx/anatop.c |    1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm/mach-imx/anatop.c b/arch/arm/mach-imx/anatop.c
index 8b18b3c..472beee 100644
--- a/arch/arm/mach-imx/anatop.c
+++ b/arch/arm/mach-imx/anatop.c
@@ -15,6 +15,7 @@
 #include <linux/of_address.h>
 #include <linux/mfd/syscon.h>
 #include <linux/regmap.h>
+#include "common.h"
 
 #define REG_SET		0x4
 #define REG_CLR		0x8
-- 
1.7.9.5
