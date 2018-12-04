Return-Path: <SRS0=gVCq=ON=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.7 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8F726C04EB8
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Tue,  4 Dec 2018 09:28:02 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5BEED20851
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Tue,  4 Dec 2018 09:28:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="an85L9cL";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=nvidia.com header.i=@nvidia.com header.b="L9vlxOku"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5BEED20851
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=nvidia.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:
	Message-ID:Date:Subject:To:From:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=FwBC7r6TK5LaxH6XHzBvZ+0V//ZE3yE/mF3jfgL0/R8=; b=an85L9cLWaTI/l
	ioSz2pN9uR4gefxXRqqkzDZUkagwMbJ/gHlGXrbguVXn18rpuH/CWivVuAE5eKOlue1kOCIedKOW8
	nmS9x1zTuXXgbgq9mVCLUAMHz3KnAE4sD4hFJ1jOJGNnP3utdChndJl+9OabVIuG415Vy7RjfIobZ
	/TqCy8yO9afiyo1bk1A+Mt+p+PffPJSItexskA4sFpXPgGHQocIxJBQ8nXR45T3yI62MP6GNxZxFz
	lN3d8rOWZ02nlgjofnW7iJnOgztd2lFRZZsOx3oT0+t0PX1PjHSXvOn2gJHJLIe8PQIXOvBC7bM/U
	e5eeoPwtXuY5GsvSSMCQ==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gU6zp-00018n-1p; Tue, 04 Dec 2018 09:28:01 +0000
Received: from hqemgate14.nvidia.com ([216.228.121.143])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gU6yk-0008My-T9
 for linux-arm-kernel@lists.infradead.org; Tue, 04 Dec 2018 09:27:15 +0000
Received: from hqpgpgate101.nvidia.com (Not Verified[216.228.121.13]) by
 hqemgate14.nvidia.com (using TLS: TLSv1.2, DES-CBC3-SHA)
 id <B5c06485a0000>; Tue, 04 Dec 2018 01:26:50 -0800
Received: from hqmail.nvidia.com ([172.20.161.6])
 by hqpgpgate101.nvidia.com (PGP Universal service);
 Tue, 04 Dec 2018 01:26:51 -0800
X-PGP-Universal: processed;
 by hqpgpgate101.nvidia.com on Tue, 04 Dec 2018 01:26:51 -0800
Received: from HQMAIL109.nvidia.com (172.20.187.15) by HQMAIL103.nvidia.com
 (172.20.187.11) with Microsoft SMTP Server (TLS) id 15.0.1395.4; Tue, 4 Dec
 2018 09:26:51 +0000
Received: from HQMAIL105.nvidia.com (172.20.187.12) by HQMAIL109.nvidia.com
 (172.20.187.15) with Microsoft SMTP Server (TLS) id 15.0.1395.4; Tue, 4 Dec
 2018 09:26:50 +0000
Received: from hqnvemgw02.nvidia.com (172.16.227.111) by HQMAIL105.nvidia.com
 (172.20.187.12) with Microsoft SMTP Server (TLS) id 15.0.1395.4 via
 Frontend Transport; Tue, 4 Dec 2018 09:26:50 +0000
Received: from josephl-linux.nvidia.com (Not Verified[10.19.108.132]) by
 hqnvemgw02.nvidia.com with Trustwave SEG (v7, 5, 8, 10121)
 id <B5c0648590002>; Tue, 04 Dec 2018 01:26:50 -0800
From: Joseph Lo <josephl@nvidia.com>
To: Thierry Reding <thierry.reding@gmail.com>, Peter De Schrijver
 <pdeschrijver@nvidia.com>, Jonathan Hunter <jonathanh@nvidia.com>
