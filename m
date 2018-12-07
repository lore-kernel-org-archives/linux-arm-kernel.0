Return-Path: <SRS0=cUnb=OQ=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,T_DKIMWL_WL_HIGH autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 27BD5C64EB1
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri,  7 Dec 2018 14:50:03 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E9B8020882
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri,  7 Dec 2018 14:50:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="isacK9iI";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=nvidia.com header.i=@nvidia.com header.b="B7lEwn49"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E9B8020882
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=nvidia.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:Date:
	Message-ID:From:References:To:Subject:Reply-To:Content-ID:Content-Description
	:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=GZH1l3U8PEOfyc41lyeg4/EKLl0pZKg/68jAZe0+rHo=; b=isacK9iIQFtUgk
	oRlZo+MAZSJjQmoe2IkS9/b0+gagIRtnwhV/+vPzpnKdxIXBtGbX9bgE7DCFomj/ZWb68h8qTI8HJ
	enbVhKeeEmvOio/8V8zT9rgxC08TpETjvtOAIL8mq25dbB6aCddEKbEwRiHgH4+An5i/Y5v6+m1qn
	ZJ6UMKLTgDCsEiM7skC7b4vWidWPKBhGirY5b1yUDrH0OmjNmXuXRkxX5bM3oSwNKtTEnIh7pROej
	uQ9biPKRRlRGk9kKBxQYT8PWR3+ykfCVos9A3SAUODg73fzcsb32kdZ9VXM/eEDQYTG5m9TGdnda7
	57038pJv+u3Ow18pyRHg==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gVHS4-0000P5-IA; Fri, 07 Dec 2018 14:50:00 +0000
Received: from hqemgate14.nvidia.com ([216.228.121.143])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gVHRx-0000AI-Og
 for linux-arm-kernel@lists.infradead.org; Fri, 07 Dec 2018 14:49:57 +0000
Received: from hqpgpgate102.nvidia.com (Not Verified[216.228.121.13]) by
 hqemgate14.nvidia.com (using TLS: TLSv1.2, DES-CBC3-SHA)
 id <B5c0a88850000>; Fri, 07 Dec 2018 06:49:41 -0800
Received: from hqmail.nvidia.com ([172.20.161.6])
 by hqpgpgate102.nvidia.com (PGP Universal service);
 Fri, 07 Dec 2018 06:49:43 -0800
X-PGP-Universal: processed;
 by hqpgpgate102.nvidia.com on Fri, 07 Dec 2018 06:49:43 -0800
Received: from [10.21.132.148] (10.124.1.5) by HQMAIL101.nvidia.com
 (172.20.187.10) with Microsoft SMTP Server (TLS) id 15.0.1395.4; Fri, 7 Dec
 2018 14:49:41 +0000
Subject: Re: [PATCH 11/19] cpufreq: tegra124: do not handle the CPU rail
To: Joseph Lo <josephl@nvidia.com>, Thierry Reding <thierry.reding@gmail.com>, 
 Peter De Schrijver <pdeschrijver@nvidia.com>
References: <20181204092548.3038-1-josephl@nvidia.com>
 <20181204092548.3038-12-josephl@nvidia.com>
From: Jon Hunter <jonathanh@nvidia.com>
Message-ID: <71da59ef-fbac-fdce-7348-6a6e23f077e3@nvidia.com>
Date: Fri, 7 Dec 2018 14:49:39 +0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.2.1
MIME-Version: 1.0
In-Reply-To: <20181204092548.3038-12-josephl@nvidia.com>
X-Originating-IP: [10.124.1.5]
X-ClientProxiedBy: HQMAIL105.nvidia.com (172.20.187.12) To
 HQMAIL101.nvidia.com (172.20.187.10)
Content-Language: en-US
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
 t=1544194181; bh=+tL8AiT6HRAf1zFonY+kltLKK1HeFjWi5PySaf7+cQw=;
 h=X-PGP-Universal:Subject:To:CC:References:From:Message-ID:Date:
 User-Agent:MIME-Version:In-Reply-To:X-Originating-IP:
 X-ClientProxiedBy:Content-Type:Content-Language:
 Content-Transfer-Encoding;
 b=B7lEwn493TRNz7MkQJN1t1OX81pshpJGMGLmWJQP3c85Ci8A4JEjNhnaVpCHOsVkB
 b4W3MyoPDNj0pNpO7BWs/81zgcXwCq5O1+oo6boOIVuZmkD9zRJE2YyNIzdoju1dqi
 cS68GyBpFpTAzMo0JQ3nsdiEnr/jUuNQAOVjDNxpTCKEo8rtHakYxxSXReYoulgthp
 NB6YQcx3h0Tx75bpk2wO3Vu20efz0Q2OkLtlizEhNO/C3EPTMRV7Av91sIGRS1agu4
 UUotRIOBwnLZarj6vXiIV0FJ7Jj3Yeq+ryuDW0GCeCQqh7NQxlGm5i5+SA1Wvu8+Ys
 x4Y1o3qmhvt7Q==
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20181207_064954_216251_8C696CBA 
X-CRM114-Status: GOOD (  21.28  )
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
Cc: linux-tegra@vger.kernel.org, Viresh Kumar <viresh.kumar@linaro.org>,
 linux-clk@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 linux-pm@vger.kernel.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org


