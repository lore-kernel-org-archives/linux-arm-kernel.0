From: fabio.estevam@freescale.com (Fabio Estevam)
Date: Fri, 26 Aug 2011 16:21:59 -0300
Subject: [PATCH 3/5] ARM: mx53: Fix the logic for BYPASS_MAX_LPM_HS 
In-Reply-To: <1314386521-29351-2-git-send-email-fabio.estevam@freescale.com>
References: <1314386521-29351-1-git-send-email-fabio.estevam@freescale.com>
	<1314386521-29351-2-git-send-email-fabio.estevam@freescale.com>
Message-ID: <1314386521-29351-3-git-send-email-fabio.estevam@freescale.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

In order to bypass the handshake with MAX the BYPASS_MAX_LPM_HS bit of CCM_CLPCR
needs to be set to one.

Fix the logic.

Signed-off-by: Fabio Estevam <fabio.estevam@freescale.com>
---
 arch/arm/mach-mx5/clock-mx51-mx53.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/arch/arm/mach-mx5/clock-mx51-mx53.c b/arch/arm/mach-mx5/clock-mx51-mx53.c
index 058fb42..588e689 100644
--- a/arch/arm/mach-mx5/clock-mx51-mx53.c
+++ b/arch/arm/mach-mx5/clock-mx51-mx53.c
@@ -569,7 +569,7 @@ static void _clk_max_disable(struct clk *clk)
 	if (cpu_is_mx51())
 		reg |= MX51_CCM_CLPCR_BYPASS_MAX_LPM_HS;
 	else if (cpu_is_mx53())
-		reg &= ~MX53_CCM_CLPCR_BYPASS_MAX_LPM_HS;
+		reg |= MX53_CCM_CLPCR_BYPASS_MAX_LPM_HS;
 	__raw_writel(reg, MXC_CCM_CLPCR);
 }
 
-- 
1.6.0.4
