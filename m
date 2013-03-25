From: fabio.estevam@freescale.com (Fabio Estevam)
Date: Mon, 25 Mar 2013 09:20:37 -0300
Subject: [PATCH 10/17] ARM: mach-imx: clk-busy: Staticize clk_busy_mux_ops
In-Reply-To: <1364214044-13950-1-git-send-email-fabio.estevam@freescale.com>
References: <1364214044-13950-1-git-send-email-fabio.estevam@freescale.com>
Message-ID: <1364214044-13950-10-git-send-email-fabio.estevam@freescale.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Fix the following sparse warning:

arch/arm/mach-imx/clk-busy.c:150:16: warning: symbol 'clk_busy_mux_ops' was not declared. Should it be static?

Signed-off-by: Fabio Estevam <fabio.estevam@freescale.com>
---
 arch/arm/mach-imx/clk-busy.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm/mach-imx/clk-busy.c b/arch/arm/mach-imx/clk-busy.c
index 1ab91b5..6809c99 100644
--- a/arch/arm/mach-imx/clk-busy.c
+++ b/arch/arm/mach-imx/clk-busy.c
@@ -147,7 +147,7 @@ static int clk_busy_mux_set_parent(struct clk_hw *hw, u8 index)
 	return ret;
 }
 
-struct clk_ops clk_busy_mux_ops = {
+static struct clk_ops clk_busy_mux_ops = {
 	.get_parent = clk_busy_mux_get_parent,
 	.set_parent = clk_busy_mux_set_parent,
 };
-- 
1.7.9.5
