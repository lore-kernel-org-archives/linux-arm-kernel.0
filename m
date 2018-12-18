Return-Path: <SRS0=e5Gl=O3=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 79B08C43387
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Tue, 18 Dec 2018 10:01:26 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4AAA7217D8
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Tue, 18 Dec 2018 10:01:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="BJG/tR9D";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=nvidia.com header.i=@nvidia.com header.b="kozxPm+v"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4AAA7217D8
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=nvidia.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:Date:
	Message-ID:From:References:To:Subject:Reply-To:Content-ID:Content-Description
	:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=6szWbt6CmTMtJKOgTve0zVG2SOPl+Ha3m3MREQtiBqI=; b=BJG/tR9D2Y+xw6
	EE5nSCp1Fl2UN68o9nwdQWmlH6cZAes8rKNLmjlXgoX2yCJ18xsFiPzPylefYj3Puc+lFv7YVPvCf
	5nW2uPPjGFyGzHkcNo0ZjkpFBZBl+kZqmoRUhTx4Os0kwW09FpAHiKNuBfIK6EMOrjIp6lf5erx/z
	VWWA2740ja4v73Cf7oKKhI8PZr+SzwAeObpfTN8V525Czu+696xJlbEsIDsiLLin0d12bw+iunR57
	EiFqhgMLhdgRA6b6FL/XxVqMAkfaX8cR84d50cUgPXItm/8OEPHIZESS5872QbmHbYZVKWBPWF1fE
	6g/KhuF5nujyTXGCdhrw==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gZCBm-00086H-TT; Tue, 18 Dec 2018 10:01:22 +0000
Received: from hqemgate14.nvidia.com ([216.228.121.143])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gZCBd-00085H-7c
 for linux-arm-kernel@lists.infradead.org; Tue, 18 Dec 2018 10:01:20 +0000
Received: from hqpgpgate102.nvidia.com (Not Verified[216.228.121.13]) by
 hqemgate14.nvidia.com (using TLS: TLSv1.2, DES-CBC3-SHA)
 id <B5c18c5590000>; Tue, 18 Dec 2018 02:00:57 -0800
Received: from hqmail.nvidia.com ([172.20.161.6])
 by hqpgpgate102.nvidia.com (PGP Universal service);
 Tue, 18 Dec 2018 02:01:02 -0800
X-PGP-Universal: processed;
 by hqpgpgate102.nvidia.com on Tue, 18 Dec 2018 02:01:02 -0800
Received: from [10.21.132.148] (10.124.1.5) by HQMAIL101.nvidia.com
 (172.20.187.10) with Microsoft SMTP Server (TLS) id 15.0.1395.4; Tue, 18 Dec
 2018 10:01:01 +0000
Subject: Re: [PATCH V3 07/20] clk: tegra: dfll: support PWM regulator control
To: Joseph Lo <josephl@nvidia.com>, Thierry Reding <thierry.reding@gmail.com>, 
 Peter De Schrijver <pdeschrijver@nvidia.com>
References: <20181218091232.23532-1-josephl@nvidia.com>
 <20181218091232.23532-8-josephl@nvidia.com>
From: Jon Hunter <jonathanh@nvidia.com>
Message-ID: <54ce8cb6-49ac-7e1d-9b16-0d7669a1f558@nvidia.com>
Date: Tue, 18 Dec 2018 10:00:59 +0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.2.1
MIME-Version: 1.0
In-Reply-To: <20181218091232.23532-8-josephl@nvidia.com>
X-Originating-IP: [10.124.1.5]
X-ClientProxiedBy: HQMAIL105.nvidia.com (172.20.187.12) To
 HQMAIL101.nvidia.com (172.20.187.10)
Content-Language: en-US
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
 t=1545127257; bh=lNXem2Pfd83efui1jcdVX9npmstdYksplI5ps5UtEGg=;
 h=X-PGP-Universal:Subject:To:CC:References:From:Message-ID:Date:
 User-Agent:MIME-Version:In-Reply-To:X-Originating-IP:
 X-ClientProxiedBy:Content-Type:Content-Language:
 Content-Transfer-Encoding;
 b=kozxPm+vuFOFYO5yW4dNRip1CTzwhcO6UFMVYJHmscqmRlGEdgpZNKYweJmKRY81R
 wkXV0m/aZl1IJTN/x4NAP88IvrVwUE+kPN8DCMrHc1IsaEQ4U6HEv9u1r3uaKdV8lw
 Tc2W5hSzabpafv9zikaIxKqu65tfRlIJIki1u8XGzGXlPbhQqGCFNbaf6s3OZ3zXg6
 T8Hae/qugTOuSHUDf2S3CFVV8ZQu7vlg4XautsRTRkhS7wCv5JJHqTlb+cqsNsm/5m
 5ufcvrgR2emmNAUg1LCRDmiC3b0YsanzQ3Zx9T6toJ6FPzVOcGHHsQspt6gfBT26Y1
 tr1n9/AZGvQkw==
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20181218_020118_146610_60A0197E 
X-CRM114-Status: GOOD (  34.57  )
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
 linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org


