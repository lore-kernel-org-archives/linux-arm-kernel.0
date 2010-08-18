From: kgene.kim@samsung.com (Kukjin Kim)
Date: Wed, 18 Aug 2010 23:01:24 +0900
Subject: [PATCH 14/14] ARM: S5PV310: Adds various special clocks
In-Reply-To: <1282140084-10265-1-git-send-email-kgene.kim@samsung.com>
References: <1282140084-10265-1-git-send-email-kgene.kim@samsung.com>
Message-ID: <1282140084-10265-15-git-send-email-kgene.kim@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Jongpill Lee <boyko.lee@samsung.com>

This patch adds various special clocks for S5PV310/S5PC210.

Signed-off-by: Jongpill Lee <boyko.lee@samsung.com>
Signed-off-by: Kukjin Kim <kgene.kim@samsung.com>
---
 arch/arm/mach-s5pv310/clock.c |  186 +++++++++++++++++++++++++++++++++++++++++
 1 files changed, 186 insertions(+), 0 deletions(-)

diff --git a/arch/arm/mach-s5pv310/clock.c b/arch/arm/mach-s5pv310/clock.c
index 04bde94..d8a7697 100644
--- a/arch/arm/mach-s5pv310/clock.c
+++ b/arch/arm/mach-s5pv310/clock.c
@@ -51,6 +51,21 @@ static int s5pv310_clksrc_mask_top_ctrl(struct clk *clk, int enable)
 	return s5p_gatectrl(S5P_CLKSRC_MASK_TOP, clk, enable);
 }
 
+static int s5pv310_clksrc_mask_cam_ctrl(struct clk *clk, int enable)
+{
+	return s5p_gatectrl(S5P_CLKSRC_MASK_CAM, clk, enable);
+}
+
+static int s5pv310_clksrc_mask_lcd0_ctrl(struct clk *clk, int enable)
+{
+	return s5p_gatectrl(S5P_CLKSRC_MASK_LCD0, clk, enable);
+}
+
+static int s5pv310_clksrc_mask_lcd1_ctrl(struct clk *clk, int enable)
+{
+	return s5p_gatectrl(S5P_CLKSRC_MASK_LCD1, clk, enable);
+}
+
 static int s5pv310_clksrc_mask_fsys_ctrl(struct clk *clk, int enable)
 {
 	return s5p_gatectrl(S5P_CLKSRC_MASK_FSYS, clk, enable);
@@ -61,6 +76,11 @@ static int s5pv310_clksrc_mask_peril0_ctrl(struct clk *clk, int enable)
 	return s5p_gatectrl(S5P_CLKSRC_MASK_PERIL0, clk, enable);
 }
 
