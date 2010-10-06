From: jhnikula@gmail.com (Jarkko Nikula)
Date: Wed,  6 Oct 2010 08:50:40 +0300
Subject: [PATCHv2 1/3] OMAP: McBSP: Fix CLKR and FSR signal muxing
In-Reply-To: <1286344242-430-1-git-send-email-jhnikula@gmail.com>
References: <1286344242-430-1-git-send-email-jhnikula@gmail.com>
Message-ID: <1286344242-430-2-git-send-email-jhnikula@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Fix bit clear. Now it clears all other bits than mask bit where it should
clear only it.

Signed-off-by: Jarkko Nikula <jhnikula@gmail.com>
Acked-by: Paul Walmsley <paul@pwsan.com>
---
 arch/arm/mach-omap2/mcbsp.c |    4 ++--
 1 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/arm/mach-omap2/mcbsp.c b/arch/arm/mach-omap2/mcbsp.c
index eba9fa1..f6b772e 100644
--- a/arch/arm/mach-omap2/mcbsp.c
+++ b/arch/arm/mach-omap2/mcbsp.c
@@ -34,7 +34,7 @@ void omap2_mcbsp1_mux_clkr_src(u8 mux)
 
 	v = omap_ctrl_readl(OMAP2_CONTROL_DEVCONF0);
 	if (mux == CLKR_SRC_CLKR)
-		v &= OMAP2_MCBSP1_CLKR_MASK;
+		v &= ~OMAP2_MCBSP1_CLKR_MASK;
 	else if (mux == CLKR_SRC_CLKX)
 		v |= OMAP2_MCBSP1_CLKR_MASK;
 	omap_ctrl_writel(v, OMAP2_CONTROL_DEVCONF0);
@@ -47,7 +47,7 @@ void omap2_mcbsp1_mux_fsr_src(u8 mux)
 
 	v = omap_ctrl_readl(OMAP2_CONTROL_DEVCONF0);
 	if (mux == FSR_SRC_FSR)
-		v &= OMAP2_MCBSP1_FSR_MASK;
+		v &= ~OMAP2_MCBSP1_FSR_MASK;
 	else if (mux == FSR_SRC_FSX)
 		v |= OMAP2_MCBSP1_FSR_MASK;
 	omap_ctrl_writel(v, OMAP2_CONTROL_DEVCONF0);
-- 
1.7.1
