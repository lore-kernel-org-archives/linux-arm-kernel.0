From: alexander.sverdlin@gmail.com (Alexander Sverdlin)
Date: Wed, 17 May 2017 19:13:48 +0200
Subject: [PATCH v4 1/5] clk: ep93xx: Implement clk_get_parent()
In-Reply-To: <20170517171352.20369-1-alexander.sverdlin@gmail.com>
References: <20170517171352.20369-1-alexander.sverdlin@gmail.com>
Message-ID: <20170517171352.20369-2-alexander.sverdlin@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Trivial implementation of clk_get_parent(), but necessary for some drivers,
such as ADC.

Signed-off-by: Alexander Sverdlin <alexander.sverdlin@gmail.com>
---
 arch/arm/mach-ep93xx/clock.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/arch/arm/mach-ep93xx/clock.c b/arch/arm/mach-ep93xx/clock.c
index 39ef3b613912..b9cd9d7da14d 100644
--- a/arch/arm/mach-ep93xx/clock.c
+++ b/arch/arm/mach-ep93xx/clock.c
@@ -475,6 +475,12 @@ int clk_set_rate(struct clk *clk, unsigned long rate)
 }
 EXPORT_SYMBOL(clk_set_rate);
 
+struct clk *clk_get_parent(struct clk *clk)
+{
+	return clk->parent;
+}
+EXPORT_SYMBOL(clk_get_parent);
+
 
 static char fclk_divisors[] = { 1, 2, 4, 8, 16, 1, 1, 1 };
 static char hclk_divisors[] = { 1, 2, 4, 5, 6, 8, 16, 32 };
-- 
2.12.2