+static int s5pv310_clksrc_mask_peril1_ctrl(struct clk *clk, int enable)
+{
+	return s5p_gatectrl(S5P_CLKSRC_MASK_PERIL1, clk, enable);
+}
+
 static int s5pv310_clk_ip_cam_ctrl(struct clk *clk, int enable)
 {
 	return s5p_gatectrl(S5P_CLKGATE_IP_CAM, clk, enable);
@@ -681,6 +701,172 @@ static struct clksrc_clk clksrcs[] = {
 		.reg_div = { .reg = S5P_CLKDIV_PERIL3, .shift = 0, .size = 4 },
 	}, {
 		.clk		= {
+			.name		= "sclk_csis",
+			.id		= 0,
+			.enable		= s5pv310_clksrc_mask_cam_ctrl,
+			.ctrlbit	= (1 << 24),
+		},
+		.sources = &clkset_group,
+		.reg_src = { .reg = S5P_CLKSRC_CAM, .shift = 24, .size = 4 },
+		.reg_div = { .reg = S5P_CLKDIV_CAM, .shift = 24, .size = 4 },
+	}, {
+		.clk		= {
+			.name		= "sclk_csis",
+			.id		= 1,
+			.enable		= s5pv310_clksrc_mask_cam_ctrl,
+			.ctrlbit	= (1 << 28),
+		},
+		.sources = &clkset_group,
+		.reg_src = { .reg = S5P_CLKSRC_CAM, .shift = 28, .size = 4 },
+		.reg_div = { .reg = S5P_CLKDIV_CAM, .shift = 28, .size = 4 },
+	}, {
+		.clk		= {
+			.name		= "sclk_cam",
+			.id		= 0,
+			.enable		= s5pv310_clksrc_mask_cam_ctrl,
+			.ctrlbit	= (1 << 16),
+		},
+		.sources = &clkset_group,
+		.reg_src = { .reg = S5P_CLKSRC_CAM, .shift = 16, .size = 4 },
+		.reg_div = { .reg = S5P_CLKDIV_CAM, .shift = 16, .size = 4 },
+	}, {
+		.clk		= {
+			.name		= "sclk_cam",
+			.id		= 1,
+			.enable		= s5pv310_clksrc_mask_cam_ctrl,
+			.ctrlbit	= (1 << 20),
+		},
+		.sources = &clkset_group,
+		.reg_src = { .reg = S5P_CLKSRC_CAM, .shift = 20, .size = 4 },
+		.reg_div = { .reg = S5P_CLKDIV_CAM, .shift = 20, .size = 4 },
+	}, {
+		.clk		= {
+			.name		= "sclk_fimc",
+			.id		= 0,
+			.enable		= s5pv310_clksrc_mask_cam_ctrl,
+			.ctrlbit	= (1 << 0),
+		},
+		.sources = &clkset_group,
+		.reg_src = { .reg = S5P_CLKSRC_CAM, .shift = 0, .size = 4 },
+		.reg_div = { .reg = S5P_CLKDIV_CAM, .shift = 0, .size = 4 },
+	}, {
+		.clk		= {
+			.name		= "sclk_fimc",
+			.id		= 1,
+			.enable		= s5pv310_clksrc_mask_cam_ctrl,
+			.ctrlbit	= (1 << 4),
+		},
+		.sources = &clkset_group,
+		.reg_src = { .reg = S5P_CLKSRC_CAM, .shift = 4, .size = 4 },
+		.reg_div = { .reg = S5P_CLKDIV_CAM, .shift = 4, .size = 4 },
+	}, {
+		.clk		= {
+			.name		= "sclk_fimc",
+			.id		= 2,
+			.enable		= s5pv310_clksrc_mask_cam_ctrl,
+			.ctrlbit	= (1 << 8),
+		},
+		.sources = &clkset_group,
+		.reg_src = { .reg = S5P_CLKSRC_CAM, .shift = 8, .size = 4 },
+		.reg_div = { .reg = S5P_CLKDIV_CAM, .shift = 8, .size = 4 },
+	}, {
+		.clk		= {
+			.name		= "sclk_fimc",
+			.id		= 3,
+			.enable		= s5pv310_clksrc_mask_cam_ctrl,
+			.ctrlbit	= (1 << 12),
+		},
+		.sources = &clkset_group,
+		.reg_src = { .reg = S5P_CLKSRC_CAM, .shift = 12, .size = 4 },
+		.reg_div = { .reg = S5P_CLKDIV_CAM, .shift = 12, .size = 4 },
+	}, {
+		.clk		= {
+			.name		= "sclk_fimd",
+			.id		= 0,
+			.enable		= s5pv310_clksrc_mask_lcd0_ctrl,
+			.ctrlbit	= (1 << 0),
+		},
+		.sources = &clkset_group,
+		.reg_src = { .reg = S5P_CLKSRC_LCD0, .shift = 0, .size = 4 },
+		.reg_div = { .reg = S5P_CLKDIV_LCD0, .shift = 0, .size = 4 },
+	}, {
+		.clk		= {
+			.name		= "sclk_fimd",
+			.id		= 1,
+			.enable		= s5pv310_clksrc_mask_lcd1_ctrl,
+			.ctrlbit	= (1 << 0),
+		},
+		.sources = &clkset_group,
+		.reg_src = { .reg = S5P_CLKSRC_LCD1, .shift = 0, .size = 4 },
+		.reg_div = { .reg = S5P_CLKDIV_LCD1, .shift = 0, .size = 4 },
+	}, {
+		.clk		= {
+			.name		= "sclk_mipi",
+			.id		= 0,
+			.parent		= &clk_sclk_mipidphy4l.clk,
+			.enable		= s5pv310_clksrc_mask_lcd0_ctrl,
+			.ctrlbit	= (1 << 12),
+		},
+		.reg_div = { .reg = S5P_CLKDIV_LCD0, .shift = 20, .size = 4 },
+	}, {
+		.clk		= {
+			.name		= "sclk_mipi",
+			.id		= 1,
+			.parent		= &clk_sclk_mipidphy2l.clk,
+			.enable		= s5pv310_clksrc_mask_lcd1_ctrl,
+			.ctrlbit	= (1 << 12),
+		},
+		.reg_div = { .reg = S5P_CLKDIV_LCD1, .shift = 20, .size = 4 },
+	}, {
+		.clk		= {
+			.name		= "sclk_sata",
+			.id		= -1,
+			.enable		= s5pv310_clksrc_mask_fsys_ctrl,
+			.ctrlbit	= (1 << 24),
+		},
+		.sources = &clkset_mout_corebus,
+		.reg_src = { .reg = S5P_CLKSRC_FSYS, .shift = 24, .size = 1 },
+		.reg_div = { .reg = S5P_CLKDIV_FSYS0, .shift = 20, .size = 4 },
+	}, {
+		.clk		= {
+			.name		= "sclk_spi",
+			.id		= 0,
+			.enable		= s5pv310_clksrc_mask_peril1_ctrl,
+			.ctrlbit	= (1 << 16),
+		},
+		.sources = &clkset_group,
+		.reg_src = { .reg = S5P_CLKSRC_PERIL1, .shift = 16, .size = 4 },
+		.reg_div = { .reg = S5P_CLKDIV_PERIL1, .shift = 0, .size = 4 },
+	}, {
+		.clk		= {
+			.name		= "sclk_spi",
+			.id		= 1,
+			.enable		= s5pv310_clksrc_mask_peril1_ctrl,
+			.ctrlbit	= (1 << 20),
+		},
+		.sources = &clkset_group,
+		.reg_src = { .reg = S5P_CLKSRC_PERIL1, .shift = 20, .size = 4 },
+		.reg_div = { .reg = S5P_CLKDIV_PERIL1, .shift = 16, .size = 4 },
+	}, {
+		.clk		= {
+			.name		= "sclk_spi",
+			.id		= 2,
+			.enable		= s5pv310_clksrc_mask_peril1_ctrl,
+			.ctrlbit	= (1 << 24),
+		},
+		.sources = &clkset_group,
+		.reg_src = { .reg = S5P_CLKSRC_PERIL1, .shift = 24, .size = 4 },
+		.reg_div = { .reg = S5P_CLKDIV_PERIL2, .shift = 0, .size = 4 },
+	}, {
+		.clk		= {
+			.name		= "sclk_fimg2d",
+			.id		= -1,
+		},
+		.sources = &clkset_mout_g2d,
+		.reg_src = { .reg = S5P_CLKSRC_IMAGE, .shift = 8, .size = 1 },
+		.reg_div = { .reg = S5P_CLKDIV_IMAGE, .shift = 0, .size = 4 },
+	}, {
+		.clk		= {
 			.name		= "sclk_mmc",
 			.id		= 0,
 			.parent		= &clk_dout_mmc0.clk,
-- 
1.6.2.5