Subject: [PATCH 07/19] clk: tegra: dfll: support PWM regulator control
Date: Tue, 4 Dec 2018 17:25:36 +0800
Message-ID: <20181204092548.3038-8-josephl@nvidia.com>
X-Mailer: git-send-email 2.19.2
In-Reply-To: <20181204092548.3038-1-josephl@nvidia.com>
References: <20181204092548.3038-1-josephl@nvidia.com>
MIME-Version: 1.0
X-NVConfidentiality: public
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
 t=1543915610; bh=iWxR/nHONSVgEB5XNYnmDTnYUzAYU2I31qQw63bW12c=;
 h=X-PGP-Universal:From:To:CC:Subject:Date:Message-ID:X-Mailer:
 In-Reply-To:References:MIME-Version:X-NVConfidentiality:
 Content-Transfer-Encoding:Content-Type;
 b=L9vlxOkujMtnPqZg00gtzPjkfiuCyCy+Je+KIbEtmgYVuLT7U2Ty2H7eo0ZYSkPDL
 KKfwdOk3aKyScGxgLKbj1n4Pw9gA8El509AdXc6RrdL7up4NlyNdALTTCsYCusPmh7
 0cwdMwL1C32VozrM4x0mX+UV3HvoP6tPmnyodmz+pZk5YZj/OMOotR2iR6CuilH4Ko
 YakHWjhSNNFqCCxkDMw1Scb2HUp6xW6QxJYY7CaAzRIIduNRd2PdqRvr+TlOo2x35V
 Yd+tY8p6ho8Jucv1amZHD8KN8rv94Bznxjb/1WYtg3knZNXpl2S8eP3+C4i12apjSZ
 0m5VWHswfDSRQ==
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20181204_012655_877094_7535030A 
X-CRM114-Status: GOOD (  22.97  )
X-BeenThere: linux-arm-kernel@lists.infradead.org
X-Mailman-Version: 2.1.21
Precedence: list
List-Id: <linux-arm-kernel.lists.infradead.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>, 
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>, 
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Cc: linux-tegra@vger.kernel.org, linux-clk@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, Joseph Lo <josephl@nvidia.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

The DFLL hardware supports two modes (I2C and PWM) for voltage control
when requesting a frequency. In this patch, we introduce PWM mode support.

To support that, we re-organize the LUT for unifying the table for both
cases of I2C and PWM mode. And generate that based on regulator info.
For the PWM-based regulator, we get this info from DT. And do the same as
the case of I2C LUT, which can help to map the PMIC voltage ID and voltages
that the regulator supported.

The other parts are the support code for initializing the DFLL hardware
to support PWM mode. Also, the register debugfs file is slightly
reworked to only show the i2c registers when I2C mode is in use.

Based on the work of Peter De Schrijver <pdeschrijver@nvidia.com>.

Signed-off-by: Joseph Lo <josephl@nvidia.com>
---
 drivers/clk/tegra/clk-dfll.c | 431 ++++++++++++++++++++++++++++++-----
 1 file changed, 368 insertions(+), 63 deletions(-)

diff --git a/drivers/clk/tegra/clk-dfll.c b/drivers/clk/tegra/clk-dfll.c
index 609e363dabf8..c294a2989f31 100644
--- a/drivers/clk/tegra/clk-dfll.c
+++ b/drivers/clk/tegra/clk-dfll.c
@@ -1,7 +1,7 @@
 /*
  * clk-dfll.c - Tegra DFLL clock source common code
  *
- * Copyright (C) 2012-2014 NVIDIA Corporation. All rights reserved.
+ * Copyright (C) 2012-2018 NVIDIA Corporation. All rights reserved.
  *
  * Aleksandr Frid <afrid@nvidia.com>
  * Paul Walmsley <pwalmsley@nvidia.com>
@@ -47,6 +47,7 @@
 #include <linux/kernel.h>
 #include <linux/module.h>
 #include <linux/of.h>
+#include <linux/pinctrl/consumer.h>
 #include <linux/pm_opp.h>
 #include <linux/pm_runtime.h>
 #include <linux/regmap.h>
@@ -243,6 +244,12 @@ enum dfll_tune_range {
 	DFLL_TUNE_LOW = 1,
 };
 
+
+enum tegra_dfll_pmu_if {
+	TEGRA_DFLL_PMU_I2C = 0,
+	TEGRA_DFLL_PMU_PWM = 1,
+};
+
 /**
  * struct dfll_rate_req - target DFLL rate request data
  * @rate: target frequency, after the postscaling
@@ -294,16 +301,25 @@ struct tegra_dfll {
 	u32				ci;
 	u32				cg;
 	bool				cg_scale;
+	u32				reg_init_uV;
 
 	/* I2C interface parameters */
 	u32				i2c_fs_rate;
 	u32				i2c_reg;
 	u32				i2c_slave_addr;
 
