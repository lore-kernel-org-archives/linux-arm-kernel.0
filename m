From: michael.williamson@criticallink.com (Michael Williamson)
Date: Tue, 22 Feb 2011 08:36:59 -0500
Subject: [PATCH v3 4/9] davinci: da830: fix driver name for spi clocks
In-Reply-To: <1298381824-7723-1-git-send-email-michael.williamson@criticallink.com>
References: <1298381824-7723-1-git-send-email-michael.williamson@criticallink.com>
Message-ID: <1298381824-7723-5-git-send-email-michael.williamson@criticallink.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The spi driver name called out for the da830 spi clock list is not correct,
fix it.

Signed-off-by: Michael Williamson <michael.williamson@criticallink.com>
Acked-by: Sekhar Nori <nsekhar@ti.com>
---
 arch/arm/mach-davinci/da830.c |    4 ++--
 1 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/arm/mach-davinci/da830.c b/arch/arm/mach-davinci/da830.c
index ec23ab4..826118e 100644
--- a/arch/arm/mach-davinci/da830.c
+++ b/arch/arm/mach-davinci/da830.c
@@ -397,8 +397,8 @@ static struct clk_lookup da830_clks[] = {
 	CLK(NULL,		"uart0",	&uart0_clk),
 	CLK(NULL,		"uart1",	&uart1_clk),
 	CLK(NULL,		"uart2",	&uart2_clk),
-	CLK("dm_spi.0",		NULL,		&spi0_clk),
-	CLK("dm_spi.1",		NULL,		&spi1_clk),
+	CLK("spi_davinci.0",	NULL,		&spi0_clk),
+	CLK("spi_davinci.1",	NULL,		&spi1_clk),
 	CLK(NULL,		"ecap0",	&ecap0_clk),
 	CLK(NULL,		"ecap1",	&ecap1_clk),
 	CLK(NULL,		"ecap2",	&ecap2_clk),
-- 
1.7.0.4
