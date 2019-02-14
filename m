Return-Path: <SRS0=niBm=QV=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 13642C43381
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Thu, 14 Feb 2019 16:55:46 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D567A222DA
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Thu, 14 Feb 2019 16:55:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="LuEZPXKZ";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="d99rXLfY"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D567A222DA
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:To:Subject:Message-ID:Date:From:
	In-Reply-To:References:MIME-Version:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=xwPZPGvl1e+F9Ha5fZeQM6f+YfDnfgQOaH7kIUnSHbk=; b=LuEZPXKZg3ZoWk
	ECBmb3NEIKwvOn++i3b9WNBpqJeKTRESwW3dJBzWUPWFRKWXq9cjisQ0SHBAte8MKQBFWCFojH99O
	eVAEiin87nPfnkvhDM1QCDUlVmtrhC5xgNx5tZmStHFq0p5qxJ6uVgIrfW08zCnqs7QWZkO/92/vF
	NgvkRZa92lc279ITNywI+mch1GM0ZhK4jv235w9I0bpt8FTTTuwQmAnLKSuL+f4s/JUrpVvHTZBUU
	pL9FMxPDOv4VnD6frMpPj3+puNGF71blZBSfQmJYT3RYVufS9Zbv1onVVKggCBX4y3lVpFCSwWzD2
	5uEoGDsNn8MKLN5uWBWQ==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1guKIa-0004tI-CM; Thu, 14 Feb 2019 16:55:44 +0000
Received: from mail-it1-x144.google.com ([2607:f8b0:4864:20::144])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1guKIW-0004sx-Q3
 for linux-arm-kernel@lists.infradead.org; Thu, 14 Feb 2019 16:55:42 +0000
Received: by mail-it1-x144.google.com with SMTP id l131so15893921ita.2
 for <linux-arm-kernel@lists.infradead.org>;
 Thu, 14 Feb 2019 08:55:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=SbBKzNBycKxM70itibKfUlYiJ9pJfd1fqDbErtUvpXc=;
 b=d99rXLfYTXazHCp6agNx8f/TLrwjgUX4pj1ny26fJvjhOaGgaaZY49A6iZYz1cC65e
 uCd3zm7zE3ZYC6rgH67f+DE4uDpu/g3bP0uCzpDWTKuTUmfpwg/SdX6DX2nLNWDIwMN1
 LRPPsMwJgF22mEVbaRzYEG02AaBjDffWJn2u7lz0B8U7IjQV5jOAD00Fl2SUMdCaF1f2
 tui1aHAa/JkdiocARufySsS6A22M3Ml15Zn3nkYZBzPmpubtvxPqADRb73PxSaCp14vP
 rIxjo48gfu+NbF4kw5YiMMgNIebHdF14IKJFs8DhM2qvcdaxK6lgOkGolVYaRKSN7sML
 KS3w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=SbBKzNBycKxM70itibKfUlYiJ9pJfd1fqDbErtUvpXc=;
 b=Sc3kKDITQFD7uh5SPvWowtb1mjAcdzWrreHmyyMFP/kI0WtBEaYOkj6LArojPeaPZk
 yJ8LZ+hq+iZXajBfY91aS9UkxQ80/XnBVWntn0Rg7iqnHfvkW2tSorJWhZ67b/0dA/JB
 npuXdYzLxuE34ldSNEQviIvjeS5DJGvKicT3zdcraXVcnEmoKjrDEpXjvd5MuHeuuvYF
 u3pVkLV+0l+UOYM+98qj8GYh3ytiJrJ9Ulunl7dBoBKN9fPw1BWgBa3MO4Esct2DUoHw
 6Gbk0a3l6fE6Q0odrFcDdXBv89wX5/2iucUbLPTteFp5fPbXz0vQdh+PSZDyu0j1dgpL
 Xg9Q==
X-Gm-Message-State: AHQUAuZOGSzsLJLv3vE+Iu5uQNUTIxifjPynLHqMVtsLVbPDKG7v4lX8
 rTVtmjVAs6H2+T122S0BaGVD06tESlZjXmwoEnLN2w==
X-Google-Smtp-Source: AHgI3IZ73trhTnBp56oqdiFpvhVapXV9PZgD9Ci4654hxG67oSOYjdqP39cfx3Orco0gZ94/lV+wvRPodce2JKUFiM4=
X-Received: by 2002:a24:c3c4:: with SMTP id s187mr2932777itg.158.1550163339656; 
 Thu, 14 Feb 2019 08:55:39 -0800 (PST)
MIME-Version: 1.0
References: <20190213132738.10294-1-ard.biesheuvel@linaro.org>
 <20190213132738.10294-2-ard.biesheuvel@linaro.org>
 <325ae70b-6520-a186-c65f-8ab29a5be3a5@arm.com>
In-Reply-To: <325ae70b-6520-a186-c65f-8ab29a5be3a5@arm.com>
From: Ard Biesheuvel <ard.biesheuvel@linaro.org>
Date: Thu, 14 Feb 2019 17:55:28 +0100
Message-ID: <CAKv+Gu9BpVDg1=2bsR6ouWM2Xw1OZGMOZ4DXv5fQxE=HQXJsRg@mail.gmail.com>
Subject: Re: [PATCH 1/2] arm64: account for GICv3 LPI tables in static
 memblock reserve table
To: Marc Zyngier <marc.zyngier@arm.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190214_085541_292591_D060C0AA 
X-CRM114-Status: GOOD (  27.63  )
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
Cc: linux-efi <linux-efi@vger.kernel.org>,
 Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will.deacon@arm.com>,
 Linux-MM <linux-mm@kvack.org>, James Morse <james.morse@arm.com>,
 Andrew Morton <akpm@linux-foundation.org>,
 linux-arm-kernel <linux-arm-kernel@lists.infradead.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

On Thu, 14 Feb 2019 at 16:48, Marc Zyngier <marc.zyngier@arm.com> wrote:
>
> Hi Ard,
>
> On 13/02/2019 13:27, Ard Biesheuvel wrote:
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
>
> Since GICv3 has 1 pending table per CPU, plus one global property table,
> can we make this 2 * NR_CPUS + 1? Or is that enough already?
>

Ah, I misread the code then. That would mean we'll only need 1 extra
slot per CPU.

So I will change this to

> > +#define INIT_MEMBLOCK_RESERVED_REGIONS       (INIT_MEMBLOCK_REGIONS + NR_CPUS)

considering that INIT_MEMBLOCK_REGIONS defaults to 128, so that one
global table is already accounted for.


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
> >
>
> Otherwise:
>
> Acked-by: Marc Zyngier <marc.zyngier@arm.com>
>
>         M.
> --
> Jazz is not dead. It just smells funny...

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
