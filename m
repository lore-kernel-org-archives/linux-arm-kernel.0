From: fabio.estevam@freescale.com (Fabio Estevam)
Date: Mon, 25 Mar 2013 09:20:38 -0300
Subject: [PATCH 11/17] ARM: mach-imx: clk: Include "clk.h"
In-Reply-To: <1364214044-13950-1-git-send-email-fabio.estevam@freescale.com>
References: <1364214044-13950-1-git-send-email-fabio.estevam@freescale.com>
Message-ID: <1364214044-13950-11-git-send-email-fabio.estevam@freescale.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Fix the following sparse warning:

arch/arm/mach-imx/clk.c:3:1: warning: symbol 'imx_ccm_lock' was not declared. Should it be static?

Signed-off-by: Fabio Estevam <fabio.estevam@freescale.com>
---
 arch/arm/mach-imx/clk.c |    1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm/mach-imx/clk.c b/arch/arm/mach-imx/clk.c
index f5e8be8..37e884e 100644
--- a/arch/arm/mach-imx/clk.c
+++ b/arch/arm/mach-imx/clk.c
@@ -1,3 +1,4 @@
 #include <linux/spinlock.h>
+#include "clk.h"
 
 DEFINE_SPINLOCK(imx_ccm_lock);
-- 
1.7.9.5
