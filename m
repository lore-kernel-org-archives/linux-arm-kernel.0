Return-Path: <SRS0=vAN3=QB=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 64CB1C282C0
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri, 25 Jan 2019 11:03:10 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 35F2C2184B
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri, 25 Jan 2019 11:03:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="EONMvhYM";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=nvidia.com header.i=@nvidia.com header.b="ZrEjVeGZ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 35F2C2184B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=nvidia.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:Date:
	Message-ID:From:References:To:Subject:Reply-To:Content-ID:Content-Description
	:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=dfKGju7brG/3L4mXeyU8WQmzfnDhkldli9aKO2W+WqQ=; b=EONMvhYMAT4k81
	UiHI6kc73lPYgvAYYNTt7sRjQalzfvKYtGb8SbSQIVIMrLDpN4Y6BxrOoxns+XvFSj3QuKKx0fRtw
	jOMYsXNXVwCIsgwDybF9Uko8V3ytsflVF7x1EWb1RsPYXWNmIRHqbbQnTjKYhWE/04GmW2abo+SGi
	xwHV9/sNlgPM5OIBtlfQ9xj1JMqPG3sKjyOSm2R28osB6gWEXHMHJPdUhl2H5Wgvv3Hv7QApXFznU
	0Ssg2lOozasHa9by0ngGy/rAF7QB3P0Ep8qAFBE+cDh9JjJc0hkraYtOhFBcrF5Z0PwskgdswHkad
	0DnL8tq7u7ZJpooX+Ocg==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gmzGP-0001Bb-G3; Fri, 25 Jan 2019 11:03:09 +0000
Received: from hqemgate16.nvidia.com ([216.228.121.65])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gmzGH-0001Ay-96
 for linux-arm-kernel@lists.infradead.org; Fri, 25 Jan 2019 11:03:07 +0000
Received: from hqpgpgate101.nvidia.com (Not Verified[216.228.121.13]) by
 hqemgate16.nvidia.com (using TLS: TLSv1.2, DES-CBC3-SHA)
 id <B5c4aecc00000>; Fri, 25 Jan 2019 03:02:24 -0800
Received: from hqmail.nvidia.com ([172.20.161.6])
 by hqpgpgate101.nvidia.com (PGP Universal service);
 Fri, 25 Jan 2019 03:03:00 -0800
X-PGP-Universal: processed;
 by hqpgpgate101.nvidia.com on Fri, 25 Jan 2019 03:03:00 -0800
Received: from [10.21.132.148] (10.124.1.5) by HQMAIL101.nvidia.com
 (172.20.187.10) with Microsoft SMTP Server (TLS) id 15.0.1395.4; Fri, 25 Jan
 2019 11:02:59 +0000
Subject: Re: [PATCH 7/7] soc/tegra: pmc: Support systems where PMC is marked
 secure
To: Thierry Reding <thierry.reding@gmail.com>
References: <20190125102255.6862-1-thierry.reding@gmail.com>
 <20190125102255.6862-7-thierry.reding@gmail.com>
From: Jon Hunter <jonathanh@nvidia.com>
Message-ID: <15306320-e1dc-c4c6-874a-52f99c685cb5@nvidia.com>
Date: Fri, 25 Jan 2019 11:02:57 +0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.2.1
MIME-Version: 1.0
In-Reply-To: <20190125102255.6862-7-thierry.reding@gmail.com>
X-Originating-IP: [10.124.1.5]
X-ClientProxiedBy: HQMAIL105.nvidia.com (172.20.187.12) To
 HQMAIL101.nvidia.com (172.20.187.10)
