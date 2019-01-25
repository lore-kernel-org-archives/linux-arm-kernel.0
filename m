Return-Path: <SRS0=vAN3=QB=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D6100C282C0
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri, 25 Jan 2019 04:21:43 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A871C218A6
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri, 25 Jan 2019 04:21:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="FGzvPEdL";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=nvidia.com header.i=@nvidia.com header.b="h4k/TjIM"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A871C218A6
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=nvidia.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:Content-Type:
	Content-Transfer-Encoding:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:Date:Message-ID:From:
	References:To:Subject:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=dW2Mn2QmJH0pPPXhx+bE9nD0bc1qxvCnWmHenxAENHg=; b=FGzvPEdLIdTytF8/eLFGBFzTK
	bszBiQ+zfLej5TULh70nMDt9y+LuCYdpwWIQxrpzU6NHv566hniD7y/tsDtYawmoJs6Z2aDd7cxBk
	Bb7e2BTy4Q77WyKYIeQfFei7+jH2LT5gYYgRN+AftY0AqIvlf5Hq5FNq6Q4hjCpz+TMYGkf24o6/j
	LwGVPpHgiCSu3PF2nC5RJVsS9lfY/GTqy5mZVhJlkUHHWGfAg4rLSvjj9YqNf/M9QHU/+jfL83NHF
	chcqBOt1N7Gal5ALTc1xqQYmEMktDCRYa0u0OPP3DLgX9j8eHAUmYiTcQb4coloR1FqTpdAbeujlO
	8BXeNKHBA==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gmszs-0005zf-En; Fri, 25 Jan 2019 04:21:40 +0000
Received: from hqemgate15.nvidia.com ([216.228.121.64])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gmszZ-0005si-IZ
 for linux-arm-kernel@lists.infradead.org; Fri, 25 Jan 2019 04:21:25 +0000
Received: from hqpgpgate102.nvidia.com (Not Verified[216.228.121.13]) by
 hqemgate15.nvidia.com (using TLS: TLSv1.2, DES-CBC3-SHA)
 id <B5c4a8ea70002>; Thu, 24 Jan 2019 20:20:55 -0800
Received: from hqmail.nvidia.com ([172.20.161.6])
 by hqpgpgate102.nvidia.com (PGP Universal service);
 Thu, 24 Jan 2019 20:21:20 -0800
X-PGP-Universal: processed;
 by hqpgpgate102.nvidia.com on Thu, 24 Jan 2019 20:21:20 -0800
Received: from [10.19.108.132] (172.20.13.39) by HQMAIL101.nvidia.com
 (172.20.187.10) with Microsoft SMTP Server (TLS) id 15.0.1395.4; Fri, 25 Jan
 2019 04:21:19 +0000
Subject: Re: [PATCH] soc/tegra: fuse: fix typo in tegra210_init_speedo_data
To: Thierry Reding <thierry.reding@gmail.com>, Jonathan Hunter
 <jonathanh@nvidia.com>
References: <20190104071646.15828-1-josephl@nvidia.com>
 <20190104071646.15828-3-josephl@nvidia.com>
From: Joseph Lo <josephl@nvidia.com>
Message-ID: <2a20640b-5df7-c9e1-9e8d-66e33e79ab83@nvidia.com>
Date: Fri, 25 Jan 2019 12:21:17 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.4.0
MIME-Version: 1.0
In-Reply-To: <20190104071646.15828-3-josephl@nvidia.com>
X-Originating-IP: [172.20.13.39]
X-ClientProxiedBy: HQMAIL106.nvidia.com (172.18.146.12) To
 HQMAIL101.nvidia.com (172.20.187.10)
Content-Language: en-US
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
 t=1548390055; bh=wio4l1/6WvEpOjUwV9nUYpkmrUecf9gtyYO1MXrKXO0=;
 h=X-PGP-Universal:Subject:To:CC:References:From:Message-ID:Date:
 User-Agent:MIME-Version:In-Reply-To:X-Originating-IP:
 X-ClientProxiedBy:Content-Type:Content-Language:
 Content-Transfer-Encoding;
 b=h4k/TjIMPD3zAIWcsOg1y1pOOjLj0sQp2ZFXgDPlPvZlnCTM8UircoSobWg8lYkwe
 qQHgn5dSMdO15i5C++dbSDkP7C23t5PXiC6OGWxDhDPvRuRe1VzeauEXjcTPfCFvXb
 Otghov1vNPy1T/0w86emnigwWQcLoRJnDxgcG/LzycLER9vS6Y3cguXpDdPC5VwScx
 AS9pf8+bNC18woFAFHA8nZXQjiJT0hCoVG1s/lIEe8/3fEgPAeXvUWiR2COGcE9Jmw
 7tV/27LxyhMXK2l6LLFsyCPTuGT1Km8HkZ5tV2p9hFqEd7S3YfiMK1Ynl4bvByNJSS
 YOikG4iUi3H7Q==
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190124_202122_198963_3ADD0E7D 
X-CRM114-Status: GOOD (  12.43  )
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
Cc: linux-tegra@vger.kernel.org, Mark Zhang <markz@nvidia.com>,
 linux-arm-kernel@lists.infradead.org
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

Hi Jon,

Could you help me to review this patch?

Thanks,
Joseph

On 1/4/19 3:16 PM, Joseph Lo wrote:
> Fix typo when reading SoC speedo value from fuse SoC speedo register.
> 
> Reported-by: Mark Zhang <markz@nvidia.com>
> Signed-off-by: Joseph Lo <josephl@nvidia.com>
> ---
>   drivers/soc/tegra/fuse/speedo-tegra210.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/soc/tegra/fuse/speedo-tegra210.c b/drivers/soc/tegra/fuse/speedo-tegra210.c
> index 5373f4c16b54..8ed35d9851f8 100644
> --- a/drivers/soc/tegra/fuse/speedo-tegra210.c
> +++ b/drivers/soc/tegra/fuse/speedo-tegra210.c
> @@ -131,7 +131,7 @@ void __init tegra210_init_speedo_data(struct tegra_sku_info *sku_info)
>   
>   	soc_speedo[0] = tegra_fuse_read_early(FUSE_SOC_SPEEDO_0);
>   	soc_speedo[1] = tegra_fuse_read_early(FUSE_SOC_SPEEDO_1);
> -	soc_speedo[2] = tegra_fuse_read_early(FUSE_CPU_SPEEDO_2);
> +	soc_speedo[2] = tegra_fuse_read_early(FUSE_SOC_SPEEDO_2);
>   
>   	cpu_iddq = tegra_fuse_read_early(FUSE_CPU_IDDQ) * 4;
>   	soc_iddq = tegra_fuse_read_early(FUSE_SOC_IDDQ) * 4;
> 

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
