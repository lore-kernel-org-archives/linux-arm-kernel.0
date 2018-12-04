Return-Path: <SRS0=gVCq=ON=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.2 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_MUTT autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6F94BC04EB8
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Tue,  4 Dec 2018 16:28:46 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 404AB206B7
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Tue,  4 Dec 2018 16:28:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="GwkDT9WB"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 404AB206B7
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:
	Message-ID:Subject:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=DZvmQWS/7K68H5bWImv4W+t8+zGSaKuFFI7UsvhrYHk=; b=GwkDT9WBMyNXw9
	Nj+GT8IFyOZiG8/xmPcW+vBCuYKl05RoVWHRyRkukG2bAo5shezm8QVBdmi9WxU/nC2s9IllWIT6M
	hJG7I760WAJA2AT50JTqEA7eut451Wz1SJSzt4x+7ciqEOiCgrHM28BlnEeGKVx1rYmRXO2+SY9Ny
	iDsVJvz1lL/LZt/HA31ZzNd+bSJ6MsqwcvlyBNrWMBcMvvNUydn5xeJBk7gn6fPUYRjyJoN9mVUbT
	EfC4D4TJNgqZ7DF/+vXK9PP+K8hX5hx+EAj32so0GHfecuV7/q333Kb+nTxaPqThw/TPyenPJ8zEg
	nqd1Yp950TEHSGcNinhg==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gUDYs-0007Ji-Ap; Tue, 04 Dec 2018 16:28:38 +0000
Received: from foss.arm.com ([217.140.101.70])
 by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gUDYp-0007IW-Ki
 for linux-arm-kernel@lists.infradead.org; Tue, 04 Dec 2018 16:28:37 +0000
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id CA797A78;
 Tue,  4 Dec 2018 08:28:24 -0800 (PST)
Received: from edgewater-inn.cambridge.arm.com
 (usa-sjc-imap-foss1.foss.arm.com [10.72.51.249])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 984D83F614;
 Tue,  4 Dec 2018 08:28:24 -0800 (PST)
Received: by edgewater-inn.cambridge.arm.com (Postfix, from userid 1000)
 id 022F71AE0BA0; Tue,  4 Dec 2018 16:28:44 +0000 (GMT)
Date: Tue, 4 Dec 2018 16:28:44 +0000
From: Will Deacon <will.deacon@arm.com>
To: Nicolas Boichat <drinkcat@chromium.org>
Subject: Re: [PATCH v2 0/3] iommu/io-pgtable-arm-v7s: Use DMA32 zone for page
 tables
Message-ID: <20181204162844.GA8169@arm.com>
References: <20181111090341.120786-1-drinkcat@chromium.org>
 <CANMq1KDxmRcWhtaJbrLHqx6yPGkNaK7WNYYf+iFjH1e8XdrwRg@mail.gmail.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <CANMq1KDxmRcWhtaJbrLHqx6yPGkNaK7WNYYf+iFjH1e8XdrwRg@mail.gmail.com>
User-Agent: Mutt/1.5.23 (2014-03-12)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20181204_082835_689535_5FB889BD 
X-CRM114-Status: GOOD (  21.62  )
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
Cc: Michal Hocko <mhocko@suse.com>, Daniel Kurtz <djkurtz@chromium.org>,
 Levin Alexander <Alexander.Levin@microsoft.com>, linux-mm@kvack.org,
 Christoph Lameter <cl@linux.com>, Huaisheng Ye <yehs1@lenovo.com>,
 Joerg Roedel <joro@8bytes.org>, Matthew Wilcox <willy@infradead.org>,
 hch@infradead.org,
 linux-arm Mailing List <linux-arm-kernel@lists.infradead.org>,
 David Rientjes <rientjes@google.com>, yingjoe.chen@mediatek.com,
 Vlastimil Babka <vbabka@suse.cz>, Tomasz Figa <tfiga@google.com>,
 Mike Rapoport <rppt@linux.vnet.ibm.com>, Hsin-Yi Wang <hsinyi@chromium.org>,
 Matthias Brugger <matthias.bgg@gmail.com>,
 Joonsoo Kim <iamjoonsoo.kim@lge.com>, Yong Wu <yong.wu@mediatek.com>,
 Robin Murphy <robin.murphy@arm.com>, lkml <linux-kernel@vger.kernel.org>,
 Pekka Enberg <penberg@kernel.org>, iommu@lists.linux-foundation.org,
 Andrew Morton <akpm@linux-foundation.org>,
 Mel Gorman <mgorman@techsingularity.net>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

On Tue, Dec 04, 2018 at 05:37:13PM +0800, Nicolas Boichat wrote:
> On Sun, Nov 11, 2018 at 5:04 PM Nicolas Boichat <drinkcat@chromium.org> wrote:
> >
> > This is a follow-up to the discussion in [1], to make sure that the page
> > tables allocated by iommu/io-pgtable-arm-v7s are contained within 32-bit
> > physical address space.
> >
> > [1] https://lists.linuxfoundation.org/pipermail/iommu/2018-November/030876.html
> 
> Hi everyone,
> 
> Let's try to summarize here.
> 
> First, we confirmed that this is a regression, and IOMMU errors happen
> on 4.19 and linux-next/master on MT8173 (elm, Acer Chromebook R13).
> The issue most likely starts from ad67f5a6545f ("arm64: replace
> ZONE_DMA with ZONE_DMA32"), i.e. 4.15, and presumably breaks a number
> of Mediatek platforms (and maybe others?).
> 
> We have a few options here:
> 1. This series [2], that adds support for GFP_DMA32 slab caches,
> _without_ adding kmalloc caches (since there are no users of
> kmalloc(..., GFP_DMA32)). I think I've addressed all the comments on
> the 3 patches, and AFAICT this solution works fine.
> 2. genalloc. That works, but unless we preallocate 4MB for L2 tables
> (which is wasteful as we usually only need a handful of L2 tables),
> we'll need changes in the core (use GFP_ATOMIC) to allow allocating on
> demand, and as it stands we'd have no way to shrink the allocation.
> 3. page_frag [3]. That works fine, and the code is quite simple. One
> drawback is that fragments in partially freed pages cannot be reused
> (from limited experiments, I see that IOMMU L2 tables are rarely
> freed, so it's unlikely a whole page would get freed). But given the
> low number of L2 tables, maybe we can live with that.
> 
> I think 2 is out. Any preference between 1 and 3? I think 1 makes
> better use of the memory, so that'd be my preference. But I'm probably
> missing something.

FWIW, I'm open to any solution at this point, since I'd like to see this
regression fixed. (1) does sound better longer-term, but (3) looks pretty
much ready to do afaict.

Will

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
