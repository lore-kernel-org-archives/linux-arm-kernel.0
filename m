Return-Path: <SRS0=qRPW=OW=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,T_MIXED_ES autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5DDAEC65BAE
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Thu, 13 Dec 2018 11:18:50 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 28C3B2086D
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Thu, 13 Dec 2018 11:18:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="G76pePAA";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=nvidia.com header.i=@nvidia.com header.b="bVQGHAe+"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 28C3B2086D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=nvidia.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:Date:
	Message-ID:From:References:To:Subject:Reply-To:Content-ID:Content-Description
	:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=dRuO3/395+rEeAecSOiM9SFHsJKnvyLEWse7tEUEiSo=; b=G76pePAAyNLo1r
	TD56wLW5zL9Kq2yqleexGIg85kVJc7m/NtcuOoOH7FL0ozwbPdZvzyG3uEiFTps+EIqXHfBgv+uyW
	BpQ+AFWrJZBvZlEwbMlarRzLtI592OP64sxAc+lQ9BX0bn5M7KEzmKvNEn0cYAOcVfAhfKz7/p6z6
	BaQP9TipGibGvJJlbosGT86kjF2f8f8XmOA2Uj2WEnWZnc1lRbBTo9bXhFJDARSO4Y+FpkaK97Y+X
	VQu2kw0sP2/Tf/NnvJNbwZwvDmB/mnytSdAuHtJ4qEaghzY2XSYqcH99r01xaxxSEjSSrTgCo7QDj
	JyP+2iWhtTb8HGteOwSA==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gXP0q-00088Y-SK; Thu, 13 Dec 2018 11:18:40 +0000
Received: from hqemgate14.nvidia.com ([216.228.121.143])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gXP0n-00086z-AQ
 for linux-arm-kernel@lists.infradead.org; Thu, 13 Dec 2018 11:18:38 +0000
Received: from hqpgpgate102.nvidia.com (Not Verified[216.228.121.13]) by
 hqemgate14.nvidia.com (using TLS: TLSv1.2, DES-CBC3-SHA)
 id <B5c123ffc0001>; Thu, 13 Dec 2018 03:18:20 -0800
Received: from hqmail.nvidia.com ([172.20.161.6])
 by hqpgpgate102.nvidia.com (PGP Universal service);
 Thu, 13 Dec 2018 03:18:24 -0800
X-PGP-Universal: processed;
 by hqpgpgate102.nvidia.com on Thu, 13 Dec 2018 03:18:24 -0800
Received: from [10.26.11.125] (172.20.13.39) by HQMAIL101.nvidia.com
 (172.20.187.10) with Microsoft SMTP Server (TLS) id 15.0.1395.4; Thu, 13 Dec
 2018 11:18:22 +0000
Subject: Re: [PATCH V2 06/21] clk: tegra: dfll: CVB calculation alignment with
 the regulator
To: Joseph Lo <josephl@nvidia.com>, Thierry Reding <thierry.reding@gmail.com>, 
 Peter De Schrijver <pdeschrijver@nvidia.com>
References: <20181213093438.29621-1-josephl@nvidia.com>
 <20181213093438.29621-7-josephl@nvidia.com>
From: Jon Hunter <jonathanh@nvidia.com>
Message-ID: <ce41aec0-64a7-03ca-e6ce-80c0c58e5a7d@nvidia.com>
Date: Thu, 13 Dec 2018 11:18:20 +0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.2.1
MIME-Version: 1.0
In-Reply-To: <20181213093438.29621-7-josephl@nvidia.com>
X-Originating-IP: [172.20.13.39]
X-ClientProxiedBy: HQMAIL103.nvidia.com (172.20.187.11) To
 HQMAIL101.nvidia.com (172.20.187.10)
