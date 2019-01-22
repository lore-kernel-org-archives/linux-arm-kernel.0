Return-Path: <SRS0=B2vk=P6=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 13D47C282C3
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Tue, 22 Jan 2019 12:10:57 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D92E720855
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Tue, 22 Jan 2019 12:10:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="lczd89mO";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="Mn8L1SAm"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D92E720855
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:To:Subject:Message-ID:Date:From:
	In-Reply-To:References:MIME-Version:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=ikI5ulwNnsJyjYaflXRqyL1VJDIyNqlOCTbbYTTYpXU=; b=lczd89mOo2EYui
	0ex6wuC3ZdMPvWbAtgwk7sq5SyO2A8IHq4JPGhhSldalE3tajALL216Q3h6vOrBuYYlE7N+0t7X+I
	4iSIZwD1pzNQXX2igSmSgKuOtvk9nYIzhHuvY3IFCF9YdtLaoCCxly+zHJr4RfJRnxe0FlKCvtWcf
	kcp2sKZ8jLPgHpi+hf2StWv4AhLXLV56f427SCBlmOKl0m9U+t1ghDql9RQSONyMXwlM7rs4iUe1c
	MQMSp8HXd0AEJPHf8bb2V1pkdvbN1kMMI7O2ulcSuU4lAFX+dsoOgd6za6BA8VJX8McYSkaL5B4AP
	32oIN1MYLqxloWY1sMRg==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1glutJ-0002S0-KJ; Tue, 22 Jan 2019 12:10:53 +0000
Received: from mail-it1-x142.google.com ([2607:f8b0:4864:20::142])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1glutG-0002Re-8R
 for linux-arm-kernel@lists.infradead.org; Tue, 22 Jan 2019 12:10:51 +0000
Received: by mail-it1-x142.google.com with SMTP id a6so19734221itl.4
 for <linux-arm-kernel@lists.infradead.org>;
 Tue, 22 Jan 2019 04:10:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=fgyviMJw6/fPmrPcsOmHINfDRRWihUQ9XsgPMv+R9UQ=;
 b=Mn8L1SAmGyRhB3IMB973O5xqjUDdnHpKGJvh/MXTC/ACbFLv9NhDqCmqI3Km41z6Ji
 XyWzzrDRsRnNteT3B/Y8UK0a+Vcb2xcdBBmrkpFulwc2sFUVx9NoJoCj9BL0F/0cn64f
 Yq2i2MSOe2J3xbsLrBeSo18H+Z9bdCYw+UWF4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=fgyviMJw6/fPmrPcsOmHINfDRRWihUQ9XsgPMv+R9UQ=;
 b=q0DoRwpLvEwWCq0VHXhlB7RnB2q8l0AYtqyF0/IElA7pb2DSbD7dLBBAvD8y7nD10p
 1sjoJ1z8mFTyP4hkyCeZVwILSiHMCP/r0VgaeihB5zEaT+kOA/mpWLCwH4+Sd12XoIT3
 +yWWAw0bYpSKuKmLcRI6hehlhQttwXuAy36FuOMWldkC7ih+cUeGLGtPCza0ebC4xG8q
 yKuTkuLOaNP/x7jHQY1m48GBkEa+lGx9IYqHdvLY9jdpYaOlTA947HqYv0RKafF4+MAk
 uj8rk0JCCzeBOzeV9qinYFGbnkA+byxskX81e32PG26EW2iXLTB2QWxp2jjDHQqq65AY
 ZVJw==
X-Gm-Message-State: AJcUukcEBdgx38xGJoBOH27NgycY2Z3TmFfjjSuggwK+IjNKgXeYxpSn
 4/hgor2WeGRuOvjp+ZOL3iG2xM1b6gnZ2ng1CO1UCw==
X-Google-Smtp-Source: ALg8bN6vCB1/YFqCqDYnITCQrFMsMe81p/IjbGhBFMa+S8huw2sEbxviwj93eQAnjSYWvEmOyJSMkI/baZjqSn8aK40=
X-Received: by 2002:a02:4c9:: with SMTP id 192mr19768753jab.2.1548159048561;
 Tue, 22 Jan 2019 04:10:48 -0800 (PST)
