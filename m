From: kgene.kim@samsung.com (Kukjin Kim)
Date: Mon, 14 Feb 2011 17:22:58 +0900
Subject: [PATCH 02/11] ARM: EXYNOS4: Update Clock part
In-Reply-To: <1297671787-10571-1-git-send-email-kgene.kim@samsung.com>
References: <1297671787-10571-1-git-send-email-kgene.kim@samsung.com>
Message-ID: <1297671787-10571-3-git-send-email-kgene.kim@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patch updates Clock part of EXYNOS4 according to the change of
ARCH name, EXYNOS4.

Signed-off-by: Kukjin Kim <kgene.kim@samsung.com>
---
 arch/arm/{mach-s5pv310 => mach-exynos4}/clock.c    |  190 ++++++++++----------
 .../include/mach/regs-clock.h                      |    8 +-
 2 files changed, 99 insertions(+), 99 deletions(-)
 rename arch/arm/{mach-s5pv310 => mach-exynos4}/clock.c (83%)
 rename arch/arm/{mach-s5pv310 => mach-exynos4}/include/mach/regs-clock.h (97%)

diff --git a/arch/arm/mach-s5pv310/clock.c b/arch/arm/mach-exynos4/clock.c
similarity index 83%
rename from arch/arm/mach-s5pv310/clock.c
rename to arch/arm/mach-exynos4/clock.c
index fc7c2f8..72d53d5 100644
--- a/arch/arm/mach-s5pv310/clock.c
+++ b/arch/arm/mach-exynos4/clock.c
@@ -1,9 +1,9 @@
-/* linux/arch/arm/mach-s5pv310/clock.c
+/* linux/arch/arm/mach-exynos4/clock.c
  *
- * Copyright (c) 2010 Samsung Electronics Co., Ltd.
- *		http://www.samsung.com/
+ * Copyright (c) 2010-2011 Samsung Electronics Co., Ltd.
+ *		http://www.samsung.com
  *
- * S5PV310 - Clock support
+ * EXYNOS4 - Clock support
  *
  * This program is free software; you can redistribute it and/or modify
  * it under the terms of the GNU General Public License version 2 as
@@ -46,72 +46,72 @@ static struct clk clk_sclk_usbphy1 = {
 	.id		= -1,
 };
 
-static int s5pv310_clksrc_mask_top_ctrl(struct clk *clk, int enable)
+static int exynos4_clksrc_mask_top_ctrl(struct clk *clk, int enable)
 {
 	return s5p_gatectrl(S5P_CLKSRC_MASK_TOP, clk, enable);
 }
 
-static int s5pv310_clksrc_mask_cam_ctrl(struct clk *clk, int enable)
+static int exynos4_clksrc_mask_cam_ctrl(struct clk *clk, int enable)
 {
 	return s5p_gatectrl(S5P_CLKSRC_MASK_CAM, clk, enable);
 }
 
-static int s5pv310_clksrc_mask_lcd0_ctrl(struct clk *clk, int enable)
+static int exynos4_clksrc_mask_lcd0_ctrl(struct clk *clk, int enable)
 {
 	return s5p_gatectrl(S5P_CLKSRC_MASK_LCD0, clk, enable);
 }
 
-static int s5pv310_clksrc_mask_lcd1_ctrl(struct clk *clk, int enable)
+static int exynos4_clksrc_mask_lcd1_ctrl(struct clk *clk, int enable)
 {
 	return s5p_gatectrl(S5P_CLKSRC_MASK_LCD1, clk, enable);
 }
 
-static int s5pv310_clksrc_mask_fsys_ctrl(struct clk *clk, int enable)
+static int exynos4_clksrc_mask_fsys_ctrl(struct clk *clk, int enable)
 {
 	return s5p_gatectrl(S5P_CLKSRC_MASK_FSYS, clk, enable);
 }
 
-static int s5pv310_clksrc_mask_peril0_ctrl(struct clk *clk, int enable)
+static int exynos4_clksrc_mask_peril0_ctrl(struct clk *clk, int enable)
 {
 	return s5p_gatectrl(S5P_CLKSRC_MASK_PERIL0, clk, enable);
 }
 
-static int s5pv310_clksrc_mask_peril1_ctrl(struct clk *clk, int enable)
+static int exynos4_clksrc_mask_peril1_ctrl(struct clk *clk, int enable)
 {
 	return s5p_gatectrl(S5P_CLKSRC_MASK_PERIL1, clk, enable);
 }
 
-static int s5pv310_clk_ip_cam_ctrl(struct clk *clk, int enable)
+static int exynos4_clk_ip_cam_ctrl(struct clk *clk, int enable)
 {
 	return s5p_gatectrl(S5P_CLKGATE_IP_CAM, clk, enable);
 }
 
-static int s5pv310_clk_ip_image_ctrl(struct clk *clk, int enable)
+static int exynos4_clk_ip_image_ctrl(struct clk *clk, int enable)
 {
 	return s5p_gatectrl(S5P_CLKGATE_IP_IMAGE, clk, enable);
 }
 
-static int s5pv310_clk_ip_lcd0_ctrl(struct clk *clk, int enable)
+static int exynos4_clk_ip_lcd0_ctrl(struct clk *clk, int enable)
 {
 	return s5p_gatectrl(S5P_CLKGATE_IP_LCD0, clk, enable);
 }
 
-static int s5pv310_clk_ip_lcd1_ctrl(struct clk *clk, int enable)
+static int exynos4_clk_ip_lcd1_ctrl(struct clk *clk, int enable)
 {
 	return s5p_gatectrl(S5P_CLKGATE_IP_LCD1, clk, enable);
 }
 
-static int s5pv310_clk_ip_fsys_ctrl(struct clk *clk, int enable)
+static int exynos4_clk_ip_fsys_ctrl(struct clk *clk, int enable)
 {
 	return s5p_gatectrl(S5P_CLKGATE_IP_FSYS, clk, enable);
 }
 
-static int s5pv310_clk_ip_peril_ctrl(struct clk *clk, int enable)
+static int exynos4_clk_ip_peril_ctrl(struct clk *clk, int enable)
 {
 	return s5p_gatectrl(S5P_CLKGATE_IP_PERIL, clk, enable);
 }
 
-static int s5pv310_clk_ip_perir_ctrl(struct clk *clk, int enable)
+static int exynos4_clk_ip_perir_ctrl(struct clk *clk, int enable)
 {
 	return s5p_gatectrl(S5P_CLKGATE_IP_PERIR, clk, enable);
 }
@@ -358,7 +358,7 @@ static struct clksrc_clk clk_vpllsrc = {
 	.clk	= {
 		.name		= "vpll_src",
 		.id		= -1,
-		.enable		= s5pv310_clksrc_mask_top_ctrl,
+		.enable		= exynos4_clksrc_mask_top_ctrl,
 		.ctrlbit	= (1 << 0),
 	},
 	.sources	= &clkset_vpllsrc,
@@ -389,205 +389,205 @@ static struct clk init_clocks_off[] = {
 		.name		= "timers",
 		.id		= -1,
 		.parent		= &clk_aclk_100.clk,
-		.enable		= s5pv310_clk_ip_peril_ctrl,
+		.enable		= exynos4_clk_ip_peril_ctrl,
 		.ctrlbit	= (1<<24),
 	}, {
 		.name		= "csis",
 		.id		= 0,
-		.enable		= s5pv310_clk_ip_cam_ctrl,
+		.enable		= exynos4_clk_ip_cam_ctrl,
 		.ctrlbit	= (1 << 4),
 	}, {
 		.name		= "csis",
 		.id		= 1,
-		.enable		= s5pv310_clk_ip_cam_ctrl,
+		.enable		= exynos4_clk_ip_cam_ctrl,
 		.ctrlbit	= (1 << 5),
 	}, {
 		.name		= "fimc",
 		.id		= 0,
-		.enable		= s5pv310_clk_ip_cam_ctrl,
+		.enable		= exynos4_clk_ip_cam_ctrl,
 		.ctrlbit	= (1 << 0),
 	}, {
 		.name		= "fimc",
 		.id		= 1,
-		.enable		= s5pv310_clk_ip_cam_ctrl,
+		.enable		= exynos4_clk_ip_cam_ctrl,
 		.ctrlbit	= (1 << 1),
 	}, {
 		.name		= "fimc",
 		.id		= 2,
-		.enable		= s5pv310_clk_ip_cam_ctrl,
+		.enable		= exynos4_clk_ip_cam_ctrl,
 		.ctrlbit	= (1 << 2),
 	}, {
 		.name		= "fimc",
 		.id		= 3,
-		.enable		= s5pv310_clk_ip_cam_ctrl,
+		.enable		= exynos4_clk_ip_cam_ctrl,
 		.ctrlbit	= (1 << 3),
 	}, {
 		.name		= "fimd",
 		.id		= 0,
-		.enable		= s5pv310_clk_ip_lcd0_ctrl,
+		.enable		= exynos4_clk_ip_lcd0_ctrl,
 		.ctrlbit	= (1 << 0),
 	}, {
 		.name		= "fimd",
 		.id		= 1,
-		.enable		= s5pv310_clk_ip_lcd1_ctrl,
+		.enable		= exynos4_clk_ip_lcd1_ctrl,
 		.ctrlbit	= (1 << 0),
 	}, {
 		.name		= "hsmmc",
 		.id		= 0,
 		.parent		= &clk_aclk_133.clk,
-		.enable		= s5pv310_clk_ip_fsys_ctrl,
+		.enable		= exynos4_clk_ip_fsys_ctrl,
 		.ctrlbit	= (1 << 5),
 	}, {
 		.name		= "hsmmc",
 		.id		= 1,
 		.parent		= &clk_aclk_133.clk,
-		.enable		= s5pv310_clk_ip_fsys_ctrl,
+		.enable		= exynos4_clk_ip_fsys_ctrl,
 		.ctrlbit	= (1 << 6),
 	}, {
 		.name		= "hsmmc",
 		.id		= 2,
 		.parent		= &clk_aclk_133.clk,
-		.enable		= s5pv310_clk_ip_fsys_ctrl,
+		.enable		= exynos4_clk_ip_fsys_ctrl,
 		.ctrlbit	= (1 << 7),
 	}, {
 		.name		= "hsmmc",
 		.id		= 3,
 		.parent		= &clk_aclk_133.clk,
-		.enable		= s5pv310_clk_ip_fsys_ctrl,
+		.enable		= exynos4_clk_ip_fsys_ctrl,
 		.ctrlbit	= (1 << 8),
 	}, {
 		.name		= "hsmmc",
 		.id		= 4,
 		.parent		= &clk_aclk_133.clk,
-		.enable		= s5pv310_clk_ip_fsys_ctrl,
+		.enable		= exynos4_clk_ip_fsys_ctrl,
 		.ctrlbit	= (1 << 9),
 	}, {
 		.name		= "sata",
 		.id		= -1,
-		.enable		= s5pv310_clk_ip_fsys_ctrl,
+		.enable		= exynos4_clk_ip_fsys_ctrl,
 		.ctrlbit	= (1 << 10),
 	}, {
 		.name		= "pdma",
 		.id		= 0,
-		.enable		= s5pv310_clk_ip_fsys_ctrl,
+		.enable		= exynos4_clk_ip_fsys_ctrl,
 		.ctrlbit	= (1 << 0),
 	}, {
 		.name		= "pdma",
 		.id		= 1,
-		.enable		= s5pv310_clk_ip_fsys_ctrl,
+		.enable		= exynos4_clk_ip_fsys_ctrl,
 		.ctrlbit	= (1 << 1),
 	}, {
 		.name		= "adc",
 		.id		= -1,
-		.enable		= s5pv310_clk_ip_peril_ctrl,
+		.enable		= exynos4_clk_ip_peril_ctrl,
 		.ctrlbit	= (1 << 15),
 	}, {
 		.name		= "rtc",
 		.id		= -1,
-		.enable		= s5pv310_clk_ip_perir_ctrl,
+		.enable		= exynos4_clk_ip_perir_ctrl,
 		.ctrlbit	= (1 << 15),
 	}, {
 		.name		= "watchdog",
 		.id		= -1,
-		.enable		= s5pv310_clk_ip_perir_ctrl,
+		.enable		= exynos4_clk_ip_perir_ctrl,
 		.ctrlbit	= (1 << 14),
 	}, {
 		.name		= "usbhost",
 		.id		= -1,
-		.enable		= s5pv310_clk_ip_fsys_ctrl ,
+		.enable		= exynos4_clk_ip_fsys_ctrl ,
 		.ctrlbit	= (1 << 12),
 	}, {
 		.name		= "otg",
 		.id		= -1,
-		.enable		= s5pv310_clk_ip_fsys_ctrl,
+		.enable		= exynos4_clk_ip_fsys_ctrl,
 		.ctrlbit	= (1 << 13),
 	}, {
 		.name		= "spi",
 		.id		= 0,
-		.enable		= s5pv310_clk_ip_peril_ctrl,
+		.enable		= exynos4_clk_ip_peril_ctrl,
 		.ctrlbit	= (1 << 16),
 	}, {
 		.name		= "spi",
 		.id		= 1,
-		.enable		= s5pv310_clk_ip_peril_ctrl,
+		.enable		= exynos4_clk_ip_peril_ctrl,
 		.ctrlbit	= (1 << 17),
 	}, {
 		.name		= "spi",
 		.id		= 2,
-		.enable		= s5pv310_clk_ip_peril_ctrl,
+		.enable		= exynos4_clk_ip_peril_ctrl,
 		.ctrlbit	= (1 << 18),
 	}, {
 		.name		= "iis",
 		.id		= 0,
-		.enable		= s5pv310_clk_ip_peril_ctrl,
+		.enable		= exynos4_clk_ip_peril_ctrl,
 		.ctrlbit	= (1 << 19),
 	}, {
 		.name		= "iis",
 		.id		= 1,
-		.enable		= s5pv310_clk_ip_peril_ctrl,
+		.enable		= exynos4_clk_ip_peril_ctrl,
 		.ctrlbit	= (1 << 20),
 	}, {
 		.name		= "iis",
 		.id		= 2,
-		.enable		= s5pv310_clk_ip_peril_ctrl,
+		.enable		= exynos4_clk_ip_peril_ctrl,
 		.ctrlbit	= (1 << 21),
 	}, {
 		.name		= "ac97",
 		.id		= -1,
-		.enable		= s5pv310_clk_ip_peril_ctrl,
+		.enable		= exynos4_clk_ip_peril_ctrl,
 		.ctrlbit	= (1 << 27),
 	}, {
 		.name		= "fimg2d",
 		.id		= -1,
-		.enable		= s5pv310_clk_ip_image_ctrl,
+		.enable		= exynos4_clk_ip_image_ctrl,
 		.ctrlbit	= (1 << 0),
 	}, {
 		.name		= "i2c",
 		.id		= 0,
 		.parent		= &clk_aclk_100.clk,
-		.enable		= s5pv310_clk_ip_peril_ctrl,
+		.enable		= exynos4_clk_ip_peril_ctrl,
 		.ctrlbit	= (1 << 6),
 	}, {
 		.name		= "i2c",
 		.id		= 1,
 		.parent		= &clk_aclk_100.clk,
-		.enable		= s5pv310_clk_ip_peril_ctrl,
+		.enable		= exynos4_clk_ip_peril_ctrl,
 		.ctrlbit	= (1 << 7),
 	}, {
 		.name		= "i2c",
 		.id		= 2,
 		.parent		= &clk_aclk_100.clk,
-		.enable		= s5pv310_clk_ip_peril_ctrl,
+		.enable		= exynos4_clk_ip_peril_ctrl,
 		.ctrlbit	= (1 << 8),
 	}, {
 		.name		= "i2c",
 		.id		= 3,
 		.parent		= &clk_aclk_100.clk,
-		.enable		= s5pv310_clk_ip_peril_ctrl,
+		.enable		= exynos4_clk_ip_peril_ctrl,
 		.ctrlbit	= (1 << 9),
 	}, {
 		.name		= "i2c",
 		.id		= 4,
 		.parent		= &clk_aclk_100.clk,
-		.enable		= s5pv310_clk_ip_peril_ctrl,
+		.enable		= exynos4_clk_ip_peril_ctrl,
 		.ctrlbit	= (1 << 10),
 	}, {
 		.name		= "i2c",
 		.id		= 5,
 		.parent		= &clk_aclk_100.clk,
-		.enable		= s5pv310_clk_ip_peril_ctrl,
+		.enable		= exynos4_clk_ip_peril_ctrl,
 		.ctrlbit	= (1 << 11),
 	}, {
 		.name		= "i2c",
 		.id		= 6,
 		.parent		= &clk_aclk_100.clk,
-		.enable		= s5pv310_clk_ip_peril_ctrl,
+		.enable		= exynos4_clk_ip_peril_ctrl,
 		.ctrlbit	= (1 << 12),
 	}, {
 		.name		= "i2c",
 		.id		= 7,
 		.parent		= &clk_aclk_100.clk,
-		.enable		= s5pv310_clk_ip_peril_ctrl,
+		.enable		= exynos4_clk_ip_peril_ctrl,
 		.ctrlbit	= (1 << 13),
 	},
 };
@@ -596,32 +596,32 @@ static struct clk init_clocks[] = {
 	{
 		.name		= "uart",
 		.id		= 0,
-		.enable		= s5pv310_clk_ip_peril_ctrl,
+		.enable		= exynos4_clk_ip_peril_ctrl,
 		.ctrlbit	= (1 << 0),
 	}, {
 		.name		= "uart",
 		.id		= 1,
-		.enable		= s5pv310_clk_ip_peril_ctrl,
+		.enable		= exynos4_clk_ip_peril_ctrl,
 		.ctrlbit	= (1 << 1),
 	}, {
 		.name		= "uart",
 		.id		= 2,
-		.enable		= s5pv310_clk_ip_peril_ctrl,
+		.enable		= exynos4_clk_ip_peril_ctrl,
 		.ctrlbit	= (1 << 2),
 	}, {
 		.name		= "uart",
 		.id		= 3,
-		.enable		= s5pv310_clk_ip_peril_ctrl,
+		.enable		= exynos4_clk_ip_peril_ctrl,
 		.ctrlbit	= (1 << 3),
 	}, {
 		.name		= "uart",
 		.id		= 4,
-		.enable		= s5pv310_clk_ip_peril_ctrl,
+		.enable		= exynos4_clk_ip_peril_ctrl,
 		.ctrlbit	= (1 << 4),
 	}, {
 		.name		= "uart",
 		.id		= 5,
-		.enable		= s5pv310_clk_ip_peril_ctrl,
+		.enable		= exynos4_clk_ip_peril_ctrl,
 		.ctrlbit	= (1 << 5),
 	}
 };
@@ -746,7 +746,7 @@ static struct clksrc_clk clksrcs[] = {
 		.clk	= {
 			.name		= "uclk1",
 			.id		= 0,
-			.enable		= s5pv310_clksrc_mask_peril0_ctrl,
+			.enable		= exynos4_clksrc_mask_peril0_ctrl,
 			.ctrlbit	= (1 << 0),
 		},
 		.sources = &clkset_group,
@@ -756,7 +756,7 @@ static struct clksrc_clk clksrcs[] = {
 		.clk		= {
 			.name		= "uclk1",
 			.id		= 1,
-			.enable		= s5pv310_clksrc_mask_peril0_ctrl,
+			.enable		= exynos4_clksrc_mask_peril0_ctrl,
 			.ctrlbit	= (1 << 4),
 		},
 		.sources = &clkset_group,
@@ -766,7 +766,7 @@ static struct clksrc_clk clksrcs[] = {
 		.clk		= {
 			.name		= "uclk1",
 			.id		= 2,
-			.enable		= s5pv310_clksrc_mask_peril0_ctrl,
+			.enable		= exynos4_clksrc_mask_peril0_ctrl,
 			.ctrlbit	= (1 << 8),
 		},
 		.sources = &clkset_group,
@@ -776,7 +776,7 @@ static struct clksrc_clk clksrcs[] = {
 		.clk		= {
 			.name		= "uclk1",
 			.id		= 3,
-			.enable		= s5pv310_clksrc_mask_peril0_ctrl,
+			.enable		= exynos4_clksrc_mask_peril0_ctrl,
 			.ctrlbit	= (1 << 12),
 		},
 		.sources = &clkset_group,
@@ -786,7 +786,7 @@ static struct clksrc_clk clksrcs[] = {
 		.clk		= {
 			.name		= "sclk_pwm",
 			.id		= -1,
-			.enable		= s5pv310_clksrc_mask_peril0_ctrl,
+			.enable		= exynos4_clksrc_mask_peril0_ctrl,
 			.ctrlbit	= (1 << 24),
 		},
 		.sources = &clkset_group,
@@ -796,7 +796,7 @@ static struct clksrc_clk clksrcs[] = {
 		.clk		= {
 			.name		= "sclk_csis",
 			.id		= 0,
-			.enable		= s5pv310_clksrc_mask_cam_ctrl,
+			.enable		= exynos4_clksrc_mask_cam_ctrl,
 			.ctrlbit	= (1 << 24),
 		},
 		.sources = &clkset_group,
@@ -806,7 +806,7 @@ static struct clksrc_clk clksrcs[] = {
 		.clk		= {
 			.name		= "sclk_csis",
 			.id		= 1,
-			.enable		= s5pv310_clksrc_mask_cam_ctrl,
+			.enable		= exynos4_clksrc_mask_cam_ctrl,
 			.ctrlbit	= (1 << 28),
 		},
 		.sources = &clkset_group,
@@ -816,7 +816,7 @@ static struct clksrc_clk clksrcs[] = {
 		.clk		= {
 			.name		= "sclk_cam",
 			.id		= 0,
-			.enable		= s5pv310_clksrc_mask_cam_ctrl,
+			.enable		= exynos4_clksrc_mask_cam_ctrl,
 			.ctrlbit	= (1 << 16),
 		},
 		.sources = &clkset_group,
@@ -826,7 +826,7 @@ static struct clksrc_clk clksrcs[] = {
 		.clk		= {
 			.name		= "sclk_cam",
 			.id		= 1,
-			.enable		= s5pv310_clksrc_mask_cam_ctrl,
+			.enable		= exynos4_clksrc_mask_cam_ctrl,
 			.ctrlbit	= (1 << 20),
 		},
 		.sources = &clkset_group,
@@ -836,7 +836,7 @@ static struct clksrc_clk clksrcs[] = {
 		.clk		= {
 			.name		= "sclk_fimc",
 			.id		= 0,
-			.enable		= s5pv310_clksrc_mask_cam_ctrl,
+			.enable		= exynos4_clksrc_mask_cam_ctrl,
 			.ctrlbit	= (1 << 0),
 		},
 		.sources = &clkset_group,
@@ -846,7 +846,7 @@ static struct clksrc_clk clksrcs[] = {
 		.clk		= {
 			.name		= "sclk_fimc",
 			.id		= 1,
-			.enable		= s5pv310_clksrc_mask_cam_ctrl,
+			.enable		= exynos4_clksrc_mask_cam_ctrl,
 			.ctrlbit	= (1 << 4),
 		},
 		.sources = &clkset_group,
@@ -856,7 +856,7 @@ static struct clksrc_clk clksrcs[] = {
 		.clk		= {
 			.name		= "sclk_fimc",
 			.id		= 2,
-			.enable		= s5pv310_clksrc_mask_cam_ctrl,
+			.enable		= exynos4_clksrc_mask_cam_ctrl,
 			.ctrlbit	= (1 << 8),
 		},
 		.sources = &clkset_group,
@@ -866,7 +866,7 @@ static struct clksrc_clk clksrcs[] = {
 		.clk		= {
 			.name		= "sclk_fimc",
 			.id		= 3,
-			.enable		= s5pv310_clksrc_mask_cam_ctrl,
+			.enable		= exynos4_clksrc_mask_cam_ctrl,
 			.ctrlbit	= (1 << 12),
 		},
 		.sources = &clkset_group,
@@ -876,7 +876,7 @@ static struct clksrc_clk clksrcs[] = {
 		.clk		= {
 			.name		= "sclk_fimd",
 			.id		= 0,
-			.enable		= s5pv310_clksrc_mask_lcd0_ctrl,
+			.enable		= exynos4_clksrc_mask_lcd0_ctrl,
 			.ctrlbit	= (1 << 0),
 		},
 		.sources = &clkset_group,
@@ -886,7 +886,7 @@ static struct clksrc_clk clksrcs[] = {
 		.clk		= {
 			.name		= "sclk_fimd",
 			.id		= 1,
-			.enable		= s5pv310_clksrc_mask_lcd1_ctrl,
+			.enable		= exynos4_clksrc_mask_lcd1_ctrl,
 			.ctrlbit	= (1 << 0),
 		},
 		.sources = &clkset_group,
@@ -896,7 +896,7 @@ static struct clksrc_clk clksrcs[] = {
 		.clk		= {
 			.name		= "sclk_sata",
 			.id		= -1,
-			.enable		= s5pv310_clksrc_mask_fsys_ctrl,
+			.enable		= exynos4_clksrc_mask_fsys_ctrl,
 			.ctrlbit	= (1 << 24),
 		},
 		.sources = &clkset_mout_corebus,
@@ -906,7 +906,7 @@ static struct clksrc_clk clksrcs[] = {
 		.clk		= {
 			.name		= "sclk_spi",
 			.id		= 0,
-			.enable		= s5pv310_clksrc_mask_peril1_ctrl,
+			.enable		= exynos4_clksrc_mask_peril1_ctrl,
 			.ctrlbit	= (1 << 16),
 		},
 		.sources = &clkset_group,
@@ -916,7 +916,7 @@ static struct clksrc_clk clksrcs[] = {
 		.clk		= {
 			.name		= "sclk_spi",
 			.id		= 1,
-			.enable		= s5pv310_clksrc_mask_peril1_ctrl,
+			.enable		= exynos4_clksrc_mask_peril1_ctrl,
 			.ctrlbit	= (1 << 20),
 		},
 		.sources = &clkset_group,
@@ -926,7 +926,7 @@ static struct clksrc_clk clksrcs[] = {
 		.clk		= {
 			.name		= "sclk_spi",
 			.id		= 2,
-			.enable		= s5pv310_clksrc_mask_peril1_ctrl,
+			.enable		= exynos4_clksrc_mask_peril1_ctrl,
 			.ctrlbit	= (1 << 24),
 		},
 		.sources = &clkset_group,
@@ -945,7 +945,7 @@ static struct clksrc_clk clksrcs[] = {
 			.name		= "sclk_mmc",
 			.id		= 0,
 			.parent		= &clk_dout_mmc0.clk,
-			.enable		= s5pv310_clksrc_mask_fsys_ctrl,
+			.enable		= exynos4_clksrc_mask_fsys_ctrl,
 			.ctrlbit	= (1 << 0),
 		},
 		.reg_div = { .reg = S5P_CLKDIV_FSYS1, .shift = 8, .size = 8 },
@@ -954,7 +954,7 @@ static struct clksrc_clk clksrcs[] = {
 			.name		= "sclk_mmc",
 			.id		= 1,
 			.parent         = &clk_dout_mmc1.clk,
-			.enable		= s5pv310_clksrc_mask_fsys_ctrl,
+			.enable		= exynos4_clksrc_mask_fsys_ctrl,
 			.ctrlbit	= (1 << 4),
 		},
 		.reg_div = { .reg = S5P_CLKDIV_FSYS1, .shift = 24, .size = 8 },
@@ -963,7 +963,7 @@ static struct clksrc_clk clksrcs[] = {
 			.name		= "sclk_mmc",
 			.id		= 2,
 			.parent         = &clk_dout_mmc2.clk,
-			.enable		= s5pv310_clksrc_mask_fsys_ctrl,
+			.enable		= exynos4_clksrc_mask_fsys_ctrl,
 			.ctrlbit	= (1 << 8),
 		},
 		.reg_div = { .reg = S5P_CLKDIV_FSYS2, .shift = 8, .size = 8 },
@@ -972,7 +972,7 @@ static struct clksrc_clk clksrcs[] = {
 			.name		= "sclk_mmc",
 			.id		= 3,
 			.parent         = &clk_dout_mmc3.clk,
-			.enable		= s5pv310_clksrc_mask_fsys_ctrl,
+			.enable		= exynos4_clksrc_mask_fsys_ctrl,
 			.ctrlbit	= (1 << 12),
 		},
 		.reg_div = { .reg = S5P_CLKDIV_FSYS2, .shift = 24, .size = 8 },
@@ -981,7 +981,7 @@ static struct clksrc_clk clksrcs[] = {
 			.name		= "sclk_mmc",
 			.id		= 4,
 			.parent         = &clk_dout_mmc4.clk,
-			.enable		= s5pv310_clksrc_mask_fsys_ctrl,
+			.enable		= exynos4_clksrc_mask_fsys_ctrl,
 			.ctrlbit	= (1 << 16),
 		},
 		.reg_div = { .reg = S5P_CLKDIV_FSYS3, .shift = 8, .size = 8 },
@@ -1022,16 +1022,16 @@ static struct clksrc_clk *sysclks[] = {
 
 static int xtal_rate;
 
-static unsigned long s5pv310_fout_apll_get_rate(struct clk *clk)
+static unsigned long exynos4_fout_apll_get_rate(struct clk *clk)
 {
 	return s5p_get_pll45xx(xtal_rate, __raw_readl(S5P_APLL_CON0), pll_4508);
 }
 
-static struct clk_ops s5pv310_fout_apll_ops = {
-	.get_rate = s5pv310_fout_apll_get_rate,
+static struct clk_ops exynos4_fout_apll_ops = {
+	.get_rate = exynos4_fout_apll_get_rate,
 };
 
-void __init_or_cpufreq s5pv310_setup_clocks(void)
+void __init_or_cpufreq exynos4_setup_clocks(void)
 {
 	struct clk *xtal_clk;
 	unsigned long apll;
@@ -1070,12 +1070,12 @@ void __init_or_cpufreq s5pv310_setup_clocks(void)
 	vpll = s5p_get_pll46xx(vpllsrc, __raw_readl(S5P_VPLL_CON0),
 				__raw_readl(S5P_VPLL_CON1), pll_4650);
 
-	clk_fout_apll.ops = &s5pv310_fout_apll_ops;
+	clk_fout_apll.ops = &exynos4_fout_apll_ops;
 	clk_fout_mpll.rate = mpll;
 	clk_fout_epll.rate = epll;
 	clk_fout_vpll.rate = vpll;
 
-	printk(KERN_INFO "S5PV310: PLL settings, A=%ld, M=%ld, E=%ld V=%ld",
+	printk(KERN_INFO "EXYNOS4: PLL settings, A=%ld, M=%ld, E=%ld V=%ld",
 			apll, mpll, epll, vpll);
 
 	armclk = clk_get_rate(&clk_armclk.clk);
@@ -1086,7 +1086,7 @@ void __init_or_cpufreq s5pv310_setup_clocks(void)
 	aclk_160 = clk_get_rate(&clk_aclk_160.clk);
 	aclk_133 = clk_get_rate(&clk_aclk_133.clk);
 
-	printk(KERN_INFO "S5PV310: ARMCLK=%ld, DMC=%ld, ACLK200=%ld\n"
+	printk(KERN_INFO "EXYNOS4: ARMCLK=%ld, DMC=%ld, ACLK200=%ld\n"
 			 "ACLK100=%ld, ACLK160=%ld, ACLK133=%ld\n",
 			armclk, sclk_dmc, aclk_200,
 			aclk_100, aclk_160, aclk_133);
@@ -1103,7 +1103,7 @@ static struct clk *clks[] __initdata = {
 	/* Nothing here yet */
 };
 
