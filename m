Return-Path: <SRS0=gVCq=ON=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.2 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7234CC04EBF
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Tue,  4 Dec 2018 22:34:14 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 42E8F20850
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Tue,  4 Dec 2018 22:34:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="pN/2FGQX"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 42E8F20850
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:
	Message-ID:Subject:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=D9vLVR9zo1+XN02Bb4rtzEYGhofg1yY2BewG7JydZmE=; b=pN/2FGQXMSvmZp
	D99KDxBreTCH5glO7g2V+jnYl6U3A1Qex7bjxQ5UvuCpFm047h2jS0tLWM9QuqKkM2JtzfjbDbfuN
	B2RxMpe7xkOEe/lV3QwqAuJzrw1kdKRNGXNIRcTZV3L+eFcnNzeM8rwQLHi6hmw1nvV/kqbXZpREB
	9/ZAhEr4hmWwQYHOe77KKcaStGGttFhUc8EkIdogRTEOmK/hfuxfG2596lAsWcY7AvmlAaguHSHS7
	oSXu0kwcsnmBSrN18pA6eCXyc5Ipfart3sekiHUP+ACzjmzSqPP9QaTqLd1UMTzZaMM6E9xk1/P0Y
	FfqjC+L4E/RaW4oQY/kg==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gUJGf-000762-DV; Tue, 04 Dec 2018 22:34:13 +0000
Received: from verein.lst.de ([213.95.11.211] helo=newverein.lst.de)
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gUJGc-000743-5K
 for linux-arm-kernel@lists.infradead.org; Tue, 04 Dec 2018 22:34:11 +0000
Received: by newverein.lst.de (Postfix, from userid 2407)
 id 3E8FD68B03; Tue,  4 Dec 2018 23:33:55 +0100 (CET)
Date: Tue, 4 Dec 2018 23:33:55 +0100
From: Christoph Hellwig <hch@lst.de>
To: Robin Murphy <robin.murphy@arm.com>
Subject: Re: [PATCH 01/23] dma-mapping: provide a generic DMA_MAPPING_ERROR
Message-ID: <20181204223355.GA12534@lst.de>
References: <20181130132231.16512-1-hch@lst.de>
 <20181130132231.16512-2-hch@lst.de>
 <653ca801-63a1-3c19-ee09-ade19fa2bbb8@arm.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <653ca801-63a1-3c19-ee09-ade19fa2bbb8@arm.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20181204_143410_345903_BE149B9C 
X-CRM114-Status: GOOD (  10.14  )
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
Cc: linux-arch@vger.kernel.org, linux-ia64@vger.kernel.org,
 linux-parisc@vger.kernel.org, David Woodhouse <dwmw2@infradead.org>,
 x86@kernel.org, linux-kernel@vger.kernel.org, iommu@lists.linux-foundation.org,
 linux-alpha@vger.kernel.org, xen-devel@lists.xenproject.org,
 Linus Torvalds <torvalds@linux-foundation.org>, Christoph Hellwig <hch@lst.de>,
 linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

On Tue, Dec 04, 2018 at 04:41:34PM +0000, Robin Murphy wrote:
> I'd have been inclined to put the default check here, i.e.
>
> -	return 0
> +	return dma_addr == DMA_MAPPING_ERROR
>
> such that the callback retains full precedence and we don't have to deal 
> with the non-trivial removals immediately if it comes to it. Not that it 
> makes a vast difference though, so either way,

Ok, I've switched it around.

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