-	/* i2c_lut array entries are regulator framework selectors */
-	unsigned			i2c_lut[MAX_DFLL_VOLTAGES];
-	int				i2c_lut_size;
-	u8				lut_min, lut_max, lut_safe;
+	/* lut array entries are regulator framework selectors or PWM values*/
+	unsigned			lut[MAX_DFLL_VOLTAGES];
+	unsigned			lut_uv[MAX_DFLL_VOLTAGES];
+	int				lut_size;
+	u8				lut_bottom, lut_min, lut_max, lut_safe;
+
+	/* PWM interface */
+	enum tegra_dfll_pmu_if		pmu_if;
+	unsigned long			pwm_rate;
+	struct pinctrl			*pwm_pin;
+	struct pinctrl_state		*pwm_enable_state;
+	struct pinctrl_state		*pwm_disable_state;
 };
 
 #define clk_hw_to_dfll(_hw) container_of(_hw, struct tegra_dfll, dfll_clk_hw)
@@ -489,6 +505,34 @@ static void dfll_set_mode(struct tegra_dfll *td,
 	dfll_wmb(td);
 }
 
+/*
+ * DVCO rate control
+ */
+
+static unsigned long get_dvco_rate_below(struct tegra_dfll *td, u8 out_min)
+{
+	struct dev_pm_opp *opp;
+	unsigned long rate, prev_rate;
+	int uv, min_uv;
+
+	min_uv = td->lut_uv[out_min];
+	for (rate = 0, prev_rate = 0; ; rate++) {
+		opp = dev_pm_opp_find_freq_ceil(td->soc->dev, &rate);
+		if (IS_ERR(opp))
+			break;
+
+		uv = dev_pm_opp_get_voltage(opp);
+		dev_pm_opp_put(opp);
+
+		if (uv && uv > min_uv)
+			return prev_rate;
+
+		prev_rate = rate;
+	}
+
+	return prev_rate;
+}
+
 /*
  * DFLL-to-I2C controller interface
  */
@@ -518,6 +562,118 @@ static int dfll_i2c_set_output_enabled(struct tegra_dfll *td, bool enable)
 	return 0;
 }
 
