From: baruch@tkos.co.il (Baruch Siach)
Date: Thu, 10 Jun 2010 12:14:32 +0300
Subject: [PATCH] mx25: add a comment documenting undocumented IPG clocks
Message-ID: <19a61a0788a899caf2be6126769b20bbf662f90a.1276161160.git.baruch@tkos.co.il>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The information in the i.MX25 Reference Manual is lacking. Add information from
the Freescale BSP.

Signed-off-by: Baruch Siach <baruch@tkos.co.il>
---
 arch/arm/mach-mx25/clock.c |   22 ++++++++++++++++++++++
 1 files changed, 22 insertions(+), 0 deletions(-)

diff --git a/arch/arm/mach-mx25/clock.c b/arch/arm/mach-mx25/clock.c
index f9662d9..43d6045 100644
--- a/arch/arm/mach-mx25/clock.c
+++ b/arch/arm/mach-mx25/clock.c
@@ -166,6 +166,28 @@ static void clk_cgcr_disable(struct clk *clk)
 		.secondary	= s,			\
 	}
 
+/*
+ * Note: the following IPG clock gating bits are wrongly marked "Reserved" in
+ * the i.MX25 Reference Manual Rev 1, table 15-13. The information below is
+ * taken from the Freescale released BSP.
+ *
+ * bit	reg	offset	clock
+ *
+ * 0	CGCR1	0	AUDMUX
+ * 12	CGCR1	12	ESAI
+ * 16	CGCR1	16	GPIO1
+ * 17	CGCR1	17	GPIO2
+ * 18	CGCR1	18	GPIO3
+ * 23	CGCR1	23	I2C1
+ * 24	CGCR1	24	I2C2
+ * 25	CGCR1	25	I2C3
+ * 27	CGCR1	27	IOMUXC
+ * 28	CGCR1	28	KPP
+ * 30	CGCR1	30	OWIRE
+ * 36	CGCR2	4	RTIC
+ * 51	CGCR2	19	WDOG
+ */
+
 DEFINE_CLOCK(gpt_clk,    0, CCM_CGCR0,  5, get_rate_gpt, NULL, NULL);
 DEFINE_CLOCK(uart_per_clk, 0, CCM_CGCR0, 15, get_rate_uart, NULL, NULL);
 DEFINE_CLOCK(cspi1_clk,  0, CCM_CGCR1,  5, get_rate_ipg, NULL, NULL);
-- 
1.7.1
