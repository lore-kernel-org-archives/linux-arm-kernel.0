Return-Path: <SRS0=cUnb=OQ=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,T_DKIMWL_WL_HIGH,URIBL_BLOCKED autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 81E35C07E85
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri,  7 Dec 2018 15:09:29 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4D534208E7
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri,  7 Dec 2018 15:09:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="X5qGhecY";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=nvidia.com header.i=@nvidia.com header.b="LXYJjPhi"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4D534208E7
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=nvidia.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:Date:
	Message-ID:From:References:To:Subject:Reply-To:Content-ID:Content-Description
	:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=gQwsNKIfqyuiZ41zWl6IWbNcT2PaeyOG0eYGubIu4oE=; b=X5qGhecYpL7SK4
	+FLzABcZ8T5r5W/cThZ5ux0VrU1Rb/rzPfH56i2dqdLfZZJKJmdfYY2zfYpJN62gC9bpKElxf6I6p
	L2YAMPfogQ+XzGceF1Ji7sHSW9Xzu5xLiQAWqpCrcPYMeoxt76fri6c1RIJKtUPpMC7esjUp5CLIo
	mTxSdb/CNSFUMEMXSemslJte/TqO0MvIjWhElDp6vpsliCU0ZFZ3ZBB/1xvtXk9SwryAHlLY3caJP
	NN1AfmHRcDd8jCQFnS3LJDxm5LnHax4VqlUHf/oZaHB3rTcyk0ho9fqwDiPB2+uZvPwxQwKKFE0RY
	kJ+pduH6Nu62iECximgA==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gVHkt-0004bM-9N; Fri, 07 Dec 2018 15:09:27 +0000
Received: from hqemgate14.nvidia.com ([216.228.121.143])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gVHkq-0004as-Bb
 for linux-arm-kernel@lists.infradead.org; Fri, 07 Dec 2018 15:09:25 +0000
Received: from hqpgpgate101.nvidia.com (Not Verified[216.228.121.13]) by
 hqemgate14.nvidia.com (using TLS: TLSv1.2, DES-CBC3-SHA)
 id <B5c0a8d180000>; Fri, 07 Dec 2018 07:09:12 -0800
Received: from hqmail.nvidia.com ([172.20.161.6])
 by hqpgpgate101.nvidia.com (PGP Universal service);
 Fri, 07 Dec 2018 07:09:13 -0800
X-PGP-Universal: processed;
 by hqpgpgate101.nvidia.com on Fri, 07 Dec 2018 07:09:13 -0800
Received: from [10.21.132.148] (172.20.13.39) by HQMAIL101.nvidia.com
 (172.20.187.10) with Microsoft SMTP Server (TLS) id 15.0.1395.4; Fri, 7 Dec
 2018 15:09:11 +0000
Subject: Re: [PATCH 07/19] clk: tegra: dfll: support PWM regulator control
To: Joseph Lo <josephl@nvidia.com>, Thierry Reding <thierry.reding@gmail.com>, 
 Peter De Schrijver <pdeschrijver@nvidia.com>
References: <20181204092548.3038-1-josephl@nvidia.com>
 <20181204092548.3038-8-josephl@nvidia.com>
From: Jon Hunter <jonathanh@nvidia.com>
Message-ID: <3d0f52c6-770e-bae2-2396-87f32455b807@nvidia.com>
Date: Fri, 7 Dec 2018 15:09:10 +0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.2.1
MIME-Version: 1.0
In-Reply-To: <20181204092548.3038-8-josephl@nvidia.com>
X-Originating-IP: [172.20.13.39]
X-ClientProxiedBy: HQMAIL103.nvidia.com (172.20.187.11) To
 HQMAIL101.nvidia.com (172.20.187.10)
Content-Language: en-US
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
 t=1544195352; bh=2x7bZt8GSoQR3uBzsKhizepBJolZFWbuCCVzjpauSqc=;
 h=X-PGP-Universal:Subject:To:CC:References:From:Message-ID:Date:
 User-Agent:MIME-Version:In-Reply-To:X-Originating-IP:
 X-ClientProxiedBy:Content-Type:Content-Language:
 Content-Transfer-Encoding;
 b=LXYJjPhiEYRayFT78GspAcY6vLak5uyTzGaMtU5isJqZ1aRu4f0dAx2NqGJ+glL37
 QT3QUShStGBesar/GMrTrhqb70FsXC5Q++aZ4DhABdtuUFBYX66jFBOXsw2p3k62gZ
 iCpbbIjx4kCQNsWdxwn3uvFnJhUWcIJYJgpXVvQxv6WnWfFCqblsvG/3Lv+u+jc8Mq
 MbCaj353fH9LS7kgKzZJfUSgh2oJscYLSrGPG0Ncju60dcuewvOKcQ22B3M8LTSVe9
 Pqpv7GAn5Rc4Y602Bi2n3ClaQVfxZYAHsTLWSsETp7RjiizNKUKwZnGtmwXFxWh2cu
 2aOvw5jGBKT4Q==
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20181207_070924_408648_FD3D139D 
X-CRM114-Status: GOOD (  21.63  )
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


On 04/12/2018 09:25, Joseph Lo wrote:
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
> +/*
> + * DVCO rate control
> + */
> +
> +static unsigned long get_dvco_rate_below(struct tegra_dfll *td, u8 out_min)
> +{
> +	struct dev_pm_opp *opp;
> +	unsigned long rate, prev_rate;
> +	int uv, min_uv;
> +
> +	min_uv = td->lut_uv[out_min];
> +	for (rate = 0, prev_rate = 0; ; rate++) {
> +		opp = dev_pm_opp_find_freq_ceil(td->soc->dev, &rate);
> +		if (IS_ERR(opp))
> +			break;
> +
> +		uv = dev_pm_opp_get_voltage(opp);

Can you fix the type of 'uv' here? It should be unsigned long.

Cheers
Jon

-- 
nvpublic

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
