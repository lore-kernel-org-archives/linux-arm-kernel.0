Return-Path: <SRS0=e5Gl=O3=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_NEOMUTT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2CF82C43387
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Tue, 18 Dec 2018 05:34:33 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id F1AE1217D9
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Tue, 18 Dec 2018 05:34:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="eH/DBGBA";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="cRC6ElVX"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org F1AE1217D9
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:
	Message-ID:Subject:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=Rq/055NgNY7doFeenu95W4H3APVuZTQPcT6TrWTom+Y=; b=eH/DBGBAxqoB9O
	2V5sWeAGFPJdChlAalP1xIigFBwoA2FgBjjcndSa0IN91QV1K1PVTBIv1ySR9SCvsSWslTnJJ6H7l
	Zib75hILOXDnGb+p6Lhu6Xcd5nI/VvPi8n6RX2NSWmD8Ao6ZEzShlbriG+PbH9n5P9UIumvG8bIMb
	9mUmoVyezUo9m7t27ENCzUd/1ir9oy2lIvycIRexGOBYhZp7K/ntTbuGogghKu2SyMe/jC8KbPSSy
	DsbVk2x7VkvILtt66QyXUKT9Px/6w/R+ga3eBT+XPbfetpzOZ24tKtQTvdhy5f3FSUg8aNJTmDamT
	2BTRBwZt13KZgVATFUUg==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gZ81X-0006rk-BS; Tue, 18 Dec 2018 05:34:31 +0000
Received: from mail-pl1-x644.google.com ([2607:f8b0:4864:20::644])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gZ81Q-0006fA-89
 for linux-arm-kernel@lists.infradead.org; Tue, 18 Dec 2018 05:34:29 +0000
Received: by mail-pl1-x644.google.com with SMTP id gn14so7272388plb.10
 for <linux-arm-kernel@lists.infradead.org>;
 Mon, 17 Dec 2018 21:34:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=date:from:to:cc:subject:message-id:references:mime-version
 :content-disposition:in-reply-to:user-agent;
 bh=7b2x8+vSss/e4OZN0iwTU5dOkP70PIhM6nSHycpICHI=;
 b=cRC6ElVXWqDx9FO2R6ssVZXmmADEdJEr6aj4XYkebXNXlG4Xqa1Q7dJNeC/nPOyw6f
 e4kEPyD/YmAG/NWyv2osMdMRxo+gKNTN198SAZmoa1XSb+WSsBzSar4UN+wGNNJ4XqLO
 JplPO/LedPMnGsfeFxBb4yt75Sk+I6UGyiR5M=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to:user-agent;
 bh=7b2x8+vSss/e4OZN0iwTU5dOkP70PIhM6nSHycpICHI=;
 b=V9iSCJYV3APVEza+9x0YMDPJf6Qhqs5lgvJqKi/mGXoqs9mD9lJ9yCdSCRRYtSOG3q
 k4aR5d3ZPEeDSlbcBseB1niBojKB1BJFiiHxo1gLbHg9HvvnsycRk98bo0574mkaT4Ce
 6JaA1sPyL/qTZ4ZUokffUddlwiRSL6W5h+mz/MugfP+nGQSu7ehcS11j47K4QZIJs9I5
 9Td4k336nsLtDNZtjfVDyIghVwtHiJV88f6te3ChPHeakaI986EuIX40QHtmY0XvgI+H
 yg2SLBi42LwbBjm7AElHDmDT77XHWHt37Mo52eX+grgYXCysjBcpkoxaJrYHYZiAg3lS
 fowg==
X-Gm-Message-State: AA+aEWZ2Ltmcf8qZP6Anvge5FN3Mhqjqgxz9kuX8X/ijFeZIIvLucFT+
 e7IhE+4OWvdliDxBcAewdcwv1g==
X-Google-Smtp-Source: AFSGD/WgUjJxKLDrQnVJKLW9jOGI7cw8TMqkipOmicm9mJRzJF2Cwgynd8//nXEsGboRQTXnycZ/3w==
X-Received: by 2002:a17:902:720c:: with SMTP id
 ba12mr15288806plb.79.1545111253527; 
 Mon, 17 Dec 2018 21:34:13 -0800 (PST)
