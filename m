Return-Path: <SRS0=iy7m=RA=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CFB0CC43381
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Mon, 25 Feb 2019 11:00:34 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 829052147C
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Mon, 25 Feb 2019 11:00:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="F1bqZsxd"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 829052147C
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:
	Message-ID:Subject:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=da8MkaVN4Wx1yqGvnEsFd0oWXVXnCrNYalg/WB2SVGg=; b=F1bqZsxd9iESNz
	dpCWPJrISaO+CBiduECZtVNTANIpDqPC5ncUKufYMYj/gpR/+/F128oPw+MFvYBatVBSbzsfLWULT
	rG0RhfKwhPnsow8C6JJlWMZ0RovyXoHCzrtfN7aO63MZQJs6J7gptUk0SbQ1S//fkmAHh5ZUE/s/m
	d8Lq5UrmOs9fyAEWPaPJLv1jm5hT+BCopfyhtk14s1gE5S1La2b5YhY07Lo8E6zlRBvO7OGXxpuV7
	aj5nfaAh+L536lELBbr2z1eynheqx04SOc9NlzneA6Rp+HduXsnGPZGUKtjFhz9xRacxN8G6MVKa+
	oxw+mm/NlLhouYWDPo1w==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gyDzm-0001fM-SU; Mon, 25 Feb 2019 11:00:26 +0000
Received: from foss.arm.com ([217.140.101.70])
 by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gyDzh-0001WK-KL
 for linux-arm-kernel@lists.infradead.org; Mon, 25 Feb 2019 11:00:23 +0000
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id A2367A78;
 Mon, 25 Feb 2019 03:00:18 -0800 (PST)
Received: from lakrids.cambridge.arm.com (usa-sjc-imap-foss1.foss.arm.com
 [10.72.51.249])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 0354A3F703;
 Mon, 25 Feb 2019 03:00:16 -0800 (PST)
Date: Mon, 25 Feb 2019 11:00:14 +0000
From: Mark Rutland <mark.rutland@arm.com>
To: Anshuman Khandual <anshuman.khandual@arm.com>
Subject: Re: [PATCH V2 1/6] KVM: ARM: Remove pgtable standard functions from
 stage-2 page tables
Message-ID: <20190225110014.GB26236@lakrids.cambridge.arm.com>
References: <1551071039-20192-1-git-send-email-anshuman.khandual@arm.com>
 <1551071039-20192-2-git-send-email-anshuman.khandual@arm.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <1551071039-20192-2-git-send-email-anshuman.khandual@arm.com>
User-Agent: Mutt/1.11.1+11 (2f07cb52) (2018-12-01)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190225_030021_792215_08D57A34 
X-CRM114-Status: GOOD (  16.68  )
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
Cc: yuzhao@google.com, Steve.Capper@arm.com, marc.zyngier@arm.com,
 Catalin.Marinas@arm.com, suzuki.poulose@arm.com, will.deacon@arm.com,
 james.morse@arm.com, linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

Hi Anshuman,

On Mon, Feb 25, 2019 at 10:33:54AM +0530, Anshuman Khandual wrote:
> ARM64 standard pgtable functions are going to use pgtable_page_[ctor|dtor]
> constructs. Certain stage-2 page table allocations are multi order which
> cannot be allocated through a generic pgtable function as it does not exist
> right now. This prevents all pgtable allocations including multi order ones
> in stage-2 from moving into new ARM64 (pgtable_page_[ctor|dtor]) pgtable
> functions. Hence remove all generic pgtable allocation function dependency
> from stage-2 page tables till there is one multi-order allocation function
> available.

I'm a bit confused by this. Which allocations are multi-order?

Why does that prevent other allcoations from using the regular routines?

Thanks,
Mark.

> Signed-off-by: Anshuman Khandual <anshuman.khandual@arm.com>
> ---
>  arch/arm/include/asm/stage2_pgtable.h   | 4 ++--
>  arch/arm64/include/asm/stage2_pgtable.h | 4 ++--
>  2 files changed, 4 insertions(+), 4 deletions(-)
> 
> diff --git a/arch/arm/include/asm/stage2_pgtable.h b/arch/arm/include/asm/stage2_pgtable.h
> index de2089501b8b..417a3be00718 100644
> --- a/arch/arm/include/asm/stage2_pgtable.h
> +++ b/arch/arm/include/asm/stage2_pgtable.h
> @@ -32,14 +32,14 @@
>  #define stage2_pgd_present(kvm, pgd)		pgd_present(pgd)
>  #define stage2_pgd_populate(kvm, pgd, pud)	pgd_populate(NULL, pgd, pud)
>  #define stage2_pud_offset(kvm, pgd, address)	pud_offset(pgd, address)
> -#define stage2_pud_free(kvm, pud)		pud_free(NULL, pud)
> +#define stage2_pud_free(kvm, pud)		free_page((unsigned long)pud)
>  
>  #define stage2_pud_none(kvm, pud)		pud_none(pud)
>  #define stage2_pud_clear(kvm, pud)		pud_clear(pud)
>  #define stage2_pud_present(kvm, pud)		pud_present(pud)
>  #define stage2_pud_populate(kvm, pud, pmd)	pud_populate(NULL, pud, pmd)
>  #define stage2_pmd_offset(kvm, pud, address)	pmd_offset(pud, address)
> -#define stage2_pmd_free(kvm, pmd)		pmd_free(NULL, pmd)
> +#define stage2_pmd_free(kvm, pmd)		free_page((unsigned long)pmd)
>  
>  #define stage2_pud_huge(kvm, pud)		pud_huge(pud)
>  
> diff --git a/arch/arm64/include/asm/stage2_pgtable.h b/arch/arm64/include/asm/stage2_pgtable.h
> index 5412fa40825e..915809e4ac32 100644
> --- a/arch/arm64/include/asm/stage2_pgtable.h
> +++ b/arch/arm64/include/asm/stage2_pgtable.h
> @@ -119,7 +119,7 @@ static inline pud_t *stage2_pud_offset(struct kvm *kvm,
>  static inline void stage2_pud_free(struct kvm *kvm, pud_t *pud)
>  {
>  	if (kvm_stage2_has_pud(kvm))
> -		pud_free(NULL, pud);
> +		free_page((unsigned long)pud);
>  }
>  
>  static inline bool stage2_pud_table_empty(struct kvm *kvm, pud_t *pudp)
> @@ -192,7 +192,7 @@ static inline pmd_t *stage2_pmd_offset(struct kvm *kvm,
>  static inline void stage2_pmd_free(struct kvm *kvm, pmd_t *pmd)
>  {
>  	if (kvm_stage2_has_pmd(kvm))
> -		pmd_free(NULL, pmd);
> +		free_page((unsigned long)pmd);
>  }
>  
>  static inline bool stage2_pud_huge(struct kvm *kvm, pud_t pud)
> -- 
> 2.20.1
> 

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
