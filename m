Return-Path: <SRS0=cUnb=OQ=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,T_DKIMWL_WL_HIGH autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AEACAC07E85
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri,  7 Dec 2018 13:55:51 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7ED6620837
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri,  7 Dec 2018 13:55:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="q+V2UdV4";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=nvidia.com header.i=@nvidia.com header.b="gDGPUByz"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7ED6620837
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=nvidia.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:Date:
	Message-ID:From:References:To:Subject:Reply-To:Content-ID:Content-Description
	:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=Axap3+Fs577yY/bKE5a6JBFXNSRwfEEnrUnZmfYmtzA=; b=q+V2UdV49Ep6XF
	rNJnU0nb09Ute70iKumRFFmKnEkwXn/w3E7Zsi63mqwnFMtTCB2RSPo/85jwZX5NN8bsRMatSLEhV
	OyQAHVyCjtzpE70Y5Vn5JHWqHACiujhHmArdImQcONKMixf16XANk2oKUM8y6XXabbfKmkflCVUvf
	i19MKZkJTWjMNdiuXeDpaFzkvaQdJjsPuRxqI3EWXffkQ9Lb1x8LSwsWCtqne3MhLBrpgB4DajrrC
	J2196o7UbZgAWFSUOVbsAvtTscjnxAqTNzJ/36KYJ3TBCKl+/r9kEJlifRDlucSO4ISgMED4rUSkE
	Zegm7Qj5SDvgupNzLHlw==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gVGbe-0006bl-1i; Fri, 07 Dec 2018 13:55:50 +0000
Received: from hqemgate16.nvidia.com ([216.228.121.65])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gVGbX-0006ao-El
 for linux-arm-kernel@lists.infradead.org; Fri, 07 Dec 2018 13:55:47 +0000
Received: from hqpgpgate102.nvidia.com (Not Verified[216.228.121.13]) by
 hqemgate16.nvidia.com (using TLS: TLSv1.2, DES-CBC3-SHA)
 id <B5c0a7bd40000>; Fri, 07 Dec 2018 05:55:32 -0800
Received: from hqmail.nvidia.com ([172.20.161.6])
 by hqpgpgate102.nvidia.com (PGP Universal service);
 Fri, 07 Dec 2018 05:55:33 -0800
X-PGP-Universal: processed;
 by hqpgpgate102.nvidia.com on Fri, 07 Dec 2018 05:55:33 -0800
Received: from [10.21.132.148] (10.124.1.5) by HQMAIL101.nvidia.com
 (172.20.187.10) with Microsoft SMTP Server (TLS) id 15.0.1395.4; Fri, 7 Dec
 2018 13:55:31 +0000
Subject: Re: [PATCH 05/19] clk: tegra: dfll: registration for multiple SoCs
To: Joseph Lo <josephl@nvidia.com>, Thierry Reding <thierry.reding@gmail.com>, 
 Peter De Schrijver <pdeschrijver@nvidia.com>
References: <20181204092548.3038-1-josephl@nvidia.com>
 <20181204092548.3038-6-josephl@nvidia.com>
From: Jon Hunter <jonathanh@nvidia.com>
Message-ID: <23a72c57-cbb2-5c4e-eebb-1ad4ba7e2dc8@nvidia.com>
Date: Fri, 7 Dec 2018 13:55:29 +0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.2.1
MIME-Version: 1.0
In-Reply-To: <20181204092548.3038-6-josephl@nvidia.com>
X-Originating-IP: [10.124.1.5]
X-ClientProxiedBy: HQMAIL105.nvidia.com (172.20.187.12) To
 HQMAIL101.nvidia.com (172.20.187.10)
