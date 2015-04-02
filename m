From: festevam@gmail.com (Fabio Estevam)
Date: Thu,  2 Apr 2015 19:23:32 -0300
Subject: [PATCH 2/2] ARM: imx: mmdc: Include "common.h" header file
In-Reply-To: <1428013412-7082-1-git-send-email-festevam@gmail.com>
References: <1428013412-7082-1-git-send-email-festevam@gmail.com>
Message-ID: <1428013412-7082-2-git-send-email-festevam@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Fabio Estevam <fabio.estevam@freescale.com>

Include the "common.h" header file to fix the following sparse warning:

arch/arm/mach-imx/mmdc.c:66:5: warning: symbol 'imx_mmdc_get_ddr_type' was not declared. Should it be static?

Signed-off-by: Fabio Estevam <fabio.estevam@freescale.com>
---
 arch/arm/mach-imx/mmdc.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/arch/arm/mach-imx/mmdc.c b/arch/arm/mach-imx/mmdc.c
index 0411f06..db9621c 100644
--- a/arch/arm/mach-imx/mmdc.c
+++ b/arch/arm/mach-imx/mmdc.c
@@ -17,6 +17,8 @@
 #include <linux/of_address.h>
 #include <linux/of_device.h>
 
+#include "common.h"
+
 #define MMDC_MAPSR		0x404
 #define BP_MMDC_MAPSR_PSD	0
 #define BP_MMDC_MAPSR_PSS	4
-- 
1.9.1
