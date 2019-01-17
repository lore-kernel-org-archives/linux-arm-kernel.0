Return-Path: <SRS0=6Gta=PZ=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 00A0CC43387
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Thu, 17 Jan 2019 17:22:06 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C420420851
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Thu, 17 Jan 2019 17:22:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="SfinorVr"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C420420851
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:
	Message-ID:Subject:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=ul2ltJrXaIQSSIkvasX5bWZrbOPU6kLr1uS4/gQzfRE=; b=SfinorVrndNMQx
	KEbiyelXrIYxsoP/qqKow2tOe+Bn7MC3p7Ta7XapFwVYL0fAWmH6KUIDJwlS+R64rwyJE64yMc2Lo
	O2+hL3dluxUf11pwQ71xbTqmUYN1ogdt0WEYkEOJcnKFcmf9gO6CinMW1FrL9BRLeInZXUrfglzp2
	CQzp0tG6aNMm+Mp5OgTs+M8ItMy11XJFktHKE3W9+zYhwdjMcKKaJWc4qne3NLcuXFdrYgzxEIoz4
	tk2BJZU4IvkJojLP68KLg+JyZX7CDpeB0QhOiAkaa2OvgqaIPUJ6IiZo8RsL7Fkl8VLzhJcBmiei6
	+bkj72W8HuPLM6hwWnPg==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gkBMf-0006Wu-Ct; Thu, 17 Jan 2019 17:22:01 +0000
Received: from verein.lst.de ([213.95.11.211] helo=newverein.lst.de)
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gkBMc-0006WD-6I
 for linux-arm-kernel@lists.infradead.org; Thu, 17 Jan 2019 17:21:59 +0000
Received: by newverein.lst.de (Postfix, from userid 2407)
 id 0146668CEB; Thu, 17 Jan 2019 18:21:52 +0100 (CET)
Date: Thu, 17 Jan 2019 18:21:52 +0100
From: Christoph Hellwig <hch@lst.de>
To: Marek Szyprowski <m.szyprowski@samsung.com>
Subject: Re: [PATCH 3/3] videobuf2: replace a layering violation with
 dma_map_resource
Message-ID: <20190117172152.GA32292@lst.de>
References: <20190111181731.11782-1-hch@lst.de>
 <CGME20190111181812epcas2p1eeb68a16701631513eaf297073f7299f@epcas2p1.samsung.com>
 <20190111181731.11782-4-hch@lst.de>
 <6f8892ac-c2aa-10df-c74f-ba032bf75160@samsung.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <6f8892ac-c2aa-10df-c74f-ba032bf75160@samsung.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190117_092158_375834_E2A8F45F 
X-CRM114-Status: GOOD (  19.96  )
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
 <niklas.soderlund+renesas@ragnatech.se>, Pawel Osciak <pawel@osciak.com>,
 Russell King <linux@armlinux.org.uk>, iommu@lists.linux-foundation.org,
 linux-kernel@vger.kernel.org, Kyungmin Park <kyungmin.park@samsung.com>,
 Mauro Carvalho Chehab <mchehab@kernel.org>, linuxppc-dev@lists.ozlabs.org,
 Christoph Hellwig <hch@lst.de>, linux-arm-kernel@lists.infradead.org,
 linux-media@vger.kernel.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

On Mon, Jan 14, 2019 at 01:42:26PM +0100, Marek Szyprowski wrote:
> Hi Christoph,
> 
> On 2019-01-11 19:17, Christoph Hellwig wrote:
> > vb2_dc_get_userptr pokes into arm direct mapping details to get the
> > resemblance of a dma address for a a physical address that does is
> > not backed by a page struct.  Not only is this not portable to other
> > architectures with dma direct mapping offsets, but also not to uses
> > of IOMMUs of any kind.  Switch to the proper dma_map_resource /
> > dma_unmap_resource interface instead.
> >
> > Signed-off-by: Christoph Hellwig <hch@lst.de>
> 
> There are checks for IOMMU presence in other places in vb2-dma-contig,
> so it was used only when no IOMMU is available, but I agree that the
> hacky code should be replaced by a generic code if possible.
> 
> Tested-by: Marek Szyprowski <m.szyprowski@samsung.com>
> 
> V4L2 pipeline works fine on older Exynos-based boards with CMA and IOMMU
> disabled.

Do you know if these rely on the offsets?  E.g. would they still work
with the patch below applied on top.  That would keep the map_resource
semantics as-is as solve the issue pointed out by Robin for now.

If not I can only think of a flag to bypass the offseting for now, but
that would be pretty ugly.  Or go for the long-term solution of
discovering the relationship between the two devices, as done by the
PCIe P2P code..

diff --git a/kernel/dma/direct.c b/kernel/dma/direct.c
index 8e0359b04957..25bd19974223 100644
--- a/kernel/dma/direct.c
+++ b/kernel/dma/direct.c
@@ -359,7 +359,7 @@ EXPORT_SYMBOL(dma_direct_map_sg);
 dma_addr_t dma_direct_map_resource(struct device *dev, phys_addr_t paddr,
 		size_t size, enum dma_data_direction dir, unsigned long attrs)
 {
-	dma_addr_t dma_addr = phys_to_dma(dev, paddr);
+	dma_addr_t dma_addr = paddr;
 
 	if (unlikely(!dma_direct_possible(dev, dma_addr, size))) {
 		report_addr(dev, dma_addr, size);


_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
