Return-Path: <SRS0=T5WJ=OO=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.7 required=3.0 tests=DKIMWL_WL_HIGH,
	DKIM_ADSP_CUSTOM_MED,DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 95FACC07E85
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Wed,  5 Dec 2018 14:39:22 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 52A4F214DE
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Wed,  5 Dec 2018 14:39:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="uCu4C+wa";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=google.com header.i=@google.com header.b="QtD8Rd2z"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 52A4F214DE
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=google.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:To:Subject:Message-ID:Date:From:
	In-Reply-To:References:MIME-Version:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=ZkL63PT8lD7tFpGHZo7F00T2QrGeZydX1DgA0OTntng=; b=uCu4C+wah6D1yI
	ysUegrjTshXgiLmQbjISkNatUOvm9WWVKbsTF//rSDxKk+Prtl/haMqdxj3k52NdQFFmyqnafQYkE
	GHn3GY0VWsWa5dyfvEZnd4p035zX6WRH+2xTftJZGzShEROFRkhgA3oQBte2jVBjvjfRlixpNSz+T
	3bnC43QwgjUU55H5l8ldTGryhINeMHSJ08QN+Xl+xCfBLRP8BhyR/r4rlwgWmHM5ijCfUbAvLinEN
	CcZapVU20szrI2tg4wV0Tim7/K1l/Z/IilpepOVTvr75iktG2iulahvqtBzZgeRJj6IJXS9wsBoTy
	qaodWvesAeGCaw0ZfYGg==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gUYKe-0004Mn-Lj; Wed, 05 Dec 2018 14:39:20 +0000
Received: from mail-it1-x144.google.com ([2607:f8b0:4864:20::144])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gUYKb-0004Li-EF
 for linux-arm-kernel@lists.infradead.org; Wed, 05 Dec 2018 14:39:18 +0000
Received: by mail-it1-x144.google.com with SMTP id m8so14326712itk.0
 for <linux-arm-kernel@lists.infradead.org>;
 Wed, 05 Dec 2018 06:39:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=AfOXIV3kOI3qtxrhTm2J4J0qZ9v3UgAv110TtUIKBK4=;
 b=QtD8Rd2zj0IAApCVU7eiDP1BuRKtvm5cySoRhLQjvSw/QmyHd7A76dG2yEvoB01yL0
 MBhP96q2b37n/JVf1ABMGJJ9IrrhUK6wX0+pEFg2Eccs5i2m/Wxv+oSTewhoJE7L5yWy
 4Hk7uFAFncsqVn408dX+9BTfxO1V8nSLQfeV1+R2wAMdFrDNkRIKZx9YIuEGU52+NVh9
 vgeKjqow1QXohGlgGIn/Uzm60ClLuG/v+aQUSDj6f3KYar02Y9p0sn+Q56Vhf7bnEqCK
 ebTm9n93DcQQp/p8XraFhz5uBuVCBOs3hmlVjXgD0v4maDImC3YIeoCfD1BkS1QmR+O4
 ZwGQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=AfOXIV3kOI3qtxrhTm2J4J0qZ9v3UgAv110TtUIKBK4=;
 b=S1w3Jnqeed/bCq4Vpv/4wFzbLx8IsNW77Vf4bODegr4sl+7PKp+v9UIPI8lPIfu2jG
 SAEwl3DiRCj1KZBLq2hvyvbO1CYxCgh9pWZhVUHhDYfmB2B6+s1YZUR8s4DNvTMpeuWH
 /eXndsHrS0m5EloV09BP1Ir5oocqvdjsF1eJQC2H15UZ/6gVit9CWwFvoVndqVrrArry
 KSPRhWE+JE2EAs1RAcDYEPs0UfTzLZNWRQrYzk44TZpSFkAAhUgdaFwhLQrqur2jOZ9e
 5RsAIEzDSYECRN+qmWAT+W53AFRZyEsCxRxF/Vx5n0UAxBrhh8uHVG4f9nfjed4toQE6
 fySg==
