Return-Path: <SRS0=tBLO=PQ=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C70CDC43387
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Tue,  8 Jan 2019 00:33:39 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8FDE92173C
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Tue,  8 Jan 2019 00:33:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="MoXzDvYU";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=nvidia.com header.i=@nvidia.com header.b="NAozP1ha"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8FDE92173C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=nvidia.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:Content-Type:
	Content-Transfer-Encoding:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:Date:Message-ID:From:
	References:To:Subject:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=/paCwHyi7jQgZdlaqKX0FZno2/iEiLdXluKKnk+UwZA=; b=MoXzDvYU9TOwuLydga8vM4ek6
	tuehSiUffGmHpQEkupmM5I2ULy8SeTPj7IONljij69Fnppqvee3lEFawv9sXg9K4DGpEgvRJ5AemE
	MkqYxFwt+LS/sf0xCkZShylY5rA2FWn76UFFE4z3hODnWgR7Nx69ZRuKJ7iQV7WWvgLAai5craSHM
	K1Pm0nrGPFHDqszvys28dqYXRj4N9BFS+kJfexSiN9FsYobxl5vZ2NTyWtFyyvD+USqdiJmQDNXPY
	4S3T68KWOOrZHVYbjtIxHoj0aXpF6D0mU5f+3h37KV7buvvz/ur2pfxrI+nqbOhWv5rkFKQgnYJJk
	ZVmmdZftg==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1ggfKo-0003Zb-2f; Tue, 08 Jan 2019 00:33:34 +0000
Received: from hqemgate14.nvidia.com ([216.228.121.143])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1ggfKk-0003ZD-69
 for linux-arm-kernel@lists.infradead.org; Tue, 08 Jan 2019 00:33:32 +0000
Received: from hqpgpgate102.nvidia.com (Not Verified[216.228.121.13]) by
 hqemgate14.nvidia.com (using TLS: TLSv1.2, DES-CBC3-SHA)
 id <B5c33efcb0000>; Mon, 07 Jan 2019 16:33:15 -0800
Received: from hqmail.nvidia.com ([172.20.161.6])
 by hqpgpgate102.nvidia.com (PGP Universal service);
 Mon, 07 Jan 2019 16:33:27 -0800
X-PGP-Universal: processed;
 by hqpgpgate102.nvidia.com on Mon, 07 Jan 2019 16:33:27 -0800
Received: from [10.19.108.132] (10.124.1.5) by HQMAIL101.nvidia.com
 (172.20.187.10) with Microsoft SMTP Server (TLS) id 15.0.1395.4; Tue, 8 Jan
 2019 00:33:25 +0000
Subject: Re: [PATCH V4 10/20] clk: tegra: dfll: build clk-dfll.c for Tegra124
 and Tegra210
To: Thierry Reding <thierry.reding@gmail.com>, Stephen Boyd
 <sboyd@kernel.org>, Peter De Schrijver <pdeschrijver@nvidia.com>, Jonathan
 Hunter <jonathanh@nvidia.com>
References: <20190104030702.8684-1-josephl@nvidia.com>
 <20190104030702.8684-11-josephl@nvidia.com>
From: Joseph Lo <josephl@nvidia.com>
Message-ID: <e35cf7f7-e46c-43f0-7789-2f237f2ce9bb@nvidia.com>
Date: Tue, 8 Jan 2019 08:33:23 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.2.1
MIME-Version: 1.0
In-Reply-To: <20190104030702.8684-11-josephl@nvidia.com>
X-Originating-IP: [10.124.1.5]
X-ClientProxiedBy: HQMAIL104.nvidia.com (172.18.146.11) To
 HQMAIL101.nvidia.com (172.20.187.10)