Content-Language: en-US
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
 t=1544190932; bh=AxG+CNpAk3aWS/K2YEG/RX+VzW8Sw1XPjEuwWtNIrJo=;
 h=X-PGP-Universal:Subject:To:CC:References:From:Message-ID:Date:
 User-Agent:MIME-Version:In-Reply-To:X-Originating-IP:
 X-ClientProxiedBy:Content-Type:Content-Language:
 Content-Transfer-Encoding;
 b=gDGPUByzuvDIkw5QavU53nmrYyuWwf49Xp9uMILdhKXV7WawTBrgXKl54SLFwfPZv
 ReGhrzVgHw/mKTF86fow3v4cPa7hyaoEgbB6EjQDF3/4IG/meGEcsl1JDALcqrp61s
 OD2P7BobUqu62zBqQPHqn0Vg9NDYuP5B1096GqgWZlsNLSTad9VhmQNqFeNS+VVWtg
 WbcHsMWpbYA2McO87mEPjH7TMsZSgpFras5uO3s/WrZ/9Y4cn5aH2QrJFhwsAzzUIt
 upPOS8d6Ei5w/hWo9D2i4KxqHyKXLLRVVr5y4Q/VhOrJevP+PQdu6+0Q/kVpIsk7xt
 RcfcqH68zR/pQ==
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20181207_055546_179735_F41489F6 
X-CRM114-Status: GOOD (  16.85  )
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
> From: Peter De Schrijver <pdeschrijver@nvidia.com>
> 
> In a future patch, support for the DFLL in Tegra210 will be introduced.
> This requires support for more than 1 set of CVB and CPU max frequency
> tables.
> 
> Signed-off-by: Peter De Schrijver <pdeschrijver@nvidia.com>
> Signed-off-by: Joseph Lo <josephl@nvidia.com>
> ---
>  drivers/clk/tegra/clk-tegra124-dfll-fcpu.c | 45 ++++++++++++++++------
>  1 file changed, 34 insertions(+), 11 deletions(-)
> 
> diff --git a/drivers/clk/tegra/clk-tegra124-dfll-fcpu.c b/drivers/clk/tegra/clk-tegra124-dfll-fcpu.c
> index 269d3595758b..1a2cc113e5c8 100644
> --- a/drivers/clk/tegra/clk-tegra124-dfll-fcpu.c
> +++ b/drivers/clk/tegra/clk-tegra124-dfll-fcpu.c
> @@ -1,7 +1,7 @@
>  /*
>   * Tegra124 DFLL FCPU clock source driver
>   *
> - * Copyright (C) 2012-2014 NVIDIA Corporation.  All rights reserved.
> + * Copyright (C) 2012-2018 NVIDIA Corporation.  All rights reserved.
>   *
>   * Aleksandr Frid <afrid@nvidia.com>
>   * Paul Walmsley <pwalmsley@nvidia.com>
> @@ -21,6 +21,7 @@
>  #include <linux/err.h>
>  #include <linux/kernel.h>
>  #include <linux/init.h>
> +#include <linux/of_device.h>
>  #include <linux/platform_device.h>
>  #include <soc/tegra/fuse.h>
>  
> @@ -28,8 +29,15 @@
>  #include "clk-dfll.h"
>  #include "cvb.h"
>  
> +struct dfll_fcpu_data {
> +	const unsigned long *cpu_max_freq_table;
> +	unsigned int cpu_max_freq_table_size;
> +	const struct cvb_table *cpu_cvb_tables;
> +	unsigned int cpu_cvb_tables_size;
> +};
> +
>  /* Maximum CPU frequency, indexed by CPU speedo id */
> -static const unsigned long cpu_max_freq_table[] = {
> +static const unsigned long tegra124_cpu_max_freq_table[] = {
>  	[0] = 2014500000UL,
>  	[1] = 2320500000UL,
>  	[2] = 2116500000UL,
> @@ -82,16 +90,36 @@ static const struct cvb_table tegra124_cpu_cvb_tables[] = {
>  	},
>  };
>  
> +static const struct dfll_fcpu_data tegra124_dfll_fcpu_data = {
> +	.cpu_max_freq_table = tegra124_cpu_max_freq_table,
> +	.cpu_max_freq_table_size = ARRAY_SIZE(tegra124_cpu_max_freq_table),
> +	.cpu_cvb_tables = tegra124_cpu_cvb_tables,
> +	.cpu_cvb_tables_size = ARRAY_SIZE(tegra124_cpu_cvb_tables)
> +};
> +
> +static const struct of_device_id tegra124_dfll_fcpu_of_match[] = {
> +	{
> +		.compatible = "nvidia,tegra124-dfll",
> +		.data = &tegra124_dfll_fcpu_data,
> +	},
> +	{ },
> +};
> +
>  static int tegra124_dfll_fcpu_probe(struct platform_device *pdev)
>  {
>  	int process_id, speedo_id, speedo_value, err;
>  	struct tegra_dfll_soc_data *soc;
> +	const struct dfll_fcpu_data *fcpu_data;
> +
> +	fcpu_data = of_device_get_match_data(&pdev->dev);
> +	if (!fcpu_data)
> +		return -ENODEV;
>  
>  	process_id = tegra_sku_info.cpu_process_id;
>  	speedo_id = tegra_sku_info.cpu_speedo_id;
>  	speedo_value = tegra_sku_info.cpu_speedo_value;
>  
> -	if (speedo_id >= ARRAY_SIZE(cpu_max_freq_table)) {
> +	if (speedo_id >= fcpu_data->cpu_max_freq_table_size) {
>  		dev_err(&pdev->dev, "unknown max CPU freq for speedo_id=%d\n",
>  			speedo_id);
>  		return -ENODEV;
> @@ -107,10 +135,10 @@ static int tegra124_dfll_fcpu_probe(struct platform_device *pdev)
>  		return -ENODEV;
>  	}
>  
> -	soc->max_freq = cpu_max_freq_table[speedo_id];
> +	soc->max_freq = fcpu_data->cpu_max_freq_table[speedo_id];
>  
> -	soc->cvb = tegra_cvb_add_opp_table(soc->dev, tegra124_cpu_cvb_tables,
> -					   ARRAY_SIZE(tegra124_cpu_cvb_tables),
> +	soc->cvb = tegra_cvb_add_opp_table(soc->dev, fcpu_data->cpu_cvb_tables,
> +					   fcpu_data->cpu_cvb_tables_size,
>  					   process_id, speedo_id, speedo_value,
>  					   soc->max_freq);
>  	if (IS_ERR(soc->cvb)) {
> @@ -142,11 +170,6 @@ static int tegra124_dfll_fcpu_remove(struct platform_device *pdev)
>  	return 0;
>  }
>  
> -static const struct of_device_id tegra124_dfll_fcpu_of_match[] = {
> -	{ .compatible = "nvidia,tegra124-dfll", },
> -	{ },
> -};
> -
>  static const struct dev_pm_ops tegra124_dfll_pm_ops = {
>  	SET_RUNTIME_PM_OPS(tegra_dfll_runtime_suspend,
>  			   tegra_dfll_runtime_resume, NULL)
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