X-Gm-Message-State: AA+aEWY/PUpgxYpEb+5FuFzYh1FWagJvtGKKccqI3HHiSUlSHLw+zp8U
 Zcnb1uVoUPbgTLEimHoS/z+4wHgP0L8SeqYHYRAgYw==
X-Google-Smtp-Source: AFSGD/WiNRIrELB1ZSvPl8zS/QoprC/hMVq/xFwOtxQU5U8nRgWkPK+Cvg/bkZPyeVHuXu/3X3PV6qyAB0VTZ4CXmxI=
X-Received: by 2002:a05:660c:f94:: with SMTP id
 x20mr13815032itl.144.1544020743940; 
 Wed, 05 Dec 2018 06:39:03 -0800 (PST)
MIME-Version: 1.0
References: <1541712198.12945.12.camel@gmx.us>
 <D7C9EA14-C812-406F-9570-CFF36F4C3983@gmx.us>
 <20181110165938.lbt6dfamk2ljafcv@localhost>
 <a2a9180f-32cf-a0fa-3829-f36133e3b924@gmx.us>
In-Reply-To: <a2a9180f-32cf-a0fa-3829-f36133e3b924@gmx.us>
From: Dmitry Vyukov <dvyukov@google.com>
Date: Wed, 5 Dec 2018 15:38:51 +0100
Message-ID: <CACT4Y+ZXHgvHdZc=VDsiTSBCkG3FomEC3TAhZgw9-_L4RBukjQ@mail.gmail.com>
Subject: Re: kmemleak: Early log buffer exceeded (525980) during boot
To: cai@gmx.us
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20181205_063917_480565_05A2D09B 
X-CRM114-Status: GOOD (  16.78  )
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
 Will Deacon <will.deacon@arm.com>, LKML <linux-kernel@vger.kernel.org>,
 kasan-dev <kasan-dev@googlegroups.com>, Linux-MM <linux-mm@kvack.org>,
 Alexander Potapenko <glider@google.com>,
 Andrey Ryabinin <aryabinin@virtuozzo.com>,
 Linux ARM <linux-arm-kernel@lists.infradead.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

On Wed, Nov 28, 2018 at 5:21 AM Qian Cai <cai@gmx.us> wrote:
> On 11/10/18 11:59 AM, Catalin Marinas wrote:
> > On Sat, Nov 10, 2018 at 10:08:10AM -0500, Qian Cai wrote:
> >> On Nov 8, 2018, at 4:23 PM, Qian Cai <cai@gmx.us> wrote:
> >>> The maximum value for DEBUG_KMEMLEAK_EARLY_LOG_SIZE is only 40000, so it
> >>> disables kmemleak every time on this aarch64 server running the latest mainline
> >>> (b00d209).
> >>>
> >>> # echo scan > /sys/kernel/debug/kmemleak
> >>> -bash: echo: write error: Device or resource busy
> >>>
> >>> Any idea on how to enable kmemleak there?
> >>
> >> I have managed to hard-code DEBUG_KMEMLEAK_EARLY_LOG_SIZE to 600000,
> >
> > That's quite a high number, I wouldn't have thought it is needed.
> > Basically the early log buffer is only used until the slub allocator
> > gets initialised and kmemleak_init() is called from start_kernel(). I
> > don't know what allocates that much memory so early.
> >
>
> It turned out that kmemleak does not play well with KASAN on those aarch64 (HPE
> Apollo 70 and Huawei TaiShan 2280) servers.
>
> After calling start_kernel()->setup_arch()->kasan_init(), kmemleak early log
> buffer went from something like from 280 to 260000. The multitude of
> kmemleak_alloc() calls is,
>
> for_each_memblock(memory, reg) x \
> while (pgdp++, addr = next, addr != end) x \
> while (ptep++, addr = next, addr != end && \ pte_none(READ_ONCE(*ptep)))
>
> Is this expected?


FTR, this should be resolved by (if put pieces together correctly):
https://lkml.org/lkml/2018/11/29/191

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
