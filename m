Return-Path: <SRS0=vAN3=QB=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 79E62C282C0
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri, 25 Jan 2019 10:57:24 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 432F12184B
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri, 25 Jan 2019 10:57:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="lgq1u8sZ";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=nvidia.com header.i=@nvidia.com header.b="P0CX3/2n"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 432F12184B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=nvidia.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:Date:
	Message-ID:From:References:To:Subject:Reply-To:Content-ID:Content-Description
	:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=ZmQ3Fg1F5qCvLBiaQqf13WsZ2fg3LcScJrl/yMiqLPs=; b=lgq1u8sZjIBOPP
	gdXNP4EFNUs2aEEvv1jDQ95c8s5KeDv8VOtkDkMctAPuPcgTBPE5gBAtavBK3BYqhmdranK5lDRGX
	WM1z3n6EJoWcv03R6zGKt2IWPJC6oPEQ6tpgN2MY+h//ZkzATTHMetwaD15VYAzWIkf/ffAQUD3b3
	YOd9Y4tVzUpZX95i+3apqZvqxZvIETtqXcqTQi5DNbnLcKVmWmQkTGYTAbqDrM416Mhx75kt0//cD
	6RDsy/pxGZL9Zveyv8WiImiVxYwq0s+WJ+KU2sNdgrDL0b1EDN8xzEM5w8xV3dGsyT9Q+GzjZtt8l
	QBFyBkYbW4gz4wIIxIbQ==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gmzAl-0007kO-PK; Fri, 25 Jan 2019 10:57:19 +0000
Received: from hqemgate14.nvidia.com ([216.228.121.143])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gmz9u-0007Dj-Bi
 for linux-arm-kernel@lists.infradead.org; Fri, 25 Jan 2019 10:56:54 +0000
Received: from hqpgpgate101.nvidia.com (Not Verified[216.228.121.13]) by
 hqemgate14.nvidia.com (using TLS: TLSv1.2, DES-CBC3-SHA)
 id <B5c4aeb590000>; Fri, 25 Jan 2019 02:56:25 -0800
Received: from hqmail.nvidia.com ([172.20.161.6])
 by hqpgpgate101.nvidia.com (PGP Universal service);
 Fri, 25 Jan 2019 02:56:25 -0800
X-PGP-Universal: processed;
 by hqpgpgate101.nvidia.com on Fri, 25 Jan 2019 02:56:25 -0800
Received: from [10.21.132.148] (172.20.13.39) by HQMAIL101.nvidia.com
 (172.20.187.10) with Microsoft SMTP Server (TLS) id 15.0.1395.4; Fri, 25 Jan
 2019 10:56:24 +0000
Subject: Re: [PATCH 6/7] soc/tegra: pmc: Explicitly initialize all fields
To: Thierry Reding <thierry.reding@gmail.com>
References: <20190125102255.6862-1-thierry.reding@gmail.com>
 <20190125102255.6862-6-thierry.reding@gmail.com>
From: Jon Hunter <jonathanh@nvidia.com>
Message-ID: <667930dd-defb-5521-544a-4949a706d1de@nvidia.com>
Date: Fri, 25 Jan 2019 10:56:22 +0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.2.1
MIME-Version: 1.0
In-Reply-To: <20190125102255.6862-6-thierry.reding@gmail.com>
X-Originating-IP: [172.20.13.39]
X-ClientProxiedBy: HQMAIL107.nvidia.com (172.20.187.13) To
 HQMAIL101.nvidia.com (172.20.187.10)
