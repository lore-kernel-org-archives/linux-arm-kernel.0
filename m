From: alexander.sverdlin@gmail.com (Alexander Sverdlin)
Date: Wed, 25 Nov 2015 12:50:27 +0100
Subject: [PATCH 1/5] clk: ep93xx: Implement clk_get_parent()
In-Reply-To: <56558B23.4080506@gmail.com>
References: <56558B23.4080506@gmail.com>
Message-ID: <5655A083.3080200@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Trivial implementation of clk_get_parent(), but necessary for some drivers,
such as ADC.

Signed-off-by: Alexander Sverdlin <alexander.sverdlin@gmail.com>
---
 arch/arm/mach-ep93xx/clock.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/arch/arm/mach-ep93xx/clock.c b/arch/arm/mach-ep93xx/clock.c
index 39ef3b6..b9cd9d7 100644
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
