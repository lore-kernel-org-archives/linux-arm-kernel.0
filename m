From: ykk@rock-chips.com (Yakir Yang)
Date: Mon, 15 Feb 2016 11:25:17 +0800
Subject: [PATCH v13.1 03/19] drm: bridge: analogix/dp: rename register
 constants
In-Reply-To: <1453427614-23053-1-git-send-email-ykk@rock-chips.com>
References: <1453427614-23053-1-git-send-email-ykk@rock-chips.com>
Message-ID: <1455506717-31869-1-git-send-email-ykk@rock-chips.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Heiko Stuebner <heiko@sntech.de>

In the original split we kept the register constants intact to keep the
diff small. Still the constants are Analogix-specific, so rename them now.

Signed-off-by: Heiko Stuebner <heiko@sntech.de>
---
This patch is splited from "[PATCH v13 01/17] drm: bridge: analogix/dp: split
exynos dp driver to bridge directory".

Changes in v13.1: None
Changes in v13: None
Changes in v12: None
Changes in v11: None
Changes in v10: None
Changes in v9: None
Changes in v8: None
Changes in v7: None
Changes in v6: None
Changes in v5: None
Changes in v4: None
Changes in v3: None
Changes in v2: None

 drivers/gpu/drm/bridge/analogix/analogix_dp_reg.c | 456 +++++++++++-----------
 drivers/gpu/drm/bridge/analogix/analogix_dp_reg.h | 248 ++++++------
 2 files changed, 352 insertions(+), 352 deletions(-)

diff --git a/drivers/gpu/drm/bridge/analogix/analogix_dp_reg.c b/drivers/gpu/drm/bridge/analogix/analogix_dp_reg.c
index 0b926ea..442cc66 100644
--- a/drivers/gpu/drm/bridge/analogix/analogix_dp_reg.c
+++ b/drivers/gpu/drm/bridge/analogix/analogix_dp_reg.c
@@ -29,13 +29,13 @@ void analogix_dp_enable_video_mute(struct analogix_dp_device *dp, bool enable)
 	u32 reg;
 
 	if (enable) {
-		reg = readl(dp->reg_base + EXYNOS_DP_VIDEO_CTL_1);
+		reg = readl(dp->reg_base + ANALOGIX_DP_VIDEO_CTL_1);
 		reg |= HDCP_VIDEO_MUTE;
-		writel(reg, dp->reg_base + EXYNOS_DP_VIDEO_CTL_1);
+		writel(reg, dp->reg_base + ANALOGIX_DP_VIDEO_CTL_1);
 	} else {
-		reg = readl(dp->reg_base + EXYNOS_DP_VIDEO_CTL_1);
+		reg = readl(dp->reg_base + ANALOGIX_DP_VIDEO_CTL_1);
 		reg &= ~HDCP_VIDEO_MUTE;
-		writel(reg, dp->reg_base + EXYNOS_DP_VIDEO_CTL_1);
+		writel(reg, dp->reg_base + ANALOGIX_DP_VIDEO_CTL_1);
 	}
 }
 
@@ -43,9 +43,9 @@ void analogix_dp_stop_video(struct analogix_dp_device *dp)
 {
 	u32 reg;
 
-	reg = readl(dp->reg_base + EXYNOS_DP_VIDEO_CTL_1);
+	reg = readl(dp->reg_base + ANALOGIX_DP_VIDEO_CTL_1);
 	reg &= ~VIDEO_EN;
-	writel(reg, dp->reg_base + EXYNOS_DP_VIDEO_CTL_1);
+	writel(reg, dp->reg_base + ANALOGIX_DP_VIDEO_CTL_1);
 }
 
 void analogix_dp_lane_swap(struct analogix_dp_device *dp, bool enable)
@@ -59,7 +59,7 @@ void analogix_dp_lane_swap(struct analogix_dp_device *dp, bool enable)
 		reg = LANE3_MAP_LOGIC_LANE_3 | LANE2_MAP_LOGIC_LANE_2 |
 			LANE1_MAP_LOGIC_LANE_1 | LANE0_MAP_LOGIC_LANE_0;
 
-	writel(reg, dp->reg_base + EXYNOS_DP_LANE_MAP);
+	writel(reg, dp->reg_base + ANALOGIX_DP_LANE_MAP);
 }
 
 void analogix_dp_init_analog_param(struct analogix_dp_device *dp)
@@ -67,41 +67,41 @@ void analogix_dp_init_analog_param(struct analogix_dp_device *dp)
 	u32 reg;
 
 	reg = TX_TERMINAL_CTRL_50_OHM;
-	writel(reg, dp->reg_base + EXYNOS_DP_ANALOG_CTL_1);
+	writel(reg, dp->reg_base + ANALOGIX_DP_ANALOG_CTL_1);
 
 	reg = SEL_24M | TX_DVDD_BIT_1_0625V;
-	writel(reg, dp->reg_base + EXYNOS_DP_ANALOG_CTL_2);
+	writel(reg, dp->reg_base + ANALOGIX_DP_ANALOG_CTL_2);
 
 	reg = DRIVE_DVDD_BIT_1_0625V | VCO_BIT_600_MICRO;
-	writel(reg, dp->reg_base + EXYNOS_DP_ANALOG_CTL_3);
+	writel(reg, dp->reg_base + ANALOGIX_DP_ANALOG_CTL_3);
 
 	reg = PD_RING_OSC | AUX_TERMINAL_CTRL_50_OHM |
 		TX_CUR1_2X | TX_CUR_16_MA;
-	writel(reg, dp->reg_base + EXYNOS_DP_PLL_FILTER_CTL_1);
+	writel(reg, dp->reg_base + ANALOGIX_DP_PLL_FILTER_CTL_1);
 
 	reg = CH3_AMP_400_MV | CH2_AMP_400_MV |
 		CH1_AMP_400_MV | CH0_AMP_400_MV;
-	writel(reg, dp->reg_base + EXYNOS_DP_TX_AMP_TUNING_CTL);
+	writel(reg, dp->reg_base + ANALOGIX_DP_TX_AMP_TUNING_CTL);
 }
 
 void analogix_dp_init_interrupt(struct analogix_dp_device *dp)
 {
 	/* Set interrupt pin assertion polarity as high */
-	writel(INT_POL1 | INT_POL0, dp->reg_base + EXYNOS_DP_INT_CTL);
+	writel(INT_POL1 | INT_POL0, dp->reg_base + ANALOGIX_DP_INT_CTL);
 
 	/* Clear pending regisers */
-	writel(0xff, dp->reg_base + EXYNOS_DP_COMMON_INT_STA_1);
-	writel(0x4f, dp->reg_base + EXYNOS_DP_COMMON_INT_STA_2);
-	writel(0xe0, dp->reg_base + EXYNOS_DP_COMMON_INT_STA_3);
-	writel(0xe7, dp->reg_base + EXYNOS_DP_COMMON_INT_STA_4);
-	writel(0x63, dp->reg_base + EXYNOS_DP_INT_STA);
+	writel(0xff, dp->reg_base + ANALOGIX_DP_COMMON_INT_STA_1);
+	writel(0x4f, dp->reg_base + ANALOGIX_DP_COMMON_INT_STA_2);
+	writel(0xe0, dp->reg_base + ANALOGIX_DP_COMMON_INT_STA_3);
+	writel(0xe7, dp->reg_base + ANALOGIX_DP_COMMON_INT_STA_4);
+	writel(0x63, dp->reg_base + ANALOGIX_DP_INT_STA);
 
 	/* 0:mask,1: unmask */
-	writel(0x00, dp->reg_base + EXYNOS_DP_COMMON_INT_MASK_1);
-	writel(0x00, dp->reg_base + EXYNOS_DP_COMMON_INT_MASK_2);
-	writel(0x00, dp->reg_base + EXYNOS_DP_COMMON_INT_MASK_3);
-	writel(0x00, dp->reg_base + EXYNOS_DP_COMMON_INT_MASK_4);
-	writel(0x00, dp->reg_base + EXYNOS_DP_INT_STA_MASK);
+	writel(0x00, dp->reg_base + ANALOGIX_DP_COMMON_INT_MASK_1);
+	writel(0x00, dp->reg_base + ANALOGIX_DP_COMMON_INT_MASK_2);
+	writel(0x00, dp->reg_base + ANALOGIX_DP_COMMON_INT_MASK_3);
+	writel(0x00, dp->reg_base + ANALOGIX_DP_COMMON_INT_MASK_4);
+	writel(0x00, dp->reg_base + ANALOGIX_DP_INT_STA_MASK);
 }
 
 void analogix_dp_reset(struct analogix_dp_device *dp)
@@ -114,44 +114,44 @@ void analogix_dp_reset(struct analogix_dp_device *dp)
 	reg = MASTER_VID_FUNC_EN_N | SLAVE_VID_FUNC_EN_N |
 		AUD_FIFO_FUNC_EN_N | AUD_FUNC_EN_N |
 		HDCP_FUNC_EN_N | SW_FUNC_EN_N;
-	writel(reg, dp->reg_base + EXYNOS_DP_FUNC_EN_1);
+	writel(reg, dp->reg_base + ANALOGIX_DP_FUNC_EN_1);
 
 	reg = SSC_FUNC_EN_N | AUX_FUNC_EN_N |
 		SERDES_FIFO_FUNC_EN_N |
 		LS_CLK_DOMAIN_FUNC_EN_N;
-	writel(reg, dp->reg_base + EXYNOS_DP_FUNC_EN_2);
+	writel(reg, dp->reg_base + ANALOGIX_DP_FUNC_EN_2);
 
 	usleep_range(20, 30);
 
 	analogix_dp_lane_swap(dp, 0);
 
-	writel(0x0, dp->reg_base + EXYNOS_DP_SYS_CTL_1);
-	writel(0x40, dp->reg_base + EXYNOS_DP_SYS_CTL_2);
-	writel(0x0, dp->reg_base + EXYNOS_DP_SYS_CTL_3);
-	writel(0x0, dp->reg_base + EXYNOS_DP_SYS_CTL_4);
+	writel(0x0, dp->reg_base + ANALOGIX_DP_SYS_CTL_1);
+	writel(0x40, dp->reg_base + ANALOGIX_DP_SYS_CTL_2);
+	writel(0x0, dp->reg_base + ANALOGIX_DP_SYS_CTL_3);
+	writel(0x0, dp->reg_base + ANALOGIX_DP_SYS_CTL_4);
 
-	writel(0x0, dp->reg_base + EXYNOS_DP_PKT_SEND_CTL);
-	writel(0x0, dp->reg_base + EXYNOS_DP_HDCP_CTL);
+	writel(0x0, dp->reg_base + ANALOGIX_DP_PKT_SEND_CTL);
+	writel(0x0, dp->reg_base + ANALOGIX_DP_HDCP_CTL);
 
-	writel(0x5e, dp->reg_base + EXYNOS_DP_HPD_DEGLITCH_L);
-	writel(0x1a, dp->reg_base + EXYNOS_DP_HPD_DEGLITCH_H);
+	writel(0x5e, dp->reg_base + ANALOGIX_DP_HPD_DEGLITCH_L);
+	writel(0x1a, dp->reg_base + ANALOGIX_DP_HPD_DEGLITCH_H);
 
-	writel(0x10, dp->reg_base + EXYNOS_DP_LINK_DEBUG_CTL);
+	writel(0x10, dp->reg_base + ANALOGIX_DP_LINK_DEBUG_CTL);
 
-	writel(0x0, dp->reg_base + EXYNOS_DP_PHY_TEST);
+	writel(0x0, dp->reg_base + ANALOGIX_DP_PHY_TEST);
 
-	writel(0x0, dp->reg_base + EXYNOS_DP_VIDEO_FIFO_THRD);
-	writel(0x20, dp->reg_base + EXYNOS_DP_AUDIO_MARGIN);
+	writel(0x0, dp->reg_base + ANALOGIX_DP_VIDEO_FIFO_THRD);
+	writel(0x20, dp->reg_base + ANALOGIX_DP_AUDIO_MARGIN);
 
-	writel(0x4, dp->reg_base + EXYNOS_DP_M_VID_GEN_FILTER_TH);
-	writel(0x2, dp->reg_base + EXYNOS_DP_M_AUD_GEN_FILTER_TH);
+	writel(0x4, dp->reg_base + ANALOGIX_DP_M_VID_GEN_FILTER_TH);
+	writel(0x2, dp->reg_base + ANALOGIX_DP_M_AUD_GEN_FILTER_TH);
 
