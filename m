Return-Path: <SRS0=4WgJ=OK=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8432EC04EB9
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Sat,  1 Dec 2018 16:57:37 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 54D822082F
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Sat,  1 Dec 2018 16:57:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="BwK+wYpZ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 54D822082F
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:
	Message-ID:Subject:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=oPXA8cRvAI9HMNDeftBvlVqcy2MrswEROBx9HpNsXLc=; b=BwK+wYpZ8KMa+/
	2C08gvM5H7indoA9Nzx3XN3pM7ZpYdZBM4nqYu5GENvJBVC6z4sR963J7EVglIQUzYCKMw6fBGLQu
	7NW7A+VJfwf1g7yGOrmffWDyY7d4ZXuQpQ5kJ9yKwtM0QyIkm7NpqkdtxPgTubl/yjN5IwCKjAXaw
	GMXJl7V73YL49U9WoDLJ47f0PUVZKZ2apGeu0dN+F+uwPrnxLLgMxqbtb2rTW6VO6zYD/uwoFJRMq
	2HLiwsBefeaNYJCW0+sNLsbuEIstco/OSmoci/WRKH1l1vJyfahJfPH9mm+pe5rz8+ELsv1AfJRQu
	MhdypMpBOYxVYXQ2zGjg==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gT8aA-0003yx-RA; Sat, 01 Dec 2018 16:57:30 +0000
Received: from verein.lst.de ([213.95.11.211] helo=newverein.lst.de)
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gT8a8-0003xy-5i
 for linux-arm-kernel@lists.infradead.org; Sat, 01 Dec 2018 16:57:29 +0000
Received: by newverein.lst.de (Postfix, from userid 2407)
 id B62056732A; Sat,  1 Dec 2018 17:57:16 +0100 (CET)
Date: Sat, 1 Dec 2018 17:57:16 +0100
From: Christoph Hellwig <hch@lst.de>
To: Robin Murphy <robin.murphy@arm.com>
Subject: Re: [PATCH 2/9] dma-direct: reject highmem pages from
 dma_alloc_from_contiguous
Message-ID: <20181201165716.GB20912@lst.de>
References: <20181105121931.13481-1-hch@lst.de>
 <20181105121931.13481-3-hch@lst.de>
 <e479a766-07c0-c319-0d91-318aaafdf7bc@arm.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <e479a766-07c0-c319-0d91-318aaafdf7bc@arm.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20181201_085728_361552_9E67E6F5 
X-CRM114-Status: UNSURE (   9.96  )
X-CRM114-Notice: Please train this message.
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
 Will Deacon <will.deacon@arm.com>, linux-kernel@vger.kernel.org,
 iommu@lists.linux-foundation.org, Guo Ren <ren_guo@c-sky.com>,
 Laura Abbott <labbott@redhat.com>, Christoph Hellwig <hch@lst.de>,
 linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

On Fri, Nov 30, 2018 at 07:04:51PM +0000, Robin Murphy wrote:
> On 05/11/2018 12:19, Christoph Hellwig wrote:
>> dma_alloc_from_contiguous can return highmem pages depending on the
>> setup, which a plain non-remapping DMA allocator can't handle.  Detect
>> this case and try the normal page allocator instead.
>
> ...except the actual implementation is "Detect this case and fail the 
> entire allocation if so".

True, that actually changed from when I wrote the commit log due to
some layer issues.  I'll update the commit log.

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
