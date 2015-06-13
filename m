From: heiko@sntech.de (Heiko Stuebner)
Date: Sat, 13 Jun 2015 18:22:17 +0200
Subject: [PATCH 3/8] clk: rockchip: add COMPOSITE_NOGATE_DIVTBL variant
In-Reply-To: <1434212542-17145-1-git-send-email-heiko@sntech.de>
References: <1434212542-17145-1-git-send-email-heiko@sntech.de>
Message-ID: <1434212542-17145-4-git-send-email-heiko@sntech.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

A clock branch consisting of a mux and divider with non-standard
divider values.

Signed-off-by: Heiko Stuebner <heiko@sntech.de>
---
 drivers/clk/rockchip/clk.h | 20 ++++++++++++++++++++
 1 file changed, 20 insertions(+)

diff --git a/drivers/clk/rockchip/clk.h b/drivers/clk/rockchip/clk.h
index 92edb5f..501f02e 100644
--- a/drivers/clk/rockchip/clk.h
+++ b/drivers/clk/rockchip/clk.h
@@ -308,6 +308,26 @@ struct rockchip_clk_branch {
 		.gate_offset	= -1,				\
 	}
 
+#define COMPOSITE_NOGATE_DIVTBL(_id, cname, pnames, f, mo, ms,	\
+				mw, mf, ds, dw, df, dt)		\
+	{							\
+		.id		= _id,				\
+		.branch_type	= branch_composite,		\
+		.name		= cname,			\
+		.parent_names	= pnames,			\
+		.num_parents	= ARRAY_SIZE(pnames),		\
+		.flags		= f,				\
+		.muxdiv_offset	= mo,				\
+		.mux_shift	= ms,				\
+		.mux_width	= mw,				\
+		.mux_flags	= mf,				\
+		.div_shift	= ds,				\
+		.div_width	= dw,				\
+		.div_flags	= df,				\
+		.div_table	= dt,				\
+		.gate_offset	= -1,				\
+	}
+
 #define COMPOSITE_FRAC(_id, cname, pname, f, mo, df, go, gs, gf)\
 	{							\
 		.id		= _id,				\
-- 
2.1.4
