From: jhnikula@gmail.com (Jarkko Nikula)
Date: Wed,  6 Oct 2010 08:50:41 +0300
Subject: [PATCHv2 2/3] OMAP: McBSP: Swap CLKS source definition
In-Reply-To: <1286344242-430-1-git-send-email-jhnikula@gmail.com>
References: <1286344242-430-1-git-send-email-jhnikula@gmail.com>
Message-ID: <1286344242-430-3-git-send-email-jhnikula@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This is just a readability and debugging improvement. As selection bit in
DEVCONF register is cleared when using 96 MHz PRCM source and set when using
external CLKS pin, change definitions to be sync with these.

Signed-off-by: Jarkko Nikula <jhnikula@gmail.com>
Acked-by: Paul Walmsley <paul@pwsan.com>
---
 arch/arm/plat-omap/include/plat/mcbsp.h |    4 ++--
 1 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/arm/plat-omap/include/plat/mcbsp.h b/arch/arm/plat-omap/include/plat/mcbsp.h
index 4da6f94..e19abf2 100644
--- a/arch/arm/plat-omap/include/plat/mcbsp.h
+++ b/arch/arm/plat-omap/include/plat/mcbsp.h
@@ -321,8 +321,8 @@
 #define FSR_SRC_FSX		1
 
 /* McBSP functional clock sources */
-#define MCBSP_CLKS_PAD_SRC	0
-#define MCBSP_CLKS_PRCM_SRC	1
+#define MCBSP_CLKS_PRCM_SRC	0
+#define MCBSP_CLKS_PAD_SRC	1
 
 /* we don't do multichannel for now */
 struct omap_mcbsp_reg_cfg {
-- 
1.7.1