+
+/*
+ * DFLL-to-PWM controller interface
+ */
+
+/**
+ * dfll_pwm_set_output_enabled - enable/disable PWM voltage requests
+ * @td: DFLL instance
+ * @enable: whether to enable or disable the PWM voltage requests
+ *
+ * Set the master enable control for PWM control value updates. If disabled,
+ * then the PWM signal is not driven. Also configure the PWM output pad
+ * to the appropriate state.
+ */
+static int dfll_pwm_set_output_enabled(struct tegra_dfll *td, bool enable)
+{
+	int ret;
+	u32 val, div;
+
+	if (enable) {
+		ret = pinctrl_select_state(td->pwm_pin, td->pwm_enable_state);
+		if (ret < 0) {
+			dev_err(td->dev, "setting enable state failed\n");
+			return -EINVAL;
+		}
+		val = dfll_readl(td, DFLL_OUTPUT_CFG);
+		val &= ~DFLL_OUTPUT_CFG_PWM_DIV_MASK;
+		div = DIV_ROUND_UP(td->ref_rate, td->pwm_rate);
+		val |= (div << DFLL_OUTPUT_CFG_PWM_DIV_SHIFT)
+				& DFLL_OUTPUT_CFG_PWM_DIV_MASK;
+		dfll_writel(td, val, DFLL_OUTPUT_CFG);
+		dfll_wmb(td);
+
+		val |= DFLL_OUTPUT_CFG_PWM_ENABLE;
+		dfll_writel(td, val, DFLL_OUTPUT_CFG);
+		dfll_wmb(td);
+	} else {
+		ret = pinctrl_select_state(td->pwm_pin, td->pwm_disable_state);
+		if (ret < 0)
+			dev_warn(td->dev, "setting disable state failed\n");
+
+		val = dfll_readl(td, DFLL_OUTPUT_CFG);
+		val &= ~DFLL_OUTPUT_CFG_PWM_ENABLE;
+		dfll_writel(td, val, DFLL_OUTPUT_CFG);
+		dfll_wmb(td);
+	}
+
+	return 0;
+}
+
+/**
+ * dfll_set_force_output_value - set fixed value for force output
+ * @td: DFLL instance
+ * @out_val: value to force output
+ *
+ * Set the fixed value for force output, DFLL will output this value when
+ * force output is enabled.
+ */
+static u32 dfll_set_force_output_value(struct tegra_dfll *td, u8 out_val)
+{
+	u32 val = dfll_readl(td, DFLL_OUTPUT_FORCE);
+
+	val = (val & DFLL_OUTPUT_FORCE_ENABLE) | (out_val & OUT_MASK);
+	dfll_writel(td, val, DFLL_OUTPUT_FORCE);
+	dfll_wmb(td);
+
+	return dfll_readl(td, DFLL_OUTPUT_FORCE);
+}
+
+/**
+ * dfll_set_force_output_enabled - enable/disable force output
+ * @td: DFLL instance
+ * @enable: whether to enable or disable the force output
+ *
+ * Set the enable control for fouce output with fixed value.
+ */
+static void dfll_set_force_output_enabled(struct tegra_dfll *td, bool enable)
+{
+	u32 val = dfll_readl(td, DFLL_OUTPUT_FORCE);
+
+	if (enable)
+		val |= DFLL_OUTPUT_FORCE_ENABLE;
+	else
+		val &= ~DFLL_OUTPUT_FORCE_ENABLE;
+
+	dfll_writel(td, val, DFLL_OUTPUT_FORCE);
+	dfll_wmb(td);
+}
+
+/**
+ * dfll_force_output - force output a fixed value
+ * @td: DFLL instance
+ * @out_sel: value to force output
+ *
+ * Set the fixed value for force output, DFLL will output this value.
+ */
+static int dfll_force_output(struct tegra_dfll *td, unsigned int out_sel)
+{
+	u32 val;
+
+	if (out_sel > OUT_MASK)
+		return -EINVAL;
+
+	val = dfll_set_force_output_value(td, out_sel);
+	if ((td->mode < DFLL_CLOSED_LOOP) &&
+	    !(val & DFLL_OUTPUT_FORCE_ENABLE)) {
+		dfll_set_force_output_enabled(td, true);
+	}
+
+	return 0;
+}
+
 /**
  * dfll_load_lut - load the voltage lookup table
  * @td: struct tegra_dfll *
@@ -539,7 +695,7 @@ static void dfll_load_i2c_lut(struct tegra_dfll *td)
 			lut_index = i;
 
 		val = regulator_list_hardware_vsel(td->vdd_reg,
-						     td->i2c_lut[lut_index]);
+						     td->lut[lut_index]);
 		__raw_writel(val, td->lut_base + i * 4);
 	}
 
@@ -594,24 +750,41 @@ static void dfll_init_out_if(struct tegra_dfll *td)
 {
 	u32 val;
 
-	td->lut_min = 0;
-	td->lut_max = td->i2c_lut_size - 1;
-	td->lut_safe = td->lut_min + 1;
+	td->lut_min = td->lut_bottom;
+	td->lut_max = td->lut_size - 1;
+	td->lut_safe = td->lut_min + (td->lut_min < td->lut_max ? 1 : 0);
+
+	/* clear DFLL_OUTPUT_CFG before setting new value */
+	dfll_writel(td, 0, DFLL_OUTPUT_CFG);
+	dfll_wmb(td);
 
