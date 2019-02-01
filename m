Return-Path: <SRS0=JyYb=QI=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2C6F4C282D8
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri,  1 Feb 2019 16:16:47 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id F091221726
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri,  1 Feb 2019 16:16:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="b6oPFy2F"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org F091221726
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:
	Message-ID:Subject:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=ObbnETiJuz2WMfOJXy0IB1kNHb9IovFzKEBBTc2aOGo=; b=b6oPFy2F/3Lhq/
	8oOJJml/DByDhJ6XtsZyENJtYOs7sYkZq8TwbFc/NZF1acou49qfbl2lXs9rP1ozwwPPZWBMlHmaC
	cTK+TEpAOmI0RGbquwgWetYfXnM5oA7Wkgrq66MSspx2/XcqBbFcOf6uf960MFTxbmqV3FvxfI4q9
	fzqNkatnW7c4h2r+gl1s+1kWJkz2U4v5UWNzjqMlpft3PwKG7MLoGaz4M79lQ/2ZF6BszviIJoowo
	r+uDs9yrunmmuWzBA2zxK2+ftDmg4LNPtbduyoTGPQMfWkrRqzn4+S9+2lSobJHcv0f3cJM5ibtMU
	USgOWmvyGmxehxtXmMaA==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gpbUh-000728-Me; Fri, 01 Feb 2019 16:16:43 +0000
Received: from verein.lst.de ([213.95.11.211] helo=newverein.lst.de)
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gpbUd-00071o-VC
 for linux-arm-kernel@lists.infradead.org; Fri, 01 Feb 2019 16:16:41 +0000
Received: by newverein.lst.de (Postfix, from userid 2407)
 id 841E168D93; Fri,  1 Feb 2019 17:16:38 +0100 (CET)
Date: Fri, 1 Feb 2019 17:16:38 +0100
From: Christoph Hellwig <hch@lst.de>
To: Robin Murphy <robin.murphy@arm.com>
Subject: Re: [PATCH 03/19] dma-iommu: don't use a scatterlist in
 iommu_dma_alloc
Message-ID: <20190201161638.GJ6532@lst.de>
References: <20190114094159.27326-1-hch@lst.de>
 <20190114094159.27326-4-hch@lst.de>
 <5145b2f7-6fc8-6ed9-4cf2-9b7e1d33b0fe@arm.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <5145b2f7-6fc8-6ed9-4cf2-9b7e1d33b0fe@arm.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190201_081640_153529_47A69285 
X-CRM114-Status: GOOD (  10.80  )
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

On Fri, Feb 01, 2019 at 03:24:45PM +0000, Robin Murphy wrote:
> On 14/01/2019 09:41, Christoph Hellwig wrote:
>> Directly iterating over the pages makes the code a bit simpler and
>> prepares for the following changes.
>
> It also defeats the whole purpose of __iommu_dma_alloc_pages(), so I'm not 
> really buying the simplification angle - you've *seen* that code, right? ;)

How does it defeat the purpose of __iommu_dma_alloc_pages?


_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
