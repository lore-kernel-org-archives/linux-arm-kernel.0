Return-Path: <SRS0=baBj=PW=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ED804C43387
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Mon, 14 Jan 2019 15:30:16 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9061720657
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Mon, 14 Jan 2019 15:30:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="hAHHkDOC"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9061720657
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:
	Message-ID:Subject:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=54B3Lrr7wz3E0N9k4A7OETpgUkM9B10zejcXKM41xlI=; b=hAHHkDOCXQdMYQ
	iy+YeUK0H1NJqrUDD3UI6aSoYyaV1hevGcfxX5PHHk2H8F7UA37he+SaudMOfcftoruyZz2FvWUss
	kIQQ7ksVuEioD5IcIUDRLxrj749GlhzeKGPO+DTmnQSz5NhN8/bTbZJO9aEzQuEdbr4+RwzHpEy1j
	nZPK4GjdRXd32WToEl71KYclkKdzNAW7WsO7XoDRJrzA/zBj8uurb2A5ls8Fho1Cen2EH8s2o8YCq
	bDz6vOQMviM5rqJlNY9EJvYpf6B6KMvOXSioG2FobFxaWFPlNk3JhAsWsEss9EPKaVTFnj19Mi1Xw
	wNfg1uaW9pnoZN1a9gIQ==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gj4Bn-0004oG-MJ; Mon, 14 Jan 2019 15:30:11 +0000
Received: from foss.arm.com ([217.140.101.70])
 by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gj4Bk-0004H6-7K
 for linux-arm-kernel@lists.infradead.org; Mon, 14 Jan 2019 15:30:10 +0000
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id F37CC80D;
 Mon, 14 Jan 2019 07:30:04 -0800 (PST)
Received: from lakrids.cambridge.arm.com (usa-sjc-imap-foss1.foss.arm.com
 [10.72.51.249])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 36C6E3F70D;
 Mon, 14 Jan 2019 07:30:04 -0800 (PST)
Date: Mon, 14 Jan 2019 15:29:59 +0000
From: Mark Rutland <mark.rutland@arm.com>
To: Will Deacon <will.deacon@arm.com>
Subject: Re: [PATCH] arm64: Remove asm/memblock.h
Message-ID: <20190114152958.GA18787@lakrids.cambridge.arm.com>
References: <20190114142224.19200-1-will.deacon@arm.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20190114142224.19200-1-will.deacon@arm.com>
User-Agent: Mutt/1.11.1+11 (2f07cb52) (2018-12-01)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190114_073008_281735_9B23EF3D 
X-CRM114-Status: GOOD (  20.03  )
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
Cc: catalin.marinas@arm.com, linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

On Mon, Jan 14, 2019 at 02:22:24PM +0000, Will Deacon wrote:
> The arm64 asm/memblock.h header exists only to provide a function
> prototype for arm64_memblock_init(), which is called only from
> setup_arch().
> 
> Move the declaration into mmu.h, where it can live alongside other
> init functions such as paging_init() and bootmem_init() without the
> need for its own special header file.
> 
> Signed-off-by: Will Deacon <will.deacon@arm.com>

Seems legit.

Acked-by: Mark Rutland <mark.rutland@arm.com>

Mark.

> ---
>  arch/arm64/include/asm/memblock.h | 21 ---------------------
>  arch/arm64/include/asm/mmu.h      |  1 +
>  arch/arm64/kernel/setup.c         |  1 -
>  arch/arm64/mm/mmu.c               |  1 -
>  4 files changed, 1 insertion(+), 23 deletions(-)
>  delete mode 100644 arch/arm64/include/asm/memblock.h
> 
> diff --git a/arch/arm64/include/asm/memblock.h b/arch/arm64/include/asm/memblock.h
> deleted file mode 100644
> index 6afeed2467f1..000000000000
> --- a/arch/arm64/include/asm/memblock.h
> +++ /dev/null
> @@ -1,21 +0,0 @@
> -/*
> - * Copyright (C) 2012 ARM Ltd.
> - *
> - * This program is free software; you can redistribute it and/or modify
> - * it under the terms of the GNU General Public License version 2 as
> - * published by the Free Software Foundation.
> - *
> - * This program is distributed in the hope that it will be useful,
> - * but WITHOUT ANY WARRANTY; without even the implied warranty of
> - * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
> - * GNU General Public License for more details.
> - *
> - * You should have received a copy of the GNU General Public License
> - * along with this program.  If not, see <http://www.gnu.org/licenses/>.
> - */
> -#ifndef __ASM_MEMBLOCK_H
> -#define __ASM_MEMBLOCK_H
> -
> -extern void arm64_memblock_init(void);
> -
> -#endif
> diff --git a/arch/arm64/include/asm/mmu.h b/arch/arm64/include/asm/mmu.h
> index 7689c7aa1d77..43596b1a5897 100644
> --- a/arch/arm64/include/asm/mmu.h
> +++ b/arch/arm64/include/asm/mmu.h
> @@ -85,6 +85,7 @@ static inline struct bp_hardening_data *arm64_get_bp_hardening_data(void)
>  static inline void arm64_apply_bp_hardening(void)	{ }
>  #endif	/* CONFIG_HARDEN_BRANCH_PREDICTOR */
>  
> +extern void arm64_memblock_init(void);
>  extern void paging_init(void);
>  extern void bootmem_init(void);
>  extern void __iomem *early_io_map(phys_addr_t phys, unsigned long virt);
> diff --git a/arch/arm64/kernel/setup.c b/arch/arm64/kernel/setup.c
> index 4b0e1231625c..71f5fbb12608 100644
> --- a/arch/arm64/kernel/setup.c
> +++ b/arch/arm64/kernel/setup.c
> @@ -58,7 +58,6 @@
>  #include <asm/cacheflush.h>
>  #include <asm/tlbflush.h>
>  #include <asm/traps.h>
> -#include <asm/memblock.h>
>  #include <asm/efi.h>
>  #include <asm/xen/hypervisor.h>
>  #include <asm/mmu_context.h>
> diff --git a/arch/arm64/mm/mmu.c b/arch/arm64/mm/mmu.c
> index b6f5aa52ac67..d6b6f1b169bb 100644
> --- a/arch/arm64/mm/mmu.c
> +++ b/arch/arm64/mm/mmu.c
> @@ -42,7 +42,6 @@
>  #include <asm/setup.h>
>  #include <asm/sizes.h>
>  #include <asm/tlb.h>
> -#include <asm/memblock.h>
>  #include <asm/mmu_context.h>
>  #include <asm/ptdump.h>
>  #include <asm/tlbflush.h>
> -- 
> 2.11.0
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
