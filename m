Return-Path: <SRS0=AzG1=P3=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2BE9CC61CE4
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Sat, 19 Jan 2019 21:02:41 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E7E0E2084C
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Sat, 19 Jan 2019 21:02:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="pUVJViu5"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E7E0E2084C
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:
	Message-ID:Subject:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=CjBAyWJ6c17oSF9zQEPStAxzD0r23PXFpKL/9gcDZP4=; b=pUVJViu5l92JsF
	Bv5fEB+EE35AYDS4p0hJMenLpJLwpv9BWX+50Xhh/M9EpdAMylCDA+rQwzMa1Nq/UthxObEDuh1Oa
	sElOWulF8wZNjvtWtgYOfo5e4/o7Y0AsnkFw5g30StZFMsa/ROY4bUY4Nr9ZRw8X8kjzv7xAfYfTq
	dbSkPeqyAIYwJPGFf5uXWEKJRsDiGj/bmoWR3bf6CD3ShtBIK+5at/BSj8AJGextPa3rwQWvU+iwi
	S5N4RVSgLibfZwhFHTRJjWtNBmR0I2Eo0Bzcgxgfdf4npnMKHEVS3nEOdZ7xhYibgvmbIe5TABUws
	97rlIpQYJFLxiTVOXOgQ==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gkxlH-00009j-Vq; Sat, 19 Jan 2019 21:02:39 +0000
Received: from foss.arm.com ([217.140.101.70])
 by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gkxlE-000098-53
 for linux-arm-kernel@lists.infradead.org; Sat, 19 Jan 2019 21:02:37 +0000
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 01718EBD;
 Sat, 19 Jan 2019 13:02:33 -0800 (PST)
Received: from brain-police (usa-sjc-mx-foss1.foss.arm.com [217.140.101.70])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id E418D3F5C1;
 Sat, 19 Jan 2019 13:02:31 -0800 (PST)
Date: Sat, 19 Jan 2019 21:02:23 +0000
From: Will Deacon <will.deacon@arm.com>
To: Tobias Klausmann <tobias.johannes.klausmann@mni.thm.de>
Subject: Re: [PATCH] arch/arm64: Add the various compression methods to the
 default config
Message-ID: <20190119210221.GA30173@brain-police>
References: <20190119185540.20526-1-tobias.johannes.klausmann@mni.thm.de>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20190119185540.20526-1-tobias.johannes.klausmann@mni.thm.de>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190119_130236_201791_4EFE3BD2 
X-CRM114-Status: GOOD (  14.21  )
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
Cc: catalin.marinas@arm.com, linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

On Sat, Jan 19, 2019 at 07:55:40PM +0100, Tobias Klausmann wrote:
> There is no reason having arm64 not select these configurations by
> default!
> 
> Signed-off-by: Tobias Klausmann <tobias.johannes.klausmann@mni.thm.de>
> ---
>  arch/arm64/Kconfig | 5 +++++
>  1 file changed, 5 insertions(+)
> 
> diff --git a/arch/arm64/Kconfig b/arch/arm64/Kconfig
> index a4168d366127..91a5e1cd7279 100644
> --- a/arch/arm64/Kconfig
> +++ b/arch/arm64/Kconfig
> @@ -140,6 +140,11 @@ config ARM64
>  	select HAVE_GENERIC_DMA_COHERENT
>  	select HAVE_HW_BREAKPOINT if PERF_EVENTS
>  	select HAVE_IRQ_TIME_ACCOUNTING
> +	select HAVE_KERNEL_GZIP
> +	select HAVE_KERNEL_LZ4
> +	select HAVE_KERNEL_LZMA
> +	select HAVE_KERNEL_LZO
> +	select HAVE_KERNEL_XZ
>  	select HAVE_MEMBLOCK_NODE_MAP if NUMA
>  	select HAVE_NMI
>  	select HAVE_PATA_PLATFORM

I don't really understand what this patch achieves. We don't have a built-in
decompressor for arm64, as we defer to the bootloader to handle that for us
instead. The Image.gz target already produces a gzipped kernel payload.

What are you trying to do?

Will

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
