From: Julia.Lawall@lip6.fr (Julia Lawall)
Date: Sat, 27 Oct 2018 07:47:36 +0200
Subject: [PATCH 2/8] ARM: vexpress/spc: constify clk_ops structure
In-Reply-To: <1540619262-22681-1-git-send-email-Julia.Lawall@lip6.fr>
References: <1540619262-22681-1-git-send-email-Julia.Lawall@lip6.fr>
Message-ID: <1540619262-22681-3-git-send-email-Julia.Lawall@lip6.fr>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The clk_ops structure is only stored in the ops field of a
clk_init_data structure.  This field is const, so the clk_ops
structure can be const as well.

Identified and transformed using Coccinelle.

Signed-off-by: Julia Lawall <Julia.Lawall@lip6.fr>

---
 arch/arm/mach-vexpress/spc.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm/mach-vexpress/spc.c b/arch/arm/mach-vexpress/spc.c
index 0f5381d13494..611f22de48cb 100644
--- a/arch/arm/mach-vexpress/spc.c
+++ b/arch/arm/mach-vexpress/spc.c
@@ -521,7 +521,7 @@ static int spc_set_rate(struct clk_hw *hw, unsigned long rate,
 	return ve_spc_set_performance(spc->cluster, rate / 1000);
 }
 
-static struct clk_ops clk_spc_ops = {
+static const struct clk_ops clk_spc_ops = {
 	.recalc_rate = spc_recalc_rate,
 	.round_rate = spc_round_rate,
 	.set_rate = spc_set_rate,
