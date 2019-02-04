Return-Path: <SRS0=7SeU=QL=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 02B96C282C4
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Mon,  4 Feb 2019 13:51:27 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id BA9792081B
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Mon,  4 Feb 2019 13:51:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="erfSz0Go";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="T27lCmRd"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BA9792081B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:To:Subject:Message-ID:Date:From:
	In-Reply-To:References:MIME-Version:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=S3qxHOlDSD6B9nQ3Cb23USFjAwZuyXJfaDrUEx7DKDA=; b=erfSz0Goav/Msv
	DCZaN2IP8SIjMasg9suLCdUI5ztKSU60w6phlyadF2q0lJygyJ59DAwz/Vpmm0D4pI9yF7PT8mvKT
	nUocqYGBVruFykveB1uJtKnOtjlp3DpXO4B3wMxPO9htCp2xJ/xvqxHXwGq1h3QsLWGNHvgTRJss1
	CnxEyE1+eCD8Ae5quJG0AMvvcB5d6wn5mktIKYOjnwK6k/4DjY3OT2GQPIhBld3YJFdgFGmKwuvJX
	pE+2OaeLO1FdybK9VaA6kHh4NT2PD9vu3SnyylY6VZYKIkpZ50FjoTgCin9dxxwMdXqbMwO9kKS0S
	n9H+6p+BjnwR9l/TUBoQ==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gqeei-0003pQ-99; Mon, 04 Feb 2019 13:51:24 +0000
Received: from mail-it1-x143.google.com ([2607:f8b0:4864:20::143])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gqeeZ-0003fZ-QZ
 for linux-arm-kernel@lists.infradead.org; Mon, 04 Feb 2019 13:51:21 +0000
Received: by mail-it1-x143.google.com with SMTP id a6so21056144itl.4
 for <linux-arm-kernel@lists.infradead.org>;
 Mon, 04 Feb 2019 05:51:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=yWRevMXFNpbxuvqzTy7dEBAKGR7R1aJnsJ95RwqNsIE=;
 b=T27lCmRdUNDkqdUgBHyeTzzsb9P5jTw46dSCXdTmm9HiKq8O0H5JqSafq/YM4JG/3I
 lgn5rd0796iFafK/hr97kpCmsW0g2iWJxljl+qNx/xV9664a6qxwTB0WzGxy4I6XIGXt
 F6HuotaeZ/YHSdJsv8ldkozEdfBLTF+Shy2uo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=yWRevMXFNpbxuvqzTy7dEBAKGR7R1aJnsJ95RwqNsIE=;
 b=Mn8DrZx1JBKPXkPIsKk8tviJRNJ5eJS+d7dZdAKZSc0gcBdOxIvfZRjllT56k2Kwhg
 ECG+1dF9SH+vGg2Xgmz4ogLJYHsxrzJ8WSuG8bHKXXLx1Mk0nXANLac99Br1kvw+joE/
 5SPlE8WINHKHRJLktPZ/cqmAKyE1ECo9XeZHQuxGUcA6G0snVzdT9oY+ahbGkz62DlAN
 oCsdXFCzDj18fYMHEgHVDBzG72rS5tqpji8ElJZGzK60SIQPjmnmEf1Ebz5VmQj4VLio
 ZicSxI9LRvGfbDM/9KVQqqUQTz/pxP+LqqEeUYEfAZI7n8rzzG6xxzCN87tXpG+6YYuv
 GGuQ==
X-Gm-Message-State: AHQUAuYOjGQgcbA0dMKmvQthIPXq+m0YP4UYnV4yCnifNBE514kAx117
 uEIVQXRiLpghfI9rFLD6kyyKPa5G1Vi6zXUJXz1l0g==
X-Google-Smtp-Source: AHgI3IZgVyAzAJ8FFiLNyXeQJJfGuc9kq8AVJ2YkLcsJNTo5Vfw2GZXFeqVkxehVeImEEdMHh33qgKdd5ENNDQt//uk=
X-Received: by 2002:a05:6638:14:: with SMTP id z20mr714314jao.2.1549288274710; 
 Mon, 04 Feb 2019 05:51:14 -0800 (PST)
MIME-Version: 1.0
References: <fe7fa86a-42ed-ee58-be26-4d8ae45fadab@lca.pw>
 <20190201134847.GC29903@fuggles.cambridge.arm.com>
 <1549054142.6911.25.camel@lca.pw>
 <20190204102715.GA11645@capper-debian.cambridge.arm.com>
