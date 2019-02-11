Return-Path: <SRS0=sCCJ=QS=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EA2F2C282D7
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Mon, 11 Feb 2019 13:59:58 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B89D2222B0
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Mon, 11 Feb 2019 13:59:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="dWuAalxR";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=nvidia.com header.i=@nvidia.com header.b="U20y8UF7"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B89D2222B0
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=nvidia.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:Content-Type:
	Content-Transfer-Encoding:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:Date:Message-ID:From:
	References:To:Subject:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=R+mdewmbn7v0Jgv3nYgc7DCxZGYg/22eriA0KhcNQ/8=; b=dWuAalxR/f6tMPL2ahHBBp+HL
	0fIc/cCAQvuc6sWHMdT1KjgZCYbPj5QLtobjHiPqIUbU9/G/rwtM/1A5DjMeq16vHttFhXki68YbT
	TAQwX4/5s3wNEWE7RrJzbg65SbUsHOvca9+S4/FRvz7BKmpC4fJD7jRvdDGvJIAkVePHNnYQfuK4y
	vF1YCL0DPK+SYL9W0qipcyE0fFfm1Z5qUw6enhNf9JO6J1tGJZBJ3RIOFFzzqK0wSNTGYRIFEnwmp
	cIz+5mYjpMfGNSpVeXLxaCBYDBUK+bQ8vpVyVPp89ckqXyg+uUrKDMZgtMgJ3GAbkSvWdgSHPzXMo
	gSCmIHBlg==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gtC7g-0003sz-5J; Mon, 11 Feb 2019 13:59:48 +0000
Received: from hqemgate15.nvidia.com ([216.228.121.64])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gtC7d-0003sG-4i
 for linux-arm-kernel@lists.infradead.org; Mon, 11 Feb 2019 13:59:46 +0000
Received: from hqpgpgate102.nvidia.com (Not Verified[216.228.121.13]) by
 hqemgate15.nvidia.com (using TLS: TLSv1.2, DES-CBC3-SHA)
 id <B5c617fad0000>; Mon, 11 Feb 2019 05:59:09 -0800
Received: from hqmail.nvidia.com ([172.20.161.6])
 by hqpgpgate102.nvidia.com (PGP Universal service);
 Mon, 11 Feb 2019 05:59:43 -0800
X-PGP-Universal: processed;
 by hqpgpgate102.nvidia.com on Mon, 11 Feb 2019 05:59:43 -0800
Received: from [10.25.73.17] (10.124.1.5) by HQMAIL101.nvidia.com
 (172.20.187.10) with Microsoft SMTP Server (TLS) id 15.0.1395.4; Mon, 11 Feb
 2019 13:59:40 +0000
Subject: Re: [PATCH] ARM: tegra: enforce PM requirement
To: <linux@armlinux.org.uk>, <jhogan@kernel.org>
References: <1549365418-26283-1-git-send-email-spujar@nvidia.com>
From: Sameer Pujar <spujar@nvidia.com>
Message-ID: <d78324ad-25de-a125-a1bd-6088f069ef58@nvidia.com>
Date: Mon, 11 Feb 2019 19:29:37 +0530
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.5.0
MIME-Version: 1.0
In-Reply-To: <1549365418-26283-1-git-send-email-spujar@nvidia.com>
X-Originating-IP: [10.124.1.5]
X-ClientProxiedBy: HQMAIL105.nvidia.com (172.20.187.12) To
 HQMAIL101.nvidia.com (172.20.187.10)
Content-Language: en-GB
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
 t=1549893549; bh=c2rYtvV9Y8Jv6429/xOpMhGVJpz09K9qJjWqjFbEOR4=;
 h=X-PGP-Universal:Subject:To:CC:References:From:Message-ID:Date:
 User-Agent:MIME-Version:In-Reply-To:X-Originating-IP:
 X-ClientProxiedBy:Content-Type:Content-Transfer-Encoding:
 Content-Language;
 b=U20y8UF7OAfHuv5x2uYtxojMJ2zG6jzvqpbJj25AbouYWTZhiZO9ACdMmWMFaAAbG
 v+LkiQBThjc9IOnVtFCdRBs4TuzAOw24ODCHSuepLKhiBeytO+2H+wYIWzwJbPo3J+
 bqQlEysSE6GjegWwt2UUcHHhFgrO2WP/jBkBPXGRRHFoXiNLJL/63lBOsni6T3pV4r
 KPXa5YaOyBrBD0ivedcedAhrM8wdDQIqLwyJZzzWI2RaJ/IG4p7mUa2Zaoilvhv9r2
 rjpaHTncYW/wfTs8rfcOaD1uG/s7XjAd1uNi6R9lOVqBWzBCcf+nePQo+aeXmAZ//0
 0RTWYaq9pQnzA==
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190211_055945_190844_E02838EB 
X-CRM114-Status: GOOD (  14.70  )
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
Cc: linux-tegra@vger.kernel.org, thierry.reding@gmail.com,
 linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 jonathanh@nvidia.com
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org


On 2/5/2019 4:46 PM, Sameer Pujar wrote:
> Drivers need to handle !PM case with work arounds for managing clocks
> and power explicitly, which is not really necessary when PM support on
> tegra is in good shape. In fact ARM 64-bit tegra platforms enforce PM
> support and there is no reason why this cannot be done for 32-bit.
>
> This patch selects PM unconditionally and drivers can rely on runtime
> PM framework for clock and power management.
>
> Signed-off-by: Sameer Pujar <spujar@nvidia.com>
> Reviewed-by: Thierry Reding <treding@nvidia.com>
> Reviewed-by: Jonathan Hunter <jonathanh@nvidia.com>
> ---
>   arch/arm/mach-tegra/Kconfig | 1 +
>   1 file changed, 1 insertion(+)
>
> diff --git a/arch/arm/mach-tegra/Kconfig b/arch/arm/mach-tegra/Kconfig
> index 7f3b83e..51a8fa3 100644
> --- a/arch/arm/mach-tegra/Kconfig
> +++ b/arch/arm/mach-tegra/Kconfig
> @@ -10,6 +10,7 @@ menuconfig ARCH_TEGRA
>   	select HAVE_ARM_SCU if SMP
>   	select HAVE_ARM_TWD if SMP
>   	select PINCTRL
> +	select PM
>   	select PM_OPP
>   	select ARCH_HAS_RESET_CONTROLLER
>   	select RESET_CONTROLLER

Request for review comments or approval.

Thanks,
Sameer.


_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