On 04/12/2018 09:25, Joseph Lo wrote:
> The Tegra124 cpufreq driver has no information to handle the Vdd-CPU
> rail. So the driver shouldn't handle for the CPU clock switching from
> DFLL to other PLL clocks. It was designed to work on DFLL clock only,
> which handle the frequency/voltage scaling in the background. This
> patch removes the driver dependency of the CPU rail.
> 
> Cc: Viresh Kumar <viresh.kumar@linaro.org>
> Cc: linux-pm@vger.kernel.org
> Signed-off-by: Joseph Lo <josephl@nvidia.com>
> ---
>  drivers/cpufreq/Kconfig.arm        |  2 +-
>  drivers/cpufreq/tegra124-cpufreq.c | 26 ++------------------------
>  2 files changed, 3 insertions(+), 25 deletions(-)
> 
> diff --git a/drivers/cpufreq/Kconfig.arm b/drivers/cpufreq/Kconfig.arm
> index 4e1131ef85ae..a609f8820c47 100644
> --- a/drivers/cpufreq/Kconfig.arm
> +++ b/drivers/cpufreq/Kconfig.arm
> @@ -262,7 +262,7 @@ config ARM_TEGRA20_CPUFREQ
>  
>  config ARM_TEGRA124_CPUFREQ
>  	tristate "Tegra124 CPUFreq support"
> -	depends on ARCH_TEGRA && CPUFREQ_DT && REGULATOR
> +	depends on ARCH_TEGRA && CPUFREQ_DT
>  	default y
>  	help
>  	  This adds the CPUFreq driver support for Tegra124 SOCs.
> diff --git a/drivers/cpufreq/tegra124-cpufreq.c b/drivers/cpufreq/tegra124-cpufreq.c
> index 43530254201a..448d00763d00 100644
> --- a/drivers/cpufreq/tegra124-cpufreq.c
> +++ b/drivers/cpufreq/tegra124-cpufreq.c
> @@ -22,11 +22,9 @@
>  #include <linux/of.h>
>  #include <linux/platform_device.h>
>  #include <linux/pm_opp.h>
> -#include <linux/regulator/consumer.h>
>  #include <linux/types.h>
>  
>  struct tegra124_cpufreq_priv {
> -	struct regulator *vdd_cpu_reg;
>  	struct clk *cpu_clk;
>  	struct clk *pllp_clk;
>  	struct clk *pllx_clk;
> @@ -60,14 +58,6 @@ static int tegra124_cpu_switch_to_dfll(struct tegra124_cpufreq_priv *priv)
>  	return ret;
>  }
>  
> -static void tegra124_cpu_switch_to_pllx(struct tegra124_cpufreq_priv *priv)
> -{
> -	clk_set_parent(priv->cpu_clk, priv->pllp_clk);
> -	clk_disable_unprepare(priv->dfll_clk);
> -	regulator_sync_voltage(priv->vdd_cpu_reg);
> -	clk_set_parent(priv->cpu_clk, priv->pllx_clk);
> -}
> -
>  static int tegra124_cpufreq_probe(struct platform_device *pdev)
>  {
>  	struct tegra124_cpufreq_priv *priv;
> @@ -88,16 +78,10 @@ static int tegra124_cpufreq_probe(struct platform_device *pdev)
>  	if (!np)
>  		return -ENODEV;
>  
> -	priv->vdd_cpu_reg = regulator_get(cpu_dev, "vdd-cpu");
> -	if (IS_ERR(priv->vdd_cpu_reg)) {
> -		ret = PTR_ERR(priv->vdd_cpu_reg);
> -		goto out_put_np;
> -	}
> -
>  	priv->cpu_clk = of_clk_get_by_name(np, "cpu_g");
>  	if (IS_ERR(priv->cpu_clk)) {
>  		ret = PTR_ERR(priv->cpu_clk);
> -		goto out_put_vdd_cpu_reg;
> +		goto out_put_np;
>  	}
>  
>  	priv->dfll_clk = of_clk_get_by_name(np, "dfll");
> @@ -129,15 +113,13 @@ static int tegra124_cpufreq_probe(struct platform_device *pdev)
>  		platform_device_register_full(&cpufreq_dt_devinfo);
>  	if (IS_ERR(priv->cpufreq_dt_pdev)) {
>  		ret = PTR_ERR(priv->cpufreq_dt_pdev);
> -		goto out_switch_to_pllx;
> +		goto out_put_pllp_clk;
>  	}
>  
>  	platform_set_drvdata(pdev, priv);
>  
>  	return 0;
>  
> -out_switch_to_pllx:
> -	tegra124_cpu_switch_to_pllx(priv);
>  out_put_pllp_clk:
>  	clk_put(priv->pllp_clk);
>  out_put_pllx_clk:
> @@ -146,8 +128,6 @@ static int tegra124_cpufreq_probe(struct platform_device *pdev)
>  	clk_put(priv->dfll_clk);
>  out_put_cpu_clk:
>  	clk_put(priv->cpu_clk);
> -out_put_vdd_cpu_reg:
> -	regulator_put(priv->vdd_cpu_reg);
>  out_put_np:
>  	of_node_put(np);
>  
> @@ -159,13 +139,11 @@ static int tegra124_cpufreq_remove(struct platform_device *pdev)
>  	struct tegra124_cpufreq_priv *priv = platform_get_drvdata(pdev);
>  
>  	platform_device_unregister(priv->cpufreq_dt_pdev);
> -	tegra124_cpu_switch_to_pllx(priv);
>  
>  	clk_put(priv->pllp_clk);
>  	clk_put(priv->pllx_clk);
>  	clk_put(priv->dfll_clk);
>  	clk_put(priv->cpu_clk);
> -	regulator_put(priv->vdd_cpu_reg);

I see what you are saying and while this does appear to be broken, it
also does not seem right that if we load and unload this driver the CPU
clock parent will remain as the DFLL clock. Can't we query the voltage
of the vdd-cpu regulator before we switch and then restore it before we
switch back?

I am just trying to understand if there is no way to switch back? If not
then maybe we should not allow this driver to be built as a module and
remove the removal function altogether.

Cheers
Jon

-- 
nvpublic

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
