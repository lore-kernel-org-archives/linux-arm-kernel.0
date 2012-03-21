From: javier.martin@vista-silicon.com (Javier Martin)
Date: Wed, 21 Mar 2012 16:19:41 +0100
Subject: [PATCH] MX2: Fix mx2_camera clock regression.
Message-ID: <1332343181-16968-1-git-send-email-javier.martin@vista-silicon.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The following patch breaks mx2_camera driver:
http://git.linuxtv.org/media_tree.git?a=commitdiff;h=52f1a845e25dc0c6435153aca1a170e20b282429

This change fixes the problem.

Signed-off-by: Javier Martin <javier.martin@vista-silicon.com>
---
 arch/arm/mach-imx/clock-imx27.c |    1 +
 1 files changed, 1 insertions(+), 0 deletions(-)

diff --git a/arch/arm/mach-imx/clock-imx27.c b/arch/arm/mach-imx/clock-imx27.c
index b9a95ed..98e04f5 100644
--- a/arch/arm/mach-imx/clock-imx27.c
+++ b/arch/arm/mach-imx/clock-imx27.c
@@ -662,6 +662,7 @@ static struct clk_lookup lookups[] = {
 	_REGISTER_CLOCK(NULL, "dma", dma_clk)
 	_REGISTER_CLOCK(NULL, "rtic", rtic_clk)
 	_REGISTER_CLOCK(NULL, "brom", brom_clk)
+	_REGISTER_CLOCK(NULL, "emma", emma_clk)
 	_REGISTER_CLOCK("m2m-emmaprp.0", NULL, emma_clk)
 	_REGISTER_CLOCK(NULL, "slcdc", slcdc_clk)
 	_REGISTER_CLOCK("imx27-fec.0", NULL, fec_clk)
-- 
1.7.0.4
