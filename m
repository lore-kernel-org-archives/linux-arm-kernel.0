Return-Path: <SRS0=Pwbl=PU=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9A26FC43444
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Sat, 12 Jan 2019 12:12:40 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6AEED20854
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Sat, 12 Jan 2019 12:12:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="eUBu7hUW"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6AEED20854
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:
	Message-ID:Subject:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=8O1Dzc/VIFnsBM9DNnCAk4nRWyr9Etsu/duwsGperEo=; b=eUBu7hUWP80cnp
	Od4+p3hgeIYkZKFbnNsYv489xsWqoyru2GPpULFnV+tb//QyLAdTj6/sOHUTCYCmGx0bZmLIIqqYB
	rfEkbeUCcawRdO/qZdscUpJ1oO1NSPXeA+JJCjRJX+RSffMM+ir9M3LuUsStke00cPSjXo+Ln+NaA
	1l5X7latX0Rg3pcDghTgt6IUaCY63cCi95IPHkTwgfc6pB1gNVW9lsQ4JxbZVSH++he8lat5hmMQm
	ShWVPzxdmlKe8kFl8jDWmZmSU/3uNlkZ6nDnudOeGwSmTDvEPxcoy3uPMgAzE41fORuB3epgZrZJ4
	Q+TrBRnH3zTjCN0Inhkg==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1giI9U-0004QR-Kq; Sat, 12 Jan 2019 12:12:36 +0000
Received: from willy by bombadil.infradead.org with local (Exim 4.90_1 #2 (Red
 Hat Linux)) id 1giI9Q-0004Q7-1d; Sat, 12 Jan 2019 12:12:32 +0000
Date: Sat, 12 Jan 2019 04:12:31 -0800
From: Matthew Wilcox <willy@infradead.org>
To: Anshuman Khandual <anshuman.khandual@arm.com>
Subject: Re: [PATCH] mm: Introduce GFP_PGTABLE
Message-ID: <20190112121230.GQ6310@bombadil.infradead.org>
References: <1547288798-10243-1-git-send-email-anshuman.khandual@arm.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <1547288798-10243-1-git-send-email-anshuman.khandual@arm.com>
User-Agent: Mutt/1.9.2 (2017-12-15)
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
Cc: mark.rutland@arm.com, mhocko@suse.com, linux-sh@vger.kernel.org,
 peterz@infradead.org, catalin.marinas@arm.com, dave.hansen@linux.intel.com,
 will.deacon@arm.com, linux-kernel@vger.kernel.org, linux-mm@kvack.org,
 kvmarm@lists.cs.columbia.edu, mpe@ellerman.id.au, linux@armlinux.org.uk,
 mingo@redhat.com, vbabka@suse.cz, rientjes@google.com, marc.zyngier@arm.com,
 rppt@linux.vnet.ibm.com, shakeelb@google.com, kirill@shutemov.name,
 tglx@linutronix.de, linux-arm-kernel@lists.infradead.org,
 ard.biesheuvel@linaro.org, robin.murphy@arm.com, steve.capper@arm.com,
 christoffer.dall@arm.com, james.morse@arm.com, aneesh.kumar@linux.ibm.com,
 akpm@linux-foundation.org, linuxppc-dev@lists.ozlabs.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

On Sat, Jan 12, 2019 at 03:56:38PM +0530, Anshuman Khandual wrote:
> All architectures have been defining their own PGALLOC_GFP as (GFP_KERNEL |
> __GFP_ZERO) and using it for allocating page table pages.

Except that's not true.

> +++ b/arch/x86/mm/pgtable.c
> @@ -13,19 +13,17 @@ phys_addr_t physical_mask __ro_after_init = (1ULL << __PHYSICAL_MASK_SHIFT) - 1;
>  EXPORT_SYMBOL(physical_mask);
>  #endif
>  
> -#define PGALLOC_GFP (GFP_KERNEL_ACCOUNT | __GFP_ZERO)
> -
>  #ifdef CONFIG_HIGHPTE

...

>  pte_t *pte_alloc_one_kernel(struct mm_struct *mm)
>  {
> -	return (pte_t *)__get_free_page(PGALLOC_GFP & ~__GFP_ACCOUNT);
> +	return (pte_t *)__get_free_page(GFP_PGTABLE & ~__GFP_ACCOUNT);
>  }

I think x86 was the only odd one out here, but you'll need to try again ...

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
