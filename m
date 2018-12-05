Return-Path: <SRS0=T5WJ=OO=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.7 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 73E91C04EB9
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Wed,  5 Dec 2018 07:37:35 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 41EF920850
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Wed,  5 Dec 2018 07:37:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="X/5cZfbx";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="DQXrHnki"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 41EF920850
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:To:Subject:Message-ID:Date:From:
	In-Reply-To:References:MIME-Version:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=RfWHYYMovUyzFZzpyaR52MGFKZPN9JYMZy47ta27ZWc=; b=X/5cZfbxKTuL/+
	Kxc6HWKRC9nvV2gKu+Bweb80Xt2OIdcRiWnru32WRdrXpelOqOGWYWX3sNBPrkeP6Uaz+sS3suAob
	IgplzSUVdpOiHO8onwX1wYxgxaxy5A3UCfhsjHivBFYpOhP6/EtL7csm3Iasq//adryLIJrcYwmkc
	ndfb0t4FywTuyKYXaj5CuBawWNbciXAuUGQLY0QFoeowgzjkahSodqFIL1glWk/cWj/bgshVSeLjR
	lLvde6jX9t8P3eUCyoxaHBNxHZyacsnLmRd/zK/Tvpsk/x2/upkrfUmaXpYpJT4t8fJWzNgR/pfmN
	vAvyjGWxSbSRnYkmaG1w==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gURkU-0006RD-7Q; Wed, 05 Dec 2018 07:37:34 +0000
Received: from mail-it1-x143.google.com ([2607:f8b0:4864:20::143])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gURkQ-0006QJ-88
 for linux-arm-kernel@lists.infradead.org; Wed, 05 Dec 2018 07:37:31 +0000
Received: by mail-it1-x143.google.com with SMTP id h193so18767001ita.5
 for <linux-arm-kernel@lists.infradead.org>;
 Tue, 04 Dec 2018 23:37:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=jkTrNYt7fjmOkBFR9cCizpTwwY6al+R2nNwW1id0OOI=;
 b=DQXrHnki7jtuYUyULs1gG8aYTelYlu9U2HKkn49V6Bi8ETw0H7u8VxBE7VWlGGW8V5
 1FvlSTAwGv97K+hYSKhPHMuJZjmnRNEUQEIZiK9RbJKgmxdg2E1ka/S99S18wxeqb7+p
 WZ2CoW1Bl1/FKjgNRNltVNRaNKzE1wnZnDxMA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=jkTrNYt7fjmOkBFR9cCizpTwwY6al+R2nNwW1id0OOI=;
 b=eKiM0SEzb5mCon2Z+a0ovVfht3KayXGmoe5D8l+f1yORG1wPVak2jOmzoKQqP6I1Rk
 tgCBlTixom6YcFSvRqGRtFlDcLhTK+U2xqCk2WThwYHwUbmMh3Ez9Fe4bhv8gIpvtNd/
 IlDO2bgEPwy03JN4z+RDm0Fzp3S4ZLHUdEk02Db6XN3Kn8wkWN0ilQt/U3+kymPNaNpL
 u84Hiler0xST+M+NoHoEy8yFuDCekNhnrJ4IQgrHUY5VjwlM1RKZtQqj18rygzrKFktq
 j8fti/ktclCGkja2x3uQgJ86q1Wz0HFarPVFg8MN3iEtksFj1wKse+IEO/sL1Dd06tNq
 uNSg==
X-Gm-Message-State: AA+aEWaOy3nsjUTB9JxO15aBt5D2EA3Q2ETPa0VqGmfqBooaGYXlMVl2
 ob46PNuT/K9jNzepS+kBzYV2YrPtz1DdbVKt/FhdOpOM
X-Google-Smtp-Source: AFSGD/VCyKQfzSXzXgDR2De+wqxXCuOPT3UAT7e/DRrdAiCRdHADdSGVHQu9OfJGOSnlJ6B0ZcsNheQoEHkYmoDCh1I=
X-Received: by 2002:a24:edc4:: with SMTP id
 r187mr15716842ith.158.1543995437578; 
 Tue, 04 Dec 2018 23:37:17 -0800 (PST)
MIME-Version: 1.0
References: <20181205014213.943-1-natechancellor@gmail.com>
 <20181205014213.943-2-natechancellor@gmail.com>
In-Reply-To: <20181205014213.943-2-natechancellor@gmail.com>
From: Ard Biesheuvel <ard.biesheuvel@linaro.org>
Date: Wed, 5 Dec 2018 08:37:05 +0100
Message-ID: <CAKv+Gu-N9j5X4WoFDbQrzeOCfBaNm6ujXe_fAruusE_kWdj8iQ@mail.gmail.com>
Subject: Re: [PATCH 2/2] ARM: Wrap '--pic-veneer' with ld-option
To: Nathan Chancellor <natechancellor@gmail.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20181204_233730_287173_801EFC59 
X-CRM114-Status: GOOD (  14.79  )
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
Cc: Nicolas Pitre <nicolas.pitre@linaro.org>,
 Nick Desaulniers <ndesaulniers@google.com>,
 Russell King <linux@armlinux.org.uk>, Stefan Agner <stefan@agner.ch>,
 Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
 linux-arm-kernel <linux-arm-kernel@lists.infradead.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

On Wed, 5 Dec 2018 at 02:42, Nathan Chancellor <natechancellor@gmail.com> wrote:
>
> This flag is not supported by lld:
>
>     ld.lld: error: unknown argument: --pic-veneer
>
> Signed-off-by: Nathan Chancellor <natechancellor@gmail.com>

Hi Nate,

Does this mean ld.lld is guaranteed to produce position independent
veneers if you build kernels that are bigger than the typical range of
a relative branch?

> ---
>  arch/arm/Makefile | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/arch/arm/Makefile b/arch/arm/Makefile
> index e2a0baf36766..4fab2aa29570 100644
> --- a/arch/arm/Makefile
> +++ b/arch/arm/Makefile
> @@ -10,7 +10,7 @@
>  #
>  # Copyright (C) 1995-2001 by Russell King
>
> -LDFLAGS_vmlinux        := --no-undefined -X --pic-veneer
> +LDFLAGS_vmlinux        := --no-undefined -X $(call ld-option,--pic-veneer)
>  ifeq ($(CONFIG_CPU_ENDIAN_BE8),y)
>  LDFLAGS_vmlinux        += --be8
>  KBUILD_LDFLAGS_MODULE  += --be8
> --
> 2.20.0.rc1
>

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
