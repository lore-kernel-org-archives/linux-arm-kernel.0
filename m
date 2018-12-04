Return-Path: <SRS0=gVCq=ON=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.2 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C5D17C04EB8
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Tue,  4 Dec 2018 15:32:03 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7B0652081C
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Tue,  4 Dec 2018 15:32:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="JZsnDgEh";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="10VOnRLw"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7B0652081C
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:
	Message-ID:Subject:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=I1u4NBlCfCWaSrmfvpKZ+8sOZibVKiKuk5Nw88wvKv0=; b=JZsnDgEhXZp3aA
	ioRV/qXAhcsvNfD3tq7bB23UtPEIc79FH165XsWT52Ojm8vssxTt6OcS4dYmYA3m+/wAJ1N4h4st1
	pS6eTYRgIFVxZtrY15U0xEtgRIy37f1opoKzkaqHq4+n7GBLmXDzpGRNkJo+61aYGzaNdUjRzhJe5
	RutNKaOa8f5SdIQM7Thw4p2GnMSjTrmDJXXS2opsjpp95xpTCZProhP/kZ+7yfCd5SJSwkWKB4kYx
	uxNVXKe5IBrfMAc2/3/wK47D9/R6wuxBxjHaz/mzOMGxXBoXQfVURDsH+pXqq1U3PyvDmKsqZt9d5
	/9mMm5nlPGml/eQMvYZA==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gUCg4-0002oM-0R; Tue, 04 Dec 2018 15:32:00 +0000
Received: from merlin.infradead.org ([2001:8b0:10b:1231::1])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gUCfY-0002E3-Qk
 for linux-arm-kernel@bombadil.infradead.org; Tue, 04 Dec 2018 15:31:28 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=infradead.org; s=merlin.20170209; h=In-Reply-To:Content-Type:MIME-Version:
 References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
 Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
 Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
 List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=yUuhCrnSRvW4I1vOhY6BIiGqt7BxyQcGedPYq1+07SM=; b=10VOnRLw2vw2GFBqMW4cdZOPH
 PvfgWhHiRsQbK1XOJ4qlLICLZD/0u8ClXB9TYaZ0k6aZ5a1E7sgrlA/pgR9RirQZzt/U7yCO/Bv3v
 GvmKq/8D7vbUaODxNmpsfIvIIFY7aSqkNhAnahf7fLsd4UhptAyi+eG0i0FIORLvyhmEIw/Wn82M2
 ei/oyJElWiE0ABgL/a9xyB09xZU7dJZd/z9fY7PmID6uZc1Z2svEsMsIJ9d976REwLlJfDy2MELAh
 LJSvaYjCxcZADhLj8jJCJmJGC8/nKFUz3hLPeN8CS8siNN2Arj2Rylc4/0wuAh4sTs02jHs+xoYxi
 SD/uAnmxQ==;
Received: from usa-sjc-mx-foss1.foss.arm.com ([217.140.101.70]
 helo=foss.arm.com)
 by merlin.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gUBW6-0001pn-9V
 for linux-arm-kernel@lists.infradead.org; Tue, 04 Dec 2018 14:17:39 +0000
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id CD9BF15BE;
 Tue,  4 Dec 2018 06:17:24 -0800 (PST)
Received: from edgewater-inn.cambridge.arm.com
 (usa-sjc-imap-foss1.foss.arm.com [10.72.51.249])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 9D51E3F5AF;
 Tue,  4 Dec 2018 06:17:24 -0800 (PST)
Received: by edgewater-inn.cambridge.arm.com (Postfix, from userid 1000)
 id F38B01AE121C; Tue,  4 Dec 2018 14:17:44 +0000 (GMT)
Date: Tue, 4 Dec 2018 14:17:44 +0000
From: Will Deacon <will.deacon@arm.com>
To: Ard Biesheuvel <ard.biesheuvel@linaro.org>
Subject: Re: [PATCH] arm64: relocatable: fix inconsistencies in linker script
 and options
Message-ID: <20181204141744.GA6269@arm.com>
References: <20181203195805.28835-1-ard.biesheuvel@linaro.org>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20181203195805.28835-1-ard.biesheuvel@linaro.org>
User-Agent: Mutt/1.5.23 (2014-03-12)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20181204_091738_435009_9E3D0B3F 
X-CRM114-Status: GOOD (  22.58  )
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
Cc: catalin.marinas@arm.com, Peter Smith <peter.smith@linaro.org>,
 Nick Desaulniers <ndesaulniers@google.com>,
 linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

Hey Ard,

On Mon, Dec 03, 2018 at 08:58:05PM +0100, Ard Biesheuvel wrote:
> readelf complains about the section layout of vmlinux when building
> with CONFIG_RELOCATABLE=y (for KASLR):
> 
>   readelf: Warning: [21]: Link field (0) should index a symtab section.
>   readelf: Warning: [21]: Info field (0) should index a relocatable section.
> 
> Also, it seems that our use of '-pie -shared' is contradictory, and
> thus ambiguous. In general, the way KASLR is wired up at the moment
> is highly tailored to how ld.bfd happens to implement (and conflate)
> PIE executables and shared libraries, so given the current effort to
> support other toolchains, let's fix some of these issues as well.
> 
> - Drop the -pie linker argument and just leave -shared. In ld.bfd,
>   the differences between them are unclear (except for the ELF type
>   of the produced image [0]) but lld chokes on seeing both at the
>   same time.
> 
> - Rename the .rela output section to .rela.dyn, as is customary for
>   shared libraries and PIE executables, so that it is not misidentified
>   by readelf as a static relocation section (producing the warnings
>   above).
> 
> - Pass the -z notext and -z norelro options to explicitly instruct the
>   linker to permit text relocations, and to omit the RELRO program
>   header (which requires a certain section layout that we don't adhere
>   to in the kernel). These are the defaults for current versions of
>   ld.bfd.
> 
> - Discard .eh_frame and .gnu.hash sections to avoid them from being
>   emitted between .head.text and .text, screwing up the section layout.
> 
> These changes only affect the ELF image, and produce the same binary
> image.

Thanks, I've queued this up on for-next/core.

> [0] b9dce7f1ba01 ("arm64: kernel: force ET_DYN ELF type for ...")
> 
> Cc: Nick Desaulniers <ndesaulniers@google.com>
> Cc: Peter Smith <peter.smith@linaro.org>
> Tested-by: Nick Desaulniers <ndesaulniers@google.com>
> Signed-off-by: Ard Biesheuvel <ard.biesheuvel@linaro.org>
> ---
> This supersedes
> 
> [RFT PATCH] arm64: relocatable: build the kernel as a proper shared library
> [RFT PATCH] arm64: add support for building the KASLR kernel with LLVM lld

Also, this ^^ is /really/ helpful :)

Thanks,

Will

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
