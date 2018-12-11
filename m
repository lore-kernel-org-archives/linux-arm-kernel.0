Return-Path: <SRS0=rVA4=OU=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B4E6DC67839
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Tue, 11 Dec 2018 23:06:43 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8686120851
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Tue, 11 Dec 2018 23:06:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="haVOA0iN"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8686120851
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arndb.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:To:Subject:Message-ID:Date:From:
	In-Reply-To:References:MIME-Version:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=ZMDWBN1Kb34k1ehyuHQdSiJKIYSzS51xngnVrcOsh/c=; b=haVOA0iNqd4WEP
	WzaLNcqejceGDTvqPlVsD2XzQ4TZXX5DIgl6WXiLa5CvI/yxAyGvn7eY0Cuwr2lZ1K5Nzmz5Bt1lI
	g17LzXk+S22fG+ELpCWycNKU5B0yRS1YUkx0mAf3lnIr1FftLg1msguQarnAt0U+us67jtEkWcDpj
	wYTwxu8DPeU57wcCve+F4HJ3ApizIkQ9Fr6h5/rv5erE5+vNPmDwOjy8AyakTvI6J4KIB8w6KphLz
	5jMKORhQIwPqgIJyd9XN15XikawCNkc1XjiXgg7GdzFURnV3ts6QXZd32K1moUFKbou6CScYdYLqg
	QMi1qvuLYRkxGWcoYk6w==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gWr6u-0005Nx-7h; Tue, 11 Dec 2018 23:06:40 +0000
Received: from mail-qt1-f193.google.com ([209.85.160.193])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gWr6p-0005NI-Tk
 for linux-arm-kernel@lists.infradead.org; Tue, 11 Dec 2018 23:06:38 +0000
Received: by mail-qt1-f193.google.com with SMTP id p17so18494064qtl.5
 for <linux-arm-kernel@lists.infradead.org>;
 Tue, 11 Dec 2018 15:06:25 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=IkMmH1mhXU3VW4ObtR4ZJXKnvYitIo1p/cFOmAJ9SzA=;
 b=NiSnvBPvzwHpN2Vb7j9Cghk8rqm6YtNxX86/tpDCSqnc15hcoZkn3SdT3kxTaYQ1rS
 hBjZoapd5lLu67WIsF0wox+yCdntsynB1PMe/fL7+c8G035syHuFBRv2WKNHs4leOuWp
 G4IkRHX2eEV9611S/gJ5HqYTcVPQ9wpe9gStl4f3oTYjFmRiAGlecx76fsiigeTNqK7y
 wDuaIVpF6CeTxXl7CMtTfNbp+rLDvDO6n3SNgKGVRxfwN4lLb0NfiVXfLFfuVSGyAFIX
 pUv6etF4D4KGOWJHLxbCZf0EAFRRsO5GS9CoBUv6uu8pI4zm6hSOqQ9sAfhSysPG59Ry
 RKvg==
X-Gm-Message-State: AA+aEWYj0Fc0c6YWqa2XcRZSDUM4WGvy8aYJVBCKc7NspoFinRIXwg+e
 QXeibW18VWlWQyybB7YH4gBRJhAo6Qapa5M9+U8=
X-Google-Smtp-Source: AFSGD/X8jzW69BTylF8O0Ixvaa950UNnYKIbZ69F/PgNkgC9yD47Wkq1l5jsLWlTz5PBr8KsBbKFCTTa+YsO0f7qZ+o=
X-Received: by 2002:a0c:d992:: with SMTP id y18mr17559848qvj.161.1544569584375; 
 Tue, 11 Dec 2018 15:06:24 -0800 (PST)
