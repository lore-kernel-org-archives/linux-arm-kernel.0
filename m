Return-Path: <SRS0=4WgJ=OK=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0CA4CC04EB9
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Sat,  1 Dec 2018 17:05:24 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id CD35A206B7
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Sat,  1 Dec 2018 17:05:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="u1GxIFRy"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CD35A206B7
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:
	Message-ID:Subject:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=rdAAH8mRUITXnpJe2qj3MgiFh9ZChFNdZYagBFPivZc=; b=u1GxIFRyGZcmkq
	CGv85PapI2xQshzRD1Bw2pysId/+qVHolnmoKDvGDDryFmoZiya1qIhfHapjNXkjcT/Bgb+Z5nBzD
	ddjqe2otvm5SYborVrZTSGsl/8ExQFUK2uRlzNjKrVMo9yUz92ttunzrQkcrXxeFueL0nyzfTDAM+
	a7RA0yKZYJzjHpf5+oUhTzBrDQ7U2f0SXF4dXWUzF/lSCYtlf/TKZ9SwRYxmkAyaMsSSX0foWK/5r
	ZXC4iudFDbT6cRpPej0Zh7epZmyrn8fBpKYOsDacspVm6/SRNDpSze8OrgCX1HzZirK84fTXw9iTa
	W5KoscctHbP7ShIoDJmw==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gT8hm-0000gB-Ri; Sat, 01 Dec 2018 17:05:22 +0000
Received: from verein.lst.de ([213.95.11.211] helo=newverein.lst.de)
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gT8hj-0000Jz-Of
 for linux-arm-kernel@lists.infradead.org; Sat, 01 Dec 2018 17:05:21 +0000
Received: by newverein.lst.de (Postfix, from userid 2407)
 id 5A0AF6732A; Sat,  1 Dec 2018 18:05:06 +0100 (CET)
Date: Sat, 1 Dec 2018 18:05:06 +0100
From: Christoph Hellwig <hch@lst.de>
To: Robin Murphy <robin.murphy@arm.com>
Subject: Re: [PATCH 6/9] dma-remap: support DMA_ATTR_NO_KERNEL_MAPPING
Message-ID: <20181201170506.GE20912@lst.de>
References: <20181105121931.13481-1-hch@lst.de>
 <20181105121931.13481-7-hch@lst.de>
 <e993440c-53bf-8071-b1b6-06d022d39e4e@arm.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <e993440c-53bf-8071-b1b6-06d022d39e4e@arm.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20181201_090519_948869_49DC8594 
X-CRM114-Status: GOOD (  13.20  )
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

On Fri, Nov 30, 2018 at 07:05:40PM +0000, Robin Murphy wrote:
> On 05/11/2018 12:19, Christoph Hellwig wrote:
>> Do not waste vmalloc space on allocations that do not require a mapping
>> into the kernel address space.
>>
>> Signed-off-by: Christoph Hellwig <hch@lst.de>
>> ---
>>   kernel/dma/remap.c | 11 +++++++++--
>>   1 file changed, 9 insertions(+), 2 deletions(-)
>>
>> diff --git a/kernel/dma/remap.c b/kernel/dma/remap.c
>> index 8f1fca34b894..10a545126b0b 100644
>> --- a/kernel/dma/remap.c
>> +++ b/kernel/dma/remap.c
>> @@ -200,7 +200,8 @@ void *arch_dma_alloc(struct device *dev, size_t size, dma_addr_t *dma_handle,
>>     	size = PAGE_ALIGN(size);
>>   -	if (!gfpflags_allow_blocking(flags)) {
>> +	if (!gfpflags_allow_blocking(flags) &&
>> +	    !(attrs & DMA_ATTR_NO_KERNEL_MAPPING)) {
>>   		ret = dma_alloc_from_pool(size, &page, flags);
>>   		if (!ret)
>>   			return NULL;
>> @@ -215,6 +216,9 @@ void *arch_dma_alloc(struct device *dev, size_t size, dma_addr_t *dma_handle,
>>   	/* remove any dirty cache lines on the kernel alias */
>>   	arch_dma_prep_coherent(page, size);
>>   +	if (attrs & DMA_ATTR_NO_KERNEL_MAPPING)
>> +		return page; /* opaqueue cookie */
>
> Best to preempt the inevitable patch fixing that typo in 3 months' time. 
> Otherwise,

Thanks,

fixed.

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
