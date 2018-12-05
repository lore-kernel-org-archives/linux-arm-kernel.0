Return-Path: <SRS0=T5WJ=OO=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.7 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9CE55C04EB9
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Wed,  5 Dec 2018 05:51:42 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6D8A920672
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Wed,  5 Dec 2018 05:51:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="SGtl7/1Z";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="CwgbkZCA"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6D8A920672
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=chromium.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:To:Subject:Message-ID:Date:From:
	In-Reply-To:References:MIME-Version:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=CNp/SvNzz9TeVMEpX7pM84Qvluy06FX8XgoDdp2hCfQ=; b=SGtl7/1Z6p5yOV
	F7OyBkSdyiAJa2s2stI2rSBeB2Ql8khd7c+U0H1p3LgPo5rsokcHd0S2JYcLwawv/4yX7C+KTrZu6
	nzH5PgFG/Ac9/oZTluhF0yZZAVfqqP0UnMaYRCT8vtxRDOsSoxPf6pSEQrmoY8QchNy7BsLhH86Jb
	MQ8Y7Bm+cxkpjjOD2GU5Q2SbjbTuLlnCkG/N01yfIP7LKcPUeRQaqGD5bYYzUm2lE21MwH/DQd4PK
	TQNMCg5aWFV0uWBay2k+piv/XyAuccX+LPlBeyClxfoEhnwGtK+GglQqdugvD7YpBWTJJ/GNrQkzq
	Dieakgrch8Q218A9FHmg==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gUQ61-0000CI-Md; Wed, 05 Dec 2018 05:51:41 +0000
Received: from mail-pg1-x543.google.com ([2607:f8b0:4864:20::543])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gUQ5y-0000BW-Ot
 for linux-arm-kernel@lists.infradead.org; Wed, 05 Dec 2018 05:51:40 +0000
Received: by mail-pg1-x543.google.com with SMTP id z10so8488500pgp.7
 for <linux-arm-kernel@lists.infradead.org>;
 Tue, 04 Dec 2018 21:51:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=chromium.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=+7B9CTpvYp8u/sULrhl76RfRou0xrjyBsdRlbjKE8Ho=;
 b=CwgbkZCAdv5iXvavxspbZTlrvci7haOVEDqSV54ieGnR8NmMDEk5kOiEihAwY2EDXR
 GslGbiUVCkW9dDlHGAxZFUE9wLWC1s9nS4QR+tXos15jBfJGk2BkGPvNtR7OqbCFfHZQ
 9gRsdtV15ckj7dBeNrIZ7mKV3SnEr6Bo9DJvs=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=+7B9CTpvYp8u/sULrhl76RfRou0xrjyBsdRlbjKE8Ho=;
 b=VvkIzXwEAfk3CbYKh+Touv9XISbq60+TEJ3ecG7Jl2uQtGLfUgwJun83Y6RsjleOgo
 vY5s81xeF2EaD4zD+pPfhcK7sV7wjznrHpeJ3Ch4aK9kBkHSeNYQ/Xi1pgqKrZZSPxu0
 CMeitqXysRYQG94OJqU2zdRrYFoEXQEIjy84CVGuI77oKiRmFBpgwch51Y6qSAHYZ2yE
 TN8kgdIRe1w2bq8p4BhBu8lhzwjCw5ICCkiDBXqsEHuxwnTC6HmpkPGI9W+5zsWoMi2+
 Bh9KC0e4m+Ea+EOKK3SpTAp1UAQiU+1LfR2MqICQJ5Uir/D+Syyo7zpVPe5yd01LrAG+
 +bzw==
X-Gm-Message-State: AA+aEWa076n+7RFKjklIS6Esb1l+3Sc0291EStcObowIfpUtC62w2zTb
 mpap1Lx929B12O6+UdOyJXY6VeA2lk9gnaVxy4PoEg==
X-Google-Smtp-Source: AFSGD/WnqzvPNxEcwdeKF0Z3YYSXuv2XwN4gyJTrVZxB7RcC9HXuRyiJWFGIlBYYfacjsjjz7eYfkfdNkFkfIbwfXWo=
X-Received: by 2002:a63:7cf:: with SMTP id 198mr19694633pgh.129.1543989088019; 
 Tue, 04 Dec 2018 21:51:28 -0800 (PST)
MIME-Version: 1.0
References: <20181111090341.120786-1-drinkcat@chromium.org>
 <CANMq1KDxmRcWhtaJbrLHqx6yPGkNaK7WNYYf+iFjH1e8XdrwRg@mail.gmail.com>
 <b99dd00f-fe1c-1cac-8ee3-5b0c1af9a92e@suse.cz>
 <CANMq1KDzKJqJwGsW3A90JY_0kgDtAMjOikT-3C9zQG01=3dibQ@mail.gmail.com>
In-Reply-To: <CANMq1KDzKJqJwGsW3A90JY_0kgDtAMjOikT-3C9zQG01=3dibQ@mail.gmail.com>
From: Nicolas Boichat <drinkcat@chromium.org>
Date: Wed, 5 Dec 2018 13:51:16 +0800
Message-ID: <CANMq1KAd4SzyWY+=fS4aeqyj_b3y7AUXmdoUWe3X1gq=ATOD5Q@mail.gmail.com>
Subject: Re: [PATCH v2 0/3] iommu/io-pgtable-arm-v7s: Use DMA32 zone for page
 tables
