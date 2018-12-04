Return-Path: <SRS0=gVCq=ON=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DA4F9C04EB8
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Tue,  4 Dec 2018 15:54:09 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id AB8D120672
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Tue,  4 Dec 2018 15:54:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="oeLHm8ac";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=nvidia.com header.i=@nvidia.com header.b="qm/m46v+"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AB8D120672
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=nvidia.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:
	Message-ID:Subject:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=H7Kb6Ws2OEgzl9jTPjCJXiZAvsn4qj7ekkJXfCkEG/Q=; b=oeLHm8acKpujAu
	dXWgKHvtsiWyYe/AWwKtdIGtvnpLiXT1Ym26uxykdcfRkfahjUI7iVIoFxNlBPPSmgTDrDtYZKiKJ
	mfTJ+KyL2AmGbkUZ2SsXhsGhoJ171ST1n6FZ+P4YzGGYMSw1HUA8pgwRUyd3sfnHe989tG8TCSSQ6
	SGXFeCaxPcgOEaGkrhSS00xEozZID7HuicOgvwssCchek1jt+8lQLutiz4gHNEOIEaJ+4wysEAzn0
	dcNaxbu2ruE1DmE4hFb62IqWrUDa5XjwTNeSJyI8PVFvZSlO1lfU5x8P/n1oBCjdZyyhvAwKZVqqs
	HC2YNCgnkS9YMeDKCK2g==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gUD1T-0000N1-SO; Tue, 04 Dec 2018 15:54:07 +0000
Received: from hqemgate15.nvidia.com ([216.228.121.64])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gUD1Q-0000MQ-HE
 for linux-arm-kernel@lists.infradead.org; Tue, 04 Dec 2018 15:54:06 +0000
Received: from hqpgpgate101.nvidia.com (Not Verified[216.228.121.13]) by
 hqemgate15.nvidia.com (using TLS: TLSv1.2, DES-CBC3-SHA)
 id <B5c06a3100000>; Tue, 04 Dec 2018 07:53:52 -0800
Received: from hqmail.nvidia.com ([172.20.161.6])
 by hqpgpgate101.nvidia.com (PGP Universal service);
 Tue, 04 Dec 2018 07:53:54 -0800
X-PGP-Universal: processed;
 by hqpgpgate101.nvidia.com on Tue, 04 Dec 2018 07:53:54 -0800
Received: from tbergstrom-lnx.Nvidia.com (10.124.1.5) by HQMAIL101.nvidia.com
 (172.20.187.10) with Microsoft SMTP Server (TLS) id 15.0.1395.4;
 Tue, 4 Dec 2018 15:53:53 +0000
Received: by tbergstrom-lnx.Nvidia.com (Postfix, from userid 1000)
 id 4D13B407B1; Tue,  4 Dec 2018 17:53:51 +0200 (EET)
Date: Tue, 4 Dec 2018 17:53:51 +0200
From: Peter De Schrijver <pdeschrijver@nvidia.com>
To: Joseph Lo <josephl@nvidia.com>
Subject: Re: [PATCH 07/19] clk: tegra: dfll: support PWM regulator control
Message-ID: <20181204155351.GD26056@pdeschrijver-desktop.Nvidia.com>
References: <20181204092548.3038-1-josephl@nvidia.com>
 <20181204092548.3038-8-josephl@nvidia.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20181204092548.3038-8-josephl@nvidia.com>
