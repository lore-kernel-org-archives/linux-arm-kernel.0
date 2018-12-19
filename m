Return-Path: <SRS0=AchV=O4=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 74BB4C43387
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Wed, 19 Dec 2018 17:00:51 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 45BCF214C6
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Wed, 19 Dec 2018 17:00:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="A/MtW6Uk"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 45BCF214C6
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:
	Message-ID:Subject:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=nx21pl35bb7qbnk+3zTi3Qv2B2c4Y31r9Os7bMvicsI=; b=A/MtW6UkmZn2hQ
	N+bxL65k3RYfM3hpqezKgiJb6PN3FePoo3J90XsJVTDboBmdIduVZvlrJ7vdsLlfngWnRc2SDd+g5
	rBzvsrt6UjF5vrTFG4aMor6sO/nx6z/OifvXuQ5ON+WElkC2TNV5HyhzoFF5Xd+O6jvbVhVkXhxaa
	tceiao7jEWS2qFArRgEOCHiHd12yJ+n4QlO4tsnT7+N5elaXRToNl0VVtCNKP6ceaUYn+aL1oULIO
	pUOb/Um6E+y/8CJLi1536LLUAPbEHTBqr5hOC7sPh6OrId7tDPYKnemoyAycCkL1lLA/XdwiwgFIu
	DL5qtxl1pFDcCxf9zZdA==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gZfDE-0001JD-B2; Wed, 19 Dec 2018 17:00:48 +0000
Received: from verein.lst.de ([213.95.11.211] helo=newverein.lst.de)
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gZfDB-0001Ik-Dk
 for linux-arm-kernel@lists.infradead.org; Wed, 19 Dec 2018 17:00:46 +0000
Received: by newverein.lst.de (Postfix, from userid 2407)
 id 0E61468AFE; Wed, 19 Dec 2018 18:00:34 +0100 (CET)
Date: Wed, 19 Dec 2018 18:00:34 +0100
From: Christoph Hellwig <hch@lst.de>
To: Robin Murphy <robin.murphy@arm.com>
Subject: Re: [PATCH dma-mapping tree] arm64: default to the direct mapping
 in get_arch_dma_ops
Message-ID: <20181219170034.GA26129@lst.de>
References: <20181214150240.26427-1-hch@lst.de>
 <3a6c8eff-a5dd-6a17-71ed-f480df3801d8@arm.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <3a6c8eff-a5dd-6a17-71ed-f480df3801d8@arm.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20181219_090045_609755_1A1A67AE 
X-CRM114-Status: GOOD (  11.10  )
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
Cc: catalin.marinas@arm.com, will.deacon@arm.com,
 iommu@lists.linux-foundation.org, Christoph Hellwig <hch@lst.de>,
 linux-arm-kernel@lists.infradead.org, m.szyprowski@samsung.com
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

On Wed, Dec 19, 2018 at 04:59:03PM +0000, Robin Murphy wrote:
> On 14/12/2018 15:02, Christoph Hellwig wrote:
>> Otherwise the direct mapping won't work at all given that a NULL
>> dev->dma_ops causes a fallback.  Note that we already explicitly set
>> dev->dma_ops to dma_dummy_ops for dma-incapable devices, so this
>> fallback should not be needed anyway.
>
> Sorry, I'd somehow completely missed that you'd sent a proper patch for 
> this - indeed it looks like the right change to make.
>
> Reviewed-by: Robin Murphy <robin.murphy@arm.com>

Thanks.  I've added this given that I hadn't pushed out the tree yet.

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
