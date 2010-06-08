From: eric@eukrea.com (=?utf-8?q?Eric=20B=C3=A9nard?=)
Date: Tue,  8 Jun 2010 18:07:05 +0200
Subject: [PATCH] i.MX35: return IPU clock's value for mx3fb
Message-ID: <1276013225-11982-1-git-send-email-eric@eukrea.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

without this patch, ipu_clk's value is 0 thus preventing mx3fb from
calculating the right divisor for pixel clock generator.

Signed-off-by: Eric B?nard <eric@eukrea.com>
---
 arch/arm/mach-mx3/clock-imx35.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/arch/arm/mach-mx3/clock-imx35.c b/arch/arm/mach-mx3/clock-imx35.c
index 9f3e943..28be011 100644
--- a/arch/arm/mach-mx3/clock-imx35.c
+++ b/arch/arm/mach-mx3/clock-imx35.c
@@ -359,7 +359,7 @@ DEFINE_CLOCK(i2c1_clk,   0, CCM_CGR1, 10, get_rate_ipg_per, NULL);
 DEFINE_CLOCK(i2c2_clk,   1, CCM_CGR1, 12, get_rate_ipg_per, NULL);
 DEFINE_CLOCK(i2c3_clk,   2, CCM_CGR1, 14, get_rate_ipg_per, NULL);
 DEFINE_CLOCK(iomuxc_clk, 0, CCM_CGR1, 16, NULL, NULL);
-DEFINE_CLOCK(ipu_clk,    0, CCM_CGR1, 18, NULL, NULL);
+DEFINE_CLOCK(ipu_clk,    0, CCM_CGR1, 18, get_rate_ahb, NULL);
 DEFINE_CLOCK(kpp_clk,    0, CCM_CGR1, 20, get_rate_ipg, NULL);
 DEFINE_CLOCK(mlb_clk,    0, CCM_CGR1, 22, get_rate_ahb, NULL);
 DEFINE_CLOCK(mshc_clk,   0, CCM_CGR1, 24, get_rate_mshc, NULL);
-- 
1.6.3.3
