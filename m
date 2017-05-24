From: jbrunet@baylibre.com (Jerome Brunet)
Date: Wed, 24 May 2017 11:39:31 +0200
Subject: [PATCH v2 1/2] clk: meson: meson8b: mark clk81 as critical
In-Reply-To: <20170524093932.5262-1-jbrunet@baylibre.com>
References: <20170524093932.5262-1-jbrunet@baylibre.com>
Message-ID: <20170524093932.5262-2-jbrunet@baylibre.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Martin Blumenstingl <martin.blumenstingl@googlemail.com>

Disabling clk81 results in an immediate freeze of the whole system. This
can happen "accidentally" when the last child-clock of clk81 is disabled
(in this case the common clock framework also disables clk81, even if it
was only enabled indirectly before).

Signed-off-by: Martin Blumenstingl <martin.blumenstingl@googlemail.com>
Signed-off-by: Jerome Brunet <jbrunet@baylibre.com>
---
 drivers/clk/meson/meson8b.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/clk/meson/meson8b.c b/drivers/clk/meson/meson8b.c
index e9985503165c..9d1aaf6e9ac6 100644
--- a/drivers/clk/meson/meson8b.c
+++ b/drivers/clk/meson/meson8b.c
@@ -399,7 +399,7 @@ struct clk_gate meson8b_clk81 = {
 		.ops = &clk_gate_ops,
 		.parent_names = (const char *[]){ "mpeg_clk_div" },
 		.num_parents = 1,
-		.flags = (CLK_SET_RATE_PARENT | CLK_IGNORE_UNUSED),
+		.flags = (CLK_SET_RATE_PARENT | CLK_IS_CRITICAL),
 	},
 };
 
-- 
2.9.4
