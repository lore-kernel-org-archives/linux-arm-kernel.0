From: k.kozlowski@samsung.com (Krzysztof Kozlowski)
Date: Wed, 08 Apr 2015 15:22:18 +0200
Subject: [PATCH 7/8] clk: ls1x: Fix duplicate const for parent names
In-Reply-To: <1428499339-29569-1-git-send-email-k.kozlowski@samsung.com>
References: <1428499339-29569-1-git-send-email-k.kozlowski@samsung.com>
Message-ID: <1428499339-29569-8-git-send-email-k.kozlowski@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Replace duplicated const keyword with proper array of const pointers to
const strings.

Signed-off-by: Krzysztof Kozlowski <k.kozlowski@samsung.com>
---
 drivers/clk/clk-ls1x.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/clk/clk-ls1x.c b/drivers/clk/clk-ls1x.c
index ca80103ac188..d4c61985f448 100644
--- a/drivers/clk/clk-ls1x.c
+++ b/drivers/clk/clk-ls1x.c
@@ -80,9 +80,9 @@ static struct clk *__init clk_register_pll(struct device *dev,
 	return clk;
 }
 
-static const char const *cpu_parents[] = { "cpu_clk_div", "osc_33m_clk", };
-static const char const *ahb_parents[] = { "ahb_clk_div", "osc_33m_clk", };
-static const char const *dc_parents[] = { "dc_clk_div", "osc_33m_clk", };
+static const char * const cpu_parents[] = { "cpu_clk_div", "osc_33m_clk", };
+static const char * const ahb_parents[] = { "ahb_clk_div", "osc_33m_clk", };
+static const char * const dc_parents[] = { "dc_clk_div", "osc_33m_clk", };
 
 void __init ls1x_clk_init(void)
 {
-- 
1.9.1