In-Reply-To: <20190204102715.GA11645@capper-debian.cambridge.arm.com>
From: Ard Biesheuvel <ard.biesheuvel@linaro.org>
Date: Mon, 4 Feb 2019 14:51:03 +0100
Message-ID: <CAKv+Gu8KQLHfq3L1Xjd0RSbvs2eEokyUkT+7v4df=BRdqmjrnQ@mail.gmail.com>
Subject: Re: kernel_page_tables issue with CONFIG_ARM64_USER_VA_BITS_52=y
To: Steve Capper <Steve.Capper@arm.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190204_055116_329115_38D80C62 
X-CRM114-Status: GOOD (  16.78  )
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
Cc: Catalin Marinas <Catalin.Marinas@arm.com>, nd <nd@arm.com>,
 Qian Cai <cai@lca.pw>, Linux ARM <linux-arm-kernel@lists.infradead.org>,
 Will Deacon <Will.Deacon@arm.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

Hi Steve,

On Mon, 4 Feb 2019 at 11:27, Steve Capper <Steve.Capper@arm.com> wrote:
>
> On Fri, Feb 01, 2019 at 03:49:02PM -0500, Qian Cai wrote:
> > On Fri, 2019-02-01 at 13:48 +0000, Will Deacon wrote:
> > > Hi Qian Cai,
>
> [...]
>
> > Unfortunately, although this takes care of kernel_page_tables, it breaks
> > efi_page_tables.
> >
> > # cat /sys/kernel/debug/efi_page_tables
> > BUG()
> >
> > # ./scripts/faddr2line vmlinux walk_pgd+0x84/0x254
> > walk_pgd+0x84/0x254:
> > __read_once_size at include/linux/compiler.h:193 (discriminator 1)
> > (inlined by) walk_pgd at arch/arm64/mm/dump.c:345 (discriminator 1)
> >
> > 344:        do {
> > 345:                pgd_t pgd = READ_ONCE(*pgdp);
> > 346:                next = pgd_addr_end(addr, 0);
> >
> > kernel BUG at arch/arm64/mm/dump.c:332!
> >
> >                 } else {
> >                         BUG_ON(pud_bad(pud));
> >                         walk_pmd(st, pudp, addr, next);
> >
>
> Hi Qian Cai,
> Apologies for missing the efi_page_tables.
>
> Does the following (applied to Will's fix) help?
>
> Cheers,
> --
> Steve
>
> --->8
>
> diff --git a/arch/arm64/mm/dump.c b/arch/arm64/mm/dump.c
> index 00ca2adeb5ef..42ac8fd15e59 100644
> --- a/arch/arm64/mm/dump.c
> +++ b/arch/arm64/mm/dump.c
> @@ -339,11 +339,12 @@ static void walk_pgd(struct pg_state *st, struct mm_struct *mm,
>                      unsigned long start)
>  {
>         unsigned long next, addr = start;
> +       unsigned long end = (start < TASK_SIZE_64) ? TASK_SIZE_64 : 0;
>         pgd_t *pgdp = pgd_offset(mm, addr);
>
>         do {
>                 pgd_t pgd = READ_ONCE(*pgdp);
> -               next = pgd_addr_end(addr, 0);
> +               next = pgd_addr_end(addr, end);
>
>                 if (pgd_none(pgd)) {
>                         note_page(st, addr, 1, pgd_val(pgd));
> @@ -351,7 +352,7 @@ static void walk_pgd(struct pg_state *st, struct mm_struct *mm,
>                         BUG_ON(pgd_bad(pgd));
>                         walk_pud(st, pgdp, addr, next);
>                 }
> -       } while (pgdp++, addr = next, addr);
> +       } while (pgdp++, addr = next, addr != end);
>  }
>
>  void ptdump_walk_pgd(struct seq_file *m, struct ptdump_info *info)
> diff --git a/drivers/firmware/efi/arm-runtime.c b/drivers/firmware/efi/arm-runtime.c
> index 23ea1ed409d1..16757966c3bf 100644
> --- a/drivers/firmware/efi/arm-runtime.c
> +++ b/drivers/firmware/efi/arm-runtime.c
> @@ -38,7 +38,8 @@ static struct ptdump_info efi_ptdump_info = {
>         .mm             = &efi_mm,
>         .markers        = (struct addr_marker[]){
>                 { 0,            "UEFI runtime start" },
> -               { DEFAULT_MAP_WINDOW_64, "UEFI runtime end" }
> +               { DEFAULT_MAP_WINDOW_64, "UEFI runtime end" },
> +               { -1, NULL }
>         },
>         .base_addr      = 0,
>  };
>

FYI this last hunk went into v5.0-rc5 as a fix (proposed by Qian)

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