MIME-Version: 1.0
References: <721E7B42-2D55-4866-9C1A-3E8D64F33F9C@gmx.us>
 <20181207223449.38808-1-cai@lca.pw>
 <CAK8P3a20kRDrkS1YFLp6cYeKcUoC9s+O_tnYNbKEMWGukia1Tg@mail.gmail.com>
 <1544548707.18411.3.camel@lca.pw>
 <CAK8P3a3ghizoj5xwkQayuwu2Z1HppSqHLwHGPp97dUG4upv+LA@mail.gmail.com>
 <1544565158.18411.5.camel@lca.pw>
 <CAK8P3a0DiaeHtUKhWGniXQfrx3DOk9goSXp_d2-dcMunY8jRyg@mail.gmail.com>
 <1544565572.18411.7.camel@lca.pw>
 <CAK8P3a2kStKc8bB1cXh=PEaVUMcg01o5AqtGM5NyJ0RT0JLPuA@mail.gmail.com>
 <1544566937.18411.9.camel@lca.pw>
In-Reply-To: <1544566937.18411.9.camel@lca.pw>
From: Arnd Bergmann <arnd@arndb.de>
Date: Wed, 12 Dec 2018 00:06:07 +0100
Message-ID: <CAK8P3a2T-DDfmpN_KcLB8cZKTszE4tohR8ChtktP3-du76hJog@mail.gmail.com>
Subject: Re: [PATCH] arm64: increase stack size for KASAN_EXTRA
To: cai@lca.pw
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20181211_150635_965766_F611AFE2 
X-CRM114-Status: GOOD (  18.42  )
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
 Will Deacon <will.deacon@arm.com>,
 Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
 kasan-dev <kasan-dev@googlegroups.com>, Linux-MM <linux-mm@kvack.org>,
 Alexander Potapenko <glider@google.com>,
 Linux ARM <linux-arm-kernel@lists.infradead.org>,
 Andrey Ryabinin <aryabinin@virtuozzo.com>, Dmitry Vyukov <dvyukov@google.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

On Tue, Dec 11, 2018 at 11:22 PM Qian Cai <cai@lca.pw> wrote:
>
> On Tue, 2018-12-11 at 23:12 +0100, Arnd Bergmann wrote:
> > On Tue, Dec 11, 2018 at 10:59 PM Qian Cai <cai@lca.pw> wrote:
> > >
> > > On Tue, 2018-12-11 at 22:56 +0100, Arnd Bergmann wrote:
> > > > On Tue, Dec 11, 2018 at 10:52 PM Qian Cai <cai@lca.pw> wrote:
> > > > > On Tue, 2018-12-11 at 22:43 +0100, Arnd Bergmann wrote:
> > > > > > On Tue, Dec 11, 2018 at 6:18 PM Qian Cai <cai@lca.pw> wrote:
> > > > >
> > > > > I am not too keen to do the version-check considering some LTS versions
> > > > > could
> > > > > just back-port those patches and the render the version-check
> > > > > incorrectly.
> > > >
> > > > I'm not following what the problem is. Do you mean distro versions gcc
> > > > with the compiler bugfix, or LTS kernel versions?
> > > >
> > >
> > > I mean distro versions of GCC where the version is still 8 but keep back-
> > > porting
> > > tons of patches.
> >
> > Ok, but in that case, checking the version would still be no worse
> > than your current patch, the only difference is that for users of a
> > fixed older gcc, the kernel would use more stack than it needs.
> >
>
> I am thinking about something it is probably best just waiting for those major
> distors to complete upgrading to GCC9 or back-porting those stack reduction
> patches first. Then, it is good time to tie up loose ends for those default
> stack sizes in all combinations.

I was basically trying to make sure we don't forget it when it gets to that.

Another alternative would be to just disable KASAN_EXTRA now
for gcc versions before 9, which essentially means for everyone,
but then we get it back once a working version gets released. As
I understand, this kasan option is actually fairly useless given its
cost, so very few people would miss it.

On a related note, I think we have to turn off asan-stack entirely
on all released clang versions. asan-stack in general is much more
useful than the use-after-scope check, but we clang produces some
very large stack frames with it and we probably can't even work
around it with KASAN_THREAD_SHIFT=2 but would need even
more than that otherwise.

         Arnd

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
