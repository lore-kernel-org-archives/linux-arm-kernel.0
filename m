Return-Path: <SRS0=baBj=PW=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_MUTT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 28413C43387
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Mon, 14 Jan 2019 17:09:03 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id EBBA520873
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Mon, 14 Jan 2019 17:09:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="bUXR41v/"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EBBA520873
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:
	Message-ID:Subject:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=o4eRx9S9ATak4TgS/gJCTffLDRvyRp+mSmgB3YzutmM=; b=bUXR41v/uqr1JN
	zRPyYhCywDrPWmZWJVDgYskq49A59pPaH9a0tvH90jxPGgvf0VI0JX6uNCqJazYmtB91nS31iZTRW
	DzgQ6bgPJwk0mV/qrgySiVur1GBz1V+577I7loovhEVk2SXCUXdBwUCHvB5WYhICqE1HSC9Oxh68M
	ZQ920WJWE2+5faCj6NLuAwzHboAy9yJ0hQt7l+OAzXxav7fAVAC0kryJn6dsBDzkuU0dx6g7ifDEd
	IxlRkz8o57ARvQNASTzt19TKtrDu+qE5VeEdtyU+QpIfU0zz2r1TWpATs4JPVIQcTP348rvHJmRmt
	R0+D4SzrrECGa7b6opNA==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gj5jR-0001pp-Pi; Mon, 14 Jan 2019 17:09:01 +0000
Received: from verein.lst.de ([213.95.11.211] helo=newverein.lst.de)
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gj5jO-0001pG-5f
 for linux-arm-kernel@lists.infradead.org; Mon, 14 Jan 2019 17:08:59 +0000
Received: by newverein.lst.de (Postfix, from userid 2407)
 id 0861268D93; Mon, 14 Jan 2019 18:08:56 +0100 (CET)
Date: Mon, 14 Jan 2019 18:08:55 +0100
From: Christoph Hellwig <hch@lst.de>
To: Robin Murphy <robin.murphy@arm.com>
Subject: Re: [PATCH 1/3] dma-mapping: remove the default map_resource
 implementation
Message-ID: <20190114170855.GA7485@lst.de>
References: <20190111181731.11782-1-hch@lst.de>
 <20190111181731.11782-2-hch@lst.de>
 <c882430e-1dbd-df86-d686-0381dcaa668e@arm.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <c882430e-1dbd-df86-d686-0381dcaa668e@arm.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190114_090858_358959_D23DD7FD 
X-CRM114-Status: GOOD (  20.32  )
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
Cc: Niklas =?iso-8859-1?Q?S=F6derlund?=
 <niklas.soderlund+renesas@ragnatech.se>, linux-media@vger.kernel.org,
 Pawel Osciak <pawel@osciak.com>, Russell King <linux@armlinux.org.uk>,
 iommu@lists.linux-foundation.org, linux-kernel@vger.kernel.org,
 Kyungmin Park <kyungmin.park@samsung.com>,
 Mauro Carvalho Chehab <mchehab@kernel.org>, linuxppc-dev@lists.ozlabs.org,
 Christoph Hellwig <hch@lst.de>, linux-arm-kernel@lists.infradead.org,
 Marek Szyprowski <m.szyprowski@samsung.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

On Mon, Jan 14, 2019 at 01:12:33PM +0000, Robin Murphy wrote:
> Ignoring the offset was kind of intentional there, because at the time I 
> was primarily thinking about it in terms of the Keystone 2 platform where 
> the peripherals are all in the same place (0-2GB) in both the bus and CPU 
> physical address maps, and only the view of RAM differs between the two 
> (2-4GB vs. 32-34GB). However, on something like BCM283x, the peripherals 
> region is also offset from its bus address in the CPU view, but at a 
> *different* offset relative to that of RAM.

I was more thinking of the PCIe P2P case, where we need to apply a
consistent offset to translate between the CPU and the bus view.

But this isn't really used for PCIe P2P, so I guess keeping the original
sematics might be a better idea.  That being said the videobuf code seems
to rely on these offsets, so we might be between a rock and a hard place.

> Fortunately, I'm not aware of any platform which has a DMA engine behind an 
> IOMMU (and thus *needs* to use dma_map_resource() to avoid said IOMMU 
> blocking the slave device register reads/writes) and also has any nonzero 
> offsets, and AFAIK the IOMMU-less platforms above aren't using 
> dma_map_resource() at all, so this change shouldn't actually break 
> anything, but I guess we have a bit of a problem making it truly generic 
> and robust :(

Note that we don't actually use the code in this patch for ARM/ARM64
platforms with IOMMUs, as both the ARM and the ARM64 iommu code have
their own implementations of ->map_resource that actually program
the iommu (which at least for the PCIe P2P case would be wrong).

> Is this perhaps another shove in the direction of overhauling 
> dma_pfn_offset into an arbitrary "DMA ranges" lookup table?

It is long overdue anyway.

>>   		addr = ops->map_resource(dev, phys_addr, size, dir, attrs);
>
> Might it be reasonable to do:
>
> 	if (!dma_is_direct(ops) && ops->map_resource)
> 		addr = ops->map_resource(...);
> 	else
> 		addr = dma_direct_map_resource(...);
>
> and avoid having to explicitly wire up the dma_direct callback elsewhere?

No, I absolutely _want_ the callback explicitly wired up.  That is the
only way to ensure we actually intentionally support it and don't just
get a default that often won't work.  Same issue for ->mmap and
->get_sgtable.

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
