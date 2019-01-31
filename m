Return-Path: <SRS0=sKCI=QH=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_MUTT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CEF5FC169C4
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Thu, 31 Jan 2019 08:39:07 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id AA8C92084A
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Thu, 31 Jan 2019 08:39:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="trAxKI8W"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AA8C92084A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:Message-Id:In-Reply-To:MIME-Version:
	References:Subject:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=6jISg5YNseHddLd2WLPa238NynIpdHTMtp9xLsmBXZg=; b=trAxKI8Wj3Gf7q
	5R27EsjCIM6N+zpq5OVLve7fN1arioH/cJnHplgtnRsgh3POMehofcHNhBxD+uzgjdLhQRAIZVE5u
	PHKglJLPHHv+o52naYxYCinmk4e7HCZRoqASmXeqs6Q+6U6LYd/PeL1gaRP1sXHXoarHnT3omvzeE
	KpRlS7kMcOhDTQaWvnd8LqfP36ijMAlXK+GIdmEtN8YY47fUjB5Y7hiVilDwbWYpZoVF8Kv4mu+dA
	lLgi7qzU8u4JxkxG/gbbbKlJnJ3C/Dc5/3x/VIzC/LRVwrJiZebGzgFH1fmzfXYrLiHSmZ31yB/Pt
	4W6v+ioJVDojcVTqkNkg==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gp7sI-000092-U6; Thu, 31 Jan 2019 08:39:06 +0000
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]
 helo=mx0a-001b2d01.pphosted.com)
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gp7sE-00008L-Ne
 for linux-arm-kernel@lists.infradead.org; Thu, 31 Jan 2019 08:39:04 +0000
Received: from pps.filterd (m0098416.ppops.net [127.0.0.1])
 by mx0b-001b2d01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id
 x0V8UUbq107124
 for <linux-arm-kernel@lists.infradead.org>; Thu, 31 Jan 2019 03:39:01 -0500