X-NVConfidentiality: public
User-Agent: Mutt/1.9.4 (2018-02-28)
X-Originating-IP: [10.124.1.5]
X-ClientProxiedBy: HQMAIL101.nvidia.com (172.20.187.10) To
 HQMAIL101.nvidia.com (172.20.187.10)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
 t=1543938832; bh=+xK3964oEOfajkTiLiKhdTiSfIMslNMhfSxOJRM3UPs=;
 h=X-PGP-Universal:Date:From:To:CC:Subject:Message-ID:References:
 MIME-Version:Content-Type:Content-Disposition:In-Reply-To:
 X-NVConfidentiality:User-Agent:X-Originating-IP:X-ClientProxiedBy;
 b=qm/m46v+wkZ6JB88OAxtEGeEcO8jCt4hQS4QwqHiJ7LeTmpDBHRjP9wEBqL9OdrBh
 dcoBOYlB21898rhB46FpIwgVBkqB9OUlIMo62KtEvBflkBaEkfU5MafwVuImwHOfSC
 Cqir0NJkcE3jBBNWr1Sed9jqENJuO4ZuDayVwC/1o2uael7Fl9y8ZAmaAhl9wjWbNV
 T0d39Au23s0DweAwk4IlsTXEPa+1RgwhsWP7jBYF0/vto4Lb88PyGCixUz5SGw6nz1
 F/JG1gk+8q0dPjFveW7MnNpAsKV30Yb8RHMxZLK79S+nw7uCVHkAmAYRutzI68UvHJ
 ycZcER0Bheteg==
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20181204_075404_584683_705628D4 
X-CRM114-Status: GOOD (  25.59  )
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
Cc: linux-tegra@vger.kernel.org, Thierry Reding <thierry.reding@gmail.com>,
 linux-clk@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 Jonathan Hunter <jonathanh@nvidia.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

On Tue, Dec 04, 2018 at 05:25:36PM +0800, Joseph Lo wrote:
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
>  drivers/clk/tegra/clk-dfll.c | 431 ++++++++++++++++++++++++++++++-----
>  1 file changed, 368 insertions(+), 63 deletions(-)
> 
> diff --git a/drivers/clk/tegra/clk-dfll.c b/drivers/clk/tegra/clk-dfll.c
> index 609e363dabf8..c294a2989f31 100644
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
> @@ -294,16 +301,25 @@ struct tegra_dfll {
>  	u32				ci;
>  	u32				cg;
>  	bool				cg_scale;
> +	u32				reg_init_uV;
>  
>  	/* I2C interface parameters */
>  	u32				i2c_fs_rate;
>  	u32				i2c_reg;
>  	u32				i2c_slave_addr;
>  
> -	/* i2c_lut array entries are regulator framework selectors */
> -	unsigned			i2c_lut[MAX_DFLL_VOLTAGES];
> -	int				i2c_lut_size;
> -	u8				lut_min, lut_max, lut_safe;
> +	/* lut array entries are regulator framework selectors or PWM values*/
> +	unsigned			lut[MAX_DFLL_VOLTAGES];
> +	unsigned			lut_uv[MAX_DFLL_VOLTAGES];
> +	int				lut_size;
> +	u8				lut_bottom, lut_min, lut_max, lut_safe;
> +
> +	/* PWM interface */
> +	enum tegra_dfll_pmu_if		pmu_if;
> +	unsigned long			pwm_rate;
> +	struct pinctrl			*pwm_pin;
> +	struct pinctrl_state		*pwm_enable_state;
> +	struct pinctrl_state		*pwm_disable_state;
>  };
>  
>  #define clk_hw_to_dfll(_hw) container_of(_hw, struct tegra_dfll, dfll_clk_hw)
> @@ -489,6 +505,34 @@ static void dfll_set_mode(struct tegra_dfll *td,
>  	dfll_wmb(td);
>  }
>  
...

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
> +		int vinit = td->reg_init_uV;
> +		int vstep = td->soc->alignment.step_uv;
> +		int vmin = td->lut_uv[0];
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
> @@ -640,8 +813,8 @@ static int find_lut_index_for_rate(struct tegra_dfll *td, unsigned long rate)
>  	uv = dev_pm_opp_get_voltage(opp);
>  	dev_pm_opp_put(opp);
>  
> -	for (i = 0; i < td->i2c_lut_size; i++) {
> -		if (regulator_list_voltage(td->vdd_reg, td->i2c_lut[i]) == uv)
> +	for (i = td->lut_bottom; i < td->lut_size; i++) {
> +		if (regulator_list_voltage(td->vdd_reg, td->lut[i]) == uv)

Use td->lut_uv[] here, so it will also work for PWM regulators. Also
change == to >= because the exact OPP voltage may not be available. In
the next patch the rounding can then be fixed.

Cheers,

Peter.

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