-	writel(0x00000101, dp->reg_base + EXYNOS_DP_SOC_GENERAL_CTL);
+	writel(0x00000101, dp->reg_base + ANALOGIX_DP_SOC_GENERAL_CTL);
 }
 
 void analogix_dp_swreset(struct analogix_dp_device *dp)
 {
-	writel(RESET_DP_TX, dp->reg_base + EXYNOS_DP_TX_SW_RESET);
+	writel(RESET_DP_TX, dp->reg_base + ANALOGIX_DP_TX_SW_RESET);
 }
 
 void analogix_dp_config_interrupt(struct analogix_dp_device *dp)
@@ -160,26 +160,26 @@ void analogix_dp_config_interrupt(struct analogix_dp_device *dp)
 
 	/* 0: mask, 1: unmask */
 	reg = COMMON_INT_MASK_1;
-	writel(reg, dp->reg_base + EXYNOS_DP_COMMON_INT_MASK_1);
+	writel(reg, dp->reg_base + ANALOGIX_DP_COMMON_INT_MASK_1);
 
 	reg = COMMON_INT_MASK_2;
-	writel(reg, dp->reg_base + EXYNOS_DP_COMMON_INT_MASK_2);
+	writel(reg, dp->reg_base + ANALOGIX_DP_COMMON_INT_MASK_2);
 
 	reg = COMMON_INT_MASK_3;
-	writel(reg, dp->reg_base + EXYNOS_DP_COMMON_INT_MASK_3);
+	writel(reg, dp->reg_base + ANALOGIX_DP_COMMON_INT_MASK_3);
 
 	reg = COMMON_INT_MASK_4;
-	writel(reg, dp->reg_base + EXYNOS_DP_COMMON_INT_MASK_4);
+	writel(reg, dp->reg_base + ANALOGIX_DP_COMMON_INT_MASK_4);
 
 	reg = INT_STA_MASK;
-	writel(reg, dp->reg_base + EXYNOS_DP_INT_STA_MASK);
+	writel(reg, dp->reg_base + ANALOGIX_DP_INT_STA_MASK);
 }
 
 enum pll_status analogix_dp_get_pll_lock_status(struct analogix_dp_device *dp)
 {
 	u32 reg;
 
-	reg = readl(dp->reg_base + EXYNOS_DP_DEBUG_CTL);
+	reg = readl(dp->reg_base + ANALOGIX_DP_DEBUG_CTL);
 	if (reg & PLL_LOCK)
 		return PLL_LOCKED;
 	else
@@ -191,13 +191,13 @@ void analogix_dp_set_pll_power_down(struct analogix_dp_device *dp, bool enable)
 	u32 reg;
 
 	if (enable) {
-		reg = readl(dp->reg_base + EXYNOS_DP_PLL_CTL);
+		reg = readl(dp->reg_base + ANALOGIX_DP_PLL_CTL);
 		reg |= DP_PLL_PD;
-		writel(reg, dp->reg_base + EXYNOS_DP_PLL_CTL);
+		writel(reg, dp->reg_base + ANALOGIX_DP_PLL_CTL);
 	} else {
-		reg = readl(dp->reg_base + EXYNOS_DP_PLL_CTL);
+		reg = readl(dp->reg_base + ANALOGIX_DP_PLL_CTL);
 		reg &= ~DP_PLL_PD;
-		writel(reg, dp->reg_base + EXYNOS_DP_PLL_CTL);
+		writel(reg, dp->reg_base + ANALOGIX_DP_PLL_CTL);
 	}
 }
 
@@ -210,77 +210,77 @@ void analogix_dp_set_analog_power_down(struct analogix_dp_device *dp,
 	switch (block) {
 	case AUX_BLOCK:
 		if (enable) {
-			reg = readl(dp->reg_base + EXYNOS_DP_PHY_PD);
+			reg = readl(dp->reg_base + ANALOGIX_DP_PHY_PD);
 			reg |= AUX_PD;
-			writel(reg, dp->reg_base + EXYNOS_DP_PHY_PD);
+			writel(reg, dp->reg_base + ANALOGIX_DP_PHY_PD);
 		} else {
-			reg = readl(dp->reg_base + EXYNOS_DP_PHY_PD);
+			reg = readl(dp->reg_base + ANALOGIX_DP_PHY_PD);
 			reg &= ~AUX_PD;
-			writel(reg, dp->reg_base + EXYNOS_DP_PHY_PD);
+			writel(reg, dp->reg_base + ANALOGIX_DP_PHY_PD);
 		}
 		break;
 	case CH0_BLOCK:
 		if (enable) {
-			reg = readl(dp->reg_base + EXYNOS_DP_PHY_PD);
+			reg = readl(dp->reg_base + ANALOGIX_DP_PHY_PD);
 			reg |= CH0_PD;
-			writel(reg, dp->reg_base + EXYNOS_DP_PHY_PD);
+			writel(reg, dp->reg_base + ANALOGIX_DP_PHY_PD);
 		} else {
-			reg = readl(dp->reg_base + EXYNOS_DP_PHY_PD);
+			reg = readl(dp->reg_base + ANALOGIX_DP_PHY_PD);
 			reg &= ~CH0_PD;
-			writel(reg, dp->reg_base + EXYNOS_DP_PHY_PD);
+			writel(reg, dp->reg_base + ANALOGIX_DP_PHY_PD);
 		}
 		break;
 	case CH1_BLOCK:
 		if (enable) {
-			reg = readl(dp->reg_base + EXYNOS_DP_PHY_PD);
+			reg = readl(dp->reg_base + ANALOGIX_DP_PHY_PD);
 			reg |= CH1_PD;
-			writel(reg, dp->reg_base + EXYNOS_DP_PHY_PD);
+			writel(reg, dp->reg_base + ANALOGIX_DP_PHY_PD);
 		} else {
-			reg = readl(dp->reg_base + EXYNOS_DP_PHY_PD);
+			reg = readl(dp->reg_base + ANALOGIX_DP_PHY_PD);
 			reg &= ~CH1_PD;
-			writel(reg, dp->reg_base + EXYNOS_DP_PHY_PD);
+			writel(reg, dp->reg_base + ANALOGIX_DP_PHY_PD);
 		}
 		break;
 	case CH2_BLOCK:
 		if (enable) {
-			reg = readl(dp->reg_base + EXYNOS_DP_PHY_PD);
+			reg = readl(dp->reg_base + ANALOGIX_DP_PHY_PD);
 			reg |= CH2_PD;
-			writel(reg, dp->reg_base + EXYNOS_DP_PHY_PD);
+			writel(reg, dp->reg_base + ANALOGIX_DP_PHY_PD);
 		} else {
-			reg = readl(dp->reg_base + EXYNOS_DP_PHY_PD);
+			reg = readl(dp->reg_base + ANALOGIX_DP_PHY_PD);
 			reg &= ~CH2_PD;
-			writel(reg, dp->reg_base + EXYNOS_DP_PHY_PD);
+			writel(reg, dp->reg_base + ANALOGIX_DP_PHY_PD);
 		}
 		break;
 	case CH3_BLOCK:
 		if (enable) {
-			reg = readl(dp->reg_base + EXYNOS_DP_PHY_PD);
+			reg = readl(dp->reg_base + ANALOGIX_DP_PHY_PD);
 			reg |= CH3_PD;
-			writel(reg, dp->reg_base + EXYNOS_DP_PHY_PD);
+			writel(reg, dp->reg_base + ANALOGIX_DP_PHY_PD);
 		} else {
-			reg = readl(dp->reg_base + EXYNOS_DP_PHY_PD);
+			reg = readl(dp->reg_base + ANALOGIX_DP_PHY_PD);
 			reg &= ~CH3_PD;
-			writel(reg, dp->reg_base + EXYNOS_DP_PHY_PD);
+			writel(reg, dp->reg_base + ANALOGIX_DP_PHY_PD);
 		}
 		break;
 	case ANALOG_TOTAL:
 		if (enable) {
-			reg = readl(dp->reg_base + EXYNOS_DP_PHY_PD);
+			reg = readl(dp->reg_base + ANALOGIX_DP_PHY_PD);
 			reg |= DP_PHY_PD;
-			writel(reg, dp->reg_base + EXYNOS_DP_PHY_PD);
+			writel(reg, dp->reg_base + ANALOGIX_DP_PHY_PD);
 		} else {
-			reg = readl(dp->reg_base + EXYNOS_DP_PHY_PD);
+			reg = readl(dp->reg_base + ANALOGIX_DP_PHY_PD);
 			reg &= ~DP_PHY_PD;
-			writel(reg, dp->reg_base + EXYNOS_DP_PHY_PD);
+			writel(reg, dp->reg_base + ANALOGIX_DP_PHY_PD);
 		}
 		break;
 	case POWER_ALL:
 		if (enable) {
 			reg = DP_PHY_PD | AUX_PD | CH3_PD | CH2_PD |
 				CH1_PD | CH0_PD;
-			writel(reg, dp->reg_base + EXYNOS_DP_PHY_PD);
+			writel(reg, dp->reg_base + ANALOGIX_DP_PHY_PD);
 		} else {
-			writel(0x00, dp->reg_base + EXYNOS_DP_PHY_PD);
+			writel(0x00, dp->reg_base + ANALOGIX_DP_PHY_PD);
 		}
 		break;
 	default:
@@ -296,11 +296,11 @@ void analogix_dp_init_analog_func(struct analogix_dp_device *dp)
 	analogix_dp_set_analog_power_down(dp, POWER_ALL, 0);
 
 	reg = PLL_LOCK_CHG;
-	writel(reg, dp->reg_base + EXYNOS_DP_COMMON_INT_STA_1);
+	writel(reg, dp->reg_base + ANALOGIX_DP_COMMON_INT_STA_1);
 
-	reg = readl(dp->reg_base + EXYNOS_DP_DEBUG_CTL);
+	reg = readl(dp->reg_base + ANALOGIX_DP_DEBUG_CTL);
 	reg &= ~(F_PLL_LOCK | PLL_LOCK_CTRL);
-	writel(reg, dp->reg_base + EXYNOS_DP_DEBUG_CTL);
+	writel(reg, dp->reg_base + ANALOGIX_DP_DEBUG_CTL);
 
 	/* Power up PLL */
 	if (analogix_dp_get_pll_lock_status(dp) == PLL_UNLOCKED) {
@@ -317,10 +317,10 @@ void analogix_dp_init_analog_func(struct analogix_dp_device *dp)
 	}
 
 	/* Enable Serdes FIFO function and Link symbol clock domain module */
-	reg = readl(dp->reg_base + EXYNOS_DP_FUNC_EN_2);
+	reg = readl(dp->reg_base + ANALOGIX_DP_FUNC_EN_2);
 	reg &= ~(SERDES_FIFO_FUNC_EN_N | LS_CLK_DOMAIN_FUNC_EN_N
 		| AUX_FUNC_EN_N);
-	writel(reg, dp->reg_base + EXYNOS_DP_FUNC_EN_2);
+	writel(reg, dp->reg_base + ANALOGIX_DP_FUNC_EN_2);
 }
 
 void analogix_dp_clear_hotplug_interrupts(struct analogix_dp_device *dp)
@@ -331,10 +331,10 @@ void analogix_dp_clear_hotplug_interrupts(struct analogix_dp_device *dp)
 		return;
 
 	reg = HOTPLUG_CHG | HPD_LOST | PLUG;
-	writel(reg, dp->reg_base + EXYNOS_DP_COMMON_INT_STA_4);
+	writel(reg, dp->reg_base + ANALOGIX_DP_COMMON_INT_STA_4);
 
 	reg = INT_HPD;
-	writel(reg, dp->reg_base + EXYNOS_DP_INT_STA);
+	writel(reg, dp->reg_base + ANALOGIX_DP_INT_STA);
 }
 
 void analogix_dp_init_hpd(struct analogix_dp_device *dp)
@@ -346,9 +346,9 @@ void analogix_dp_init_hpd(struct analogix_dp_device *dp)
 
 	analogix_dp_clear_hotplug_interrupts(dp);
 
-	reg = readl(dp->reg_base + EXYNOS_DP_SYS_CTL_3);
+	reg = readl(dp->reg_base + ANALOGIX_DP_SYS_CTL_3);
 	reg &= ~(F_HPD | HPD_CTRL);
-	writel(reg, dp->reg_base + EXYNOS_DP_SYS_CTL_3);
+	writel(reg, dp->reg_base + ANALOGIX_DP_SYS_CTL_3);
 }
 
 enum dp_irq_type analogix_dp_get_irq_type(struct analogix_dp_device *dp)