-	dfll_i2c_writel(td, 0, DFLL_OUTPUT_CFG);
 	val = (td->lut_safe << DFLL_OUTPUT_CFG_SAFE_SHIFT) |
-		(td->lut_max << DFLL_OUTPUT_CFG_MAX_SHIFT) |
-		(td->lut_min << DFLL_OUTPUT_CFG_MIN_SHIFT);
-	dfll_i2c_writel(td, val, DFLL_OUTPUT_CFG);
-	dfll_i2c_wmb(td);
+	      (td->lut_max << DFLL_OUTPUT_CFG_MAX_SHIFT) |
+	      (td->lut_min << DFLL_OUTPUT_CFG_MIN_SHIFT);
+	dfll_writel(td, val, DFLL_OUTPUT_CFG);
+	dfll_wmb(td);
 
 	dfll_writel(td, 0, DFLL_OUTPUT_FORCE);
 	dfll_i2c_writel(td, 0, DFLL_INTR_EN);
 	dfll_i2c_writel(td, DFLL_INTR_MAX_MASK | DFLL_INTR_MIN_MASK,
 			DFLL_INTR_STS);
 
-	dfll_load_i2c_lut(td);
-	dfll_init_i2c_if(td);
+	if (td->pmu_if == TEGRA_DFLL_PMU_PWM) {
+		int vinit = td->reg_init_uV;
+		int vstep = td->soc->alignment.step_uv;
+		int vmin = td->lut_uv[0];
+
+		/* set initial voltage */
+		if ((vinit >= vmin) && vstep) {
+			unsigned int vsel;
+
+			vsel = DIV_ROUND_UP((vinit - vmin), vstep);
+			dfll_force_output(td, vsel);
+		}
+	} else {
+		dfll_load_i2c_lut(td);
+		dfll_init_i2c_if(td);
+	}
 }
 
 /*
@@ -640,8 +813,8 @@ static int find_lut_index_for_rate(struct tegra_dfll *td, unsigned long rate)
 	uv = dev_pm_opp_get_voltage(opp);
 	dev_pm_opp_put(opp);
 
-	for (i = 0; i < td->i2c_lut_size; i++) {
-		if (regulator_list_voltage(td->vdd_reg, td->i2c_lut[i]) == uv)
+	for (i = td->lut_bottom; i < td->lut_size; i++) {
+		if (regulator_list_voltage(td->vdd_reg, td->lut[i]) == uv)
 			return i;
 	}
 
@@ -863,9 +1036,14 @@ static int dfll_lock(struct tegra_dfll *td)
 			return -EINVAL;
 		}
 
-		dfll_i2c_set_output_enabled(td, true);
+		if (td->pmu_if == TEGRA_DFLL_PMU_PWM)
+			dfll_pwm_set_output_enabled(td, true);
+		else
+			dfll_i2c_set_output_enabled(td, true);
+
 		dfll_set_mode(td, DFLL_CLOSED_LOOP);
 		dfll_set_frequency_request(td, req);
+		dfll_set_force_output_enabled(td, false);
 		return 0;
 
 	default:
@@ -889,7 +1067,10 @@ static int dfll_unlock(struct tegra_dfll *td)
 	case DFLL_CLOSED_LOOP:
 		dfll_set_open_loop_config(td);
 		dfll_set_mode(td, DFLL_OPEN_LOOP);
-		dfll_i2c_set_output_enabled(td, false);
+		if (td->pmu_if == TEGRA_DFLL_PMU_PWM)
+			dfll_pwm_set_output_enabled(td, false);
+		else
+			dfll_i2c_set_output_enabled(td, false);
 		return 0;
 
 	case DFLL_OPEN_LOOP:
@@ -1171,15 +1352,17 @@ static int attr_registers_show(struct seq_file *s, void *data)
 		seq_printf(s, "[0x%02x] = 0x%08x\n", offs,
 			   dfll_i2c_readl(td, offs));
 
-	seq_puts(s, "\nINTEGRATED I2C CONTROLLER REGISTERS:\n");
-	offs = DFLL_I2C_CLK_DIVISOR;
-	seq_printf(s, "[0x%02x] = 0x%08x\n", offs,
-		   __raw_readl(td->i2c_controller_base + offs));
-
-	seq_puts(s, "\nLUT:\n");
-	for (offs = 0; offs <  4 * MAX_DFLL_VOLTAGES; offs += 4)
+	if (td->pmu_if == TEGRA_DFLL_PMU_I2C) {
+		seq_puts(s, "\nINTEGRATED I2C CONTROLLER REGISTERS:\n");
+		offs = DFLL_I2C_CLK_DIVISOR;
 		seq_printf(s, "[0x%02x] = 0x%08x\n", offs,
-			   __raw_readl(td->lut_base + offs));
+			   __raw_readl(td->i2c_controller_base + offs));
+
+		seq_puts(s, "\nLUT:\n");
+		for (offs = 0; offs <  4 * MAX_DFLL_VOLTAGES; offs += 4)
+			seq_printf(s, "[0x%02x] = 0x%08x\n", offs,
+				   __raw_readl(td->lut_base + offs));
+	}
 
 	return 0;
 }
@@ -1387,9 +1570,61 @@ static int find_vdd_map_entry_min(struct tegra_dfll *td, int uV)
 	return -EINVAL;
 }
 
+/*
+ * dfll_build_pwm_lut - build the PWM regulator lookup table
+ * @td: DFLL instance
+ * @v_max: Vmax from OPP table
+ *
+ * Look-up table in h/w is ignored when PWM is used as DFLL interface to PMIC.
+ * In this case closed loop output is controlling duty cycle directly. The s/w
+ * look-up that maps PWM duty cycle to voltage is still built by this function.
+ */
+static int dfll_build_pwm_lut(struct tegra_dfll *td, int v_max)
+{
+	int i, reg_volt;
+	unsigned long rate;
+	u8 lut_bottom = MAX_DFLL_VOLTAGES;
+	int v_min = td->soc->cvb->min_millivolts * 1000;
+
+	for (i = 0; i < MAX_DFLL_VOLTAGES; i++) {
+		reg_volt = td->lut_uv[i];
+
+		/* since opp voltage is exact mv */
+		reg_volt = (reg_volt / 1000) * 1000;
+		if (reg_volt > v_max)
+			break;
+
+		td->lut[i] = i;
+		if ((lut_bottom == MAX_DFLL_VOLTAGES) && (reg_volt >= v_min))
+			lut_bottom = i;
+	}
+
+	/* determine voltage boundaries */
+	td->lut_size = i;
+	if ((lut_bottom == MAX_DFLL_VOLTAGES) ||
+	    (lut_bottom + 1 >= td->lut_size)) {
+		dev_err(td->dev, "no voltage above DFLL minimum %d mV\n",
+			td->soc->cvb->min_millivolts);
+		return -EINVAL;
+	}
+	td->lut_bottom = lut_bottom;
+
+	/* determine rate boundaries */
+	rate = get_dvco_rate_below(td, td->lut_bottom);
+	if (!rate) {
+		dev_err(td->dev, "no opp below DFLL minimum voltage %d mV\n",
+			td->soc->cvb->min_millivolts);
+		return -EINVAL;
+	}
+	td->dvco_rate_min = rate;
+
+	return 0;
+}
+
 /**
  * dfll_build_i2c_lut - build the I2C voltage register lookup table
  * @td: DFLL instance
+ * @v_max: Vmax from OPP table
  *
  * The DFLL hardware has 33 bytes of look-up table RAM that must be filled with
  * PMIC voltage register values that span the entire DFLL operating range.
@@ -1397,33 +1632,26 @@ static int find_vdd_map_entry_min(struct tegra_dfll *td, int uV)
  * the soc-specific platform driver (td->soc->opp_dev) and the PMIC
  * register-to-voltage mapping queried from the regulator framework.
  *
- * On success, fills in td->i2c_lut and returns 0, or -err on failure.
+ * On success, fills in td->lut and returns 0, or -err on failure.
  */