Content-Language: en-US
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
 t=1548413785; bh=tq3Drf4qkdqUuFooE28fPyMuI+LS28IRHFQTeRDIn0U=;
 h=X-PGP-Universal:Subject:To:CC:References:From:Message-ID:Date:
 User-Agent:MIME-Version:In-Reply-To:X-Originating-IP:
 X-ClientProxiedBy:Content-Type:Content-Language:
 Content-Transfer-Encoding;
 b=P0CX3/2n8XnP3GKwL9W81GWUUGX+JuH2zqbktWnrrv9KeTiCGmFWjNSN6/4/nIUCU
 8+J1D5NcOMTe2pIeTpEPbj2KNoYTC1X+1Obb3bitm9nJgi8K//oy/kiH5MoyJS9PrV
 y6QMCgM0Bf8y1Dkc5pgYeOy5igiqeWb+jOo/cWapNugH2PUsjeZH0g4u8+3w2hkHDq
 GpZicva/0njajb3gI2z+rzg2ahJcavKcAZyMGyRk91HjiKENZbkV8jBnC+0Mqx3Tyq
 0D45ocCmWZdwskJbO3m93DBb7GhU3wp0F2NzkxLB7pqcvJI+Lr17w97lUrzhammML3
 RtJ/dwiC4KrLA==
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190125_025627_278965_C6ACE5E2 
X-CRM114-Status: GOOD (  13.36  )
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
> From: Thierry Reding <treding@nvidia.com>
> 
> It's not strictly necessary to initialize the fields in struct
> tegra_pmc_soc if they are 0/false. However, we already initialize them
> explicitly even if unnecessary, so keep doing that for consistency.
> 
> Signed-off-by: Thierry Reding <treding@nvidia.com>
> ---
>  drivers/soc/tegra/pmc.c | 10 +++++++++-
>  1 file changed, 9 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/soc/tegra/pmc.c b/drivers/soc/tegra/pmc.c
> index 2a2e6aaae97e..976f93628fff 100644
> --- a/drivers/soc/tegra/pmc.c
> +++ b/drivers/soc/tegra/pmc.c
> @@ -2069,6 +2069,8 @@ static const struct tegra_pmc_soc tegra20_pmc_soc = {
>  	.cpu_powergates = NULL,
>  	.has_tsense_reset = false,
>  	.has_gpu_clamps = false,
> +	.needs_mbist_war = false,
> +	.has_impl_33v_pwr = false,
>  	.num_io_pads = 0,
>  	.io_pads = NULL,
>  	.num_pin_descs = 0,
> @@ -2113,6 +2115,7 @@ static const struct tegra_pmc_soc tegra30_pmc_soc = {
>  	.cpu_powergates = tegra30_cpu_powergates,
>  	.has_tsense_reset = true,
>  	.has_gpu_clamps = false,
> +	.needs_mbist_war = false,
>  	.has_impl_33v_pwr = false,
>  	.num_io_pads = 0,
>  	.io_pads = NULL,
> @@ -2162,6 +2165,7 @@ static const struct tegra_pmc_soc tegra114_pmc_soc = {
>  	.cpu_powergates = tegra114_cpu_powergates,
>  	.has_tsense_reset = true,
>  	.has_gpu_clamps = false,
> +	.needs_mbist_war = false,
>  	.has_impl_33v_pwr = false,
>  	.num_io_pads = 0,
>  	.io_pads = NULL,
> @@ -2271,6 +2275,7 @@ static const struct tegra_pmc_soc tegra124_pmc_soc = {
>  	.cpu_powergates = tegra124_cpu_powergates,
>  	.has_tsense_reset = true,
>  	.has_gpu_clamps = true,
> +	.needs_mbist_war = false,
>  	.has_impl_33v_pwr = false,
>  	.num_io_pads = ARRAY_SIZE(tegra124_io_pads),
>  	.io_pads = tegra124_io_pads,
> @@ -2375,8 +2380,8 @@ static const struct tegra_pmc_soc tegra210_pmc_soc = {
>  	.cpu_powergates = tegra210_cpu_powergates,
>  	.has_tsense_reset = true,
>  	.has_gpu_clamps = true,
> -	.has_impl_33v_pwr = false,
>  	.needs_mbist_war = true,
> +	.has_impl_33v_pwr = false,
>  	.num_io_pads = ARRAY_SIZE(tegra210_io_pads),
>  	.io_pads = tegra210_io_pads,
>  	.num_pin_descs = ARRAY_SIZE(tegra210_pin_descs),
> @@ -2499,6 +2504,7 @@ static const struct tegra_pmc_soc tegra186_pmc_soc = {
>  	.cpu_powergates = NULL,
>  	.has_tsense_reset = false,
>  	.has_gpu_clamps = false,
> +	.needs_mbist_war = false,
>  	.has_impl_33v_pwr = true,
>  	.num_io_pads = ARRAY_SIZE(tegra186_io_pads),
>  	.io_pads = tegra186_io_pads,
> @@ -2577,6 +2583,8 @@ static const struct tegra_pmc_soc tegra194_pmc_soc = {
>  	.cpu_powergates = NULL,
>  	.has_tsense_reset = false,
>  	.has_gpu_clamps = false,
> +	.needs_mbist_war = false,
> +	.has_impl_33v_pwr = false,
>  	.num_io_pads = ARRAY_SIZE(tegra194_io_pads),
>  	.io_pads = tegra194_io_pads,
>  	.regs = &tegra186_pmc_regs,
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