Content-Language: en-US
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
 t=1544699900; bh=Vbz3tmjdFwpJvmZ+jlw3DUWSkr7W5Hizzlsxesx0A30=;
 h=X-PGP-Universal:Subject:To:CC:References:From:Message-ID:Date:
 User-Agent:MIME-Version:In-Reply-To:X-Originating-IP:
 X-ClientProxiedBy:Content-Type:Content-Language:
 Content-Transfer-Encoding;
 b=bVQGHAe+Q/IEcJx8YOIsZtQcCN3AADjH64RnsO1rIM3Cox33TrKhpJjuS9IXF7SnK
 2+Z/No6ITCJOUotoYtDXHqrlZbDyxLJ0R/Fw2o9MeTJaIXTVzcWdnB2SdTqov+fOcf
 eWrRn6T7dLf18prbfA+1KJj8kFwdTsXoddBQTbUJWaER/aK8Fbzg7NPbp2eIVfTRuX
 CnGzTpZsPyClJ8TlBmfF7eYuFRoLPq0U3+cOPxS/hSnsqOQQZGwl4ldzPv4s5OFxXR
 UGzDP8t7qX/5CqCRlWyyNWYG7tqrUvS6/J55onwAwcNcI32d0JsetHUx4HHx0RRmA9
 j14Q+U9l1z9Zw==
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20181213_031837_367009_A0543E47 
X-CRM114-Status: GOOD (  22.36  )
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