@@ -363,7 +363,7 @@ enum dp_irq_type analogix_dp_get_irq_type(struct analogix_dp_device *dp)
 			return DP_IRQ_TYPE_HP_CABLE_OUT;
 	} else {
 		/* Parse hotplug interrupt status register */
-		reg = readl(dp->reg_base + EXYNOS_DP_COMMON_INT_STA_4);
+		reg = readl(dp->reg_base + ANALOGIX_DP_COMMON_INT_STA_4);
 
 		if (reg & PLUG)
 			return DP_IRQ_TYPE_HP_CABLE_IN;
@@ -383,9 +383,9 @@ void analogix_dp_reset_aux(struct analogix_dp_device *dp)
 	u32 reg;
 
 	/* Disable AUX channel module */
-	reg = readl(dp->reg_base + EXYNOS_DP_FUNC_EN_2);
+	reg = readl(dp->reg_base + ANALOGIX_DP_FUNC_EN_2);
 	reg |= AUX_FUNC_EN_N;
-	writel(reg, dp->reg_base + EXYNOS_DP_FUNC_EN_2);
+	writel(reg, dp->reg_base + ANALOGIX_DP_FUNC_EN_2);
 }
 
 void analogix_dp_init_aux(struct analogix_dp_device *dp)
@@ -394,23 +394,23 @@ void analogix_dp_init_aux(struct analogix_dp_device *dp)
 
 	/* Clear inerrupts related to AUX channel */
 	reg = RPLY_RECEIV | AUX_ERR;
-	writel(reg, dp->reg_base + EXYNOS_DP_INT_STA);
+	writel(reg, dp->reg_base + ANALOGIX_DP_INT_STA);
 
 	analogix_dp_reset_aux(dp);
 
 	/* Disable AUX transaction H/W retry */
 	reg = AUX_BIT_PERIOD_EXPECTED_DELAY(3) | AUX_HW_RETRY_COUNT_SEL(0)|
 		AUX_HW_RETRY_INTERVAL_600_MICROSECONDS;
-	writel(reg, dp->reg_base + EXYNOS_DP_AUX_HW_RETRY_CTL);
+	writel(reg, dp->reg_base + ANALOGIX_DP_AUX_HW_RETRY_CTL);
 
 	/* Receive AUX Channel DEFER commands equal to DEFFER_COUNT*64 */
 	reg = DEFER_CTRL_EN | DEFER_COUNT(1);
-	writel(reg, dp->reg_base + EXYNOS_DP_AUX_CH_DEFER_CTL);
+	writel(reg, dp->reg_base + ANALOGIX_DP_AUX_CH_DEFER_CTL);
 
 	/* Enable AUX channel module */
-	reg = readl(dp->reg_base + EXYNOS_DP_FUNC_EN_2);
+	reg = readl(dp->reg_base + ANALOGIX_DP_FUNC_EN_2);
 	reg &= ~AUX_FUNC_EN_N;
-	writel(reg, dp->reg_base + EXYNOS_DP_FUNC_EN_2);
+	writel(reg, dp->reg_base + ANALOGIX_DP_FUNC_EN_2);
 }
 
 int analogix_dp_get_plug_in_status(struct analogix_dp_device *dp)
@@ -421,7 +421,7 @@ int analogix_dp_get_plug_in_status(struct analogix_dp_device *dp)
 		if (gpio_get_value(dp->hpd_gpio))
 			return 0;
 	} else {
-		reg = readl(dp->reg_base + EXYNOS_DP_SYS_CTL_3);
+		reg = readl(dp->reg_base + ANALOGIX_DP_SYS_CTL_3);
 		if (reg & HPD_STATUS)
 			return 0;
 	}
@@ -433,9 +433,9 @@ void analogix_dp_enable_sw_function(struct analogix_dp_device *dp)
 {
 	u32 reg;
 
-	reg = readl(dp->reg_base + EXYNOS_DP_FUNC_EN_1);
+	reg = readl(dp->reg_base + ANALOGIX_DP_FUNC_EN_1);
 	reg &= ~SW_FUNC_EN_N;
-	writel(reg, dp->reg_base + EXYNOS_DP_FUNC_EN_1);
+	writel(reg, dp->reg_base + ANALOGIX_DP_FUNC_EN_1);
 }
 
 int analogix_dp_start_aux_transaction(struct analogix_dp_device *dp)
@@ -445,34 +445,34 @@ int analogix_dp_start_aux_transaction(struct analogix_dp_device *dp)
 	int timeout_loop = 0;
 
 	/* Enable AUX CH operation */
-	reg = readl(dp->reg_base + EXYNOS_DP_AUX_CH_CTL_2);
+	reg = readl(dp->reg_base + ANALOGIX_DP_AUX_CH_CTL_2);
 	reg |= AUX_EN;
-	writel(reg, dp->reg_base + EXYNOS_DP_AUX_CH_CTL_2);
+	writel(reg, dp->reg_base + ANALOGIX_DP_AUX_CH_CTL_2);
 
 	/* Is AUX CH command reply received? */
-	reg = readl(dp->reg_base + EXYNOS_DP_INT_STA);
+	reg = readl(dp->reg_base + ANALOGIX_DP_INT_STA);
 	while (!(reg & RPLY_RECEIV)) {
 		timeout_loop++;
 		if (DP_TIMEOUT_LOOP_COUNT < timeout_loop) {
 			dev_err(dp->dev, "AUX CH command reply failed!\n");
 			return -ETIMEDOUT;
 		}
-		reg = readl(dp->reg_base + EXYNOS_DP_INT_STA);
+		reg = readl(dp->reg_base + ANALOGIX_DP_INT_STA);
 		usleep_range(10, 11);
 	}
 
 	/* Clear interrupt source for AUX CH command reply */
-	writel(RPLY_RECEIV, dp->reg_base + EXYNOS_DP_INT_STA);
+	writel(RPLY_RECEIV, dp->reg_base + ANALOGIX_DP_INT_STA);
 
 	/* Clear interrupt source for AUX CH access error */
-	reg = readl(dp->reg_base + EXYNOS_DP_INT_STA);
+	reg = readl(dp->reg_base + ANALOGIX_DP_INT_STA);
 	if (reg & AUX_ERR) {
-		writel(AUX_ERR, dp->reg_base + EXYNOS_DP_INT_STA);
+		writel(AUX_ERR, dp->reg_base + ANALOGIX_DP_INT_STA);
 		return -EREMOTEIO;
 	}
 
 	/* Check AUX CH error access status */
