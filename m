From: baruch@tkos.co.il (Baruch Siach)
Date: Mon, 25 Jan 2010 12:58:22 +0200
Subject: [PATCH 4/4] mx25: make the FEC AHB clk secondary of the IPG
In-Reply-To: <20100125105439.GE6724@jasper.tkos.co.il>
References: <20100125105439.GE6724@jasper.tkos.co.il>
Message-ID: <b70c4b9f71f7d0b2a3d0bbaba53a088f4ad03bed.1264416923.git.baruch@tkos.co.il>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This makes the FEC clock configuration consistent with the UART one.

Signed-off-by: Baruch Siach <baruch@tkos.co.il>
---
 arch/arm/mach-mx25/clock.c |    4 ++--
 1 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/arm/mach-mx25/clock.c b/arch/arm/mach-mx25/clock.c
index c003ac4..6acc88b 100644
--- a/arch/arm/mach-mx25/clock.c
+++ b/arch/arm/mach-mx25/clock.c
@@ -166,7 +166,7 @@ DEFINE_CLOCK(uart_per_clk, 0, CCM_CGCR0, 15, get_rate_uart, NULL, NULL);
 DEFINE_CLOCK(cspi1_clk,  0, CCM_CGCR1,  5, get_rate_ipg, NULL, NULL);
 DEFINE_CLOCK(cspi2_clk,  0, CCM_CGCR1,  6, get_rate_ipg, NULL, NULL);
 DEFINE_CLOCK(cspi3_clk,  0, CCM_CGCR1,  7, get_rate_ipg, NULL, NULL);
-DEFINE_CLOCK(fec_ipg_clk, 0, CCM_CGCR1, 15, get_rate_ipg, NULL, NULL);
+DEFINE_CLOCK(fec_ahb_clk, 0, CCM_CGCR0, 23, NULL,	 NULL, NULL);
 DEFINE_CLOCK(uart1_clk,  0, CCM_CGCR2, 14, get_rate_uart, NULL, &uart_per_clk);
 DEFINE_CLOCK(uart2_clk,  0, CCM_CGCR2, 15, get_rate_uart, NULL, &uart_per_clk);
 DEFINE_CLOCK(uart3_clk,  0, CCM_CGCR2, 16, get_rate_uart, NULL, &uart_per_clk);
@@ -181,7 +181,7 @@ DEFINE_CLOCK(pwm4_clk,	 0, CCM_CGCR2,  2, get_rate_ipg, NULL, NULL);
 DEFINE_CLOCK(kpp_clk,	 0, CCM_CGCR1, 28, get_rate_ipg, NULL, NULL);
 DEFINE_CLOCK(tsc_clk,	 0, CCM_CGCR2, 13, get_rate_ipg, NULL, NULL);
 DEFINE_CLOCK(i2c_clk,	 0, CCM_CGCR0,  6, get_rate_i2c, NULL, NULL);
-DEFINE_CLOCK(fec_clk,	 0, CCM_CGCR0, 23, get_rate_ipg, NULL, &fec_ipg_clk);
+DEFINE_CLOCK(fec_clk,	 0, CCM_CGCR1, 15, get_rate_ipg, NULL, &fec_ahb_clk);
 
 #define _REGISTER_CLOCK(d, n, c)	\
 	{				\
-- 
1.6.5
