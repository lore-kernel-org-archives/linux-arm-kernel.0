Return-Path: <SRS0=/awj=OT=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 49844C04EB8
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Mon, 10 Dec 2018 16:34:35 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id EBBDA20821
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Mon, 10 Dec 2018 16:34:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="nKRvpM2O";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="cv9MOUEb"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EBBDA20821
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:Content-Type:
	Content-Transfer-Encoding:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:Date:Message-ID:From:
	References:To:Subject:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=Yzjfsq7thNZ6bRMne+IuleTBoiRKaNliVVXAwFuvp9U=; b=nKRvpM2O05lQg8GITZ3kJB58W
	wBDOOFNCpbP6L1yRvQfRpoZ5GUtEbD0kdOe7OSQK5DD2LHXKhsFeMGqtgMubD5Qxb5fLPu9DoxWEw
	77cKvv7cCkj3aY9cBJ61dsrGvr5AAQzI1DUK8yhqBZzGmKJKvf4NtKvAW3QtB7ro/BOYnzN9C8waZ
	pvyPju2yMMCCx/QBsVsbA7PBe3YKJxe3tYxzb6vBi2Zg4Wh5xX024IrhTrRKRawzevDWDvI1jMgfj
	zufmLQ7wVSKV44TstHu0HzRQqmRl43Sk1faFOCtWS/v6UCgldlPtX1aFPwCRmV3+A1YwJk+pFbaW9
	K8C3tKTjA==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gWOVr-0005Rr-Cq; Mon, 10 Dec 2018 16:34:31 +0000
Received: from casper.infradead.org ([2001:8b0:10b:1236::1])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gWOVp-0005Qq-IJ
 for linux-arm-kernel@bombadil.infradead.org; Mon, 10 Dec 2018 16:34:29 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:Content-Type:
 In-Reply-To:MIME-Version:Date:Message-ID:From:References:Cc:To:Subject:Sender
 :Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
 Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
 List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=js4Rysh9tCE8/XXPZjBa/IF4C8cPGtjdSKqLJbUrhas=; b=cv9MOUEbww++ZBh/RSMS5yDPEg
 yXjEASGbD8bfZJ8yXHFxZbOIjkYmaAecnpprRwmPvQNam3dJYpQZ9UyXOZSmGnadqIaqhaDZAOi/+
 CTOEfhRMnkguzDoabopyVPl8pnbRosp4/OSF47qCAg9EVXLxfKtYEGBJ1Lbvm4atqPLm/LWzDvnHH
 P0rvNARM9n/iHToLJw2LbauzyHb8COPaSTRQy6Zr8ze4EoXXnzhfEtqpFzMY3FlaJFyheXKOlD+hB
 y6Gku2c3OcuRk7wfffbJMB6R9oLKgUrixOUaHCh1DEKtX0njqrKoBSbWhK2yWyNJlWyLmNgAoqcsK
 sfiQCDOA==;
Received: from foss.arm.com ([217.140.101.70])
 by casper.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gWOTl-00088O-B7
 for linux-arm-kernel@lists.infradead.org; Mon, 10 Dec 2018 16:32:25 +0000
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 41A2C1596;
 Mon, 10 Dec 2018 08:32:10 -0800 (PST)
Received: from [10.1.196.75] (e110467-lin.cambridge.arm.com [10.1.196.75])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 4E9753F6A8;
 Mon, 10 Dec 2018 08:32:08 -0800 (PST)
Subject: Re: [PATCH v3 2/9] arch/arm/mm/dma-mapping.c: Convert to use
 vm_insert_range
To: Souptick Joarder <jrdr.linux@gmail.com>,
 Andrew Morton <akpm@linux-foundation.org>,
 Matthew Wilcox <willy@infradead.org>, Michal Hocko <mhocko@suse.com>,
 Russell King - ARM Linux <linux@armlinux.org.uk>, iamjoonsoo.kim@lge.com,
 treding@nvidia.com, Kees Cook <keescook@chromium.org>,
 Marek Szyprowski <m.szyprowski@samsung.com>
