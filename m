Return-Path: <SRS0=niBm=QV=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1FA7EC4360F
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Thu, 14 Feb 2019 15:11:17 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id DF884218FF
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Thu, 14 Feb 2019 15:11:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="Y7r5GU+a";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="pCKFqDbe";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="UL/T0oQC"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DF884218FF
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:To:Subject:Message-ID:Date:From:
	In-Reply-To:References:MIME-Version:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=mm6wfL1ndrC8wQj3uEomyOn7YNTMpZilrWbz4bxFpp8=; b=Y7r5GU+a5dGGcI
	3RHcHeIUZb58PZAxf5nxnbRHruMJx4jdt5VPdjOyUkYyD/6qDhMs4gwYJX0Ex8ZJAh570/b1TeiiI
	Oj0cKBRkUCgIb1QcBsZdh9Y+vIjuFzCI3gl2FS7LsTRm8x5wE48qbR6zXxH7i40R5ezbnWgzwmNwR
	gkvcs/XeAALRrCv3BhYzig9Hgt13Aj1jBZWnHuAE8yC2IGSlge6nr2mcLYbuQz2WRKhIl/4Tpr/fh
	+a2te0DZAopg1UEyyzflWiTlK3GdHFi1eOPc1t/YTK8Osm9uThEUvF51laOsw2FBs9GwvhPvK/J2X
	inqFXsLJjK5AmhDWLn+A==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1guIfR-0003Tt-AA; Thu, 14 Feb 2019 15:11:13 +0000
Received: from merlin.infradead.org ([2001:8b0:10b:1231::1])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1guIez-0002yt-GN
 for linux-arm-kernel@bombadil.infradead.org; Thu, 14 Feb 2019 15:10:45 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=infradead.org; s=merlin.20170209; h=Content-Type:Cc:To:Subject:Message-ID:
 Date:From:In-Reply-To:References:MIME-Version:Sender:Reply-To:
 Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
 Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
 List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=fOPW6Mt+59GqhiXIWQYxkAJiix/xK3/ru9QOvlEjTHQ=; b=pCKFqDbe8KcjugT94bL4e3PV4
 yZ5qm00EUjXYQxF0fmHeiuxaIcA6vbw6v6qccoYqM3SeWkZoGKtJPih/fgh4w8lI6ut7eehpvPJVb
 QcxocnpXNq3n2gVB2dZKywwf96rm20tX5S2tx7u7K4NxWSL73EEJq1ZCt+k+hWBSksg2n8IJ47ojo
 qV0Tvzh36gDcnQlRfA5MQBEGwkFWb7rTAlgQKzu2nz/JFMh2a0vyzQXa4sjCEi/YHo7F5XEUqysrA
 15TD84JuuCG9SMi5NtLUEPozvPRw0Lfm9WXj8Hxfze1vN3d2lWRL4DF6oHs41KJZyT09EL//L1z2J
 wOktKZ0Cw==;
Received: from mail-it1-x144.google.com ([2607:f8b0:4864:20::144])
 by merlin.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1guISV-0006I6-Ax
 for linux-arm-kernel@lists.infradead.org; Thu, 14 Feb 2019 14:57:53 +0000
Received: by mail-it1-x144.google.com with SMTP id y184so15652014itc.1
 for <linux-arm-kernel@lists.infradead.org>;
 Thu, 14 Feb 2019 06:57:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=fOPW6Mt+59GqhiXIWQYxkAJiix/xK3/ru9QOvlEjTHQ=;
 b=UL/T0oQCqgKvCW5nPoiBM7Y8F7aSSEpxcfUDxAo0vQC1OvFGRsdq38fuaiFmK2zJBo
 2Y48ArB40B2ckdZDZFdqfMOvPz4DJVWDAVcmt0Ls+wEfe0Ut0/1eluLcGVf9vAc7nuCd
 JL8XMGFeUS7k9t9hmJ+DpgOZSZOAIwiyssmX1DGDTnLLSLZMPy4NGfewXLM43B9udyOY
 ojAmtLxGnIQ7AKcuw/VJJtiRvR+zqQeAqox3TuGMTqwgFXM6CazXz5rYraCH1odEQ0tA
 HfDnBDU+AZJ5RPryWbwaBhn9+fu3QuGq7gf2FtBbZeKz+ECR15yZW43jqKWItcJ9Pzn5
 40Xw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=fOPW6Mt+59GqhiXIWQYxkAJiix/xK3/ru9QOvlEjTHQ=;
 b=ub8/HzJsYL3L+u55Mtm1XRwoTJUgs4sbwEOOnJTlNdihqVxZt/d/O8BNgzGXIS90aQ
 zhZq08kynnWz3J/9R1Z/AJ1RYuA7BRjyzydNnolSbtbpvA9bE3BqZgeVMVNtvn7xPhe/
 uO0egm0GUK4JdP3ITUa2WItVeSJovTnlPj3DSWlWxBroUvAXA1/bG+U3C24nzdh4hCFW
 ERxUesExqyVRhb0jMII8Jsucf217OQH4jo0vyQd6fK9kmlH/2JgMKUq+9ljnB1SG21tC
 Q35lIbGtzV+kqq0mLZCEhjbfVGozqlmiYv1uNchzqPDETokqjEhwZ9Gl0TiBwT5JwTGA
 lCRQ==