On 13/12/2018 09:34, Joseph Lo wrote:
> The CVB table contains calibration data for the CPU DFLL based on
> process characterization. The regulator step and offset parameters depend
> on the regulator supplying vdd-cpu, not on the specific Tegra SKU.
> 
> When using a PWM controlled regulator, the voltage step and offset are
> determined by the regulator type in use. This is specified in DT. When
> using an I2C controlled regulator, we can retrieve them from CPU regulator
> Then pass this information to the CVB table calculation function.
> 
> Based on the work done of "Peter De Schrijver <pdeschrijver@nvidia.com>"
> and "Alex Frid <afrid@nvidia.com>".
> 
> Signed-off-by: Joseph Lo <josephl@nvidia.com>
> ---
> *V2:
>  - use the updated DT binding string for parsing
>  - update the mechanism for geting regulator data from DT (PWM mode) or
>  regulator (I2C mode)
> ---
>  drivers/clk/tegra/clk-dfll.h               |  6 ++-
>  drivers/clk/tegra/clk-tegra124-dfll-fcpu.c | 57 ++++++++++++++++++++--
>  drivers/clk/tegra/cvb.c                    | 12 +++--
>  drivers/clk/tegra/cvb.h                    |  6 +--
>  4 files changed, 67 insertions(+), 14 deletions(-)
> 
> diff --git a/drivers/clk/tegra/clk-dfll.h b/drivers/clk/tegra/clk-dfll.h
> index 83352c8078f2..ecc43cb9b6f1 100644
> --- a/drivers/clk/tegra/clk-dfll.h
> +++ b/drivers/clk/tegra/clk-dfll.h
> @@ -1,6 +1,6 @@
>  /*
>   * clk-dfll.h - prototypes and macros for the Tegra DFLL clocksource driver
> - * Copyright (C) 2013 NVIDIA Corporation.  All rights reserved.
> + * Copyright (C) 2013-2018 NVIDIA Corporation.  All rights reserved.
>   *
>   * Aleksandr Frid <afrid@nvidia.com>
>   * Paul Walmsley <pwalmsley@nvidia.com>
> @@ -22,11 +22,14 @@
>  #include <linux/reset.h>
>  #include <linux/types.h>
>  
> +#include "cvb.h"
> +
>  /**
>   * struct tegra_dfll_soc_data - SoC-specific hooks/integration for the DFLL driver
>   * @dev: struct device * that holds the OPP table for the DFLL
>   * @max_freq: maximum frequency supported on this SoC
>   * @cvb: CPU frequency table for this SoC
> + * @alignment: parameters of the regulator step and offset
>   * @init_clock_trimmers: callback to initialize clock trimmers
>   * @set_clock_trimmers_high: callback to tune clock trimmers for high voltage
>   * @set_clock_trimmers_low: callback to tune clock trimmers for low voltage
> @@ -35,6 +38,7 @@ struct tegra_dfll_soc_data {
>  	struct device *dev;
>  	unsigned long max_freq;
>  	const struct cvb_table *cvb;
> +	struct rail_alignment alignment;
>  
>  	void (*init_clock_trimmers)(void);
>  	void (*set_clock_trimmers_high)(void);
> diff --git a/drivers/clk/tegra/clk-tegra124-dfll-fcpu.c b/drivers/clk/tegra/clk-tegra124-dfll-fcpu.c
> index 1a2cc113e5c8..189b5e20ee4e 100644
> --- a/drivers/clk/tegra/clk-tegra124-dfll-fcpu.c
> +++ b/drivers/clk/tegra/clk-tegra124-dfll-fcpu.c
> @@ -23,6 +23,7 @@
>  #include <linux/init.h>
>  #include <linux/of_device.h>
>  #include <linux/platform_device.h>
> +#include <linux/regulator/consumer.h>
>  #include <soc/tegra/fuse.h>
>  
>  #include "clk.h"
> @@ -50,9 +51,6 @@ static const struct cvb_table tegra124_cpu_cvb_tables[] = {
>  		.process_id = -1,
>  		.min_millivolts = 900,
>  		.max_millivolts = 1260,
> -		.alignment = {
> -			.step_uv = 10000, /* 10mV */
> -		},
>  		.speedo_scale = 100,
>  		.voltage_scale = 1000,
>  		.entries = {
> @@ -105,11 +103,45 @@ static const struct of_device_id tegra124_dfll_fcpu_of_match[] = {
>  	{ },
>  };
>  
> +static void get_alignment_from_dt(struct device *dev,
> +				  struct rail_alignment *align)
> +{
> +	align->step_uv = 0;
> +	align->offset_uv = 0;
> +
> +	if (of_property_read_u32(dev->of_node,
> +				 "nvidia,pwm-voltage-step-microvolts",
> +				 &align->step_uv))
> +		align->step_uv = 0;

Not sure why it is necessary to initialise this again on failure.

> +
> +	if (of_property_read_u32(dev->of_node,
> +				 "nvidia,pwm-min-microvolts",
> +				 &align->offset_uv))
> +		align->offset_uv = 0;

Same here.

> +}
> +
> +static int get_alignment_from_regulator(struct device *dev,
> +					 struct rail_alignment *align)
> +{
> +	struct regulator *reg = devm_regulator_get(dev, "vdd-cpu");
> +
> +	if (IS_ERR(reg))
> +		return PTR_ERR(reg);
> +
> +	align->offset_uv = regulator_list_voltage(reg, 0);
> +	align->step_uv = regulator_get_linear_step(reg);
> +
> +	devm_regulator_put(reg);
> +
> +	return 0;
> +}
> +
>  static int tegra124_dfll_fcpu_probe(struct platform_device *pdev)
>  {
>  	int process_id, speedo_id, speedo_value, err;
>  	struct tegra_dfll_soc_data *soc;
>  	const struct dfll_fcpu_data *fcpu_data;
> +	struct rail_alignment align;
>  
>  	fcpu_data = of_device_get_match_data(&pdev->dev);
>  	if (!fcpu_data)
> @@ -135,12 +167,27 @@ static int tegra124_dfll_fcpu_probe(struct platform_device *pdev)
>  		return -ENODEV;
>  	}
>  
> +	if (of_property_read_bool(pdev->dev.of_node, "nvidia,pwm-to-pmic")) {
> +		get_alignment_from_dt(&pdev->dev, &align);
> +	} else {
> +		err = get_alignment_from_regulator(&pdev->dev, &align);
> +		if (err == -EPROBE_DEFER)
> +			return -EPROBE_DEFER;

Why not return any error here? The print below maybe misleading.

> +	}
> +
> +	if (!align.step_uv) {
> +		dev_err(&pdev->dev, "missing step uv\n");
> +		return -EINVAL;
> +	}
> +

Cheers
Jon

-- 
nvpublic

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
