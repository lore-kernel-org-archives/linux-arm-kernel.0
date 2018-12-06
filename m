Return-Path: <SRS0=DN+v=OP=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.2 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 65EE1C04EB8
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Thu,  6 Dec 2018 16:05:25 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 315832054F
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Thu,  6 Dec 2018 16:05:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="rby+TOaJ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 315832054F
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:
	Message-ID:Subject:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=3w1NpOF8Pz0BtWfU/4n5sXFP8Syv/UUUsUiL53AUj7U=; b=rby+TOaJagOq6P
	vwEvyH9cFWREyCIfFAA9u1EthLlHPGw/1pB6qHu6SJuXKXpdCDcxsYVfjQKAoZynDqCubuMPgLVh1
	20utFgtuX8v4wvTd8xiij2o3RHstp25FOxbus1fSc7A31sWh3zKtctFLVBuwsF4yJMLmpjPZA0s7F
	TWGL+ByDQy+nPJnll3dcyP2uIrNstrXNI28DfDvwSdtHKe/Ls99m3OawUqZQ2d6ZQtpdLFEF/4+tG
	ZyZ8tAI0Fp+34C1B0nj/aTkyquVszpucZRlAvVBbuUXFoVOGK+lP6IflfSD2BJ8q/YwDGE/w7EDE+
	e/gw3tRu5ADZeqvsryUA==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gUw9L-0008Fx-5o; Thu, 06 Dec 2018 16:05:15 +0000
Received: from foss.arm.com ([217.140.101.70])
 by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gUw9G-0006yH-8c
 for linux-arm-kernel@lists.infradead.org; Thu, 06 Dec 2018 16:05:13 +0000
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id BEC8480D;
 Thu,  6 Dec 2018 08:04:59 -0800 (PST)
Received: from arrakis.emea.arm.com (arrakis.cambridge.arm.com [10.1.196.113])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id
 8B6643F59C; Thu,  6 Dec 2018 08:04:58 -0800 (PST)
Date: Thu, 6 Dec 2018 16:04:56 +0000
From: Catalin Marinas <catalin.marinas@arm.com>
To: Allen Pais <allen.pais@oracle.com>
Subject: Re: [PATCH] arm64: hugetlb: Register hugepages during arch init
Message-ID: <20181206160455.GK54495@arrakis.emea.arm.com>
References: <1540256817-3327-1-git-send-email-allen.pais@oracle.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <1540256817-3327-1-git-send-email-allen.pais@oracle.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20181206_080510_310423_F159DDCA 
X-CRM114-Status: GOOD (  20.49  )
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
Cc: Anshuman Khandual <anshuman.khandual@arm.com>,
 Will Deacon <will.deacon@arm.com>, linux-kernel@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, Steve Capper <Steve.Capper@arm.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

It seems that we somehow missed this patch. Cc'ing a few more people
that touched hugetlbpage.c.

Catalin

On Tue, Oct 23, 2018 at 06:36:57AM +0530, Allen Pais wrote:
> Add hstate for each supported hugepage size using arch initcall.
> 
> * no hugepage parameters
> 
>   Without hugepage parameters, only a default hugepage size is
>   available for dynamic allocation.  It's different, for example, from
>   x86_64 and sparc64 where all supported hugepage sizes are available.
> 
> * only default_hugepagesz= is specified and set not to HPAGE_SIZE
> 
>   In spite of the fact that default_hugepagesz= is set to a valid
>   hugepage size, it's treated as unsupported and reverted to
>   HPAGE_SIZE.  Such behaviour is also different from x86_64 and
>   sparc64.
> 
> Reviewed-by: Tom Saeger <tom.saeger@oracle.com>
> Signed-off-by: Dmitry Klochkov <dmitry.klochkov@oracle.com>
> Signed-off-by: Allen Pais <allen.pais@oracle.com>
> ---
>  arch/arm64/mm/hugetlbpage.c | 33 ++++++++++++++++++++++-----------
>  1 file changed, 22 insertions(+), 11 deletions(-)
> 
> diff --git a/arch/arm64/mm/hugetlbpage.c b/arch/arm64/mm/hugetlbpage.c
> index f58ea50..28cbc22 100644
> --- a/arch/arm64/mm/hugetlbpage.c
> +++ b/arch/arm64/mm/hugetlbpage.c
> @@ -429,6 +429,27 @@ void huge_ptep_clear_flush(struct vm_area_struct *vma,
>  	clear_flush(vma->vm_mm, addr, ptep, pgsize, ncontig);
>  }
>  
> +static void __init add_huge_page_size(unsigned long size)
> +{
> +	if (size_to_hstate(size))
> +		return;
> +
> +	hugetlb_add_hstate(ilog2(size) - PAGE_SHIFT);
> +}
> +
> +static int __init hugetlbpage_init(void)
> +{
> +#ifdef CONFIG_ARM64_4K_PAGES
> +	add_huge_page_size(PUD_SIZE);
> +#endif
> +	add_huge_page_size(PMD_SIZE * CONT_PMDS);
> +	add_huge_page_size(PMD_SIZE);
> +	add_huge_page_size(PAGE_SIZE * CONT_PTES);
> +
> +	return 0;
> +}
> +arch_initcall(hugetlbpage_init);
> +
>  static __init int setup_hugepagesz(char *opt)
>  {
>  	unsigned long ps = memparse(opt, &opt);
> @@ -440,7 +461,7 @@ static __init int setup_hugepagesz(char *opt)
>  	case PMD_SIZE * CONT_PMDS:
>  	case PMD_SIZE:
>  	case PAGE_SIZE * CONT_PTES:
> -		hugetlb_add_hstate(ilog2(ps) - PAGE_SHIFT);
> +		add_huge_page_size(ps);
>  		return 1;
>  	}
>  
> @@ -449,13 +470,3 @@ static __init int setup_hugepagesz(char *opt)
>  	return 0;
>  }
>  __setup("hugepagesz=", setup_hugepagesz);
> -
> -#ifdef CONFIG_ARM64_64K_PAGES
> -static __init int add_default_hugepagesz(void)
> -{
> -	if (size_to_hstate(CONT_PTES * PAGE_SIZE) == NULL)
> -		hugetlb_add_hstate(CONT_PTE_SHIFT);
> -	return 0;
> -}
> -arch_initcall(add_default_hugepagesz);
> -#endif
> -- 
> 1.8.3.1
> 
> 
> _______________________________________________
> linux-arm-kernel mailing list
> linux-arm-kernel@lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