X-Gm-Message-State: AHQUAuYvOnAgBdxno6D57PToqG8toU96W9kBtKNXF8thuhc9z+EnY4Uz
 F+LBX+8EbMkLuPjU3cbDs7eUIhOKxYkZq+bErgnt/lWJ
X-Google-Smtp-Source: AHgI3IZ+2b2BblXqrKvEkrJCR5O+CXFYXnxdZh01OqgqyL/HdORirJm2pPC+jw+AhflBBycYC/+F6UDZm9csI+MDKZ8=
X-Received: by 2002:a24:c3c4:: with SMTP id s187mr2541264itg.158.1550156267008; 
 Thu, 14 Feb 2019 06:57:47 -0800 (PST)
MIME-Version: 1.0
References: <20190213132738.10294-1-ard.biesheuvel@linaro.org>
 <20190213132738.10294-2-ard.biesheuvel@linaro.org>
 <20190214083350.GA9063@rapoport-lnx>
In-Reply-To: <20190214083350.GA9063@rapoport-lnx>
From: Ard Biesheuvel <ard.biesheuvel@linaro.org>
Date: Thu, 14 Feb 2019 15:57:35 +0100
Message-ID: <CAKv+Gu8ZvMgS3VgkGVQthh-QWWoAmjxEDhj-pp98_BG4-810Wg@mail.gmail.com>
Subject: Re: [PATCH 1/2] arm64: account for GICv3 LPI tables in static
 memblock reserve table
To: Mike Rapoport <rppt@linux.ibm.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190214_095751_487233_4FF4DE73 
X-CRM114-Status: GOOD (  34.93  )
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
Cc: linux-efi <linux-efi@vger.kernel.org>, Marc Zyngier <marc.zyngier@arm.com>,
 Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will.deacon@arm.com>,
 Linux-MM <linux-mm@kvack.org>, James Morse <james.morse@arm.com>,
 Andrew Morton <akpm@linux-foundation.org>,
 linux-arm-kernel <linux-arm-kernel@lists.infradead.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