To: Vlastimil Babka <vbabka@suse.cz>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20181204_215138_819827_563A553D 
X-CRM114-Status: GOOD (  28.40  )
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
Cc: Michal Hocko <mhocko@suse.com>, Will Deacon <will.deacon@arm.com>,
 Daniel Kurtz <djkurtz@chromium.org>,
 Levin Alexander <Alexander.Levin@microsoft.com>, linux-mm@kvack.org,
 Christoph Lameter <cl@linux.com>, Huaisheng Ye <yehs1@lenovo.com>,
 Joerg Roedel <joro@8bytes.org>, Matthew Wilcox <willy@infradead.org>,
 hch@infradead.org,
 linux-arm Mailing List <linux-arm-kernel@lists.infradead.org>,
 David Rientjes <rientjes@google.com>, yingjoe.chen@mediatek.com,
 Tomasz Figa <tfiga@google.com>, Mike Rapoport <rppt@linux.vnet.ibm.com>,
 Hsin-Yi Wang <hsinyi@chromium.org>, Matthias Brugger <matthias.bgg@gmail.com>,
 Joonsoo Kim <iamjoonsoo.kim@lge.com>, Yong Wu <yong.wu@mediatek.com>,
 Robin Murphy <robin.murphy@arm.com>, lkml <linux-kernel@vger.kernel.org>,
 Pekka Enberg <penberg@kernel.org>, iommu@lists.linux-foundation.org,
 Andrew Morton <akpm@linux-foundation.org>,
 Mel Gorman <mgorman@techsingularity.net>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

On Wed, Dec 5, 2018 at 10:04 AM Nicolas Boichat <drinkcat@chromium.org> wrote:
>
> On Tue, Dec 4, 2018 at 10:35 PM Vlastimil Babka <vbabka@suse.cz> wrote:
> >
> > On 12/4/18 10:37 AM, Nicolas Boichat wrote:
> > > On Sun, Nov 11, 2018 at 5:04 PM Nicolas Boichat <drinkcat@chromium.org> wrote:
> > >>
> > >> This is a follow-up to the discussion in [1], to make sure that the page
> > >> tables allocated by iommu/io-pgtable-arm-v7s are contained within 32-bit
> > >> physical address space.
> > >>
> > >> [1] https://lists.linuxfoundation.org/pipermail/iommu/2018-November/030876.html
> > >
> > > Hi everyone,
> > >
> > > Let's try to summarize here.
> > >
> > > First, we confirmed that this is a regression, and IOMMU errors happen
> > > on 4.19 and linux-next/master on MT8173 (elm, Acer Chromebook R13).
> > > The issue most likely starts from ad67f5a6545f ("arm64: replace
> > > ZONE_DMA with ZONE_DMA32"), i.e. 4.15, and presumably breaks a number
> > > of Mediatek platforms (and maybe others?).
> > >
> > > We have a few options here:
> > > 1. This series [2], that adds support for GFP_DMA32 slab caches,
> > > _without_ adding kmalloc caches (since there are no users of
> > > kmalloc(..., GFP_DMA32)). I think I've addressed all the comments on
> > > the 3 patches, and AFAICT this solution works fine.
> > > 2. genalloc. That works, but unless we preallocate 4MB for L2 tables
> > > (which is wasteful as we usually only need a handful of L2 tables),
> > > we'll need changes in the core (use GFP_ATOMIC) to allow allocating on
> > > demand, and as it stands we'd have no way to shrink the allocation.
> > > 3. page_frag [3]. That works fine, and the code is quite simple. One
> > > drawback is that fragments in partially freed pages cannot be reused
> > > (from limited experiments, I see that IOMMU L2 tables are rarely
> > > freed, so it's unlikely a whole page would get freed). But given the
> > > low number of L2 tables, maybe we can live with that.
> > >
> > > I think 2 is out. Any preference between 1 and 3? I think 1 makes
> > > better use of the memory, so that'd be my preference. But I'm probably
> > > missing something.
> >
> > I would prefer 1 as well. IIRC you already confirmed that alignment
> > requirements are not broken for custom kmem caches even in presence of
> > SLUB debug options (and I would say it's a bug to be fixed if they
> > weren't).
>
> > I just asked (and didn't get a reply I think) about your
> > ability to handle the GFP_ATOMIC allocation failures. They should be
> > rare when only single page allocations are needed for the kmem cache.
> > But in case they are not an option, then preallocating would be needed,
> > thus probably option 2.
>
> Oh, sorry, I missed your question.
>
> I don't have a full answer, but:
> - The allocations themselves are rare (I count a few 10s of L2 tables
> at most on my system, I assume we rarely have >100), and yes, we only
> need a single page, so the failures should be exceptional.
> - My change is probably not making anything worse: I assume that even
> with the current approach using GFP_DMA slab caches on older kernels,
> failures could potentially happen. I don't think we've seen those. If
> we are really concerned about this, maybe we'd need to modify
> mtk_iommu_map to not hold a spinlock (if that's possible), so we don't
> need to use GFP_ATOMIC. I suggest we just keep an eye on such issues,
> and address them if they show up (we can even revisit genalloc at that
> stage).
>
> Anyway, I'll clean up patches for 1 (mostly commit message changes
> based on the comments in the threads) and resend.

Done here: https://patchwork.kernel.org/cover/10713019/ .

> Thanks,
>
> > > [2] https://patchwork.kernel.org/cover/10677529/, 3 patches
> > > [3] https://patchwork.codeaurora.org/patch/671639/
> > >
> > > Thanks,
> > >
> > > Nicolas
> > >
> >

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