Received: from e06smtp02.uk.ibm.com (e06smtp02.uk.ibm.com [195.75.94.98])
 by mx0b-001b2d01.pphosted.com with ESMTP id 2qbvqjtnwn-1
 (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
 for <linux-arm-kernel@lists.infradead.org>; Thu, 31 Jan 2019 03:39:00 -0500
Received: from localhost
 by e06smtp02.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linux-arm-kernel@lists.infradead.org> from <rppt@linux.ibm.com>;
 Thu, 31 Jan 2019 08:38:58 -0000
Received: from b06cxnps4074.portsmouth.uk.ibm.com (9.149.109.196)
 by e06smtp02.uk.ibm.com (192.168.101.132) with IBM ESMTP SMTP Gateway:
 Authorized Use Only! Violators will be prosecuted; 
 (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
 Thu, 31 Jan 2019 08:38:48 -0000
Received: from d06av24.portsmouth.uk.ibm.com (d06av24.portsmouth.uk.ibm.com
 [9.149.105.60])
 by b06cxnps4074.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 x0V8clRi8782276
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
 Thu, 31 Jan 2019 08:38:48 GMT
Received: from d06av24.portsmouth.uk.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id BF89342052;
 Thu, 31 Jan 2019 08:38:46 +0000 (GMT)
Received: from d06av24.portsmouth.uk.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 4515642042;
 Thu, 31 Jan 2019 08:38:44 +0000 (GMT)
Received: from rapoport-lnx (unknown [9.148.8.84])
 by d06av24.portsmouth.uk.ibm.com (Postfix) with ESMTPS;
 Thu, 31 Jan 2019 08:38:44 +0000 (GMT)
Date: Thu, 31 Jan 2019 10:38:42 +0200
From: Mike Rapoport <rppt@linux.ibm.com>
To: Souptick Joarder <jrdr.linux@gmail.com>
Subject: Re: [PATCHv2 1/9] mm: Introduce new vm_insert_range and
 vm_insert_range_buggy API
References: <20190131030812.GA2174@jordon-HP-15-Notebook-PC>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20190131030812.GA2174@jordon-HP-15-Notebook-PC>
User-Agent: Mutt/1.5.24 (2015-08-30)
X-TM-AS-GCONF: 00
x-cbid: 19013108-0008-0000-0000-000002B93473
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 19013108-0009-0000-0000-000022253606
Message-Id: <20190131083842.GE28876@rapoport-lnx>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:, ,
 definitions=2019-01-31_04:, , signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1810050000 definitions=main-1901310068
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190131_003902_889445_E54657A3 
X-CRM114-Status: GOOD (  36.94  )
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
Cc: mhocko@suse.com, heiko@sntech.de, peterz@infradead.org,
 dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
 linux-mm@kvack.org, linux1394-devel@lists.sourceforge.net,
 m.szyprowski@samsung.com, sfr@canb.auug.org.au,
 oleksandr_andrushchenko@epam.com, joro@8bytes.org, linux@armlinux.org.uk,
 willy@infradead.org, airlied@linux.ie, linux-arm-kernel@lists.infradead.org,
 linux-rockchip@lists.infradead.org, treding@nvidia.com,
 linux-media@vger.kernel.org, keescook@chromium.org, pawel@osciak.com,
 riel@surriel.com, iommu@lists.linux-foundation.org, rppt@linux.vnet.ibm.com,
 boris.ostrovsky@oracle.com, mchehab@kernel.org, iamjoonsoo.kim@lge.com,
 vbabka@suse.cz, jgross@suse.com, hjc@rock-chips.com, xen-devel@lists.xen.org,
 kyungmin.park@samsung.com, stefanr@s5r6.in-berlin.de,
 akpm@linux-foundation.org, robin.murphy@arm.com,
 kirill.shutemov@linux.intel.com
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

On Thu, Jan 31, 2019 at 08:38:12AM +0530, Souptick Joarder wrote:
> Previouly drivers have their own way of mapping range of
> kernel pages/memory into user vma and this was done by
> invoking vm_insert_page() within a loop.
> 
> As this pattern is common across different drivers, it can
> be generalized by creating new functions and use it across
> the drivers.
> 
> vm_insert_range() is the API which could be used to mapped
> kernel memory/pages in drivers which has considered vm_pgoff
> 
> vm_insert_range_buggy() is the API which could be used to map
> range of kernel memory/pages in drivers which has not considered
> vm_pgoff. vm_pgoff is passed default as 0 for those drivers.
> 
> We _could_ then at a later "fix" these drivers which are using
> vm_insert_range_buggy() to behave according to the normal vm_pgoff
> offsetting simply by removing the _buggy suffix on the function
> name and if that causes regressions, it gives us an easy way to revert.
> 
> Signed-off-by: Souptick Joarder <jrdr.linux@gmail.com>
> Suggested-by: Russell King <linux@armlinux.org.uk>
> Suggested-by: Matthew Wilcox <willy@infradead.org>
> ---
>  include/linux/mm.h |  4 +++
>  mm/memory.c        | 81 ++++++++++++++++++++++++++++++++++++++++++++++++++++++
>  mm/nommu.c         | 14 ++++++++++
>  3 files changed, 99 insertions(+)
> 
> diff --git a/include/linux/mm.h b/include/linux/mm.h
> index 80bb640..25752b0 100644
> --- a/include/linux/mm.h
> +++ b/include/linux/mm.h
> @@ -2565,6 +2565,10 @@ unsigned long change_prot_numa(struct vm_area_struct *vma,
>  int remap_pfn_range(struct vm_area_struct *, unsigned long addr,
>  			unsigned long pfn, unsigned long size, pgprot_t);
>  int vm_insert_page(struct vm_area_struct *, unsigned long addr, struct page *);
> +int vm_insert_range(struct vm_area_struct *vma, struct page **pages,
> +				unsigned long num);
> +int vm_insert_range_buggy(struct vm_area_struct *vma, struct page **pages,
> +				unsigned long num);
>  vm_fault_t vmf_insert_pfn(struct vm_area_struct *vma, unsigned long addr,
>  			unsigned long pfn);
>  vm_fault_t vmf_insert_pfn_prot(struct vm_area_struct *vma, unsigned long addr,
> diff --git a/mm/memory.c b/mm/memory.c
> index e11ca9d..0a4bf57 100644
> --- a/mm/memory.c
> +++ b/mm/memory.c
> @@ -1520,6 +1520,87 @@ int vm_insert_page(struct vm_area_struct *vma, unsigned long addr,
>  }
>  EXPORT_SYMBOL(vm_insert_page);
> 
> +/**
> + * __vm_insert_range - insert range of kernel pages into user vma
> + * @vma: user vma to map to
> + * @pages: pointer to array of source kernel pages
> + * @num: number of pages in page array
> + * @offset: user's requested vm_pgoff
> + *
> + * This allows drivers to insert range of kernel pages they've allocated
> + * into a user vma.
> + *
> + * If we fail to insert any page into the vma, the function will return
> + * immediately leaving any previously inserted pages present.  Callers
> + * from the mmap handler may immediately return the error as their caller
> + * will destroy the vma, removing any successfully inserted pages. Other
> + * callers should make their own arrangements for calling unmap_region().
> + *
> + * Context: Process context.
> + * Return: 0 on success and error code otherwise.
> + */
> +static int __vm_insert_range(struct vm_area_struct *vma, struct page **pages,
> +				unsigned long num, unsigned long offset)
> +{
> +	unsigned long count = vma_pages(vma);
> +	unsigned long uaddr = vma->vm_start;
> +	int ret, i;
> +
> +	/* Fail if the user requested offset is beyond the end of the object */
> +	if (offset > num)
> +		return -ENXIO;
> +
> +	/* Fail if the user requested size exceeds available object size */
> +	if (count > num - offset)
> +		return -ENXIO;
> +
> +	for (i = 0; i < count; i++) {
> +		ret = vm_insert_page(vma, uaddr, pages[offset + i]);
> +		if (ret < 0)
> +			return ret;
> +		uaddr += PAGE_SIZE;
> +	}
> +
> +	return 0;
> +}
> +
> +/**
> + * vm_insert_range - insert range of kernel pages starts with non zero offset
> + * @vma: user vma to map to
> + * @pages: pointer to array of source kernel pages
> + * @num: number of pages in page array
> + *
> + * Maps an object consisting of `num' `pages', catering for the user's
> + * requested vm_pgoff
> + *

The elaborate description you've added to __vm_insert_range() is better put
here, as this is the "public" function.

> + * Context: Process context. Called by mmap handlers.
> + * Return: 0 on success and error code otherwise.
> + */
> +int vm_insert_range(struct vm_area_struct *vma, struct page **pages,
> +				unsigned long num)
> +{
> +	return __vm_insert_range(vma, pages, num, vma->vm_pgoff);
> +}
> +EXPORT_SYMBOL(vm_insert_range);
> +
> +/**
> + * vm_insert_range_buggy - insert range of kernel pages starts with zero offset
> + * @vma: user vma to map to
> + * @pages: pointer to array of source kernel pages
> + * @num: number of pages in page array
> + *
> + * Maps a set of pages, always starting at page[0]

Here I'd add something like:

Similar to vm_insert_range(), except that it explicitly sets @vm_pgoff to
0. This function is intended for the drivers that did not consider
@vm_pgoff.

> vm_insert_range_buggy() is the API which could be used to map
> range of kernel memory/pages in drivers which has not considered
> vm_pgoff. vm_pgoff is passed default as 0 for those drivers.

> + *
> + * Context: Process context. Called by mmap handlers.
> + * Return: 0 on success and error code otherwise.
> + */
> +int vm_insert_range_buggy(struct vm_area_struct *vma, struct page **pages,
> +				unsigned long num)
> +{
> +	return __vm_insert_range(vma, pages, num, 0);
> +}
> +EXPORT_SYMBOL(vm_insert_range_buggy);
> +
>  static vm_fault_t insert_pfn(struct vm_area_struct *vma, unsigned long addr,
>  			pfn_t pfn, pgprot_t prot, bool mkwrite)
>  {
> diff --git a/mm/nommu.c b/mm/nommu.c
> index 749276b..21d101e 100644
> --- a/mm/nommu.c
> +++ b/mm/nommu.c
> @@ -473,6 +473,20 @@ int vm_insert_page(struct vm_area_struct *vma, unsigned long addr,
>  }
>  EXPORT_SYMBOL(vm_insert_page);
> 
> +int vm_insert_range(struct vm_area_struct *vma, struct page **pages,
> +			unsigned long num)
> +{
> +	return -EINVAL;
> +}
> +EXPORT_SYMBOL(vm_insert_range);
> +
> +int vm_insert_range_buggy(struct vm_area_struct *vma, struct page **pages,
> +				unsigned long num)
> +{
> +	return -EINVAL;
> +}
> +EXPORT_SYMBOL(vm_insert_range_buggy);
> +
>  /*
>   *  sys_brk() for the most part doesn't need the global kernel
>   *  lock, except when an application is doing something nasty
> -- 
> 1.9.1
> 

-- 
Sincerely yours,
Mike.


_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
