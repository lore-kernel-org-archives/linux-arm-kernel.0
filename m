From: zhengxing@rock-chips.com (Xing Zheng)
Date: Wed,  9 Mar 2016 10:43:31 +0800
Subject: [PATCH v3 6/7] clk: rockchip: add a COMPOSITE_FRACMUX_NOGATE type
In-Reply-To: <1457491027-30936-1-git-send-email-zhengxing@rock-chips.com>
References: <1457491027-30936-1-git-send-email-zhengxing@rock-chips.com>
Message-ID: <1457491411-31114-1-git-send-email-zhengxing@rock-chips.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Because there are some frac clock mux nodes don't need gate node on
the RK3399.

Signed-off-by: Xing Zheng <zhengxing@rock-chips.com>
---

Changes in v3: None
Changes in v2: None

 drivers/clk/rockchip/clk.h |   16 ++++++++++++++++
 1 file changed, 16 insertions(+)

diff --git a/drivers/clk/rockchip/clk.h b/drivers/clk/rockchip/clk.h
index 7526f9a..75dc30e 100644
--- a/drivers/clk/rockchip/clk.h
+++ b/drivers/clk/rockchip/clk.h
@@ -451,6 +451,22 @@ struct rockchip_clk_branch {
 		.child		= ch,				\
 	}
 
+#define COMPOSITE_FRACMUX_NOGATE(_id, cname, pname, f, mo, df, ch) \
+	{							\
+		.id		= _id,				\
+		.branch_type	= branch_fraction_divider,	\
+		.name		= cname,			\
+		.parent_names	= (const char *[]){ pname },	\
+		.num_parents	= 1,				\
+		.flags		= f,				\
+		.muxdiv_offset	= mo,				\
+		.div_shift	= 16,				\
+		.div_width	= 16,				\
+		.div_flags	= df,				\
+		.gate_offset	= -1,				\
+		.child		= ch,				\
+	}
+
 #define MUX(_id, cname, pnames, f, o, s, w, mf)			\
 	{							\
 		.id		= _id,				\
-- 
1.7.9.5