Content-Language: en-US
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
 t=1546907595; bh=0C/9p+KQvbWVu1QlA9kj0iDcu2pPx+8XZUeatHR3wKw=;
 h=X-PGP-Universal:Subject:To:CC:References:From:Message-ID:Date:
 User-Agent:MIME-Version:In-Reply-To:X-Originating-IP:
 X-ClientProxiedBy:Content-Type:Content-Language:
 Content-Transfer-Encoding;
 b=NAozP1haaQomSy3CHVgxlOWetCdGiAtToq/bgJM5kDta8WpTkXIunvyHdrOf8KERk
 9S9jb18ChJWk5iTq0uWrawic9StleAfIeAd1G5J00S7Vz+LItMwZ0czf/oXuPO6I02
 qV+Fp9yUtOWqAk9mJcjZfoRiH+jVX4sA29RaqKK7cH7oU01C9m1878RuD2MWd5NmMz
 6YomCmV1IYFMSKCm67AMJ3YOmFrvdszpWWOcg6bnIokDeYC2u4vlhcUpyc5+ri2V08
 hmyYLtBiQC0lLyTW2kBC5wTq6M9R6unrv6TmnXaZkVYGzu9q6Yunw/yYtq7DUcluJL
 GeNK8km4xrJvQ==
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190107_163330_242680_35E53DE5 
X-CRM114-Status: GOOD (  16.10  )
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
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

On 1/4/19 11:06 AM, Joseph Lo wrote:
> From: Peter De Schrijver <pdeschrijver@nvidia.com>
> 
> Tegra210 has a DFLL as well and can share the majority of the code with
> the Tegra124 implementation. So build the same code for both platforms.
> 
> Signed-off-by: Peter De Schrijver <pdeschrijver@nvidia.com>
> Signed-off-by: Joseph Lo <josephl@nvidia.com>
> Acked-by: Jon Hunter <jonathanh@nvidia.com>
> ---
> *V4:
>   - remove parenthesis in Kconfig of DFLL driver
> *V3:
>   - no change
> *V2:
>   - add ack tag
> ---

Hi Stephen,

Could you help me to review this patch again?

Thanks,
Joseph
>   drivers/clk/tegra/Kconfig  | 5 +++++
>   drivers/clk/tegra/Makefile | 2 +-
>   2 files changed, 6 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/clk/tegra/Kconfig b/drivers/clk/tegra/Kconfig
> index 7ddacae5d0b1..1adcccfa7829 100644
> --- a/drivers/clk/tegra/Kconfig
> +++ b/drivers/clk/tegra/Kconfig
> @@ -5,3 +5,8 @@ config TEGRA_CLK_EMC
>   config CLK_TEGRA_BPMP
>   	def_bool y
>   	depends on TEGRA_BPMP
> +
> +config TEGRA_CLK_DFLL
> +	depends on ARCH_TEGRA_124_SOC || ARCH_TEGRA_210_SOC
> +	select PM_OPP
> +	def_bool y
> diff --git a/drivers/clk/tegra/Makefile b/drivers/clk/tegra/Makefile
> index 6507acc843c7..4812e45c2214 100644
> --- a/drivers/clk/tegra/Makefile
> +++ b/drivers/clk/tegra/Makefile
> @@ -20,7 +20,7 @@ obj-$(CONFIG_ARCH_TEGRA_2x_SOC)         += clk-tegra20.o
>   obj-$(CONFIG_ARCH_TEGRA_3x_SOC)         += clk-tegra30.o
>   obj-$(CONFIG_ARCH_TEGRA_114_SOC)	+= clk-tegra114.o
>   obj-$(CONFIG_ARCH_TEGRA_124_SOC)	+= clk-tegra124.o
> -obj-$(CONFIG_ARCH_TEGRA_124_SOC)	+= clk-tegra124-dfll-fcpu.o
> +obj-$(CONFIG_TEGRA_CLK_DFLL)		+= clk-tegra124-dfll-fcpu.o
>   obj-$(CONFIG_ARCH_TEGRA_132_SOC)	+= clk-tegra124.o
>   obj-y					+= cvb.o
>   obj-$(CONFIG_ARCH_TEGRA_210_SOC)	+= clk-tegra210.o
> 

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
