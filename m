Return-Path: <SRS0=T5WJ=OO=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.7 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B768AC04EB9
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Wed,  5 Dec 2018 08:10:36 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7E04F2084C
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Wed,  5 Dec 2018 08:10:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="EKJGwb5x";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="ewFQM0Vq"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7E04F2084C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:To:Subject:Message-ID:Date:From:
	In-Reply-To:References:MIME-Version:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=IuX/Ud0W+yKISRsUUJOFO3BrtI4SOup9hkABSx50vl8=; b=EKJGwb5xZ6mriW
	dLKWFz8UW/c6dQLe6QHdTGOrRhcXeXfcPdYB18sXZ3aGXtDHT1oke2VXLIJb4NwIYpipHP4dyVeGG
	KXEt53dY0jd6bqTlqzF9WI2UZJ85husCaoS+KfXQ/hByn5c5QXCTS14F+fVn567uIaR1ePNoxnkUr
	iTHaiincPLLuD2RIu/qx2bXh7f0Gob74o6mB1DHcMzX7hpb/YRq1+VdELKAO7XyzKh8Fzi+tjgxqU
	E0/p5OPgHiarWK3nZlAmSjbY1MaRi3OLlhGfo5tw6qe4pKAbTcpE1XFGxC04ZULqBeKWlTAW2w+T2
	CaAejp8GrndG6snwXJWw==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gUSGI-00038X-KW; Wed, 05 Dec 2018 08:10:26 +0000
Received: from mail-it1-x142.google.com ([2607:f8b0:4864:20::142])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gUSGC-0002Bp-3f
 for linux-arm-kernel@lists.infradead.org; Wed, 05 Dec 2018 08:10:24 +0000
Received: by mail-it1-x142.google.com with SMTP id a6so18890831itl.4
 for <linux-arm-kernel@lists.infradead.org>;
 Wed, 05 Dec 2018 00:10:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=oZ3hSwv8XRSBREnEXqtCrC4UEedzsNDdAjUoXfYalNw=;
 b=ewFQM0VqiOFg9qI5CSQ0Tbe7PkqavFPB5Fi1+3/uMSIxfHI23kxEUVaOljt0izfYRl
 k7MBOQfNdDPPSrgEeyc3cwwMFy8FUlwqgeOH/bxHAnKV8/fK7I2ADY0fQff88ce4AK2I
 9kAOg03LR6uYo7tcKl39suY981XQPMx/dJQ0I=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=oZ3hSwv8XRSBREnEXqtCrC4UEedzsNDdAjUoXfYalNw=;
 b=X7/9JShFk6TgZWSbOR8zxk+L9PRHWmTeBcHtHtOfzr897Ik56HA/DVKQkj9+rl/aFj
 57I+7Tl9ALQSyZzEYjnaOxS9t2VLAh8TJ13YDXKEoO3GoT9hpOLCIy2tYJHjHY9nktL+
 S1DtGmLKBcPjWBFFvVPrITgidRG0tyA0wfhzAzLFOW+X2J7zGUmzxXA7atuO1tdB3z7f
 dXzkdra1q8Pm0vo6DQsHLaPhGKAl9ojpCKJv4DAFmn42oixnKJdTdFaeVy3sPCP9l4R9
 51fDGmqzxVvc9NcoZG6NRz34ZHYwB87TFYPybnASjhw+btokOM+mvaY2zStvZwBuyMA+
 HhhQ==
X-Gm-Message-State: AA+aEWaSupFfqihoeeztszIHJ1kb35vNkgaD8ImMtieL8pjDrAIM+KjI
 I0kMyS0A4AKMmGcGnmQkHWWEZMMjZKRPy4leU0RdOA==
X-Google-Smtp-Source: AFSGD/XgScyNPdqqz4t4IlEYaAIiwvuydGMdGI5LldpztAWT+L6WELWwOB6zzpFPccWsajg/1/cKUiW+jIJG/x29ETE=
X-Received: by 2002:a02:183:: with SMTP id 3mr7522139jak.130.1543997408631;
 Wed, 05 Dec 2018 00:10:08 -0800 (PST)
MIME-Version: 1.0
References: <20181205014213.943-1-natechancellor@gmail.com>
 <20181205014213.943-2-natechancellor@gmail.com>
 <CAKv+Gu-N9j5X4WoFDbQrzeOCfBaNm6ujXe_fAruusE_kWdj8iQ@mail.gmail.com>
 <20181205080645.GA11936@flashbox>
In-Reply-To: <20181205080645.GA11936@flashbox>
From: Ard Biesheuvel <ard.biesheuvel@linaro.org>
Date: Wed, 5 Dec 2018 09:09:56 +0100
Message-ID: <CAKv+Gu9Nq51Fj_14MYS6MEm0VPHOJB1CBFkCHmyC8Wt0=NWpRg@mail.gmail.com>
Subject: Re: [PATCH 2/2] ARM: Wrap '--pic-veneer' with ld-option
To: Nathan Chancellor <natechancellor@gmail.com>, Arnd Bergmann <arnd@arndb.de>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20181205_001020_769235_A9B4194F 
X-CRM114-Status: GOOD (  22.92  )
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

(+ Arnd)

On Wed, 5 Dec 2018 at 09:06, Nathan Chancellor <natechancellor@gmail.com> wrote:
>
> On Wed, Dec 05, 2018 at 08:37:05AM +0100, Ard Biesheuvel wrote:
> > On Wed, 5 Dec 2018 at 02:42, Nathan Chancellor <natechancellor@gmail.com> wrote:
> > >
> > > This flag is not supported by lld:
> > >
> > >     ld.lld: error: unknown argument: --pic-veneer
> > >
> > > Signed-off-by: Nathan Chancellor <natechancellor@gmail.com>
> >
> > Hi Nate,
> >
> > Does this mean ld.lld is guaranteed to produce position independent
> > veneers if you build kernels that are bigger than the typical range of
> > a relative branch?
> >
>
> Hi Ard,
>
> Honestly, I'm not quite sure. I saw your commit that introduced this
> flag and I wasn't quite sure what to make of it for lld. What
> configuration would I use to verify and what would I check for?
>

Try building allyesconfig, and check the resulting binary for veneers
(which have 'veneer' in the symbol name, at least when ld.bfd emits
them). These veneers should not take the [virtual] address of the
branch target directly, but take a PC relative offset (as in the
example in the commit log of that patch you are referring to)

> Additionally, I have filed an LLVM bug for the lld developers to
> check and see if this is a flag they should support:
>
> https://bugs.llvm.org/show_bug.cgi?id=39886
>
> Thanks for the quick reply,
> Nathan
>
> > > ---
> > >  arch/arm/Makefile | 2 +-
> > >  1 file changed, 1 insertion(+), 1 deletion(-)
> > >
> > > diff --git a/arch/arm/Makefile b/arch/arm/Makefile
> > > index e2a0baf36766..4fab2aa29570 100644
> > > --- a/arch/arm/Makefile
> > > +++ b/arch/arm/Makefile
> > > @@ -10,7 +10,7 @@
> > >  #
> > >  # Copyright (C) 1995-2001 by Russell King
> > >
> > > -LDFLAGS_vmlinux        := --no-undefined -X --pic-veneer
> > > +LDFLAGS_vmlinux        := --no-undefined -X $(call ld-option,--pic-veneer)
> > >  ifeq ($(CONFIG_CPU_ENDIAN_BE8),y)
> > >  LDFLAGS_vmlinux        += --be8
> > >  KBUILD_LDFLAGS_MODULE  += --be8
> > > --
> > > 2.20.0.rc1
> > >

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