Content-Language: en-US
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
 t=1548414144; bh=3axdOTl6wkcvfkK7R7JARGPD8Xdd+38MmD1iQA3fH2o=;
 h=X-PGP-Universal:Subject:To:CC:References:From:Message-ID:Date:
 User-Agent:MIME-Version:In-Reply-To:X-Originating-IP:
 X-ClientProxiedBy:Content-Type:Content-Language:
 Content-Transfer-Encoding;
 b=ZrEjVeGZdkgW9eVvRXUiAOt2wDgJirbXlAE3/o/J3d1dwJ8cvCo8N3QTj029R87EP
 mGW2MD16YLQ+m52AriJiYS/5P9RPKIB+ST5ZdD+2Y0DdLkooW+MEv/eM0fV7FyLUWK
 0SACgLuqYayRTMCxaSLQLLj4bWoOM3k+uaY5X3ArO7aKUBPfzPPgCbqljxUO09q7eZ
 U4ca+ZvlV+IjVkE/5yyrCeWfteCgDyaA1AYHHVC9ttlncuNaC3kgnJZt3Am0xWcV5s
 3VnUZoB6RYfCUt8pGW8dEmr2tK6yPOUwBmiMhZIjcxroZZIa9CC1XnJlUGnVuyxV3r
 KSsWQUJwRgWog==
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190125_030301_341378_6E698617 
X-CRM114-Status: GOOD (  23.30  )
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
Cc: linux-tegra@vger.kernel.org, Stephen Warren <swarren@nvidia.com>,
 linux-arm-kernel@lists.infradead.org, Joseph Lo <josephl@nvidia.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org