On 18/12/2018 09:12, Joseph Lo wrote:
> The DFLL hardware supports two modes (I2C and PWM) for voltage control
> when requesting a frequency. In this patch, we introduce PWM mode support.
> 
> To support that, we re-organize the LUT for unifying the table for both
> cases of I2C and PWM mode. And generate that based on regulator info.
> For the PWM-based regulator, we get this info from DT. And do the same as
> the case of I2C LUT, which can help to map the PMIC voltage ID and voltages
> that the regulator supported.
> 
> The other parts are the support code for initializing the DFLL hardware
> to support PWM mode. Also, the register debugfs file is slightly
> reworked to only show the i2c registers when I2C mode is in use.
> 
> Based on the work of Peter De Schrijver <pdeschrijver@nvidia.com>.
> 
> Signed-off-by: Joseph Lo <josephl@nvidia.com>
> ---
> *V3:
>  - more variable type fixes for reg_init_uV and lut_uv
>  - add WARN_ON for 'find_vdd_map_*' APIs if that could be called
>  accidently in PWM mode
> *V2:
>  - move reg_init_uV to be with the PWM related variables
>  - fix the variable type to 'unsigned long' if it needs to catch the
>  return value from 'dev_pm_opp_get_voltage'
>  - update to use lut_uv table for LUT look up. This makes the generic
>  lut_uv table to work with both PWM and I2C mode.
> ---
>  drivers/clk/tegra/clk-dfll.c | 444 +++++++++++++++++++++++++++++------
>  1 file changed, 377 insertions(+), 67 deletions(-)
> 
> diff --git a/drivers/clk/tegra/clk-dfll.c b/drivers/clk/tegra/clk-dfll.c
> index 609e363dabf8..96be522398ed 100644
> --- a/drivers/clk/tegra/clk-dfll.c
> +++ b/drivers/clk/tegra/clk-dfll.c
> @@ -1,7 +1,7 @@
>  /*
>   * clk-dfll.c - Tegra DFLL clock source common code
>   *
> - * Copyright (C) 2012-2014 NVIDIA Corporation. All rights reserved.
> + * Copyright (C) 2012-2018 NVIDIA Corporation. All rights reserved.
>   *
>   * Aleksandr Frid <afrid@nvidia.com>
>   * Paul Walmsley <pwalmsley@nvidia.com>
> @@ -47,6 +47,7 @@
>  #include <linux/kernel.h>
>  #include <linux/module.h>
>  #include <linux/of.h>
> +#include <linux/pinctrl/consumer.h>
>  #include <linux/pm_opp.h>
>  #include <linux/pm_runtime.h>
>  #include <linux/regmap.h>
> @@ -243,6 +244,12 @@ enum dfll_tune_range {
>  	DFLL_TUNE_LOW = 1,
>  };
>  
> +
> +enum tegra_dfll_pmu_if {
> +	TEGRA_DFLL_PMU_I2C = 0,
> +	TEGRA_DFLL_PMU_PWM = 1,
> +};
> +
>  /**
>   * struct dfll_rate_req - target DFLL rate request data
>   * @rate: target frequency, after the postscaling
> @@ -300,10 +307,19 @@ struct tegra_dfll {
>  	u32				i2c_reg;
>  	u32				i2c_slave_addr;
>  
> -	/* i2c_lut array entries are regulator framework selectors */
> -	unsigned			i2c_lut[MAX_DFLL_VOLTAGES];
> -	int				i2c_lut_size;
> -	u8				lut_min, lut_max, lut_safe;
> +	/* lut array entries are regulator framework selectors or PWM values*/
> +	unsigned			lut[MAX_DFLL_VOLTAGES];
> +	unsigned long			lut_uv[MAX_DFLL_VOLTAGES];
> +	int				lut_size;
> +	u8				lut_bottom, lut_min, lut_max, lut_safe;
> +
> +	/* PWM interface */
> +	enum tegra_dfll_pmu_if		pmu_if;
> +	unsigned long			pwm_rate;
> +	struct pinctrl			*pwm_pin;
> +	struct pinctrl_state		*pwm_enable_state;
> +	struct pinctrl_state		*pwm_disable_state;
> +	u32				reg_init_uV;
>  };
>  
>  #define clk_hw_to_dfll(_hw) container_of(_hw, struct tegra_dfll, dfll_clk_hw)
> @@ -489,6 +505,34 @@ static void dfll_set_mode(struct tegra_dfll *td,
>  	dfll_wmb(td);
>  }
>  
> +/*
> + * DVCO rate control
> + */
> +
> +static unsigned long get_dvco_rate_below(struct tegra_dfll *td, u8 out_min)
> +{
> +	struct dev_pm_opp *opp;
> +	unsigned long rate, prev_rate;
> +	unsigned long uv, min_uv;
> +
> +	min_uv = td->lut_uv[out_min];
> +	for (rate = 0, prev_rate = 0; ; rate++) {
> +		opp = dev_pm_opp_find_freq_ceil(td->soc->dev, &rate);
> +		if (IS_ERR(opp))
> +			break;
> +
> +		uv = dev_pm_opp_get_voltage(opp);
> +		dev_pm_opp_put(opp);
> +
> +		if (uv && uv > min_uv)
> +			return prev_rate;
> +
> +		prev_rate = rate;
> +	}
> +
> +	return prev_rate;
> +}
> +
>  /*
>   * DFLL-to-I2C controller interface
>   */
> @@ -518,6 +562,118 @@ static int dfll_i2c_set_output_enabled(struct tegra_dfll *td, bool enable)
>  	return 0;
>  }
>  
> +
> +/*
> + * DFLL-to-PWM controller interface
> + */
> +
> +/**
> + * dfll_pwm_set_output_enabled - enable/disable PWM voltage requests
> + * @td: DFLL instance
> + * @enable: whether to enable or disable the PWM voltage requests
> + *
> + * Set the master enable control for PWM control value updates. If disabled,
> + * then the PWM signal is not driven. Also configure the PWM output pad
> + * to the appropriate state.
> + */
> +static int dfll_pwm_set_output_enabled(struct tegra_dfll *td, bool enable)
> +{
> +	int ret;
> +	u32 val, div;
> +
> +	if (enable) {
> +		ret = pinctrl_select_state(td->pwm_pin, td->pwm_enable_state);
> +		if (ret < 0) {
> +			dev_err(td->dev, "setting enable state failed\n");
> +			return -EINVAL;
> +		}
> +		val = dfll_readl(td, DFLL_OUTPUT_CFG);
> +		val &= ~DFLL_OUTPUT_CFG_PWM_DIV_MASK;
> +		div = DIV_ROUND_UP(td->ref_rate, td->pwm_rate);
> +		val |= (div << DFLL_OUTPUT_CFG_PWM_DIV_SHIFT)
> +				& DFLL_OUTPUT_CFG_PWM_DIV_MASK;
> +		dfll_writel(td, val, DFLL_OUTPUT_CFG);
> +		dfll_wmb(td);
> +
> +		val |= DFLL_OUTPUT_CFG_PWM_ENABLE;
> +		dfll_writel(td, val, DFLL_OUTPUT_CFG);
> +		dfll_wmb(td);
> +	} else {
> +		ret = pinctrl_select_state(td->pwm_pin, td->pwm_disable_state);
> +		if (ret < 0)
> +			dev_warn(td->dev, "setting disable state failed\n");
> +
> +		val = dfll_readl(td, DFLL_OUTPUT_CFG);
> +		val &= ~DFLL_OUTPUT_CFG_PWM_ENABLE;
> +		dfll_writel(td, val, DFLL_OUTPUT_CFG);
> +		dfll_wmb(td);
> +	}
> +
> +	return 0;
> +}
> +
> +/**
> + * dfll_set_force_output_value - set fixed value for force output
> + * @td: DFLL instance
> + * @out_val: value to force output
> + *
> + * Set the fixed value for force output, DFLL will output this value when
> + * force output is enabled.
> + */
> +static u32 dfll_set_force_output_value(struct tegra_dfll *td, u8 out_val)
> +{
> +	u32 val = dfll_readl(td, DFLL_OUTPUT_FORCE);
> +
> +	val = (val & DFLL_OUTPUT_FORCE_ENABLE) | (out_val & OUT_MASK);
> +	dfll_writel(td, val, DFLL_OUTPUT_FORCE);
> +	dfll_wmb(td);
> +
> +	return dfll_readl(td, DFLL_OUTPUT_FORCE);
> +}
> +
> +/**
> + * dfll_set_force_output_enabled - enable/disable force output
> + * @td: DFLL instance
> + * @enable: whether to enable or disable the force output
> + *
> + * Set the enable control for fouce output with fixed value.
> + */
> +static void dfll_set_force_output_enabled(struct tegra_dfll *td, bool enable)
> +{
> +	u32 val = dfll_readl(td, DFLL_OUTPUT_FORCE);
> +
> +	if (enable)
> +		val |= DFLL_OUTPUT_FORCE_ENABLE;
> +	else
> +		val &= ~DFLL_OUTPUT_FORCE_ENABLE;
> +
> +	dfll_writel(td, val, DFLL_OUTPUT_FORCE);
> +	dfll_wmb(td);
> +}
> +
> +/**
> + * dfll_force_output - force output a fixed value
> + * @td: DFLL instance
> + * @out_sel: value to force output
> + *
> + * Set the fixed value for force output, DFLL will output this value.
> + */
> +static int dfll_force_output(struct tegra_dfll *td, unsigned int out_sel)
> +{
> +	u32 val;
> +
> +	if (out_sel > OUT_MASK)
> +		return -EINVAL;
> +
> +	val = dfll_set_force_output_value(td, out_sel);
> +	if ((td->mode < DFLL_CLOSED_LOOP) &&
> +	    !(val & DFLL_OUTPUT_FORCE_ENABLE)) {
> +		dfll_set_force_output_enabled(td, true);
> +	}
> +
> +	return 0;
> +}
> +
>  /**
>   * dfll_load_lut - load the voltage lookup table
>   * @td: struct tegra_dfll *
> @@ -539,7 +695,7 @@ static void dfll_load_i2c_lut(struct tegra_dfll *td)
>  			lut_index = i;
>  
>  		val = regulator_list_hardware_vsel(td->vdd_reg,
> -						     td->i2c_lut[lut_index]);
> +						     td->lut[lut_index]);
>  		__raw_writel(val, td->lut_base + i * 4);
>  	}
>  
> @@ -594,24 +750,41 @@ static void dfll_init_out_if(struct tegra_dfll *td)
>  {
>  	u32 val;
>  
> -	td->lut_min = 0;
> -	td->lut_max = td->i2c_lut_size - 1;
> -	td->lut_safe = td->lut_min + 1;
> +	td->lut_min = td->lut_bottom;
> +	td->lut_max = td->lut_size - 1;
> +	td->lut_safe = td->lut_min + (td->lut_min < td->lut_max ? 1 : 0);
> +
> +	/* clear DFLL_OUTPUT_CFG before setting new value */
> +	dfll_writel(td, 0, DFLL_OUTPUT_CFG);
> +	dfll_wmb(td);
>  
> -	dfll_i2c_writel(td, 0, DFLL_OUTPUT_CFG);
>  	val = (td->lut_safe << DFLL_OUTPUT_CFG_SAFE_SHIFT) |
> -		(td->lut_max << DFLL_OUTPUT_CFG_MAX_SHIFT) |
> -		(td->lut_min << DFLL_OUTPUT_CFG_MIN_SHIFT);
> -	dfll_i2c_writel(td, val, DFLL_OUTPUT_CFG);
> -	dfll_i2c_wmb(td);
> +	      (td->lut_max << DFLL_OUTPUT_CFG_MAX_SHIFT) |
> +	      (td->lut_min << DFLL_OUTPUT_CFG_MIN_SHIFT);
> +	dfll_writel(td, val, DFLL_OUTPUT_CFG);
> +	dfll_wmb(td);
>  
>  	dfll_writel(td, 0, DFLL_OUTPUT_FORCE);
>  	dfll_i2c_writel(td, 0, DFLL_INTR_EN);
>  	dfll_i2c_writel(td, DFLL_INTR_MAX_MASK | DFLL_INTR_MIN_MASK,
>  			DFLL_INTR_STS);
>  
> -	dfll_load_i2c_lut(td);
> -	dfll_init_i2c_if(td);
> +	if (td->pmu_if == TEGRA_DFLL_PMU_PWM) {
> +		u32 vinit = td->reg_init_uV;
> +		int vstep = td->soc->alignment.step_uv;
> +		unsigned long vmin = td->lut_uv[0];
> +
> +		/* set initial voltage */
> +		if ((vinit >= vmin) && vstep) {
> +			unsigned int vsel;
> +
> +			vsel = DIV_ROUND_UP((vinit - vmin), vstep);
> +			dfll_force_output(td, vsel);
> +		}
> +	} else {
> +		dfll_load_i2c_lut(td);
> +		dfll_init_i2c_if(td);
> +	}
>  }
>  
>  /*
> @@ -631,7 +804,8 @@ static void dfll_init_out_if(struct tegra_dfll *td)
>  static int find_lut_index_for_rate(struct tegra_dfll *td, unsigned long rate)
>  {
>  	struct dev_pm_opp *opp;
> -	int i, uv;
> +	unsigned long uv;
> +	int i;
>  
>  	opp = dev_pm_opp_find_freq_ceil(td->soc->dev, &rate);
>  	if (IS_ERR(opp))
> @@ -640,8 +814,8 @@ static int find_lut_index_for_rate(struct tegra_dfll *td, unsigned long rate)
>  	uv = dev_pm_opp_get_voltage(opp);
>  	dev_pm_opp_put(opp);
>  
> -	for (i = 0; i < td->i2c_lut_size; i++) {
> -		if (regulator_list_voltage(td->vdd_reg, td->i2c_lut[i]) == uv)
> +	for (i = td->lut_bottom; i < td->lut_size; i++) {
> +		if (td->lut_uv[i] >= uv)
>  			return i;
>  	}
>  
> @@ -863,9 +1037,14 @@ static int dfll_lock(struct tegra_dfll *td)
>  			return -EINVAL;
>  		}
>  
> -		dfll_i2c_set_output_enabled(td, true);
> +		if (td->pmu_if == TEGRA_DFLL_PMU_PWM)
> +			dfll_pwm_set_output_enabled(td, true);
> +		else
> +			dfll_i2c_set_output_enabled(td, true);
> +
>  		dfll_set_mode(td, DFLL_CLOSED_LOOP);
>  		dfll_set_frequency_request(td, req);
> +		dfll_set_force_output_enabled(td, false);
>  		return 0;
>  
>  	default:
> @@ -889,7 +1068,10 @@ static int dfll_unlock(struct tegra_dfll *td)
>  	case DFLL_CLOSED_LOOP:
>  		dfll_set_open_loop_config(td);
>  		dfll_set_mode(td, DFLL_OPEN_LOOP);
> -		dfll_i2c_set_output_enabled(td, false);
> +		if (td->pmu_if == TEGRA_DFLL_PMU_PWM)
> +			dfll_pwm_set_output_enabled(td, false);
> +		else
> +			dfll_i2c_set_output_enabled(td, false);
>  		return 0;
>  
>  	case DFLL_OPEN_LOOP:
> @@ -1171,15 +1353,17 @@ static int attr_registers_show(struct seq_file *s, void *data)
>  		seq_printf(s, "[0x%02x] = 0x%08x\n", offs,
>  			   dfll_i2c_readl(td, offs));
>  
> -	seq_puts(s, "\nINTEGRATED I2C CONTROLLER REGISTERS:\n");
> -	offs = DFLL_I2C_CLK_DIVISOR;
> -	seq_printf(s, "[0x%02x] = 0x%08x\n", offs,
> -		   __raw_readl(td->i2c_controller_base + offs));
> -
> -	seq_puts(s, "\nLUT:\n");
> -	for (offs = 0; offs <  4 * MAX_DFLL_VOLTAGES; offs += 4)
> +	if (td->pmu_if == TEGRA_DFLL_PMU_I2C) {
> +		seq_puts(s, "\nINTEGRATED I2C CONTROLLER REGISTERS:\n");
> +		offs = DFLL_I2C_CLK_DIVISOR;
>  		seq_printf(s, "[0x%02x] = 0x%08x\n", offs,
> -			   __raw_readl(td->lut_base + offs));
> +			   __raw_readl(td->i2c_controller_base + offs));
> +
> +		seq_puts(s, "\nLUT:\n");
> +		for (offs = 0; offs <  4 * MAX_DFLL_VOLTAGES; offs += 4)
> +			seq_printf(s, "[0x%02x] = 0x%08x\n", offs,
> +				   __raw_readl(td->lut_base + offs));
> +	}
>  
>  	return 0;
>  }
> @@ -1351,6 +1535,9 @@ static int find_vdd_map_entry_exact(struct tegra_dfll *td, int uV)
>  {
>  	int i, n_voltages, reg_uV;
>  
> +	if (WARN_ON(td->pmu_if == TEGRA_DFLL_PMU_PWM))
> +		return -EINVAL;
> +
>  	n_voltages = regulator_count_voltages(td->vdd_reg);
>  	for (i = 0; i < n_voltages; i++) {
>  		reg_uV = regulator_list_voltage(td->vdd_reg, i);
> @@ -1373,6 +1560,9 @@ static int find_vdd_map_entry_min(struct tegra_dfll *td, int uV)
>  {
>  	int i, n_voltages, reg_uV;
>  
> +	if (WARN_ON(td->pmu_if == TEGRA_DFLL_PMU_PWM))
> +		return -EINVAL;
> +
>  	n_voltages = regulator_count_voltages(td->vdd_reg);
>  	for (i = 0; i < n_voltages; i++) {
>  		reg_uV = regulator_list_voltage(td->vdd_reg, i);
> @@ -1387,9 +1577,61 @@ static int find_vdd_map_entry_min(struct tegra_dfll *td, int uV)
>  	return -EINVAL;
>  }
>  
> +/*
> + * dfll_build_pwm_lut - build the PWM regulator lookup table
> + * @td: DFLL instance
> + * @v_max: Vmax from OPP table
> + *
> + * Look-up table in h/w is ignored when PWM is used as DFLL interface to PMIC.
> + * In this case closed loop output is controlling duty cycle directly. The s/w
> + * look-up that maps PWM duty cycle to voltage is still built by this function.
> + */
> +static int dfll_build_pwm_lut(struct tegra_dfll *td, unsigned long v_max)
> +{
> +	int i;
> +	unsigned long rate, reg_volt;
> +	u8 lut_bottom = MAX_DFLL_VOLTAGES;
> +	int v_min = td->soc->cvb->min_millivolts * 1000;
> +
> +	for (i = 0; i < MAX_DFLL_VOLTAGES; i++) {
> +		reg_volt = td->lut_uv[i];
> +
> +		/* since opp voltage is exact mv */
> +		reg_volt = (reg_volt / 1000) * 1000;
> +		if (reg_volt > v_max)
> +			break;
> +
> +		td->lut[i] = i;
> +		if ((lut_bottom == MAX_DFLL_VOLTAGES) && (reg_volt >= v_min))
> +			lut_bottom = i;
> +	}
> +
> +	/* determine voltage boundaries */
> +	td->lut_size = i;
> +	if ((lut_bottom == MAX_DFLL_VOLTAGES) ||
> +	    (lut_bottom + 1 >= td->lut_size)) {
> +		dev_err(td->dev, "no voltage above DFLL minimum %d mV\n",
> +			td->soc->cvb->min_millivolts);
> +		return -EINVAL;
> +	}
> +	td->lut_bottom = lut_bottom;
> +
> +	/* determine rate boundaries */
> +	rate = get_dvco_rate_below(td, td->lut_bottom);
> +	if (!rate) {
> +		dev_err(td->dev, "no opp below DFLL minimum voltage %d mV\n",
> +			td->soc->cvb->min_millivolts);
> +		return -EINVAL;
> +	}
> +	td->dvco_rate_min = rate;
> +
> +	return 0;
> +}
> +
>  /**
>   * dfll_build_i2c_lut - build the I2C voltage register lookup table
>   * @td: DFLL instance
> + * @v_max: Vmax from OPP table
>   *
>   * The DFLL hardware has 33 bytes of look-up table RAM that must be filled with
>   * PMIC voltage register values that span the entire DFLL operating range.
> @@ -1397,33 +1639,24 @@ static int find_vdd_map_entry_min(struct tegra_dfll *td, int uV)
>   * the soc-specific platform driver (td->soc->opp_dev) and the PMIC
>   * register-to-voltage mapping queried from the regulator framework.
>   *
> - * On success, fills in td->i2c_lut and returns 0, or -err on failure.
> + * On success, fills in td->lut and returns 0, or -err on failure.
>   */
> -static int dfll_build_i2c_lut(struct tegra_dfll *td)
> +static int dfll_build_i2c_lut(struct tegra_dfll *td, unsigned long v_max)
>  {
> +	unsigned long rate, v, v_opp;
>  	int ret = -EINVAL;
> -	int j, v, v_max, v_opp;
> -	int selector;
> -	unsigned long rate;
> -	struct dev_pm_opp *opp;
> -	int lut;
> -
> -	rate = ULONG_MAX;
> -	opp = dev_pm_opp_find_freq_floor(td->soc->dev, &rate);
> -	if (IS_ERR(opp)) {
> -		dev_err(td->dev, "couldn't get vmax opp, empty opp table?\n");
> -		goto out;
> -	}
> -	v_max = dev_pm_opp_get_voltage(opp);
> -	dev_pm_opp_put(opp);
> +	int j, selector, lut;
>  
>  	v = td->soc->cvb->min_millivolts * 1000;
>  	lut = find_vdd_map_entry_exact(td, v);
>  	if (lut < 0)
>  		goto out;
> -	td->i2c_lut[0] = lut;
> +	td->lut[0] = lut;
> +	td->lut_bottom = 0;
>  
>  	for (j = 1, rate = 0; ; rate++) {
> +		struct dev_pm_opp *opp;
> +
>  		opp = dev_pm_opp_find_freq_ceil(td->soc->dev, &rate);
>  		if (IS_ERR(opp))
>  			break;
> @@ -1435,39 +1668,64 @@ static int dfll_build_i2c_lut(struct tegra_dfll *td)
>  		dev_pm_opp_put(opp);
>  
>  		for (;;) {
> -			v += max(1, (v_max - v) / (MAX_DFLL_VOLTAGES - j));
> +			v += max(1UL, (v_max - v) / (MAX_DFLL_VOLTAGES - j));
>  			if (v >= v_opp)
>  				break;
>  
>  			selector = find_vdd_map_entry_min(td, v);
>  			if (selector < 0)
>  				goto out;
> -			if (selector != td->i2c_lut[j - 1])
> -				td->i2c_lut[j++] = selector;
> +			if (selector != td->lut[j - 1])
> +				td->lut[j++] = selector;
>  		}
>  
>  		v = (j == MAX_DFLL_VOLTAGES - 1) ? v_max : v_opp;
>  		selector = find_vdd_map_entry_exact(td, v);
>  		if (selector < 0)
>  			goto out;
> -		if (selector != td->i2c_lut[j - 1])
> -			td->i2c_lut[j++] = selector;
> +		if (selector != td->lut[j - 1])
> +			td->lut[j++] = selector;
>  
>  		if (v >= v_max)
>  			break;
>  	}
> -	td->i2c_lut_size = j;
> +	td->lut_size = j;
>  
>  	if (!td->dvco_rate_min)
>  		dev_err(td->dev, "no opp above DFLL minimum voltage %d mV\n",
>  			td->soc->cvb->min_millivolts);
> -	else
> +	else {
>  		ret = 0;
> +		for (j = 0; j < td->lut_size; j++)
> +			td->lut_uv[j] =
> +				regulator_list_voltage(td->vdd_reg,
> +						       td->lut[j]);
> +	}
>  
>  out:
>  	return ret;
>  }
>  
> +static int dfll_build_lut(struct tegra_dfll *td)
> +{
> +	unsigned long rate, v_max;
> +	struct dev_pm_opp *opp;
> +
> +	rate = ULONG_MAX;
> +	opp = dev_pm_opp_find_freq_floor(td->soc->dev, &rate);
> +	if (IS_ERR(opp)) {
> +		dev_err(td->dev, "couldn't get vmax opp, empty opp table?\n");
> +		return -EINVAL;
> +	}
> +	v_max = dev_pm_opp_get_voltage(opp);
> +	dev_pm_opp_put(opp);
> +
> +	if (td->pmu_if == TEGRA_DFLL_PMU_PWM)
> +		return dfll_build_pwm_lut(td, v_max);
> +	else
> +		return dfll_build_i2c_lut(td, v_max);
> +}
> +
>  /**
>   * read_dt_param - helper function for reading required parameters from the DT
>   * @td: DFLL instance
> @@ -1526,11 +1784,56 @@ static int dfll_fetch_i2c_params(struct tegra_dfll *td)
>  	}
>  	td->i2c_reg = vsel_reg;
>  
> -	ret = dfll_build_i2c_lut(td);
> -	if (ret) {
> -		dev_err(td->dev, "couldn't build I2C LUT\n");
> +	return 0;
> +}
> +
> +static int dfll_fetch_pwm_params(struct tegra_dfll *td)
> +{
> +	int ret, i;
> +	u32 pwm_period;
> +
> +	if (!td->soc->alignment.step_uv || !td->soc->alignment.offset_uv) {
> +		dev_err(td->dev,
> +			"Missing step or alignment info for PWM regulator");
> +		return -EINVAL;
> +	}
> +	for (i = 0; i < MAX_DFLL_VOLTAGES; i++)
> +		td->lut_uv[i] = td->soc->alignment.offset_uv +
> +				i * td->soc->alignment.step_uv;
> +
> +	ret = read_dt_param(td, "nvidia,pwm-tristate-microvolts",
> +			    &td->reg_init_uV);
> +	if (!ret) {
> +		dev_err(td->dev, "couldn't get initialized voltage\n");
> +		return ret;
> +	}
> +
> +	ret = read_dt_param(td, "nvidia,pwm-period", &pwm_period);
> +	if (!ret) {
> +		dev_err(td->dev, "couldn't get PWM period\n");
>  		return ret;
>  	}
> +	td->pwm_rate = (NSEC_PER_SEC / pwm_period) * (MAX_DFLL_VOLTAGES - 1);
> +
> +	td->pwm_pin = devm_pinctrl_get(td->dev);
> +	if (IS_ERR(td->pwm_pin)) {
> +		dev_err(td->dev, "DT: missing pinctrl device\n");
> +		return PTR_ERR(td->pwm_pin);
> +	}
> +
> +	td->pwm_enable_state = pinctrl_lookup_state(td->pwm_pin,
> +						    "dvfs_pwm_enable");
> +	if (IS_ERR(td->pwm_enable_state)) {
> +		dev_err(td->dev, "DT: missing pwm enabled state\n");
> +		return PTR_ERR(td->pwm_enable_state);
> +	}
> +
> +	td->pwm_disable_state = pinctrl_lookup_state(td->pwm_pin,
> +						     "dvfs_pwm_disable");
> +	if (IS_ERR(td->pwm_disable_state)) {
> +		dev_err(td->dev, "DT: missing pwm disabled state\n");
> +		return PTR_ERR(td->pwm_disable_state);
> +	}
>  
>  	return 0;
>  }
> @@ -1597,16 +1900,6 @@ int tegra_dfll_register(struct platform_device *pdev,
>  
>  	td->soc = soc;
>  
> -	td->vdd_reg = devm_regulator_get(td->dev, "vdd-cpu");
> -	if (IS_ERR(td->vdd_reg)) {
> -		ret = PTR_ERR(td->vdd_reg);
> -		if (ret != -EPROBE_DEFER)
> -			dev_err(td->dev, "couldn't get vdd_cpu regulator: %d\n",
> -				ret);
> -
> -		return ret;
> -	}
> -
>  	td->dvco_rst = devm_reset_control_get(td->dev, "dvco");
>  	if (IS_ERR(td->dvco_rst)) {
>  		dev_err(td->dev, "couldn't get dvco reset\n");
> @@ -1619,10 +1912,27 @@ int tegra_dfll_register(struct platform_device *pdev,
>  		return ret;
>  	}
>  
> -	ret = dfll_fetch_i2c_params(td);
> +	if (of_property_read_bool(td->dev->of_node, "nvidia,pwm-to-pmic")) {
> +		td->pmu_if = TEGRA_DFLL_PMU_PWM;
> +		ret = dfll_fetch_pwm_params(td);
> +	} else  {
> +		td->vdd_reg = devm_regulator_get(td->dev, "vdd-cpu");
> +		if (IS_ERR(td->vdd_reg)) {
> +			dev_err(td->dev, "couldn't get vdd_cpu regulator\n");
> +			return PTR_ERR(td->vdd_reg);
> +		}
> +		td->pmu_if = TEGRA_DFLL_PMU_I2C;
> +		ret = dfll_fetch_i2c_params(td);
> +	}
>  	if (ret)
>  		return ret;
>  
> +	ret = dfll_build_lut(td);
> +	if (ret) {
> +		dev_err(td->dev, "couldn't build LUT\n");
> +		return ret;
> +	}
> +
>  	mem = platform_get_resource(pdev, IORESOURCE_MEM, 0);
>  	if (!mem) {
>  		dev_err(td->dev, "no control register resource\n");
> 

Acked-by: Jon Hunter <jonathanh@nvidia.com>

Cheers
Jon

-- 
nvpublic

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
