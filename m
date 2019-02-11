Return-Path: <SRS0=sCCJ=QS=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A2E60C169C4
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Mon, 11 Feb 2019 16:39:48 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 70F55218F0
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Mon, 11 Feb 2019 16:39:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="MniFUARY"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 70F55218F0
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:
	Message-ID:Subject:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=077HJonUnddSkDeEyIBghsJdBXxhtCj/pyJ94yccRRM=; b=MniFUARYEJ5kOp
	HXdUHjG2idgBCfyqJv8+4IAxKwKJMk9LEcgZtaH6YMnrIDWEzjz2f8YPi88wjKL6aV0pCEOoEZ+2w
	FjeT7Y7Sn34BgwoZOsxTa5eTmvHMeSpiG7SI9pGUOEIo21PvHuEriLnR+7ohr4LPJ9WwXHYKYl87W
	XNYE50aYRjsCJFKif2MxjWOsURQ3we7m1cUsa2oaUZPnTQI19ebNvVvrOdt4VkLik7AtkZ+Dcj+jb
	eyfn+f+oX3e8bPBGtoMEBq04KIcNU4YI5Tokje7+nPoLFk/uuQRQffLwUjarzycORqD1Ulkny0E1Q
	ZpYv/1KqQhHHEBnplbnA==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gtEcQ-000593-6w; Mon, 11 Feb 2019 16:39:42 +0000
Received: from verein.lst.de ([213.95.11.211] helo=newverein.lst.de)
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gtEcM-00058Y-KX
 for linux-arm-kernel@lists.infradead.org; Mon, 11 Feb 2019 16:39:40 +0000
Received: by newverein.lst.de (Postfix, from userid 2407)
 id C033768DD6; Mon, 11 Feb 2019 17:39:36 +0100 (CET)
Date: Mon, 11 Feb 2019 17:39:36 +0100
From: Christoph Hellwig <hch@lst.de>
To: Robin Murphy <robin.murphy@arm.com>
Subject: Re: [PATCH 16/19] dma-iommu: don't depend on CONFIG_DMA_DIRECT_REMAP
Message-ID: <20190211163936.GA29978@lst.de>
References: <20190114094159.27326-1-hch@lst.de>
 <20190114094159.27326-17-hch@lst.de>
 <4698cdca-0e5b-c82f-bb80-3ba0f986c544@arm.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <4698cdca-0e5b-c82f-bb80-3ba0f986c544@arm.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190211_083938_819961_C5A9CF35 
X-CRM114-Status: GOOD (  15.01  )
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
Cc: Tom Lendacky <thomas.lendacky@amd.com>,
 Catalin Marinas <catalin.marinas@arm.com>, Joerg Roedel <joro@8bytes.org>,
 Will Deacon <will.deacon@arm.com>, linux-kernel@vger.kernel.org,
 iommu@lists.linux-foundation.org, Christoph Hellwig <hch@lst.de>,
 linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

On Wed, Feb 06, 2019 at 11:55:49AM +0000, Robin Murphy wrote:
> On 14/01/2019 09:41, Christoph Hellwig wrote:
>> For entirely dma coherent architectures there is no good reason to ever
>> remap dma coherent allocation.
>
> Yes there is, namely assembling large buffers without the need for massive 
> CMA areas and compaction overhead under memory fragmentation. That has 
> always been a distinct concern from the DMA_DIRECT_REMAP cases; they've 
> just been able to share a fair few code paths.

Well, I guess I need to reword this - there is no _requirement_ to
remap.  And x86 has been happy to not remap so far and I see absolutely
no reason to force anyone to remap.

>>  Move all the remap and pool code under
>> CONFIG_DMA_DIRECT_REMAP ifdefs, and drop the Kconfig dependency.
>
> As far as I'm concerned that splits things the wrong way. Logically, 
> iommu_dma_alloc() should always have done its own vmap() instead of just 
> returning the bare pages array, but that was tricky to resolve with the 
> design of having the caller handle everything to do with coherency (forcing 
> the caller to unpick that mapping just to remap it yet again in the 
> noncoherent case didn't seem sensible).

I don't parse this.  In the old code base before this series
iommu_dma_alloc is a relatively low-level helper allocating and mapping
pages.  And that one should have done the remapping, and in fact does
so since ("dma-iommu: refactor page array remap helpers").  It just
happens that the function is now called iommu_dma_alloc_remap.

The new iommu_dma_alloc is the high level entry point that handles
every possible case of different allocations, including those where
we do not have a virtual mapping.

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
