Return-Path: <SRS0=rVA4=OU=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 34062C07E85
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Tue, 11 Dec 2018 14:18:42 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 059E020849
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Tue, 11 Dec 2018 14:18:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="Z3HGpr77"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 059E020849
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:
	Message-ID:Subject:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=2C4gN1n2JPyR9OHfJ4NCt4J3xADKnR4fuEeMo3iNWWM=; b=Z3HGpr77RZwFZX
	mbTVLJFBQdMtmm0tQnUf4WCmKdNR7hG7N2y6+sd8mmhuAaKdQLsl5dz0msi4X+lMk7z0Mmi3BYIxY
	sF64JVFJUF7lZbaC9cB9oeQiSPnNsigduvLIDfXGbHsQ76zfFkRI3f08Ah71VISKGrvS/K1HrZttq
	D2RJ1nhgbnb83hnAG57MYjI+jHdwBEML9ZQ9ZbBpnxLt1xiiiD9lhpXGl3IlIJzsm2W02GBIgV/uv
	Ti/vfJbN1wuVBvt6uUwunuh3JE9hHBNGlUcwRJgc4rVkOyJKWnlYnAOmcF4iPRLyIvrmCV+kWxMNK
	kp2r4yrl3BwagoHW3nxQ==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gWiru-0008V0-Rv; Tue, 11 Dec 2018 14:18:38 +0000
Received: from usa-sjc-mx-foss1.foss.arm.com ([217.140.101.70]
 helo=foss.arm.com)
 by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gWiro-0008Tj-0p
 for linux-arm-kernel@lists.infradead.org; Tue, 11 Dec 2018 14:18:33 +0000
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id E47E21596;
 Tue, 11 Dec 2018 06:18:19 -0800 (PST)
Received: from edgewater-inn.cambridge.arm.com
 (usa-sjc-imap-foss1.foss.arm.com [10.72.51.249])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id B57043F59C;
 Tue, 11 Dec 2018 06:18:19 -0800 (PST)
Received: by edgewater-inn.cambridge.arm.com (Postfix, from userid 1000)
 id BE1781AE0B6B; Tue, 11 Dec 2018 14:18:42 +0000 (GMT)
Date: Tue, 11 Dec 2018 14:18:42 +0000
From: Will Deacon <will.deacon@arm.com>
To: Arnd Bergmann <arnd@arndb.de>
Subject: Re: [PATCH] arm64: fix ARM64_USER_VA_BITS_52 builds
Message-ID: <20181211141842.GA11618@edgewater-inn.cambridge.arm.com>
References: <20181211140832.567893-1-arnd@arndb.de>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20181211140832.567893-1-arnd@arndb.de>
User-Agent: Mutt/1.11.1+30 (d10eec459b35) ()
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20181211_061832_063843_99792B0D 
X-CRM114-Status: GOOD (  18.86  )
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
Cc: Catalin Marinas <catalin.marinas@arm.com>,
 linux-arm-kernel@lists.infradead.org,
 Kristina Martsenko <kristina.martsenko@arm.com>, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

On Tue, Dec 11, 2018 at 03:08:10PM +0100, Arnd Bergmann wrote:
> In some randconfig builds, the new CONFIG_ARM64_USER_VA_BITS_52
> triggered a build failure:
> 
> arch/arm64/mm/proc.S:287: Error: immediate out of range
> 
> As it turns out, we were incorrectly setting PGTABLE_LEVELS here,
> lacking any other default value.
> This fixes the calculation of CONFIG_PGTABLE_LEVELS to consider
> all combinations again.
> 
> Fixes: 68d23da4373a ("arm64: Kconfig: Re-jig CONFIG options for 52-bit VA")
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>
> ---
>  arch/arm64/Kconfig | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/arch/arm64/Kconfig b/arch/arm64/Kconfig
> index df201d93697d..a0f3b921b6e6 100644
> --- a/arch/arm64/Kconfig
> +++ b/arch/arm64/Kconfig
> @@ -278,7 +278,7 @@ config PGTABLE_LEVELS
>  	int
>  	default 2 if ARM64_16K_PAGES && ARM64_VA_BITS_36
>  	default 2 if ARM64_64K_PAGES && ARM64_VA_BITS_42
> -	default 3 if ARM64_64K_PAGES && ARM64_VA_BITS_48
> +	default 3 if ARM64_64K_PAGES && (ARM64_VA_BITS_48 || ARM64_USER_VA_BITS_52)
>  	default 3 if ARM64_4K_PAGES && ARM64_VA_BITS_39
>  	default 3 if ARM64_16K_PAGES && ARM64_VA_BITS_47
>  	default 4 if !ARM64_64K_PAGES && ARM64_VA_BITS_48

Thanks, Arnd. I'll pick this one up too.

Will

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