-	reg = readl(dp->reg_base + EXYNOS_DP_AUX_CH_STA);
+	reg = readl(dp->reg_base + ANALOGIX_DP_AUX_CH_STA);
 	if ((reg & AUX_STATUS_MASK) != 0) {
 		dev_err(dp->dev, "AUX CH error happens: %d\n\n",
 			reg & AUX_STATUS_MASK);
@@ -493,19 +493,19 @@ int analogix_dp_write_byte_to_dpcd(struct analogix_dp_device *dp,
 	for (i = 0; i < 3; i++) {
 		/* Clear AUX CH data buffer */
 		reg = BUF_CLR;
-		writel(reg, dp->reg_base + EXYNOS_DP_BUFFER_DATA_CTL);
+		writel(reg, dp->reg_base + ANALOGIX_DP_BUFFER_DATA_CTL);
 
 		/* Select DPCD device address */
 		reg = AUX_ADDR_7_0(reg_addr);
-		writel(reg, dp->reg_base + EXYNOS_DP_AUX_ADDR_7_0);
+		writel(reg, dp->reg_base + ANALOGIX_DP_AUX_ADDR_7_0);
 		reg = AUX_ADDR_15_8(reg_addr);
-		writel(reg, dp->reg_base + EXYNOS_DP_AUX_ADDR_15_8);
+		writel(reg, dp->reg_base + ANALOGIX_DP_AUX_ADDR_15_8);
 		reg = AUX_ADDR_19_16(reg_addr);
-		writel(reg, dp->reg_base + EXYNOS_DP_AUX_ADDR_19_16);
+		writel(reg, dp->reg_base + ANALOGIX_DP_AUX_ADDR_19_16);
 
 		/* Write data buffer */
 		reg = (unsigned int)data;
-		writel(reg, dp->reg_base + EXYNOS_DP_BUF_DATA_0);
+		writel(reg, dp->reg_base + ANALOGIX_DP_BUF_DATA_0);
 
 		/*
 		 * Set DisplayPort transaction and write 1 byte
@@ -513,7 +513,7 @@ int analogix_dp_write_byte_to_dpcd(struct analogix_dp_device *dp,
 		 * If Bit 3 is 0, I2C transaction.
 		 */
 		reg = AUX_TX_COMM_DP_TRANSACTION | AUX_TX_COMM_WRITE;
-		writel(reg, dp->reg_base + EXYNOS_DP_AUX_CH_CTL_1);
+		writel(reg, dp->reg_base + ANALOGIX_DP_AUX_CH_CTL_1);
 
 		/* Start AUX transaction */
 		retval = analogix_dp_start_aux_transaction(dp);
@@ -538,15 +538,15 @@ int analogix_dp_read_byte_from_dpcd(struct analogix_dp_device *dp,
 	for (i = 0; i < 3; i++) {
 		/* Clear AUX CH data buffer */
 		reg = BUF_CLR;
-		writel(reg, dp->reg_base + EXYNOS_DP_BUFFER_DATA_CTL);
+		writel(reg, dp->reg_base + ANALOGIX_DP_BUFFER_DATA_CTL);
 
 		/* Select DPCD device address */
 		reg = AUX_ADDR_7_0(reg_addr);
-		writel(reg, dp->reg_base + EXYNOS_DP_AUX_ADDR_7_0);
+		writel(reg, dp->reg_base + ANALOGIX_DP_AUX_ADDR_7_0);
 		reg = AUX_ADDR_15_8(reg_addr);
-		writel(reg, dp->reg_base + EXYNOS_DP_AUX_ADDR_15_8);
+		writel(reg, dp->reg_base + ANALOGIX_DP_AUX_ADDR_15_8);
 		reg = AUX_ADDR_19_16(reg_addr);
-		writel(reg, dp->reg_base + EXYNOS_DP_AUX_ADDR_19_16);
+		writel(reg, dp->reg_base + ANALOGIX_DP_AUX_ADDR_19_16);
 
 		/*
 		 * Set DisplayPort transaction and read 1 byte
@@ -554,7 +554,7 @@ int analogix_dp_read_byte_from_dpcd(struct analogix_dp_device *dp,
 		 * If Bit 3 is 0, I2C transaction.
 		 */
 		reg = AUX_TX_COMM_DP_TRANSACTION | AUX_TX_COMM_READ;
-		writel(reg, dp->reg_base + EXYNOS_DP_AUX_CH_CTL_1);
+		writel(reg, dp->reg_base + ANALOGIX_DP_AUX_CH_CTL_1);
 
 		/* Start AUX transaction */
 		retval = analogix_dp_start_aux_transaction(dp);
@@ -566,7 +566,7 @@ int analogix_dp_read_byte_from_dpcd(struct analogix_dp_device *dp,
 	}
 
 	/* Read data buffer */
-	reg = readl(dp->reg_base + EXYNOS_DP_BUF_DATA_0);
+	reg = readl(dp->reg_base + ANALOGIX_DP_BUF_DATA_0);
 	*data = (unsigned char)(reg & 0xff);
 
 	return retval;
@@ -586,7 +586,7 @@ int analogix_dp_write_bytes_to_dpcd(struct analogix_dp_device *dp,
 
 	/* Clear AUX CH data buffer */
 	reg = BUF_CLR;
-	writel(reg, dp->reg_base + EXYNOS_DP_BUFFER_DATA_CTL);
+	writel(reg, dp->reg_base + ANALOGIX_DP_BUFFER_DATA_CTL);
 
 	start_offset = 0;
 	while (start_offset < count) {
@@ -599,16 +599,16 @@ int analogix_dp_write_bytes_to_dpcd(struct analogix_dp_device *dp,
 		for (i = 0; i < 3; i++) {
 			/* Select DPCD device address */
 			reg = AUX_ADDR_7_0(reg_addr + start_offset);
-			writel(reg, dp->reg_base + EXYNOS_DP_AUX_ADDR_7_0);
+			writel(reg, dp->reg_base + ANALOGIX_DP_AUX_ADDR_7_0);
 			reg = AUX_ADDR_15_8(reg_addr + start_offset);
-			writel(reg, dp->reg_base + EXYNOS_DP_AUX_ADDR_15_8);
+			writel(reg, dp->reg_base + ANALOGIX_DP_AUX_ADDR_15_8);
 			reg = AUX_ADDR_19_16(reg_addr + start_offset);
-			writel(reg, dp->reg_base + EXYNOS_DP_AUX_ADDR_19_16);
+			writel(reg, dp->reg_base + ANALOGIX_DP_AUX_ADDR_19_16);
 
 			for (cur_data_idx = 0; cur_data_idx < cur_data_count;
 			     cur_data_idx++) {
 				reg = data[start_offset + cur_data_idx];
-				writel(reg, dp->reg_base + EXYNOS_DP_BUF_DATA_0
+				writel(reg, dp->reg_base + ANALOGIX_DP_BUF_DATA_0
 							  + 4 * cur_data_idx);
 			}
 
@@ -619,7 +619,7 @@ int analogix_dp_write_bytes_to_dpcd(struct analogix_dp_device *dp,
 			 */
 			reg = AUX_LENGTH(cur_data_count) |
 				AUX_TX_COMM_DP_TRANSACTION | AUX_TX_COMM_WRITE;
-			writel(reg, dp->reg_base + EXYNOS_DP_AUX_CH_CTL_1);
+			writel(reg, dp->reg_base + ANALOGIX_DP_AUX_CH_CTL_1);
 
 			/* Start AUX transaction */
 			retval = analogix_dp_start_aux_transaction(dp);
@@ -650,7 +650,7 @@ int analogix_dp_read_bytes_from_dpcd(struct analogix_dp_device *dp,
 
 	/* Clear AUX CH data buffer */
 	reg = BUF_CLR;
-	writel(reg, dp->reg_base + EXYNOS_DP_BUFFER_DATA_CTL);
+	writel(reg, dp->reg_base + ANALOGIX_DP_BUFFER_DATA_CTL);
 
 	start_offset = 0;
 	while (start_offset < count) {
@@ -664,11 +664,11 @@ int analogix_dp_read_bytes_from_dpcd(struct analogix_dp_device *dp,
 		for (i = 0; i < 3; i++) {
 			/* Select DPCD device address */
 			reg = AUX_ADDR_7_0(reg_addr + start_offset);
-			writel(reg, dp->reg_base + EXYNOS_DP_AUX_ADDR_7_0);
+			writel(reg, dp->reg_base + ANALOGIX_DP_AUX_ADDR_7_0);
 			reg = AUX_ADDR_15_8(reg_addr + start_offset);
-			writel(reg, dp->reg_base + EXYNOS_DP_AUX_ADDR_15_8);
+			writel(reg, dp->reg_base + ANALOGIX_DP_AUX_ADDR_15_8);
 			reg = AUX_ADDR_19_16(reg_addr + start_offset);
-			writel(reg, dp->reg_base + EXYNOS_DP_AUX_ADDR_19_16);
+			writel(reg, dp->reg_base + ANALOGIX_DP_AUX_ADDR_19_16);
 
 			/*
 			 * Set DisplayPort transaction and read
@@ -677,7 +677,7 @@ int analogix_dp_read_bytes_from_dpcd(struct analogix_dp_device *dp,
 			 */
 			reg = AUX_LENGTH(cur_data_count) |
 				AUX_TX_COMM_DP_TRANSACTION | AUX_TX_COMM_READ;
-			writel(reg, dp->reg_base + EXYNOS_DP_AUX_CH_CTL_1);
+			writel(reg, dp->reg_base + ANALOGIX_DP_AUX_CH_CTL_1);
 
 			/* Start AUX transaction */
 			retval = analogix_dp_start_aux_transaction(dp);
@@ -690,7 +690,7 @@ int analogix_dp_read_bytes_from_dpcd(struct analogix_dp_device *dp,
 
 		for (cur_data_idx = 0; cur_data_idx < cur_data_count;
 		    cur_data_idx++) {
-			reg = readl(dp->reg_base + EXYNOS_DP_BUF_DATA_0
+			reg = readl(dp->reg_base + ANALOGIX_DP_BUF_DATA_0
 						 + 4 * cur_data_idx);
 			data[start_offset + cur_data_idx] =
 				(unsigned char)reg;
@@ -711,12 +711,12 @@ int analogix_dp_select_i2c_device(struct analogix_dp_device *dp,
 
 	/* Set EDID device address */
 	reg = device_addr;
-	writel(reg, dp->reg_base + EXYNOS_DP_AUX_ADDR_7_0);
-	writel(0x0, dp->reg_base + EXYNOS_DP_AUX_ADDR_15_8);
-	writel(0x0, dp->reg_base + EXYNOS_DP_AUX_ADDR_19_16);
+	writel(reg, dp->reg_base + ANALOGIX_DP_AUX_ADDR_7_0);
+	writel(0x0, dp->reg_base + ANALOGIX_DP_AUX_ADDR_15_8);
+	writel(0x0, dp->reg_base + ANALOGIX_DP_AUX_ADDR_19_16);
 
 	/* Set offset from base address of EDID device */
-	writel(reg_addr, dp->reg_base + EXYNOS_DP_BUF_DATA_0);
+	writel(reg_addr, dp->reg_base + ANALOGIX_DP_BUF_DATA_0);
 
 	/*
 	 * Set I2C transaction and write address
@@ -725,7 +725,7 @@ int analogix_dp_select_i2c_device(struct analogix_dp_device *dp,
 	 */
 	reg = AUX_TX_COMM_I2C_TRANSACTION | AUX_TX_COMM_MOT |
 		AUX_TX_COMM_WRITE;
-	writel(reg, dp->reg_base + EXYNOS_DP_AUX_CH_CTL_1);
+	writel(reg, dp->reg_base + ANALOGIX_DP_AUX_CH_CTL_1);
 
 	/* Start AUX transaction */
 	retval = analogix_dp_start_aux_transaction(dp);
@@ -747,7 +747,7 @@ int analogix_dp_read_byte_from_i2c(struct analogix_dp_device *dp,
 	for (i = 0; i < 3; i++) {
 		/* Clear AUX CH data buffer */
 		reg = BUF_CLR;
-		writel(reg, dp->reg_base + EXYNOS_DP_BUFFER_DATA_CTL);
+		writel(reg, dp->reg_base + ANALOGIX_DP_BUFFER_DATA_CTL);
 
 		/* Select EDID device */
 		retval = analogix_dp_select_i2c_device(dp, device_addr, reg_addr);
@@ -761,7 +761,7 @@ int analogix_dp_read_byte_from_i2c(struct analogix_dp_device *dp,
 		 */
 		reg = AUX_TX_COMM_I2C_TRANSACTION |
 			AUX_TX_COMM_READ;
-		writel(reg, dp->reg_base + EXYNOS_DP_AUX_CH_CTL_1);
+		writel(reg, dp->reg_base + ANALOGIX_DP_AUX_CH_CTL_1);
 
 		/* Start AUX transaction */
 		retval = analogix_dp_start_aux_transaction(dp);
@@ -774,7 +774,7 @@ int analogix_dp_read_byte_from_i2c(struct analogix_dp_device *dp,
 
 	/* Read data */
 	if (retval == 0)
-		*data = readl(dp->reg_base + EXYNOS_DP_BUF_DATA_0);
+		*data = readl(dp->reg_base + ANALOGIX_DP_BUF_DATA_0);
 
 	return retval;
 }
@@ -795,12 +795,12 @@ int analogix_dp_read_bytes_from_i2c(struct analogix_dp_device *dp,
 		for (j = 0; j < 3; j++) {
 			/* Clear AUX CH data buffer */
 			reg = BUF_CLR;
-			writel(reg, dp->reg_base + EXYNOS_DP_BUFFER_DATA_CTL);
+			writel(reg, dp->reg_base + ANALOGIX_DP_BUFFER_DATA_CTL);
 
 			/* Set normal AUX CH command */
-			reg = readl(dp->reg_base + EXYNOS_DP_AUX_CH_CTL_2);
+			reg = readl(dp->reg_base + ANALOGIX_DP_AUX_CH_CTL_2);
 			reg &= ~ADDR_ONLY;
-			writel(reg, dp->reg_base + EXYNOS_DP_AUX_CH_CTL_2);
+			writel(reg, dp->reg_base + ANALOGIX_DP_AUX_CH_CTL_2);
 
 			/*
 			 * If Rx sends defer, Tx sends only reads
@@ -822,7 +822,7 @@ int analogix_dp_read_bytes_from_i2c(struct analogix_dp_device *dp,
 					AUX_TX_COMM_I2C_TRANSACTION |
 					AUX_TX_COMM_READ;
 				writel(reg, dp->reg_base +
-					EXYNOS_DP_AUX_CH_CTL_1);
+					ANALOGIX_DP_AUX_CH_CTL_1);
 
 				/* Start AUX transaction */
 				retval = analogix_dp_start_aux_transaction(dp);
@@ -834,7 +834,7 @@ int analogix_dp_read_bytes_from_i2c(struct analogix_dp_device *dp,
 						__func__);
 			}
 			/* Check if Rx sends defer */
-			reg = readl(dp->reg_base + EXYNOS_DP_AUX_RX_COMM);
+			reg = readl(dp->reg_base + ANALOGIX_DP_AUX_RX_COMM);
 			if (reg == AUX_RX_COMM_AUX_DEFER ||
 				reg == AUX_RX_COMM_I2C_DEFER) {
 				dev_err(dp->dev, "Defer: %d\n\n", reg);
@@ -843,7 +843,7 @@ int analogix_dp_read_bytes_from_i2c(struct analogix_dp_device *dp,
 		}
 
 		for (cur_data_idx = 0; cur_data_idx < 16; cur_data_idx++) {
-			reg = readl(dp->reg_base + EXYNOS_DP_BUF_DATA_0
+			reg = readl(dp->reg_base + ANALOGIX_DP_BUF_DATA_0
 						 + 4 * cur_data_idx);
 			edid[i + cur_data_idx] = (unsigned char)reg;
 		}
@@ -858,14 +858,14 @@ void analogix_dp_set_link_bandwidth(struct analogix_dp_device *dp, u32 bwtype)
 
 	reg = bwtype;
 	if ((bwtype == LINK_RATE_2_70GBPS) || (bwtype == LINK_RATE_1_62GBPS))
-		writel(reg, dp->reg_base + EXYNOS_DP_LINK_BW_SET);
+		writel(reg, dp->reg_base + ANALOGIX_DP_LINK_BW_SET);
 }
 
 void analogix_dp_get_link_bandwidth(struct analogix_dp_device *dp, u32 *bwtype)
 {
 	u32 reg;
 
-	reg = readl(dp->reg_base + EXYNOS_DP_LINK_BW_SET);
+	reg = readl(dp->reg_base + ANALOGIX_DP_LINK_BW_SET);
 	*bwtype = reg;
 }
 
@@ -874,14 +874,14 @@ void analogix_dp_set_lane_count(struct analogix_dp_device *dp, u32 count)
 	u32 reg;
 
 	reg = count;
-	writel(reg, dp->reg_base + EXYNOS_DP_LANE_COUNT_SET);
+	writel(reg, dp->reg_base + ANALOGIX_DP_LANE_COUNT_SET);
 }
 
 void analogix_dp_get_lane_count(struct analogix_dp_device *dp, u32 *count)
 {
 	u32 reg;
 
-	reg = readl(dp->reg_base + EXYNOS_DP_LANE_COUNT_SET);
+	reg = readl(dp->reg_base + ANALOGIX_DP_LANE_COUNT_SET);
 	*count = reg;
 }
 
@@ -890,13 +890,13 @@ void analogix_dp_enable_enhanced_mode(struct analogix_dp_device *dp, bool enable
 	u32 reg;
 
 	if (enable) {
-		reg = readl(dp->reg_base + EXYNOS_DP_SYS_CTL_4);
+		reg = readl(dp->reg_base + ANALOGIX_DP_SYS_CTL_4);
 		reg |= ENHANCED;
-		writel(reg, dp->reg_base + EXYNOS_DP_SYS_CTL_4);
+		writel(reg, dp->reg_base + ANALOGIX_DP_SYS_CTL_4);
 	} else {
-		reg = readl(dp->reg_base + EXYNOS_DP_SYS_CTL_4);
+		reg = readl(dp->reg_base + ANALOGIX_DP_SYS_CTL_4);
 		reg &= ~ENHANCED;
-		writel(reg, dp->reg_base + EXYNOS_DP_SYS_CTL_4);
+		writel(reg, dp->reg_base + ANALOGIX_DP_SYS_CTL_4);
 	}
 }
 
@@ -908,25 +908,25 @@ void analogix_dp_set_training_pattern(struct analogix_dp_device *dp,
 	switch (pattern) {
 	case PRBS7:
 		reg = SCRAMBLING_ENABLE | LINK_QUAL_PATTERN_SET_PRBS7;
-		writel(reg, dp->reg_base + EXYNOS_DP_TRAINING_PTN_SET);
+		writel(reg, dp->reg_base + ANALOGIX_DP_TRAINING_PTN_SET);
 		break;
 	case D10_2:
 		reg = SCRAMBLING_ENABLE | LINK_QUAL_PATTERN_SET_D10_2;
-		writel(reg, dp->reg_base + EXYNOS_DP_TRAINING_PTN_SET);
+		writel(reg, dp->reg_base + ANALOGIX_DP_TRAINING_PTN_SET);
 		break;
 	case TRAINING_PTN1:
 		reg = SCRAMBLING_DISABLE | SW_TRAINING_PATTERN_SET_PTN1;
-		writel(reg, dp->reg_base + EXYNOS_DP_TRAINING_PTN_SET);
+		writel(reg, dp->reg_base + ANALOGIX_DP_TRAINING_PTN_SET);
 		break;
 	case TRAINING_PTN2:
 		reg = SCRAMBLING_DISABLE | SW_TRAINING_PATTERN_SET_PTN2;
-		writel(reg, dp->reg_base + EXYNOS_DP_TRAINING_PTN_SET);
+		writel(reg, dp->reg_base + ANALOGIX_DP_TRAINING_PTN_SET);
 		break;
 	case DP_NONE:
 		reg = SCRAMBLING_ENABLE |
 			LINK_QUAL_PATTERN_SET_DISABLE |
 			SW_TRAINING_PATTERN_SET_NORMAL;
-		writel(reg, dp->reg_base + EXYNOS_DP_TRAINING_PTN_SET);
+		writel(reg, dp->reg_base + ANALOGIX_DP_TRAINING_PTN_SET);
 		break;
 	default:
 		break;
@@ -937,40 +937,40 @@ void analogix_dp_set_lane0_pre_emphasis(struct analogix_dp_device *dp, u32 level
 {
 	u32 reg;
 
-	reg = readl(dp->reg_base + EXYNOS_DP_LN0_LINK_TRAINING_CTL);
+	reg = readl(dp->reg_base + ANALOGIX_DP_LN0_LINK_TRAINING_CTL);
 	reg &= ~PRE_EMPHASIS_SET_MASK;
 	reg |= level << PRE_EMPHASIS_SET_SHIFT;
-	writel(reg, dp->reg_base + EXYNOS_DP_LN0_LINK_TRAINING_CTL);
+	writel(reg, dp->reg_base + ANALOGIX_DP_LN0_LINK_TRAINING_CTL);
 }
 
 void analogix_dp_set_lane1_pre_emphasis(struct analogix_dp_device *dp, u32 level)
 {
 	u32 reg;
 
-	reg = readl(dp->reg_base + EXYNOS_DP_LN1_LINK_TRAINING_CTL);
+	reg = readl(dp->reg_base + ANALOGIX_DP_LN1_LINK_TRAINING_CTL);
 	reg &= ~PRE_EMPHASIS_SET_MASK;
 	reg |= level << PRE_EMPHASIS_SET_SHIFT;
-	writel(reg, dp->reg_base + EXYNOS_DP_LN1_LINK_TRAINING_CTL);
+	writel(reg, dp->reg_base + ANALOGIX_DP_LN1_LINK_TRAINING_CTL);
 }
 
 void analogix_dp_set_lane2_pre_emphasis(struct analogix_dp_device *dp, u32 level)
 {
 	u32 reg;
 
-	reg = readl(dp->reg_base + EXYNOS_DP_LN2_LINK_TRAINING_CTL);
+	reg = readl(dp->reg_base + ANALOGIX_DP_LN2_LINK_TRAINING_CTL);
 	reg &= ~PRE_EMPHASIS_SET_MASK;
 	reg |= level << PRE_EMPHASIS_SET_SHIFT;
-	writel(reg, dp->reg_base + EXYNOS_DP_LN2_LINK_TRAINING_CTL);
+	writel(reg, dp->reg_base + ANALOGIX_DP_LN2_LINK_TRAINING_CTL);
 }
 
 void analogix_dp_set_lane3_pre_emphasis(struct analogix_dp_device *dp, u32 level)
 {
 	u32 reg;
 
-	reg = readl(dp->reg_base + EXYNOS_DP_LN3_LINK_TRAINING_CTL);
+	reg = readl(dp->reg_base + ANALOGIX_DP_LN3_LINK_TRAINING_CTL);
 	reg &= ~PRE_EMPHASIS_SET_MASK;
 	reg |= level << PRE_EMPHASIS_SET_SHIFT;
-	writel(reg, dp->reg_base + EXYNOS_DP_LN3_LINK_TRAINING_CTL);
+	writel(reg, dp->reg_base + ANALOGIX_DP_LN3_LINK_TRAINING_CTL);
 }
 
 void analogix_dp_set_lane0_link_training(struct analogix_dp_device *dp,
@@ -979,7 +979,7 @@ void analogix_dp_set_lane0_link_training(struct analogix_dp_device *dp,
 	u32 reg;
 
 	reg = training_lane;
-	writel(reg, dp->reg_base + EXYNOS_DP_LN0_LINK_TRAINING_CTL);
+	writel(reg, dp->reg_base + ANALOGIX_DP_LN0_LINK_TRAINING_CTL);
 }
 
 void analogix_dp_set_lane1_link_training(struct analogix_dp_device *dp,
@@ -988,7 +988,7 @@ void analogix_dp_set_lane1_link_training(struct analogix_dp_device *dp,
 	u32 reg;
 
 	reg = training_lane;
-	writel(reg, dp->reg_base + EXYNOS_DP_LN1_LINK_TRAINING_CTL);
+	writel(reg, dp->reg_base + ANALOGIX_DP_LN1_LINK_TRAINING_CTL);
 }
 
 void analogix_dp_set_lane2_link_training(struct analogix_dp_device *dp,
@@ -997,7 +997,7 @@ void analogix_dp_set_lane2_link_training(struct analogix_dp_device *dp,
 	u32 reg;
 
 	reg = training_lane;
-	writel(reg, dp->reg_base + EXYNOS_DP_LN2_LINK_TRAINING_CTL);
+	writel(reg, dp->reg_base + ANALOGIX_DP_LN2_LINK_TRAINING_CTL);
 }
 
 void analogix_dp_set_lane3_link_training(struct analogix_dp_device *dp,
@@ -1006,14 +1006,14 @@ void analogix_dp_set_lane3_link_training(struct analogix_dp_device *dp,
 	u32 reg;
 
 	reg = training_lane;
-	writel(reg, dp->reg_base + EXYNOS_DP_LN3_LINK_TRAINING_CTL);
+	writel(reg, dp->reg_base + ANALOGIX_DP_LN3_LINK_TRAINING_CTL);
 }
 
 u32 analogix_dp_get_lane0_link_training(struct analogix_dp_device *dp)
 {
 	u32 reg;
 
-	reg = readl(dp->reg_base + EXYNOS_DP_LN0_LINK_TRAINING_CTL);
+	reg = readl(dp->reg_base + ANALOGIX_DP_LN0_LINK_TRAINING_CTL);
 	return reg;
 }
 
@@ -1021,7 +1021,7 @@ u32 analogix_dp_get_lane1_link_training(struct analogix_dp_device *dp)
 {
 	u32 reg;
 
-	reg = readl(dp->reg_base + EXYNOS_DP_LN1_LINK_TRAINING_CTL);
+	reg = readl(dp->reg_base + ANALOGIX_DP_LN1_LINK_TRAINING_CTL);
 	return reg;
 }
 
@@ -1029,7 +1029,7 @@ u32 analogix_dp_get_lane2_link_training(struct analogix_dp_device *dp)
 {
 	u32 reg;
 
-	reg = readl(dp->reg_base + EXYNOS_DP_LN2_LINK_TRAINING_CTL);
+	reg = readl(dp->reg_base + ANALOGIX_DP_LN2_LINK_TRAINING_CTL);
 	return reg;
 }
 
@@ -1037,7 +1037,7 @@ u32 analogix_dp_get_lane3_link_training(struct analogix_dp_device *dp)
 {
 	u32 reg;
 
-	reg = readl(dp->reg_base + EXYNOS_DP_LN3_LINK_TRAINING_CTL);
+	reg = readl(dp->reg_base + ANALOGIX_DP_LN3_LINK_TRAINING_CTL);
 	return reg;
 }
 
@@ -1045,15 +1045,15 @@ void analogix_dp_reset_macro(struct analogix_dp_device *dp)
 {
 	u32 reg;
 
-	reg = readl(dp->reg_base + EXYNOS_DP_PHY_TEST);
+	reg = readl(dp->reg_base + ANALOGIX_DP_PHY_TEST);
 	reg |= MACRO_RST;
-	writel(reg, dp->reg_base + EXYNOS_DP_PHY_TEST);
+	writel(reg, dp->reg_base + ANALOGIX_DP_PHY_TEST);
 
 	/* 10 us is the minimum reset time. */
 	usleep_range(10, 20);
 
 	reg &= ~MACRO_RST;
-	writel(reg, dp->reg_base + EXYNOS_DP_PHY_TEST);
+	writel(reg, dp->reg_base + ANALOGIX_DP_PHY_TEST);
 }
 
 void analogix_dp_init_video(struct analogix_dp_device *dp)
@@ -1061,19 +1061,19 @@ void analogix_dp_init_video(struct analogix_dp_device *dp)
 	u32 reg;
 
 	reg = VSYNC_DET | VID_FORMAT_CHG | VID_CLK_CHG;
-	writel(reg, dp->reg_base + EXYNOS_DP_COMMON_INT_STA_1);
+	writel(reg, dp->reg_base + ANALOGIX_DP_COMMON_INT_STA_1);
 
 	reg = 0x0;
-	writel(reg, dp->reg_base + EXYNOS_DP_SYS_CTL_1);
+	writel(reg, dp->reg_base + ANALOGIX_DP_SYS_CTL_1);
 
 	reg = CHA_CRI(4) | CHA_CTRL;
-	writel(reg, dp->reg_base + EXYNOS_DP_SYS_CTL_2);
+	writel(reg, dp->reg_base + ANALOGIX_DP_SYS_CTL_2);
 
 	reg = 0x0;
-	writel(reg, dp->reg_base + EXYNOS_DP_SYS_CTL_3);
+	writel(reg, dp->reg_base + ANALOGIX_DP_SYS_CTL_3);
 
 	reg = VID_HRES_TH(2) | VID_VRES_TH(0);
-	writel(reg, dp->reg_base + EXYNOS_DP_VIDEO_CTL_8);
+	writel(reg, dp->reg_base + ANALOGIX_DP_VIDEO_CTL_8);
 }
 
 void analogix_dp_set_video_color_format(struct analogix_dp_device *dp)
@@ -1084,36 +1084,36 @@ void analogix_dp_set_video_color_format(struct analogix_dp_device *dp)
 	reg = (dp->video_info->dynamic_range << IN_D_RANGE_SHIFT) |
 		(dp->video_info->color_depth << IN_BPC_SHIFT) |
 		(dp->video_info->color_space << IN_COLOR_F_SHIFT);
-	writel(reg, dp->reg_base + EXYNOS_DP_VIDEO_CTL_2);
+	writel(reg, dp->reg_base + ANALOGIX_DP_VIDEO_CTL_2);
 
 	/* Set Input Color YCbCr Coefficients to ITU601 or ITU709 */
-	reg = readl(dp->reg_base + EXYNOS_DP_VIDEO_CTL_3);
+	reg = readl(dp->reg_base + ANALOGIX_DP_VIDEO_CTL_3);
 	reg &= ~IN_YC_COEFFI_MASK;
 	if (dp->video_info->ycbcr_coeff)
 		reg |= IN_YC_COEFFI_ITU709;
 	else
 		reg |= IN_YC_COEFFI_ITU601;
-	writel(reg, dp->reg_base + EXYNOS_DP_VIDEO_CTL_3);
+	writel(reg, dp->reg_base + ANALOGIX_DP_VIDEO_CTL_3);
 }
 
 int analogix_dp_is_slave_video_stream_clock_on(struct analogix_dp_device *dp)
 {
 	u32 reg;
 
-	reg = readl(dp->reg_base + EXYNOS_DP_SYS_CTL_1);
-	writel(reg, dp->reg_base + EXYNOS_DP_SYS_CTL_1);
+	reg = readl(dp->reg_base + ANALOGIX_DP_SYS_CTL_1);
+	writel(reg, dp->reg_base + ANALOGIX_DP_SYS_CTL_1);
 
-	reg = readl(dp->reg_base + EXYNOS_DP_SYS_CTL_1);
+	reg = readl(dp->reg_base + ANALOGIX_DP_SYS_CTL_1);
 
 	if (!(reg & DET_STA)) {
 		dev_dbg(dp->dev, "Input stream clock not detected.\n");
 		return -EINVAL;
 	}
 
-	reg = readl(dp->reg_base + EXYNOS_DP_SYS_CTL_2);
-	writel(reg, dp->reg_base + EXYNOS_DP_SYS_CTL_2);
+	reg = readl(dp->reg_base + ANALOGIX_DP_SYS_CTL_2);
+	writel(reg, dp->reg_base + ANALOGIX_DP_SYS_CTL_2);
 
-	reg = readl(dp->reg_base + EXYNOS_DP_SYS_CTL_2);
+	reg = readl(dp->reg_base + ANALOGIX_DP_SYS_CTL_2);
 	dev_dbg(dp->dev, "wait SYS_CTL_2.\n");
 
 	if (reg & CHA_STA) {
@@ -1132,30 +1132,30 @@ void analogix_dp_set_video_cr_mn(struct analogix_dp_device *dp,
 	u32 reg;
 
 	if (type == REGISTER_M) {
-		reg = readl(dp->reg_base + EXYNOS_DP_SYS_CTL_4);
+		reg = readl(dp->reg_base + ANALOGIX_DP_SYS_CTL_4);
 		reg |= FIX_M_VID;
-		writel(reg, dp->reg_base + EXYNOS_DP_SYS_CTL_4);
+		writel(reg, dp->reg_base + ANALOGIX_DP_SYS_CTL_4);
 		reg = m_value & 0xff;
-		writel(reg, dp->reg_base + EXYNOS_DP_M_VID_0);
+		writel(reg, dp->reg_base + ANALOGIX_DP_M_VID_0);
 		reg = (m_value >> 8) & 0xff;
-		writel(reg, dp->reg_base + EXYNOS_DP_M_VID_1);
+		writel(reg, dp->reg_base + ANALOGIX_DP_M_VID_1);
 		reg = (m_value >> 16) & 0xff;
-		writel(reg, dp->reg_base + EXYNOS_DP_M_VID_2);
+		writel(reg, dp->reg_base + ANALOGIX_DP_M_VID_2);
 
 		reg = n_value & 0xff;
-		writel(reg, dp->reg_base + EXYNOS_DP_N_VID_0);
+		writel(reg, dp->reg_base + ANALOGIX_DP_N_VID_0);
 		reg = (n_value >> 8) & 0xff;
-		writel(reg, dp->reg_base + EXYNOS_DP_N_VID_1);
+		writel(reg, dp->reg_base + ANALOGIX_DP_N_VID_1);
 		reg = (n_value >> 16) & 0xff;
-		writel(reg, dp->reg_base + EXYNOS_DP_N_VID_2);
+		writel(reg, dp->reg_base + ANALOGIX_DP_N_VID_2);
 	} else  {
-		reg = readl(dp->reg_base + EXYNOS_DP_SYS_CTL_4);
+		reg = readl(dp->reg_base + ANALOGIX_DP_SYS_CTL_4);
 		reg &= ~FIX_M_VID;
-		writel(reg, dp->reg_base + EXYNOS_DP_SYS_CTL_4);
+		writel(reg, dp->reg_base + ANALOGIX_DP_SYS_CTL_4);
 
-		writel(0x00, dp->reg_base + EXYNOS_DP_N_VID_0);
-		writel(0x80, dp->reg_base + EXYNOS_DP_N_VID_1);
-		writel(0x00, dp->reg_base + EXYNOS_DP_N_VID_2);
+		writel(0x00, dp->reg_base + ANALOGIX_DP_N_VID_0);
+		writel(0x80, dp->reg_base + ANALOGIX_DP_N_VID_1);
+		writel(0x00, dp->reg_base + ANALOGIX_DP_N_VID_2);
 	}
 }
 
@@ -1164,13 +1164,13 @@ void analogix_dp_set_video_timing_mode(struct analogix_dp_device *dp, u32 type)
 	u32 reg;
 
 	if (type == VIDEO_TIMING_FROM_CAPTURE) {
-		reg = readl(dp->reg_base + EXYNOS_DP_VIDEO_CTL_10);
+		reg = readl(dp->reg_base + ANALOGIX_DP_VIDEO_CTL_10);
 		reg &= ~FORMAT_SEL;
-		writel(reg, dp->reg_base + EXYNOS_DP_VIDEO_CTL_10);
+		writel(reg, dp->reg_base + ANALOGIX_DP_VIDEO_CTL_10);
 	} else {
-		reg = readl(dp->reg_base + EXYNOS_DP_VIDEO_CTL_10);
+		reg = readl(dp->reg_base + ANALOGIX_DP_VIDEO_CTL_10);
 		reg |= FORMAT_SEL;
-		writel(reg, dp->reg_base + EXYNOS_DP_VIDEO_CTL_10);
+		writel(reg, dp->reg_base + ANALOGIX_DP_VIDEO_CTL_10);
 	}
 }
 
@@ -1179,15 +1179,15 @@ void analogix_dp_enable_video_master(struct analogix_dp_device *dp, bool enable)
 	u32 reg;
 
 	if (enable) {
-		reg = readl(dp->reg_base + EXYNOS_DP_SOC_GENERAL_CTL);
+		reg = readl(dp->reg_base + ANALOGIX_DP_SOC_GENERAL_CTL);
 		reg &= ~VIDEO_MODE_MASK;
 		reg |= VIDEO_MASTER_MODE_EN | VIDEO_MODE_MASTER_MODE;
-		writel(reg, dp->reg_base + EXYNOS_DP_SOC_GENERAL_CTL);
+		writel(reg, dp->reg_base + ANALOGIX_DP_SOC_GENERAL_CTL);
 	} else {
-		reg = readl(dp->reg_base + EXYNOS_DP_SOC_GENERAL_CTL);
+		reg = readl(dp->reg_base + ANALOGIX_DP_SOC_GENERAL_CTL);
 		reg &= ~VIDEO_MODE_MASK;
 		reg |= VIDEO_MODE_SLAVE_MODE;
-		writel(reg, dp->reg_base + EXYNOS_DP_SOC_GENERAL_CTL);
+		writel(reg, dp->reg_base + ANALOGIX_DP_SOC_GENERAL_CTL);
 	}
 }
 
@@ -1195,19 +1195,19 @@ void analogix_dp_start_video(struct analogix_dp_device *dp)
 {
 	u32 reg;
 
-	reg = readl(dp->reg_base + EXYNOS_DP_VIDEO_CTL_1);
+	reg = readl(dp->reg_base + ANALOGIX_DP_VIDEO_CTL_1);
 	reg |= VIDEO_EN;
-	writel(reg, dp->reg_base + EXYNOS_DP_VIDEO_CTL_1);
+	writel(reg, dp->reg_base + ANALOGIX_DP_VIDEO_CTL_1);
 }
 
 int analogix_dp_is_video_stream_on(struct analogix_dp_device *dp)
 {
 	u32 reg;
 
-	reg = readl(dp->reg_base + EXYNOS_DP_SYS_CTL_3);
-	writel(reg, dp->reg_base + EXYNOS_DP_SYS_CTL_3);
+	reg = readl(dp->reg_base + ANALOGIX_DP_SYS_CTL_3);
+	writel(reg, dp->reg_base + ANALOGIX_DP_SYS_CTL_3);
 
-	reg = readl(dp->reg_base + EXYNOS_DP_SYS_CTL_3);
+	reg = readl(dp->reg_base + ANALOGIX_DP_SYS_CTL_3);
 	if (!(reg & STRM_VALID)) {
 		dev_dbg(dp->dev, "Input video stream is not detected.\n");
 		return -EINVAL;
@@ -1220,44 +1220,44 @@ void analogix_dp_config_video_slave_mode(struct analogix_dp_device *dp)
 {
 	u32 reg;
 
-	reg = readl(dp->reg_base + EXYNOS_DP_FUNC_EN_1);
+	reg = readl(dp->reg_base + ANALOGIX_DP_FUNC_EN_1);
 	reg &= ~(MASTER_VID_FUNC_EN_N|SLAVE_VID_FUNC_EN_N);
 	reg |= MASTER_VID_FUNC_EN_N;
-	writel(reg, dp->reg_base + EXYNOS_DP_FUNC_EN_1);
+	writel(reg, dp->reg_base + ANALOGIX_DP_FUNC_EN_1);
 
-	reg = readl(dp->reg_base + EXYNOS_DP_VIDEO_CTL_10);
+	reg = readl(dp->reg_base + ANALOGIX_DP_VIDEO_CTL_10);
 	reg &= ~INTERACE_SCAN_CFG;
 	reg |= (dp->video_info->interlaced << 2);
-	writel(reg, dp->reg_base + EXYNOS_DP_VIDEO_CTL_10);
+	writel(reg, dp->reg_base + ANALOGIX_DP_VIDEO_CTL_10);
 
-	reg = readl(dp->reg_base + EXYNOS_DP_VIDEO_CTL_10);
+	reg = readl(dp->reg_base + ANALOGIX_DP_VIDEO_CTL_10);
 	reg &= ~VSYNC_POLARITY_CFG;
 	reg |= (dp->video_info->v_sync_polarity << 1);
-	writel(reg, dp->reg_base + EXYNOS_DP_VIDEO_CTL_10);
+	writel(reg, dp->reg_base + ANALOGIX_DP_VIDEO_CTL_10);
 
-	reg = readl(dp->reg_base + EXYNOS_DP_VIDEO_CTL_10);
+	reg = readl(dp->reg_base + ANALOGIX_DP_VIDEO_CTL_10);
 	reg &= ~HSYNC_POLARITY_CFG;
 	reg |= (dp->video_info->h_sync_polarity << 0);
-	writel(reg, dp->reg_base + EXYNOS_DP_VIDEO_CTL_10);
+	writel(reg, dp->reg_base + ANALOGIX_DP_VIDEO_CTL_10);
 
 	reg = AUDIO_MODE_SPDIF_MODE | VIDEO_MODE_SLAVE_MODE;
-	writel(reg, dp->reg_base + EXYNOS_DP_SOC_GENERAL_CTL);
+	writel(reg, dp->reg_base + ANALOGIX_DP_SOC_GENERAL_CTL);
 }
 
 void analogix_dp_enable_scrambling(struct analogix_dp_device *dp)
 {
 	u32 reg;
 
-	reg = readl(dp->reg_base + EXYNOS_DP_TRAINING_PTN_SET);
+	reg = readl(dp->reg_base + ANALOGIX_DP_TRAINING_PTN_SET);
 	reg &= ~SCRAMBLING_DISABLE;
-	writel(reg, dp->reg_base + EXYNOS_DP_TRAINING_PTN_SET);
+	writel(reg, dp->reg_base + ANALOGIX_DP_TRAINING_PTN_SET);
 }
 
 void analogix_dp_disable_scrambling(struct analogix_dp_device *dp)
 {
 	u32 reg;
 
-	reg = readl(dp->reg_base + EXYNOS_DP_TRAINING_PTN_SET);
+	reg = readl(dp->reg_base + ANALOGIX_DP_TRAINING_PTN_SET);
 	reg |= SCRAMBLING_DISABLE;
-	writel(reg, dp->reg_base + EXYNOS_DP_TRAINING_PTN_SET);
+	writel(reg, dp->reg_base + ANALOGIX_DP_TRAINING_PTN_SET);
 }
diff --git a/drivers/gpu/drm/bridge/analogix/analogix_dp_reg.h b/drivers/gpu/drm/bridge/analogix/analogix_dp_reg.h
index b9661c9..738db4c 100644
--- a/drivers/gpu/drm/bridge/analogix/analogix_dp_reg.h
+++ b/drivers/gpu/drm/bridge/analogix/analogix_dp_reg.h
@@ -12,93 +12,93 @@
 #ifndef _ANALOGIX_DP_REG_H
 #define _ANALOGIX_DP_REG_H
 
-#define EXYNOS_DP_TX_SW_RESET			0x14
-#define EXYNOS_DP_FUNC_EN_1			0x18
-#define EXYNOS_DP_FUNC_EN_2			0x1C
-#define EXYNOS_DP_VIDEO_CTL_1			0x20
-#define EXYNOS_DP_VIDEO_CTL_2			0x24
-#define EXYNOS_DP_VIDEO_CTL_3			0x28
-
-#define EXYNOS_DP_VIDEO_CTL_8			0x3C
-#define EXYNOS_DP_VIDEO_CTL_10			0x44
-
-#define EXYNOS_DP_LANE_MAP			0x35C
-
-#define EXYNOS_DP_ANALOG_CTL_1			0x370
-#define EXYNOS_DP_ANALOG_CTL_2			0x374
-#define EXYNOS_DP_ANALOG_CTL_3			0x378
-#define EXYNOS_DP_PLL_FILTER_CTL_1		0x37C
-#define EXYNOS_DP_TX_AMP_TUNING_CTL		0x380
-
-#define EXYNOS_DP_AUX_HW_RETRY_CTL		0x390
-
-#define EXYNOS_DP_COMMON_INT_STA_1		0x3C4
-#define EXYNOS_DP_COMMON_INT_STA_2		0x3C8
-#define EXYNOS_DP_COMMON_INT_STA_3		0x3CC
-#define EXYNOS_DP_COMMON_INT_STA_4		0x3D0
-#define EXYNOS_DP_INT_STA			0x3DC
-#define EXYNOS_DP_COMMON_INT_MASK_1		0x3E0
-#define EXYNOS_DP_COMMON_INT_MASK_2		0x3E4
-#define EXYNOS_DP_COMMON_INT_MASK_3		0x3E8
-#define EXYNOS_DP_COMMON_INT_MASK_4		0x3EC
-#define EXYNOS_DP_INT_STA_MASK			0x3F8
-#define EXYNOS_DP_INT_CTL			0x3FC
-
-#define EXYNOS_DP_SYS_CTL_1			0x600
-#define EXYNOS_DP_SYS_CTL_2			0x604
-#define EXYNOS_DP_SYS_CTL_3			0x608
-#define EXYNOS_DP_SYS_CTL_4			0x60C
-
-#define EXYNOS_DP_PKT_SEND_CTL			0x640
-#define EXYNOS_DP_HDCP_CTL			0x648
-
-#define EXYNOS_DP_LINK_BW_SET			0x680
-#define EXYNOS_DP_LANE_COUNT_SET		0x684
-#define EXYNOS_DP_TRAINING_PTN_SET		0x688
-#define EXYNOS_DP_LN0_LINK_TRAINING_CTL		0x68C
-#define EXYNOS_DP_LN1_LINK_TRAINING_CTL		0x690
-#define EXYNOS_DP_LN2_LINK_TRAINING_CTL		0x694
-#define EXYNOS_DP_LN3_LINK_TRAINING_CTL		0x698
-
-#define EXYNOS_DP_DEBUG_CTL			0x6C0
-#define EXYNOS_DP_HPD_DEGLITCH_L		0x6C4
-#define EXYNOS_DP_HPD_DEGLITCH_H		0x6C8
-#define EXYNOS_DP_LINK_DEBUG_CTL		0x6E0
-
-#define EXYNOS_DP_M_VID_0			0x700
-#define EXYNOS_DP_M_VID_1			0x704
-#define EXYNOS_DP_M_VID_2			0x708
-#define EXYNOS_DP_N_VID_0			0x70C
-#define EXYNOS_DP_N_VID_1			0x710
-#define EXYNOS_DP_N_VID_2			0x714
-
-#define EXYNOS_DP_PLL_CTL			0x71C
-#define EXYNOS_DP_PHY_PD			0x720
-#define EXYNOS_DP_PHY_TEST			0x724
-
-#define EXYNOS_DP_VIDEO_FIFO_THRD		0x730
-#define EXYNOS_DP_AUDIO_MARGIN			0x73C
-
-#define EXYNOS_DP_M_VID_GEN_FILTER_TH		0x764
-#define EXYNOS_DP_M_AUD_GEN_FILTER_TH		0x778
-#define EXYNOS_DP_AUX_CH_STA			0x780
-#define EXYNOS_DP_AUX_CH_DEFER_CTL		0x788
-#define EXYNOS_DP_AUX_RX_COMM			0x78C
-#define EXYNOS_DP_BUFFER_DATA_CTL		0x790
-#define EXYNOS_DP_AUX_CH_CTL_1			0x794
-#define EXYNOS_DP_AUX_ADDR_7_0			0x798
-#define EXYNOS_DP_AUX_ADDR_15_8			0x79C
-#define EXYNOS_DP_AUX_ADDR_19_16		0x7A0
-#define EXYNOS_DP_AUX_CH_CTL_2			0x7A4
-
-#define EXYNOS_DP_BUF_DATA_0			0x7C0
-
-#define EXYNOS_DP_SOC_GENERAL_CTL		0x800
-
-/* EXYNOS_DP_TX_SW_RESET */
+#define ANALOGIX_DP_TX_SW_RESET			0x14
+#define ANALOGIX_DP_FUNC_EN_1			0x18
+#define ANALOGIX_DP_FUNC_EN_2			0x1C
+#define ANALOGIX_DP_VIDEO_CTL_1			0x20
+#define ANALOGIX_DP_VIDEO_CTL_2			0x24
+#define ANALOGIX_DP_VIDEO_CTL_3			0x28
+
+#define ANALOGIX_DP_VIDEO_CTL_8			0x3C
+#define ANALOGIX_DP_VIDEO_CTL_10		0x44
+
+#define ANALOGIX_DP_LANE_MAP			0x35C
+
+#define ANALOGIX_DP_ANALOG_CTL_1		0x370
+#define ANALOGIX_DP_ANALOG_CTL_2		0x374
+#define ANALOGIX_DP_ANALOG_CTL_3		0x378
+#define ANALOGIX_DP_PLL_FILTER_CTL_1		0x37C
+#define ANALOGIX_DP_TX_AMP_TUNING_CTL		0x380
+
+#define ANALOGIX_DP_AUX_HW_RETRY_CTL		0x390
+
+#define ANALOGIX_DP_COMMON_INT_STA_1		0x3C4
+#define ANALOGIX_DP_COMMON_INT_STA_2		0x3C8
+#define ANALOGIX_DP_COMMON_INT_STA_3		0x3CC
+#define ANALOGIX_DP_COMMON_INT_STA_4		0x3D0
+#define ANALOGIX_DP_INT_STA			0x3DC
+#define ANALOGIX_DP_COMMON_INT_MASK_1		0x3E0
+#define ANALOGIX_DP_COMMON_INT_MASK_2		0x3E4
+#define ANALOGIX_DP_COMMON_INT_MASK_3		0x3E8
+#define ANALOGIX_DP_COMMON_INT_MASK_4		0x3EC
+#define ANALOGIX_DP_INT_STA_MASK		0x3F8
+#define ANALOGIX_DP_INT_CTL			0x3FC
+
+#define ANALOGIX_DP_SYS_CTL_1			0x600
+#define ANALOGIX_DP_SYS_CTL_2			0x604
+#define ANALOGIX_DP_SYS_CTL_3			0x608
+#define ANALOGIX_DP_SYS_CTL_4			0x60C
+
+#define ANALOGIX_DP_PKT_SEND_CTL		0x640
+#define ANALOGIX_DP_HDCP_CTL			0x648
+
+#define ANALOGIX_DP_LINK_BW_SET			0x680
+#define ANALOGIX_DP_LANE_COUNT_SET		0x684
+#define ANALOGIX_DP_TRAINING_PTN_SET		0x688
+#define ANALOGIX_DP_LN0_LINK_TRAINING_CTL	0x68C
+#define ANALOGIX_DP_LN1_LINK_TRAINING_CTL	0x690
+#define ANALOGIX_DP_LN2_LINK_TRAINING_CTL	0x694
+#define ANALOGIX_DP_LN3_LINK_TRAINING_CTL	0x698
+
+#define ANALOGIX_DP_DEBUG_CTL			0x6C0
+#define ANALOGIX_DP_HPD_DEGLITCH_L		0x6C4
+#define ANALOGIX_DP_HPD_DEGLITCH_H		0x6C8
+#define ANALOGIX_DP_LINK_DEBUG_CTL		0x6E0
+
+#define ANALOGIX_DP_M_VID_0			0x700
+#define ANALOGIX_DP_M_VID_1			0x704
+#define ANALOGIX_DP_M_VID_2			0x708
+#define ANALOGIX_DP_N_VID_0			0x70C
+#define ANALOGIX_DP_N_VID_1			0x710
+#define ANALOGIX_DP_N_VID_2			0x714
+
+#define ANALOGIX_DP_PLL_CTL			0x71C
+#define ANALOGIX_DP_PHY_PD			0x720
+#define ANALOGIX_DP_PHY_TEST			0x724
+
+#define ANALOGIX_DP_VIDEO_FIFO_THRD		0x730
+#define ANALOGIX_DP_AUDIO_MARGIN		0x73C
+
+#define ANALOGIX_DP_M_VID_GEN_FILTER_TH		0x764
+#define ANALOGIX_DP_M_AUD_GEN_FILTER_TH		0x778
+#define ANALOGIX_DP_AUX_CH_STA			0x780
+#define ANALOGIX_DP_AUX_CH_DEFER_CTL		0x788
+#define ANALOGIX_DP_AUX_RX_COMM			0x78C
+#define ANALOGIX_DP_BUFFER_DATA_CTL		0x790
+#define ANALOGIX_DP_AUX_CH_CTL_1		0x794
+#define ANALOGIX_DP_AUX_ADDR_7_0		0x798
+#define ANALOGIX_DP_AUX_ADDR_15_8		0x79C
+#define ANALOGIX_DP_AUX_ADDR_19_16		0x7A0
+#define ANALOGIX_DP_AUX_CH_CTL_2		0x7A4
+
+#define ANALOGIX_DP_BUF_DATA_0			0x7C0
+
+#define ANALOGIX_DP_SOC_GENERAL_CTL		0x800
+
+/* ANALOGIX_DP_TX_SW_RESET */
 #define RESET_DP_TX				(0x1 << 0)
 
-/* EXYNOS_DP_FUNC_EN_1 */
+/* ANALOGIX_DP_FUNC_EN_1 */
 #define MASTER_VID_FUNC_EN_N			(0x1 << 7)
 #define SLAVE_VID_FUNC_EN_N			(0x1 << 5)
 #define AUD_FIFO_FUNC_EN_N			(0x1 << 4)
@@ -107,17 +107,17 @@
 #define CRC_FUNC_EN_N				(0x1 << 1)
 #define SW_FUNC_EN_N				(0x1 << 0)
 
-/* EXYNOS_DP_FUNC_EN_2 */
+/* ANALOGIX_DP_FUNC_EN_2 */
 #define SSC_FUNC_EN_N				(0x1 << 7)
 #define AUX_FUNC_EN_N				(0x1 << 2)
 #define SERDES_FIFO_FUNC_EN_N			(0x1 << 1)
 #define LS_CLK_DOMAIN_FUNC_EN_N			(0x1 << 0)
 
-/* EXYNOS_DP_VIDEO_CTL_1 */
+/* ANALOGIX_DP_VIDEO_CTL_1 */
 #define VIDEO_EN				(0x1 << 7)
 #define HDCP_VIDEO_MUTE				(0x1 << 6)
 
-/* EXYNOS_DP_VIDEO_CTL_1 */
+/* ANALOGIX_DP_VIDEO_CTL_1 */
 #define IN_D_RANGE_MASK				(0x1 << 7)
 #define IN_D_RANGE_SHIFT			(7)
 #define IN_D_RANGE_CEA				(0x1 << 7)
@@ -134,7 +134,7 @@
 #define IN_COLOR_F_YCBCR422			(0x1 << 0)
 #define IN_COLOR_F_RGB				(0x0 << 0)
 
-/* EXYNOS_DP_VIDEO_CTL_3 */
+/* ANALOGIX_DP_VIDEO_CTL_3 */
 #define IN_YC_COEFFI_MASK			(0x1 << 7)
 #define IN_YC_COEFFI_SHIFT			(7)
 #define IN_YC_COEFFI_ITU709			(0x1 << 7)
@@ -144,17 +144,17 @@
 #define VID_CHK_UPDATE_TYPE_1			(0x1 << 4)
 #define VID_CHK_UPDATE_TYPE_0			(0x0 << 4)
 
-/* EXYNOS_DP_VIDEO_CTL_8 */
+/* ANALOGIX_DP_VIDEO_CTL_8 */
 #define VID_HRES_TH(x)				(((x) & 0xf) << 4)
 #define VID_VRES_TH(x)				(((x) & 0xf) << 0)
 
-/* EXYNOS_DP_VIDEO_CTL_10 */
+/* ANALOGIX_DP_VIDEO_CTL_10 */
 #define FORMAT_SEL				(0x1 << 4)
 #define INTERACE_SCAN_CFG			(0x1 << 2)
 #define VSYNC_POLARITY_CFG			(0x1 << 1)
 #define HSYNC_POLARITY_CFG			(0x1 << 0)
 
-/* EXYNOS_DP_LANE_MAP */
+/* ANALOGIX_DP_LANE_MAP */
 #define LANE3_MAP_LOGIC_LANE_0			(0x0 << 6)
 #define LANE3_MAP_LOGIC_LANE_1			(0x1 << 6)
 #define LANE3_MAP_LOGIC_LANE_2			(0x2 << 6)
@@ -172,30 +172,30 @@
 #define LANE0_MAP_LOGIC_LANE_2			(0x2 << 0)
 #define LANE0_MAP_LOGIC_LANE_3			(0x3 << 0)
 
-/* EXYNOS_DP_ANALOG_CTL_1 */
+/* ANALOGIX_DP_ANALOG_CTL_1 */
 #define TX_TERMINAL_CTRL_50_OHM			(0x1 << 4)
 
-/* EXYNOS_DP_ANALOG_CTL_2 */
+/* ANALOGIX_DP_ANALOG_CTL_2 */
 #define SEL_24M					(0x1 << 3)
 #define TX_DVDD_BIT_1_0625V			(0x4 << 0)
 
-/* EXYNOS_DP_ANALOG_CTL_3 */
+/* ANALOGIX_DP_ANALOG_CTL_3 */
 #define DRIVE_DVDD_BIT_1_0625V			(0x4 << 5)
 #define VCO_BIT_600_MICRO			(0x5 << 0)
 
-/* EXYNOS_DP_PLL_FILTER_CTL_1 */
+/* ANALOGIX_DP_PLL_FILTER_CTL_1 */
 #define PD_RING_OSC				(0x1 << 6)
 #define AUX_TERMINAL_CTRL_50_OHM		(0x2 << 4)
 #define TX_CUR1_2X				(0x1 << 2)
 #define TX_CUR_16_MA				(0x3 << 0)
 
-/* EXYNOS_DP_TX_AMP_TUNING_CTL */
+/* ANALOGIX_DP_TX_AMP_TUNING_CTL */
 #define CH3_AMP_400_MV				(0x0 << 24)
 #define CH2_AMP_400_MV				(0x0 << 16)
 #define CH1_AMP_400_MV				(0x0 << 8)
 #define CH0_AMP_400_MV				(0x0 << 0)
 
-/* EXYNOS_DP_AUX_HW_RETRY_CTL */
+/* ANALOGIX_DP_AUX_HW_RETRY_CTL */
 #define AUX_BIT_PERIOD_EXPECTED_DELAY(x)	(((x) & 0x7) << 8)
 #define AUX_HW_RETRY_INTERVAL_MASK		(0x3 << 3)
 #define AUX_HW_RETRY_INTERVAL_600_MICROSECONDS	(0x0 << 3)
@@ -204,7 +204,7 @@
 #define AUX_HW_RETRY_INTERVAL_1800_MICROSECONDS	(0x3 << 3)
 #define AUX_HW_RETRY_COUNT_SEL(x)		(((x) & 0x7) << 0)
 
-/* EXYNOS_DP_COMMON_INT_STA_1 */
+/* ANALOGIX_DP_COMMON_INT_STA_1 */
 #define VSYNC_DET				(0x1 << 7)
 #define PLL_LOCK_CHG				(0x1 << 6)
 #define SPDIF_ERR				(0x1 << 5)
@@ -214,19 +214,19 @@
 #define VID_CLK_CHG				(0x1 << 1)
 #define SW_INT					(0x1 << 0)
 
-/* EXYNOS_DP_COMMON_INT_STA_2 */
+/* ANALOGIX_DP_COMMON_INT_STA_2 */
 #define ENC_EN_CHG				(0x1 << 6)
 #define HW_BKSV_RDY				(0x1 << 3)
 #define HW_SHA_DONE				(0x1 << 2)
 #define HW_AUTH_STATE_CHG			(0x1 << 1)
 #define HW_AUTH_DONE				(0x1 << 0)
 
-/* EXYNOS_DP_COMMON_INT_STA_3 */
+/* ANALOGIX_DP_COMMON_INT_STA_3 */
 #define AFIFO_UNDER				(0x1 << 7)
 #define AFIFO_OVER				(0x1 << 6)
 #define R0_CHK_FLAG				(0x1 << 5)
 
-/* EXYNOS_DP_COMMON_INT_STA_4 */
+/* ANALOGIX_DP_COMMON_INT_STA_4 */
 #define PSR_ACTIVE				(0x1 << 7)
 #define PSR_INACTIVE				(0x1 << 6)
 #define SPDIF_BI_PHASE_ERR			(0x1 << 5)
@@ -234,29 +234,29 @@
 #define HPD_LOST				(0x1 << 1)
 #define PLUG					(0x1 << 0)
 
-/* EXYNOS_DP_INT_STA */
+/* ANALOGIX_DP_INT_STA */
 #define INT_HPD					(0x1 << 6)
 #define HW_TRAINING_FINISH			(0x1 << 5)
 #define RPLY_RECEIV				(0x1 << 1)
 #define AUX_ERR					(0x1 << 0)
 
-/* EXYNOS_DP_INT_CTL */
+/* ANALOGIX_DP_INT_CTL */
 #define SOFT_INT_CTRL				(0x1 << 2)
 #define INT_POL1				(0x1 << 1)
 #define INT_POL0				(0x1 << 0)
 
-/* EXYNOS_DP_SYS_CTL_1 */
+/* ANALOGIX_DP_SYS_CTL_1 */
 #define DET_STA					(0x1 << 2)
 #define FORCE_DET				(0x1 << 1)
 #define DET_CTRL				(0x1 << 0)
 
-/* EXYNOS_DP_SYS_CTL_2 */
+/* ANALOGIX_DP_SYS_CTL_2 */
 #define CHA_CRI(x)				(((x) & 0xf) << 4)
 #define CHA_STA					(0x1 << 2)
 #define FORCE_CHA				(0x1 << 1)
 #define CHA_CTRL				(0x1 << 0)
 
-/* EXYNOS_DP_SYS_CTL_3 */
+/* ANALOGIX_DP_SYS_CTL_3 */
 #define HPD_STATUS				(0x1 << 6)
 #define F_HPD					(0x1 << 5)
 #define HPD_CTRL				(0x1 << 4)
@@ -265,13 +265,13 @@
 #define F_VALID					(0x1 << 1)
 #define VALID_CTRL				(0x1 << 0)
 
-/* EXYNOS_DP_SYS_CTL_4 */
+/* ANALOGIX_DP_SYS_CTL_4 */
 #define FIX_M_AUD				(0x1 << 4)
 #define ENHANCED				(0x1 << 3)
 #define FIX_M_VID				(0x1 << 2)
 #define M_VID_UPDATE_CTRL			(0x3 << 0)
 
-/* EXYNOS_DP_TRAINING_PTN_SET */
+/* ANALOGIX_DP_TRAINING_PTN_SET */
 #define SCRAMBLER_TYPE				(0x1 << 9)
 #define HW_LINK_TRAINING_PATTERN		(0x1 << 8)
 #define SCRAMBLING_DISABLE			(0x1 << 5)
@@ -285,24 +285,24 @@
 #define SW_TRAINING_PATTERN_SET_PTN1		(0x1 << 0)
 #define SW_TRAINING_PATTERN_SET_NORMAL		(0x0 << 0)
 
-/* EXYNOS_DP_LN0_LINK_TRAINING_CTL */
+/* ANALOGIX_DP_LN0_LINK_TRAINING_CTL */
 #define PRE_EMPHASIS_SET_MASK			(0x3 << 3)
 #define PRE_EMPHASIS_SET_SHIFT			(3)
 
-/* EXYNOS_DP_DEBUG_CTL */
+/* ANALOGIX_DP_DEBUG_CTL */
 #define PLL_LOCK				(0x1 << 4)
 #define F_PLL_LOCK				(0x1 << 3)
 #define PLL_LOCK_CTRL				(0x1 << 2)
 #define PN_INV					(0x1 << 0)
 
-/* EXYNOS_DP_PLL_CTL */
+/* ANALOGIX_DP_PLL_CTL */
 #define DP_PLL_PD				(0x1 << 7)
 #define DP_PLL_RESET				(0x1 << 6)
 #define DP_PLL_LOOP_BIT_DEFAULT			(0x1 << 4)
 #define DP_PLL_REF_BIT_1_1250V			(0x5 << 0)
 #define DP_PLL_REF_BIT_1_2500V			(0x7 << 0)
 
-/* EXYNOS_DP_PHY_PD */
+/* ANALOGIX_DP_PHY_PD */
 #define DP_PHY_PD				(0x1 << 5)
 #define AUX_PD					(0x1 << 4)
 #define CH3_PD					(0x1 << 3)
@@ -310,28 +310,28 @@
 #define CH1_PD					(0x1 << 1)
 #define CH0_PD					(0x1 << 0)
 
-/* EXYNOS_DP_PHY_TEST */
+/* ANALOGIX_DP_PHY_TEST */
 #define MACRO_RST				(0x1 << 5)
 #define CH1_TEST				(0x1 << 1)
 #define CH0_TEST				(0x1 << 0)
 
-/* EXYNOS_DP_AUX_CH_STA */
+/* ANALOGIX_DP_AUX_CH_STA */
 #define AUX_BUSY				(0x1 << 4)
 #define AUX_STATUS_MASK				(0xf << 0)
 
-/* EXYNOS_DP_AUX_CH_DEFER_CTL */
+/* ANALOGIX_DP_AUX_CH_DEFER_CTL */
 #define DEFER_CTRL_EN				(0x1 << 7)
 #define DEFER_COUNT(x)				(((x) & 0x7f) << 0)
 
-/* EXYNOS_DP_AUX_RX_COMM */
+/* ANALOGIX_DP_AUX_RX_COMM */
 #define AUX_RX_COMM_I2C_DEFER			(0x2 << 2)
 #define AUX_RX_COMM_AUX_DEFER			(0x2 << 0)
 
-/* EXYNOS_DP_BUFFER_DATA_CTL */
+/* ANALOGIX_DP_BUFFER_DATA_CTL */
 #define BUF_CLR					(0x1 << 7)
 #define BUF_DATA_COUNT(x)			(((x) & 0x1f) << 0)
 
-/* EXYNOS_DP_AUX_CH_CTL_1 */
+/* ANALOGIX_DP_AUX_CH_CTL_1 */
 #define AUX_LENGTH(x)				(((x - 1) & 0xf) << 4)
 #define AUX_TX_COMM_MASK			(0xf << 0)
 #define AUX_TX_COMM_DP_TRANSACTION		(0x1 << 3)
@@ -340,20 +340,20 @@
 #define AUX_TX_COMM_WRITE			(0x0 << 0)
 #define AUX_TX_COMM_READ			(0x1 << 0)
 
-/* EXYNOS_DP_AUX_ADDR_7_0 */
+/* ANALOGIX_DP_AUX_ADDR_7_0 */
 #define AUX_ADDR_7_0(x)				(((x) >> 0) & 0xff)
 
-/* EXYNOS_DP_AUX_ADDR_15_8 */
+/* ANALOGIX_DP_AUX_ADDR_15_8 */
 #define AUX_ADDR_15_8(x)			(((x) >> 8) & 0xff)
 
-/* EXYNOS_DP_AUX_ADDR_19_16 */
+/* ANALOGIX_DP_AUX_ADDR_19_16 */
 #define AUX_ADDR_19_16(x)			(((x) >> 16) & 0x0f)
 
-/* EXYNOS_DP_AUX_CH_CTL_2 */
+/* ANALOGIX_DP_AUX_CH_CTL_2 */
 #define ADDR_ONLY				(0x1 << 1)
 #define AUX_EN					(0x1 << 0)
 
-/* EXYNOS_DP_SOC_GENERAL_CTL */
+/* ANALOGIX_DP_SOC_GENERAL_CTL */
 #define AUDIO_MODE_SPDIF_MODE			(0x1 << 8)
 #define AUDIO_MODE_MASTER_MODE			(0x0 << 8)
 #define MASTER_VIDEO_INTERLACE_EN		(0x1 << 4)
-- 
1.9.1
