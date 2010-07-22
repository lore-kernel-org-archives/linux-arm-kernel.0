From: mkl@pengutronix.de (Marc Kleine-Budde)
Date: Thu, 22 Jul 2010 18:29:20 +0200
Subject: [PATCH V2 1/6] mx25: flexcan clock support
In-Reply-To: <1279816165-6542-1-git-send-email-mkl@pengutronix.de>
References: <1279816165-6542-1-git-send-email-mkl@pengutronix.de>
Message-ID: <1279816165-6542-2-git-send-email-mkl@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Sascha Hauer <s.hauer@pengutronix.de>

Signed-off-by: Sascha Hauer <s.hauer@pengutronix.de>
Signed-off-by: Marc Kleine-Budde <mkl@pengutronix.de>
---
 arch/arm/mach-mx25/clock.c |    4 ++++
 1 files changed, 4 insertions(+), 0 deletions(-)

diff --git a/arch/arm/mach-mx25/clock.c b/arch/arm/mach-mx25/clock.c
index 02f8247..40c7cc4 100644
--- a/arch/arm/mach-mx25/clock.c
+++ b/arch/arm/mach-mx25/clock.c
@@ -240,6 +240,8 @@ DEFINE_CLOCK(ssi1_clk,  0, CCM_CGCR2, 11, get_rate_ssi1, NULL, &ssi1_per_clk);
 DEFINE_CLOCK(ssi2_clk,  1, CCM_CGCR2, 12, get_rate_ssi2, NULL, &ssi2_per_clk);
 DEFINE_CLOCK(audmux_clk, 0, CCM_CGCR1, 0, NULL, NULL, NULL);
 DEFINE_CLOCK(csi_clk,    0, CCM_CGCR1,  4, get_rate_csi, NULL,  &csi_per_clk);
+DEFINE_CLOCK(can1_clk,	 0, CCM_CGCR1,  2, get_rate_ipg, NULL, NULL);
+DEFINE_CLOCK(can2_clk,	 0, CCM_CGCR1,  3, get_rate_ipg, NULL, NULL);
 
 #define _REGISTER_CLOCK(d, n, c)	\
 	{				\
@@ -279,6 +281,8 @@ static struct clk_lookup lookups[] = {
 	_REGISTER_CLOCK("imx-ssi.1", NULL, ssi2_clk)
 	_REGISTER_CLOCK("mx2-camera.0", NULL, csi_clk)
 	_REGISTER_CLOCK(NULL, "audmux", audmux_clk)
+	_REGISTER_CLOCK("flexcan.0", NULL, can1_clk)
+	_REGISTER_CLOCK("flexcan.1", NULL, can2_clk)
 };
 
 int __init mx25_clocks_init(void)
-- 
1.7.1
