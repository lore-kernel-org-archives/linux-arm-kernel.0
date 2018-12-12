Return-Path: <SRS0=fRgi=OV=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B17FFC04EB8
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Wed, 12 Dec 2018 07:37:27 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 78AC320851
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Wed, 12 Dec 2018 07:37:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="ijG7og9A"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 78AC320851
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:
	Message-ID:Subject:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=uxafGQZJ7oxq/4JFU/Vn/rvYJLSvK49NoGv+70Nz/Zk=; b=ijG7og9Aw12wEE
	LlDgYoiLU7n7r1JgMI8ZUa15GznLUSywzA139lXVhz69unxLTDOqr0Kc+23kQZkSkuV2BBpu4Vogf
	pUjWpRqh7gZL+iIrjvfWRmZQ657K//bcF5qg4xerQBzERLaDCufVkE6UEGKT02UZko5ob93AK13uG
	uBWfeya9mbusi8cCn4pW463lu6k9rYgdQrYqrZt0gN7uDL/n8axTllGAqipOcbSDXJWSaFhJCRPLk
	XWRNxpyPYjDnkvXsW7QsZ2eIwkIRKbwt+odRa0nfE9wbvTVq4bAx7oetOcRqRww0ksDiEL3qTLf+I
	xAFR7NhGnfHO7rEXgNEw==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gWz54-0006at-RO; Wed, 12 Dec 2018 07:37:18 +0000
Received: from verein.lst.de ([213.95.11.211] helo=newverein.lst.de)
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gWz51-0006Xs-C6
 for linux-arm-kernel@lists.infradead.org; Wed, 12 Dec 2018 07:37:16 +0000
Received: by newverein.lst.de (Postfix, from userid 2407)
 id DD30068D8D; Wed, 12 Dec 2018 08:37:03 +0100 (CET)
Date: Wed, 12 Dec 2018 08:37:03 +0100
From: Christoph Hellwig <hch@lst.de>
To: Chintan Pandya <cpandya@codeaurora.org>
Subject: Re: [PATCH] arm64: dma-mapping: Fix FORCE_CONTIGUOUS buffer clearing
Message-ID: <20181212073703.GA29091@lst.de>
References: <9bd208e9187db7a934428fe44ae0906028a8c9c3.1544469820.git.robin.murphy@arm.com>
 <9f6d3b29-7ca6-c78f-c4b6-f10dd318b1d9@codeaurora.org>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <9f6d3b29-7ca6-c78f-c4b6-f10dd318b1d9@codeaurora.org>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20181211_233715_560724_08A20D4E 
X-CRM114-Status: UNSURE (   7.72  )
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
Cc: catalin.marinas@arm.com, will.deacon@arm.com,
 Robin Murphy <robin.murphy@arm.com>, hch@lst.de,
 linux-arm-kernel@lists.infradead.org, m.szyprowski@samsung.com
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

On Wed, Dec 12, 2018 at 01:01:41PM +0530, Chintan Pandya wrote:
>>   		if (addr) {
>> -			memset(addr, 0, size);
>>   			if (!coherent)
>>   				__dma_flush_area(page_to_virt(page), iosize);
>> +			memset(addr, 0, size);
>
> For coherent case, we still skip flushing/invalidating dirty kernel
> mappings. Isn't it a problem ?

For the dma coherent case there is no need to writeback and/or invalidate
the kernel mapping.

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