-void __init s5pv310_register_clocks(void)
+void __init exynos4_register_clocks(void)
 {
 	int ptr;
 
diff --git a/arch/arm/mach-s5pv310/include/mach/regs-clock.h b/arch/arm/mach-exynos4/include/mach/regs-clock.h
similarity index 97%
rename from arch/arm/mach-s5pv310/include/mach/regs-clock.h
rename to arch/arm/mach-exynos4/include/mach/regs-clock.h
index b5c4ada..ba8f91c 100644
--- a/arch/arm/mach-s5pv310/include/mach/regs-clock.h
+++ b/arch/arm/mach-exynos4/include/mach/regs-clock.h
@@ -1,9 +1,9 @@
-/* linux/arch/arm/mach-s5pv310/include/mach/regs-clock.h
+/* linux/arch/arm/mach-exynos4/include/mach/regs-clock.h
  *
- * Copyright (c) 2010 Samsung Electronics Co., Ltd.
- *		http://www.samsung.com/
+ * Copyright (c) 2010-2011 Samsung Electronics Co., Ltd.
+ *		http://www.samsung.com
  *
- * S5PV310 - Clock register definitions
+ * EXYNOS4 - Clock register definitions
  *
  * This program is free software; you can redistribute it and/or modify
  * it under the terms of the GNU General Public License version 2 as
-- 
1.7.1
