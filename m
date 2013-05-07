From: valentin.longchamp@keymile.com (Valentin Longchamp)
Date: Tue,  7 May 2013 17:52:20 +0200
Subject: [PATCH 2/3] ARM: kirkwood: look for alternative gate ctrl of node
In-Reply-To: <1367941941-19152-1-git-send-email-valentin.longchamp@keymile.com>
References: <1367941941-19152-1-git-send-email-valentin.longchamp@keymile.com>
Message-ID: <1367941941-19152-3-git-send-email-valentin.longchamp@keymile.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The search for the gate ctrl of node must now also look for the
introduced compatible node.

Signed-off-by: Valentin Longchamp <valentin.longchamp@keymile.com>
---
 arch/arm/mach-kirkwood/board-dt.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/arch/arm/mach-kirkwood/board-dt.c b/arch/arm/mach-kirkwood/board-dt.c
index 7904758..3e607c9 100644
--- a/arch/arm/mach-kirkwood/board-dt.c
+++ b/arch/arm/mach-kirkwood/board-dt.c
@@ -44,6 +44,10 @@ static void __init kirkwood_legacy_clk_init(void)
 	struct of_phandle_args clkspec;
 	struct clk *clk;
 
+	if (np == NULL)
+		np = of_find_compatible_node(NULL, NULL,
+			"marvell,prestera-kw-gating-clock");
+
 	clkspec.np = np;
 	clkspec.args_count = 1;
 
-- 
1.8.0.1