On Thu, 14 Feb 2019 at 09:34, Mike Rapoport <rppt@linux.ibm.com> wrote:
>
> On Wed, Feb 13, 2019 at 02:27:37PM +0100, Ard Biesheuvel wrote:
> > In the irqchip and EFI code, we have what basically amounts to a quirk
> > to work around a peculiarity in the GICv3 architecture, which permits
> > the system memory address of LPI tables to be programmable only once
> > after a CPU reset. This means kexec kernels must use the same memory
> > as the first kernel, and thus ensure that this memory has not been
> > given out for other purposes by the time the ITS init code runs, which
> > is not very early for secondary CPUs.
> >
> > On systems with many CPUs, these reservations could overflow the
> > memblock reservation table, and this was addressed in commit
> > eff896288872 ("efi/arm: Defer persistent reservations until after
> > paging_init()"). However, this turns out to have made things worse,
> > since the allocation of page tables and heap space for the resized
> > memblock reservation table itself may overwrite the regions we are
> > attempting to reserve, which may cause all kinds of corruption,
> > also considering that the ITS will still be poking bits into that
> > memory in response to incoming MSIs.
> >
> > So instead, let's grow the static memblock reservation table on such
> > systems so it can accommodate these reservations at an earlier time.
> > This will permit us to revert the above commit in a subsequent patch.
> >
> > Signed-off-by: Ard Biesheuvel <ard.biesheuvel@linaro.org>
> > ---
> >  arch/arm64/include/asm/memory.h | 11 +++++++++++
> >  include/linux/memblock.h        |  3 ---
> >  mm/memblock.c                   | 10 ++++++++--
> >  3 files changed, 19 insertions(+), 5 deletions(-)
> >
> > diff --git a/arch/arm64/include/asm/memory.h b/arch/arm64/include/asm/memory.h
> > index e1ec947e7c0c..7e2b13cdd970 100644
> > --- a/arch/arm64/include/asm/memory.h
> > +++ b/arch/arm64/include/asm/memory.h
> > @@ -332,6 +332,17 @@ static inline void *phys_to_virt(phys_addr_t x)
> >  #define virt_addr_valid(kaddr)               \
> >       (_virt_addr_is_linear(kaddr) && _virt_addr_valid(kaddr))
> >
> > +/*
> > + * Given that the GIC architecture permits ITS implementations that can only be
> > + * configured with a LPI table address once, GICv3 systems with many CPUs may
> > + * end up reserving a lot of different regions after a kexec for their LPI
> > + * tables, as we are forced to reuse the same memory after kexec (and thus
> > + * reserve it persistently with EFI beforehand)
> > + */
> > +#if defined(CONFIG_EFI) && defined(CONFIG_ARM_GIC_V3_ITS)
> > +#define INIT_MEMBLOCK_RESERVED_REGIONS       (INIT_MEMBLOCK_REGIONS + 2 * NR_CPUS)
> > +#endif
> > +
> >  #include <asm-generic/memory_model.h>
> >
> >  #endif
> > diff --git a/include/linux/memblock.h b/include/linux/memblock.h
> > index 64c41cf45590..859b55b66db2 100644
> > --- a/include/linux/memblock.h
> > +++ b/include/linux/memblock.h
> > @@ -29,9 +29,6 @@ extern unsigned long max_pfn;
> >   */
> >  extern unsigned long long max_possible_pfn;
> >
> > -#define INIT_MEMBLOCK_REGIONS        128
> > -#define INIT_PHYSMEM_REGIONS 4
> > -
> >  /**
> >   * enum memblock_flags - definition of memory region attributes
> >   * @MEMBLOCK_NONE: no special request
> > diff --git a/mm/memblock.c b/mm/memblock.c
> > index 022d4cbb3618..a526c3ab8390 100644
> > --- a/mm/memblock.c
> > +++ b/mm/memblock.c
> > @@ -26,6 +26,12 @@
> >
> >  #include "internal.h"
> >
> > +#define INIT_MEMBLOCK_REGIONS                128
> > +#define INIT_PHYSMEM_REGIONS         4
> > +#ifndef INIT_MEMBLOCK_RESERVED_REGIONS
> > +#define INIT_MEMBLOCK_RESERVED_REGIONS       INIT_MEMBLOCK_REGIONS
> > +#endif
> > +
>
> I'd suggest
>
> s/INIT_MEMBLOCK_REGIONS/INIT_MEMORY_REGIONS
> s/INIT_MEMBLOCK_RESERVED_REGIONS/INIT_RESERVED_REGIONS
>

Well, I'd prefer to keep MEMBLOCK in the identifier, given that we are
setting it from an arch header file as well.

> Except that,
>
> Acked-by: Mike Rapoport <rppt@linux.ibm.com>
>

Thanks


> >  /**
> >   * DOC: memblock overview
> >   *
> > @@ -92,7 +98,7 @@ unsigned long max_pfn;
> >  unsigned long long max_possible_pfn;
> >
> >  static struct memblock_region memblock_memory_init_regions[INIT_MEMBLOCK_REGIONS] __initdata_memblock;
> > -static struct memblock_region memblock_reserved_init_regions[INIT_MEMBLOCK_REGIONS] __initdata_memblock;
> > +static struct memblock_region memblock_reserved_init_regions[INIT_MEMBLOCK_RESERVED_REGIONS] __initdata_memblock;
> >  #ifdef CONFIG_HAVE_MEMBLOCK_PHYS_MAP
> >  static struct memblock_region memblock_physmem_init_regions[INIT_PHYSMEM_REGIONS] __initdata_memblock;
> >  #endif
> > @@ -105,7 +111,7 @@ struct memblock memblock __initdata_memblock = {
> >
> >       .reserved.regions       = memblock_reserved_init_regions,
> >       .reserved.cnt           = 1,    /* empty dummy entry */
> > -     .reserved.max           = INIT_MEMBLOCK_REGIONS,
> > +     .reserved.max           = INIT_MEMBLOCK_RESERVED_REGIONS,
> >       .reserved.name          = "reserved",
> >
> >  #ifdef CONFIG_HAVE_MEMBLOCK_PHYS_MAP
> > --
> > 2.20.1
> >
>
> --
> Sincerely yours,
> Mike.
>

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