-static int dfll_build_i2c_lut(struct tegra_dfll *td)
+static int dfll_build_i2c_lut(struct tegra_dfll *td, int v_max)
 {
+	unsigned long rate;
 	int ret = -EINVAL;
-	int j, v, v_max, v_opp;
+	int j, v, v_opp;
 	int selector;
-	unsigned long rate;
-	struct dev_pm_opp *opp;
 	int lut;
 
-	rate = ULONG_MAX;
-	opp = dev_pm_opp_find_freq_floor(td->soc->dev, &rate);
-	if (IS_ERR(opp)) {
-		dev_err(td->dev, "couldn't get vmax opp, empty opp table?\n");
-		goto out;
-	}
-	v_max = dev_pm_opp_get_voltage(opp);
-	dev_pm_opp_put(opp);
-
 	v = td->soc->cvb->min_millivolts * 1000;
 	lut = find_vdd_map_entry_exact(td, v);
 	if (lut < 0)
 		goto out;
-	td->i2c_lut[0] = lut;
+	td->lut[0] = lut;
+	td->lut_bottom = 0;
 
 	for (j = 1, rate = 0; ; rate++) {
+		struct dev_pm_opp *opp;
+
 		opp = dev_pm_opp_find_freq_ceil(td->soc->dev, &rate);
 		if (IS_ERR(opp))
 			break;
@@ -1442,32 +1670,58 @@ static int dfll_build_i2c_lut(struct tegra_dfll *td)
 			selector = find_vdd_map_entry_min(td, v);
 			if (selector < 0)
 				goto out;
-			if (selector != td->i2c_lut[j - 1])
-				td->i2c_lut[j++] = selector;
+			if (selector != td->lut[j - 1])
+				td->lut[j++] = selector;
 		}
 
 		v = (j == MAX_DFLL_VOLTAGES - 1) ? v_max : v_opp;
 		selector = find_vdd_map_entry_exact(td, v);
 		if (selector < 0)
 			goto out;
-		if (selector != td->i2c_lut[j - 1])
-			td->i2c_lut[j++] = selector;
+		if (selector != td->lut[j - 1])
+			td->lut[j++] = selector;
 
 		if (v >= v_max)
 			break;
 	}
