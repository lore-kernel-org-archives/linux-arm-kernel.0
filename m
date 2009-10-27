From: derkling@gmail.com (derkling at gmail.com)
Date: Tue, 27 Oct 2009 11:06:39 +0100
Subject: [PATCH] ARM: STMP3xxx: bugfixed propagate_rate definition
Message-ID: <1256637999-21937-1-git-send-email-derkling@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Patrick Bellasi <derkling@gmail.com>

This patch remove the "__init" modifier from the definition of the
propagate_rate routine. Indeed this routine is used by the exported API
(e.g. clk_set_rate) and thus is needed at run-time.

Signed-off-by: Patrick Bellasi <derkling@gmail.com>
---
 arch/arm/plat-stmp3xxx/clock.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/arch/arm/plat-stmp3xxx/clock.c b/arch/arm/plat-stmp3xxx/clock.c
index 5d2f19a..5e64b55 100644
--- a/arch/arm/plat-stmp3xxx/clock.c
+++ b/arch/arm/plat-stmp3xxx/clock.c
@@ -925,7 +925,7 @@ static struct clk_lookup onchip_clks[] = {
 	},
 };
 
-static int __init propagate_rate(struct clk *clk)
+static int propagate_rate(struct clk *clk)
 {
 	struct clk_lookup *cl;
 
-- 
1.5.6.3