On 25/01/2019 10:22, Thierry Reding wrote:
> From: Mikko Perttunen <mperttunen@nvidia.com>
> 
> On Tegra210 systems with new enough boot software, direct register
> accesses to PMC register space from the non-secure world are not
> allowed. Instead a monitor call may be used to read and write PMC
> registers.
> 
> Add code to detect such a system by attempting to write a scratch
> register and detecting if the write happened or not. If not, we switch
> to doing all register accesses through the monitor call.
> 
> Signed-off-by: Mikko Perttunen <mperttunen@nvidia.com>
> Signed-off-by: Thierry Reding <treding@nvidia.com>
> ---
>  drivers/soc/tegra/pmc.c | 100 ++++++++++++++++++++++++++++++++++++++--
>  1 file changed, 97 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/soc/tegra/pmc.c b/drivers/soc/tegra/pmc.c
> index 976f93628fff..8628a2a17ebb 100644
> --- a/drivers/soc/tegra/pmc.c
> +++ b/drivers/soc/tegra/pmc.c
> @@ -20,6 +20,7 @@
>  
>  #define pr_fmt(fmt) "tegra-pmc: " fmt
>  
> +#include <linux/arm-smccc.h>
>  #include <linux/clk.h>
>  #include <linux/clk/tegra.h>
>  #include <linux/debugfs.h>
> @@ -145,6 +146,11 @@
>  #define WAKE_AOWAKE_CTRL 0x4f4
>  #define  WAKE_AOWAKE_CTRL_INTR_POLARITY BIT(0)
>  
> +/* for secure PMC */
> +#define TEGRA_SMC_PMC		0xc2fffe00
> +#define  TEGRA_SMC_PMC_READ	0xaa
> +#define  TEGRA_SMC_PMC_WRITE	0xbb
> +
>  struct tegra_powergate {
>  	struct generic_pm_domain genpd;
>  	struct tegra_pmc *pmc;
> @@ -216,6 +222,7 @@ struct tegra_pmc_soc {
>  	bool has_gpu_clamps;
>  	bool needs_mbist_war;
>  	bool has_impl_33v_pwr;
> +	bool maybe_tz_only;
>  
>  	const struct tegra_io_pad_soc *io_pads;
>  	unsigned int num_io_pads;
> @@ -278,6 +285,7 @@ static const char * const tegra30_reset_sources[] = {
>   * @scratch: pointer to I/O remapped region for scratch registers
>   * @clk: pointer to pclk clock
>   * @soc: pointer to SoC data structure
> + * @tz_only: flag specifying if the PMC can only be accessed via TrustZone
>   * @debugfs: pointer to debugfs entry
>   * @rate: currently configured rate of pclk
>   * @suspend_mode: lowest suspend mode available
> @@ -308,6 +316,7 @@ struct tegra_pmc {
>  	struct dentry *debugfs;
>  
>  	const struct tegra_pmc_soc *soc;
> +	bool tz_only;
>  
>  	unsigned long rate;
>  
> @@ -346,13 +355,62 @@ to_powergate(struct generic_pm_domain *domain)
>  
>  static u32 tegra_pmc_readl(struct tegra_pmc *pmc, unsigned long offset)
>  {
> +	struct arm_smccc_res res;
> +
> +	if (pmc->tz_only) {
> +		arm_smccc_smc(TEGRA_SMC_PMC, TEGRA_SMC_PMC_READ, offset, 0, 0,
> +			      0, 0, 0, &res);
> +		if (res.a0) {
> +			if (pmc->dev)
> +				dev_warn(pmc->dev, "%s(): SMC failed: %lu\n",
> +					 __func__, res.a0);
> +			else
> +				pr_warn("%s(): SMC failed: %lu\n", __func__,
> +					res.a0);
> +		}
> +
> +		return res.a1;
> +	}
> +
>  	return readl(pmc->base + offset);
>  }
>  
>  static void tegra_pmc_writel(struct tegra_pmc *pmc, u32 value,
>  			     unsigned long offset)
>  {
> -	writel(value, pmc->base + offset);
> +	struct arm_smccc_res res;
> +
> +	if (pmc->tz_only) {
> +		arm_smccc_smc(TEGRA_SMC_PMC, TEGRA_SMC_PMC_WRITE, offset,
> +			      value, 0, 0, 0, 0, &res);
> +		if (res.a0) {
> +			if (pmc->dev)
> +				dev_warn(pmc->dev, "%s(): SMC failed: %lu\n",
> +					 __func__, res.a0);
> +			else
> +				pr_warn("%s(): SMC failed: %lu\n", __func__,
> +					res.a0);
> +		}
> +	} else {
> +		writel(value, pmc->base + offset);
> +	}
> +}
> +
> +static u32 tegra_pmc_scratch_readl(struct tegra_pmc *pmc, unsigned long offset)
> +{
> +	if (pmc->tz_only)
> +		return tegra_pmc_readl(pmc, offset);
> +
> +	return readl(pmc->scratch + offset);
> +}
> +
> +static void tegra_pmc_scratch_writel(struct tegra_pmc *pmc, u32 value,
> +				     unsigned long offset)
> +{
> +	if (pmc->tz_only)
> +		tegra_pmc_writel(pmc, value, offset);
> +	else
> +		writel(value, pmc->scratch + offset);
>  }
>  
>  /*
> @@ -776,7 +834,7 @@ static int tegra_pmc_restart_notify(struct notifier_block *this,
>  	const char *cmd = data;
>  	u32 value;
>  
> -	value = readl(pmc->scratch + pmc->soc->regs->scratch0);
> +	value = tegra_pmc_scratch_readl(pmc, pmc->soc->regs->scratch0);
>  	value &= ~PMC_SCRATCH0_MODE_MASK;
>  
>  	if (cmd) {
> @@ -790,7 +848,7 @@ static int tegra_pmc_restart_notify(struct notifier_block *this,
>  			value |= PMC_SCRATCH0_MODE_RCM;
>  	}
>  
> -	writel(value, pmc->scratch + pmc->soc->regs->scratch0);
> +	tegra_pmc_scratch_writel(pmc, value, pmc->soc->regs->scratch0);
>  
>  	/* reset everything but PMC_SCRATCH0 and PMC_RST_STATUS */
>  	value = tegra_pmc_readl(pmc, PMC_CNTRL);
> @@ -2071,6 +2129,7 @@ static const struct tegra_pmc_soc tegra20_pmc_soc = {
>  	.has_gpu_clamps = false,
>  	.needs_mbist_war = false,
>  	.has_impl_33v_pwr = false,
> +	.maybe_tz_only = false,
>  	.num_io_pads = 0,
>  	.io_pads = NULL,
>  	.num_pin_descs = 0,
> @@ -2117,6 +2176,7 @@ static const struct tegra_pmc_soc tegra30_pmc_soc = {
>  	.has_gpu_clamps = false,
>  	.needs_mbist_war = false,
>  	.has_impl_33v_pwr = false,
> +	.maybe_tz_only = false,
>  	.num_io_pads = 0,
>  	.io_pads = NULL,
>  	.num_pin_descs = 0,
> @@ -2167,6 +2227,7 @@ static const struct tegra_pmc_soc tegra114_pmc_soc = {
>  	.has_gpu_clamps = false,
>  	.needs_mbist_war = false,
>  	.has_impl_33v_pwr = false,
> +	.maybe_tz_only = false,
>  	.num_io_pads = 0,
>  	.io_pads = NULL,
>  	.num_pin_descs = 0,
> @@ -2277,6 +2338,7 @@ static const struct tegra_pmc_soc tegra124_pmc_soc = {
>  	.has_gpu_clamps = true,
>  	.needs_mbist_war = false,
>  	.has_impl_33v_pwr = false,
> +	.maybe_tz_only = false,
>  	.num_io_pads = ARRAY_SIZE(tegra124_io_pads),
>  	.io_pads = tegra124_io_pads,
>  	.num_pin_descs = ARRAY_SIZE(tegra124_pin_descs),
> @@ -2382,6 +2444,7 @@ static const struct tegra_pmc_soc tegra210_pmc_soc = {
>  	.has_gpu_clamps = true,
>  	.needs_mbist_war = true,
>  	.has_impl_33v_pwr = false,
> +	.maybe_tz_only = true,
>  	.num_io_pads = ARRAY_SIZE(tegra210_io_pads),
>  	.io_pads = tegra210_io_pads,
>  	.num_pin_descs = ARRAY_SIZE(tegra210_pin_descs),
> @@ -2506,6 +2569,7 @@ static const struct tegra_pmc_soc tegra186_pmc_soc = {
>  	.has_gpu_clamps = false,
>  	.needs_mbist_war = false,
>  	.has_impl_33v_pwr = true,
> +	.maybe_tz_only = false,
>  	.num_io_pads = ARRAY_SIZE(tegra186_io_pads),
>  	.io_pads = tegra186_io_pads,
>  	.num_pin_descs = ARRAY_SIZE(tegra186_pin_descs),
> @@ -2585,6 +2649,7 @@ static const struct tegra_pmc_soc tegra194_pmc_soc = {
>  	.has_gpu_clamps = false,
>  	.needs_mbist_war = false,
>  	.has_impl_33v_pwr = false,
> +	.maybe_tz_only = false,
>  	.num_io_pads = ARRAY_SIZE(tegra194_io_pads),
>  	.io_pads = tegra194_io_pads,
>  	.regs = &tegra186_pmc_regs,
> @@ -2619,6 +2684,32 @@ static struct platform_driver tegra_pmc_driver = {
>  };
>  builtin_platform_driver(tegra_pmc_driver);
>  
> +static bool __init tegra_pmc_detect_tz_only(struct tegra_pmc *pmc)
> +{
> +	u32 value, saved;
> +
> +	saved = readl(pmc->base + pmc->soc->regs->scratch0);
> +	value = saved ^ 0xffffffff;
> +
> +	if (value == 0xffffffff)
> +		value = 0xdeadbeef;
> +
> +	/* write pattern and read it back */
> +	writel(value, pmc->base + pmc->soc->regs->scratch0);
> +	value = readl(pmc->base + pmc->soc->regs->scratch0);
> +
> +	/* if we read all-zeroes, access is restricted to TZ only */
> +	if (value == 0) {
> +		pr_info("access to PMC is restricted to TZ\n");
> +		return true;
> +	}
> +
> +	/* restore original value */
> +	writel(saved, pmc->base + pmc->soc->regs->scratch0);
> +
> +	return false;
> +}
> +
>  /*
>   * Early initialization to allow access to registers in the very early boot
>   * process.
> @@ -2681,6 +2772,9 @@ static int __init tegra_pmc_early_init(void)
>  	if (np) {
>  		pmc->soc = match->data;
>  
> +		if (pmc->soc->maybe_tz_only)
> +			pmc->tz_only = tegra_pmc_detect_tz_only(pmc);
> +
>  		tegra_powergate_init(pmc, np);
>  
>  		/*
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