Received: from localhost ([122.172.23.29])
 by smtp.gmail.com with ESMTPSA id 125sm28138946pfd.124.2018.12.17.21.34.12
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Mon, 17 Dec 2018 21:34:12 -0800 (PST)
Date: Tue, 18 Dec 2018 11:04:10 +0530
From: Viresh Kumar <viresh.kumar@linaro.org>
To: Joseph Lo <josephl@nvidia.com>
Subject: Re: [PATCH V2 12/21] cpufreq: tegra124: do not handle the CPU rail
Message-ID: <20181218053410.uknexblthpmv4ahp@vireshk-i7>
References: <20181213093438.29621-1-josephl@nvidia.com>
 <20181213093438.29621-13-josephl@nvidia.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20181213093438.29621-13-josephl@nvidia.com>
User-Agent: NeoMutt/20180323-120-3dd1ac
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20181217_213424_819457_EE75D1F7 
X-CRM114-Status: GOOD (  24.95  )
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
Cc: linux-pm@vger.kernel.org, Peter De Schrijver <pdeschrijver@nvidia.com>,
 Jonathan Hunter <jonathanh@nvidia.com>,
 Thierry Reding <thierry.reding@gmail.com>, linux-tegra@vger.kernel.org,
 linux-clk@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

On 13-12-18, 17:34, Joseph Lo wrote:
> The Tegra124 cpufreq driver has no information to handle the Vdd-CPU
> rail. So this driver shouldn't handle for the CPU clock switching from
> DFLL to other PLL clocks. It was designed to work on DFLL clock only,
> which handle the frequency/voltage scaling in the background.
> 
> This patch removes the driver dependency of the CPU rail, as well as not
> allow it to be built as a module and remove the removal function. So it
> can keep working on DFLL clock.
> 
> Cc: Viresh Kumar <viresh.kumar@linaro.org>
> Cc: linux-pm@vger.kernel.org
> Signed-off-by: Joseph Lo <josephl@nvidia.com>
> ---
> *V2:
>  - update the commit message since we change the driver not able to be
>  built as a module and remove the removal function in V2
> ---
>  drivers/cpufreq/Kconfig.arm        |  4 +--
>  drivers/cpufreq/tegra124-cpufreq.c | 41 ++----------------------------
>  2 files changed, 4 insertions(+), 41 deletions(-)
> 
> diff --git a/drivers/cpufreq/Kconfig.arm b/drivers/cpufreq/Kconfig.arm
> index 4e1131ef85ae..1d83b6e81222 100644
> --- a/drivers/cpufreq/Kconfig.arm
> +++ b/drivers/cpufreq/Kconfig.arm
> @@ -261,8 +261,8 @@ config ARM_TEGRA20_CPUFREQ
>  	  This adds the CPUFreq driver support for Tegra20 SOCs.
>  
>  config ARM_TEGRA124_CPUFREQ
> -	tristate "Tegra124 CPUFreq support"
> -	depends on ARCH_TEGRA && CPUFREQ_DT && REGULATOR
> +	bool "Tegra124 CPUFreq support"
> +	depends on ARCH_TEGRA && CPUFREQ_DT
>  	default y
>  	help
>  	  This adds the CPUFreq driver support for Tegra124 SOCs.
> diff --git a/drivers/cpufreq/tegra124-cpufreq.c b/drivers/cpufreq/tegra124-cpufreq.c
> index 43530254201a..a1bfde0a7950 100644
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
> @@ -146,34 +128,15 @@ static int tegra124_cpufreq_probe(struct platform_device *pdev)
>  	clk_put(priv->dfll_clk);
>  out_put_cpu_clk:
>  	clk_put(priv->cpu_clk);
> -out_put_vdd_cpu_reg:
> -	regulator_put(priv->vdd_cpu_reg);
>  out_put_np:
>  	of_node_put(np);
>  
>  	return ret;
>  }
>  
> -static int tegra124_cpufreq_remove(struct platform_device *pdev)
> -{
> -	struct tegra124_cpufreq_priv *priv = platform_get_drvdata(pdev);
> -
> -	platform_device_unregister(priv->cpufreq_dt_pdev);
> -	tegra124_cpu_switch_to_pllx(priv);
> -
> -	clk_put(priv->pllp_clk);
> -	clk_put(priv->pllx_clk);
> -	clk_put(priv->dfll_clk);
> -	clk_put(priv->cpu_clk);
> -	regulator_put(priv->vdd_cpu_reg);
> -
> -	return 0;
> -}
> -
>  static struct platform_driver tegra124_cpufreq_platdrv = {
>  	.driver.name	= "cpufreq-tegra124",
>  	.probe		= tegra124_cpufreq_probe,
> -	.remove		= tegra124_cpufreq_remove,
>  };
>  
>  static int __init tegra_cpufreq_init(void)

Acked-by: Viresh Kumar <viresh.kumar@linaro.org>

-- 
viresh

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