MIME-Version: 1.0
References: <20190118174324.24715-1-ard.biesheuvel@linaro.org>
 <abe25b84-4327-c927-6d91-629291a62b69@arm.com>
In-Reply-To: <abe25b84-4327-c927-6d91-629291a62b69@arm.com>
From: Ard Biesheuvel <ard.biesheuvel@linaro.org>
Date: Tue, 22 Jan 2019 13:10:37 +0100
Message-ID: <CAKv+Gu81ZRn5pTDyHeVSR4A=WmspC3aWtFyfRpzdH7gASRQH-g@mail.gmail.com>
Subject: Re: [RFC PATCH] arm64: efi: fix chicken-and-egg problem in memreserve
 code
To: James Morse <james.morse@arm.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190122_041050_309764_4D95F01C 
X-CRM114-Status: GOOD (  23.24  )
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
Cc: Mark Rutland <mark.rutland@arm.com>, linux-efi <linux-efi@vger.kernel.org>,
 Marc Zyngier <marc.zyngier@arm.com>, Catalin Marinas <catalin.marinas@arm.com>,
 Will Deacon <will.deacon@arm.com>,
 linux-arm-kernel <linux-arm-kernel@lists.infradead.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

On Tue, 22 Jan 2019 at 12:32, James Morse <james.morse@arm.com> wrote:
>
> Hi Ard,
>
> On 18/01/2019 17:43, Ard Biesheuvel wrote:
> > Unfortunately, it appears that the recently introduced and repaired
> > EFI memreserve code is still broken.
> >
> > Originally, we applied all memory reservation passed via the EFI table
> > before doing any memblock allocations. However, this turned out to be
> > problematic, given that the number of reservations is unbounded, and
> > a GICv3 system will reserve a block of memory for each CPU, resulting
> > in hundreds of reservations.
> >
> > We 'fixed' this by deferring the reservations in the memblock table
> > until after we enabled memblock resizing. However, to reach this
> > point, we must have mapped DRAM and the kernel, which itself relies
> > on some memblock allocations for page tables. Also, memblock resizing
> > itself relies on the ability to invoke memblock_alloc() to reallocate
> > those tables themselves.
> >
> > So this is a nice chicken-and-egg problem which is rather difficult
> > to fix cleanly. So instead of a clean solution, I came up with the
> > patch below.
> >
> > The idea is to set a memblock allocation limit below the lowest
> > reservation entry that occurs in the memreserve table. This way,
> > we can map DRAM and the kernel and enable memblock resizing without
> > running the risk of clobbering those reserved regions. After applying
> > all the reservations, the memblock limit restriction is lifted again,
> > allowing the boot to proceed normally.
>
> .... how does this interact with kdump? Is it possible the crash-kernel region
> is above the lowest reservation entry, meaning there is no usable memory?
>

I suppose that is possible, yes ...

>
> > The problem with this approach is that it is not guaranteed that the
> > temporary limit will leave enough memory to allocate the page tables
> > and resize the memblock reserved array. Since this is only 10s of KBs,
> > it is unlikely to break in practice, but some pathological behavior
> > may still occur, which is rather nasty :-(
>
> As I understand it, the in-kernel-image memblock_reserved_init_regions is used
> early on, because we don't know where the reserved regions of memory are, but
> INIT_MEMBLOCK_REGIONS should be big enough to describe them. We trip up when it
> isn't big enough, and we can't resize it yet.
>

Indeed. If we could establish a reasonable upper bound for the
statically allocated size, the issue would not exist.

> ... thinking out loud ...
>
> Does reserve_regions() know how big that array needs to be?
> (it can count the nomap and persistent reservations, as well as the gaps between
> memory banks).
>
> Could we 'allocate' that array to be big enough for everything learnt via EFI in
> reserve_regions()? It memblock_remove()s all existing memory, so we know at this
> point there aren't existing reservations/allocations.
>

I am not sure I follow. Re-allocating the memblock array involves
allocating some memory and moving the array into it. The complicating
factor is that that memory has to be mapped at that point, which is
not the case when reserve_regions() executes.

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