-	td->i2c_lut_size = j;
+	td->lut_size = j;
 
 	if (!td->dvco_rate_min)
 		dev_err(td->dev, "no opp above DFLL minimum voltage %d mV\n",
 			td->soc->cvb->min_millivolts);
-	else
+	else {
 		ret = 0;
+		for (j = 0; j < td->lut_size; j++)
+			td->lut_uv[j] =
+				regulator_list_voltage(td->vdd_reg,
+						       td->lut[j]);
+	}
 
 out:
 	return ret;
 }
 
+static int dfll_build_lut(struct tegra_dfll *td)
+{
+	unsigned long rate;
+	struct dev_pm_opp *opp;
+	int v_max;
+
+	rate = ULONG_MAX;
+	opp = dev_pm_opp_find_freq_floor(td->soc->dev, &rate);
+	if (IS_ERR(opp)) {
+		dev_err(td->dev, "couldn't get vmax opp, empty opp table?\n");
+		return -EINVAL;
+	}
+	v_max = dev_pm_opp_get_voltage(opp);
+	dev_pm_opp_put(opp);
+
+	if (td->pmu_if == TEGRA_DFLL_PMU_PWM)
+		return dfll_build_pwm_lut(td, v_max);
+	else
+		return dfll_build_i2c_lut(td, v_max);
+}
+
 /**
  * read_dt_param - helper function for reading required parameters from the DT
  * @td: DFLL instance
@@ -1526,11 +1780,55 @@ static int dfll_fetch_i2c_params(struct tegra_dfll *td)
 	}
 	td->i2c_reg = vsel_reg;
 
-	ret = dfll_build_i2c_lut(td);
-	if (ret) {
-		dev_err(td->dev, "couldn't build I2C LUT\n");
+	return 0;
+}
+
+static int dfll_fetch_pwm_params(struct tegra_dfll *td)
+{
+	int ret, i;
+	u32 pwm_period;
+
+	if (!td->soc->alignment.step_uv || !td->soc->alignment.offset_uv) {
+		dev_err(td->dev,
+			"Missing step or alignment info for PWM regulator");
+		return -EINVAL;
+	}
+	for (i = 0; i < MAX_DFLL_VOLTAGES; i++)
+		td->lut_uv[i] = td->soc->alignment.offset_uv +
+				i * td->soc->alignment.step_uv;
+
+	ret = read_dt_param(td, "nvidia,init-uv", &td->reg_init_uV);
+	if (!ret) {
+		dev_err(td->dev, "couldn't get initialized voltage\n");
+		return ret;
+	}
+
+	ret = read_dt_param(td, "nvidia,pwm-period", &pwm_period);
+	if (!ret) {
+		dev_err(td->dev, "couldn't get PWM period\n");
 		return ret;
 	}
+	td->pwm_rate = (NSEC_PER_SEC / pwm_period) * (MAX_DFLL_VOLTAGES - 1);
+
+	td->pwm_pin = devm_pinctrl_get(td->dev);
+	if (IS_ERR(td->pwm_pin)) {
+		dev_err(td->dev, "DT: missing pinctrl device\n");
+		return PTR_ERR(td->pwm_pin);
+	}
+
+	td->pwm_enable_state = pinctrl_lookup_state(td->pwm_pin,
+						    "dvfs_pwm_enable");
+	if (IS_ERR(td->pwm_enable_state)) {
+		dev_err(td->dev, "DT: missing pwm enabled state\n");
+		return PTR_ERR(td->pwm_enable_state);
+	}
+
+	td->pwm_disable_state = pinctrl_lookup_state(td->pwm_pin,
+						     "dvfs_pwm_disable");
+	if (IS_ERR(td->pwm_disable_state)) {
+		dev_err(td->dev, "DT: missing pwm disabled state\n");
+		return PTR_ERR(td->pwm_disable_state);
+	}
 
 	return 0;
 }
@@ -1597,16 +1895,6 @@ int tegra_dfll_register(struct platform_device *pdev,
 
 	td->soc = soc;
 
-	td->vdd_reg = devm_regulator_get(td->dev, "vdd-cpu");
-	if (IS_ERR(td->vdd_reg)) {
-		ret = PTR_ERR(td->vdd_reg);
-		if (ret != -EPROBE_DEFER)
-			dev_err(td->dev, "couldn't get vdd_cpu regulator: %d\n",
-				ret);
-
-		return ret;
-	}
-
 	td->dvco_rst = devm_reset_control_get(td->dev, "dvco");
 	if (IS_ERR(td->dvco_rst)) {
 		dev_err(td->dev, "couldn't get dvco reset\n");
@@ -1619,10 +1907,27 @@ int tegra_dfll_register(struct platform_device *pdev,
 		return ret;
 	}
 
-	ret = dfll_fetch_i2c_params(td);
+	if (of_property_read_bool(td->dev->of_node, "nvidia,pwm-to-pmic")) {
+		td->pmu_if = TEGRA_DFLL_PMU_PWM;
+		ret = dfll_fetch_pwm_params(td);
+	} else  {
+		td->vdd_reg = devm_regulator_get(td->dev, "vdd-cpu");
+		if (IS_ERR(td->vdd_reg)) {
+			dev_err(td->dev, "couldn't get vdd_cpu regulator\n");
+			return PTR_ERR(td->vdd_reg);
+		}
+		td->pmu_if = TEGRA_DFLL_PMU_I2C;
+		ret = dfll_fetch_i2c_params(td);
+	}
 	if (ret)
 		return ret;
 
+	ret = dfll_build_lut(td);
+	if (ret) {
+		dev_err(td->dev, "couldn't build LUT\n");
+		return ret;
+	}
+
 	mem = platform_get_resource(pdev, IORESOURCE_MEM, 0);
 	if (!mem) {
 		dev_err(td->dev, "no control register resource\n");
-- 
2.19.2


_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