References: <20181206184103.GA25872@jordon-HP-15-Notebook-PC>
 <CAFqt6zY9JjGhedtmhYh-+mxSMrYs6P5vtQDMSzCfL02CbLys=g@mail.gmail.com>
From: Robin Murphy <robin.murphy@arm.com>
Message-ID: <217b80f9-e02c-d02c-3c82-425c550e4ed7@arm.com>
Date: Mon, 10 Dec 2018 16:32:06 +0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.2.1
MIME-Version: 1.0
In-Reply-To: <CAFqt6zY9JjGhedtmhYh-+mxSMrYs6P5vtQDMSzCfL02CbLys=g@mail.gmail.com>
Content-Language: en-GB
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20181210_163221_710829_CBEFD388 
X-CRM114-Status: GOOD (  23.44  )
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
Cc: Linux-MM <linux-mm@kvack.org>, linux-kernel@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

On 08/12/2018 20:01, Souptick Joarder wrote:
> Hi Robin,
> 
> On Fri, Dec 7, 2018 at 12:07 AM Souptick Joarder <jrdr.linux@gmail.com> wrote:
>>
>> Convert to use vm_insert_range() to map range of kernel
>> memory to user vma.
>>
>> Signed-off-by: Souptick Joarder <jrdr.linux@gmail.com>
>> ---
>>   arch/arm/mm/dma-mapping.c | 21 +++++++--------------
>>   1 file changed, 7 insertions(+), 14 deletions(-)
>>
>> diff --git a/arch/arm/mm/dma-mapping.c b/arch/arm/mm/dma-mapping.c
>> index 661fe48..4eec323 100644
>> --- a/arch/arm/mm/dma-mapping.c
>> +++ b/arch/arm/mm/dma-mapping.c
>> @@ -1582,31 +1582,24 @@ static int __arm_iommu_mmap_attrs(struct device *dev, struct vm_area_struct *vma
>>                      void *cpu_addr, dma_addr_t dma_addr, size_t size,
>>                      unsigned long attrs)
>>   {
>> -       unsigned long uaddr = vma->vm_start;
>> -       unsigned long usize = vma->vm_end - vma->vm_start;
>> +       unsigned long page_count = vma_pages(vma);
>>          struct page **pages = __iommu_get_pages(cpu_addr, attrs);
>>          unsigned long nr_pages = PAGE_ALIGN(size) >> PAGE_SHIFT;
>>          unsigned long off = vma->vm_pgoff;
>> +       int err;
>>
>>          if (!pages)
>>                  return -ENXIO;
>>
>> -       if (off >= nr_pages || (usize >> PAGE_SHIFT) > nr_pages - off)
>> +       if (off >= nr_pages || page_count > nr_pages - off)
>>                  return -ENXIO;
>>
>>          pages += off;
>> +       err = vm_insert_range(vma, vma->vm_start, pages, page_count);
> 
> Just to clarify, do we need to adjust page_count with vma->vm_pgoff as
> original code
> have not consider it and run the loop for entire range irrespective of
> vma->vm_pgoff value ?

In this instance, page_count is the size of the VMA, not the size of the 
pages array itself, so as I understand things this patch is true to the 
original code as-is.

Robin.

> 
>> +       if (err)
>> +               pr_err("Remapping memory failed: %d\n", err);
>>
>> -       do {
>> -               int ret = vm_insert_page(vma, uaddr, *pages++);
>> -               if (ret) {
>> -                       pr_err("Remapping memory failed: %d\n", ret);
>> -                       return ret;
>> -               }
>> -               uaddr += PAGE_SIZE;
>> -               usize -= PAGE_SIZE;
>> -       } while (usize > 0);
>> -
>> -       return 0;
>> +       return err;
>>   }
>>   static int arm_iommu_mmap_attrs(struct device *dev,
>>                  struct vm_area_struct *vma, void *cpu_addr,
>> --
>> 1.9.1
>>

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
