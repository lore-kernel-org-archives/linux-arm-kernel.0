Return-Path: <SRS0=P47x=QF=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BA000C169C4
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Tue, 29 Jan 2019 21:56:02 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7FBD02147A
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Tue, 29 Jan 2019 21:56:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="Mn6LT5g6";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="hhTnKk8x"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7FBD02147A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:To:Subject:Message-ID:Date:From:
	In-Reply-To:References:MIME-Version:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=OXY2QU9OarOzX71PcfHBjNXPqxzCk4jbHsM3Kct2yys=; b=Mn6LT5g6HDEGj1
	a4SoBeAkLaDVTP41Xdfawdnda3FtMmbSG7LdM+uxZFUv/avlNobYwHrhIYaIUJ9QTXeO77KsuIgdX
	jXxAf0UjEEyE2yzfX6pPw++SQwA7poxSrR9fUXkEfJcZcGjgI7Tdpx0km7JNCcq6EXJFOOpmQaI7i
	aYmeANJoGX80SmOWUdWf6fU6TscIve1JwjcuLHg/5RT+muaOibyDvrwKgJd6oi/fEzZWBYlJ2qqpr
	gjtiuPdAV4UGPEx7CCFNBCNW2ISP8kXBKr4V22HgZIRv9Uk2aINwIQe/694blfeo8+/2Ge153W7JF
	JbnxFUutQnfxcQQQU7Dw==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gobMP-0004LI-E3; Tue, 29 Jan 2019 21:56:01 +0000
Received: from mail-it1-x142.google.com ([2607:f8b0:4864:20::142])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gobMB-0004Iv-UC
 for linux-arm-kernel@lists.infradead.org; Tue, 29 Jan 2019 21:55:50 +0000
Received: by mail-it1-x142.google.com with SMTP id b5so7136648iti.2
 for <linux-arm-kernel@lists.infradead.org>;
 Tue, 29 Jan 2019 13:55:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=/UgM09a85sE+QPqW4qdRBSbqyTilNpA4NhKBhFmZZLI=;
 b=hhTnKk8xeLnpU13y78ThWoQPOIAGSmURE4yF/cXtHccZKxxxx5g2QVUtIZf/U7f5Sq
 2oJ/z6aGELW5h49ekBidWoPHZjJvIzuw0D+MWsIJqmgoLGUqLxtGPyU3eUsqovJJfaGH
 KY18iYvvka0Fjo6/mJlHl6pgvQdbo/yCEvzH8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=/UgM09a85sE+QPqW4qdRBSbqyTilNpA4NhKBhFmZZLI=;
 b=ZRcL/HMDadp5nqyHFNgmtDRP+Tz8hmnlvTh906JbPIKcBwhXA6sf91LDQKpezxhBkt
 1bAF4rMHYUa2UWO+177SWaGM+KN892YrtvDnRWxJPq+Y5jqxB4YgSXkl86TusUs5jaGe
 fdIfUsV/1WJjneE3BQqg6/NtL4Zo23APE1ov6FF/uD3FcPkEStScVBRPDWM1JKLCKPH7
 67c6KOq7k0qsb/QxiNiBidtCW2FSA86EVLdIs0xA1Ab+v4p7L+siUpmXgWW3DnLETdQG
 nkstriAmnNsrQvIYrDMH4afiY32HpGqdW0RCp0ePsmiAXYsjNyySn6pojkQn0QsbBP+d
 NFHw==
X-Gm-Message-State: AJcUukfUgyQjn4MP++GEA81HyY7IJDArCIHO11woW49oOB0D9/emQHjA
 7b7ptzEqz/+jfyPcok7efcvU4vGeXYUuxRvVsYukvw==
X-Google-Smtp-Source: ALg8bN4uPG2olnus5GewXMy3YM3HktNZ/Z6Usf2jWEToB4dlTWt8ViCoIHPplrxk6ptbnVrZ5TpHMG74SV+UiFcEskQ=
X-Received: by 2002:a24:edc4:: with SMTP id
 r187mr15816072ith.158.1548798946768; 
 Tue, 29 Jan 2019 13:55:46 -0800 (PST)
MIME-Version: 1.0
References: <20190127082942.21998-1-ard.biesheuvel@linaro.org>
 <20190129181809.GD224095@arrakis.emea.arm.com>
In-Reply-To: <20190129181809.GD224095@arrakis.emea.arm.com>
From: Ard Biesheuvel <ard.biesheuvel@linaro.org>
Date: Tue, 29 Jan 2019 22:55:35 +0100
Message-ID: <CAKv+Gu_enWCXeYsaFRZeoU4ZVhD_qz2oQ2YOW+bSgLMc30hiLA@mail.gmail.com>
Subject: Re: [PATCH] arm64: kaslr: ensure randomized quantities are clean also
 when kaslr is off
To: Catalin Marinas <catalin.marinas@arm.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190129_135548_002574_08D190C3 
X-CRM114-Status: GOOD (  20.75  )
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
Cc: Will Deacon <will.deacon@arm.com>, stable <stable@vger.kernel.org>,
 linux-arm-kernel <linux-arm-kernel@lists.infradead.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

On Tue, 29 Jan 2019 at 19:18, Catalin Marinas <catalin.marinas@arm.com> wrote:
>
> On Sun, Jan 27, 2019 at 09:29:42AM +0100, Ard Biesheuvel wrote:
> > Commit 1598ecda7b23 ("arm64: kaslr: ensure randomized quantities are
> > clean to the PoC") added cache maintenance to ensure that global
> > variables set by the kaslr init routine are not wiped clean due to
> > cache invalidation occurring during the second round of page table
> > creation.
> >
> > However, if kaslr_early_init() exits early with no randomization
> > being applied (either due to the lack of a seed, or because the user
> > has disabled kaslr explicitly), no cache maintenance is performed,
> > leading to the same issue we attempted to fix earlier, as far as the
> > module_alloc_base variable is concerned.
> >
> > Note that module_alloc_base cannot be initialized statically, because
> > that would cause it to be subject to a R_AARCH64_RELATIVE relocation,
> > causing it to be overwritten by the second round of KASLR relocation
> > processing.
> >
> > Fixes: f80fb3a3d508 ("arm64: add support for kernel ASLR")
> > Cc: <stable@vger.kernel.org> # v4.6+
> > Signed-off-by: Ard Biesheuvel <ard.biesheuvel@linaro.org>
> > ---
> >  arch/arm64/kernel/kaslr.c | 1 +
> >  1 file changed, 1 insertion(+)
> >
> > diff --git a/arch/arm64/kernel/kaslr.c b/arch/arm64/kernel/kaslr.c
> > index ba6b41790fcd..b09b6f75f759 100644
> > --- a/arch/arm64/kernel/kaslr.c
> > +++ b/arch/arm64/kernel/kaslr.c
> > @@ -88,6 +88,7 @@ u64 __init kaslr_early_init(u64 dt_phys)
> >        * we end up running with module randomization disabled.
> >        */
> >       module_alloc_base = (u64)_etext - MODULES_VSIZE;
> > +     __flush_dcache_area(&module_alloc_base, sizeof(module_alloc_base));
>
> Do we need something similar of memstart_offset_seed? If yes, you could
> as well change the returns to a goto out.
>

No, that gets initialized to zero statically, so it isn't affected by this.

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
