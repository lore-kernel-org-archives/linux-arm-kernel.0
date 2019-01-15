Return-Path: <SRS0=3lKL=PX=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 68971C43387
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Tue, 15 Jan 2019 20:13:02 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2E35520657
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Tue, 15 Jan 2019 20:13:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="JX1h6xFd";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="CbiPtH8N"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2E35520657
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:To:Subject:Message-ID:Date:From:
	In-Reply-To:References:MIME-Version:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=4rUUeSz+M3ROciaOn1LfKeT6fD6eIb0RJvOgplohLxE=; b=JX1h6xFd7QQRmk
	KotZIBwcre+flHieiCunRv58zTE87o/gsq61nF5DpeNJC5hGY97JizOZ7Op7Uspzk0dLkSfeb8U5X
	hNYTL3FLF0L0g6pyIxGcApDYjzuSQTtXpYa4QpkTS6VRKojzZ+T/TQRxxJMXzrKs+sjpF2yQP9uSF
	u0wKSLvkpSGgMp5rcoTqcmPLXRsbwqy7x+btmv//seB1xzTXq5tMhgjVhDHhO9ZBVPiI/0KGDtXHT
	RDdddovPGqD5f/tzHQjpVA/MvbtoXGM1hdTvxsv5nQ7h5BIII1O4nkkCkO7UFFpKu1YqGm8LpDZGh
	Ng2d/aeUcBuX4mAIGPfA==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gjV50-0008Ee-QF; Tue, 15 Jan 2019 20:12:58 +0000
Received: from mail-it1-x144.google.com ([2607:f8b0:4864:20::144])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gjV4w-0008EG-Pw
 for linux-arm-kernel@lists.infradead.org; Tue, 15 Jan 2019 20:12:56 +0000
Received: by mail-it1-x144.google.com with SMTP id g85so7148901ita.3
 for <linux-arm-kernel@lists.infradead.org>;
 Tue, 15 Jan 2019 12:12:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=yVzVL+DtgVt5rbXlkDyjfjV6KWKxqAUpjqqu/7uMkQg=;
 b=CbiPtH8NSU0siossyo/NQqVnqiXesQxwyb3vngyiomXKxtLS+3bveqUaU7iSIcJFC1
 uNhc4EIuqF4Cv1FSh9w1LvzckX++JhHblSnkC2OlZA8YCV0OcUGkSQ03KImljb0GOfRs
 8bCwRJ/nvzrv4+mCm0SpKF7wHbq1KPwU46TZA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=yVzVL+DtgVt5rbXlkDyjfjV6KWKxqAUpjqqu/7uMkQg=;
 b=BzSb9v4Nb73wQFODPftWcLSx/R6yKRuYIMFInbcFz88fr7WsWfTRdbbTAn3SX7YWvc
 B/M1hZQY2cok7VkwCJvOxN8sNZW0U+xBlMCh2f1JZx88bGysEdx3OnGPRMZKZra08UKA
 qoG9j48fK/qekajZCDW7cVYbERhzqsU+FhAkHEfM0xMigKqLeuSbActZgIPRz+E2QZqJ
 YQaareiNqrUSLLT1ZviZsp9IsqZimdQhKMb6jbXRJgE7z28TZUW8kQ6RY4yTD+7jguWC
 ncp6wduxKRr3xAEOYjFVDPYnkRR8msRBAKsZ98fD5RGTKPY3BSNEXK1c9uvTOiitsJ90
 os+A==
X-Gm-Message-State: AJcUukeW5pBPuB6rXSiy5T/hLeC0VudSBa8Qvg5tKqsYyibpKjNtVbJf
 01gIWW0SmwzBmUxUNUrhJzGTTvYNnEKtlnhZdbwa2KpKpjz4Mg==
X-Google-Smtp-Source: ALg8bN5/iO7BfOfkEYvjivETNY8yJVLHmGHud0TrHC/S7A6XT23XH8zCFI6s+IT6PEhSQVvwI0+NI4YNTt64/lcq9rU=
X-Received: by 2002:a05:660c:4b:: with SMTP id
 p11mr3675545itk.71.1547583173450; 
 Tue, 15 Jan 2019 12:12:53 -0800 (PST)
MIME-Version: 1.0
References: <20190115194707.11614-1-ard.biesheuvel@linaro.org>
In-Reply-To: <20190115194707.11614-1-ard.biesheuvel@linaro.org>
From: Ard Biesheuvel <ard.biesheuvel@linaro.org>
Date: Tue, 15 Jan 2019 21:12:41 +0100
Message-ID: <CAKv+Gu_BZZVNj9scfwfuEmbPD93oyBGjs08raLgD7dQ9+3B7Fw@mail.gmail.com>
Subject: Re: [PATCH] arm64: kaslr: ensure randomized quantities are clean to
 the PoC
To: linux-arm-kernel <linux-arm-kernel@lists.infradead.org>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190115_121254_839204_86D17EC0 
X-CRM114-Status: GOOD (  20.78  )
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
Cc: Mark Rutland <mark.rutland@arm.com>,
 Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will.deacon@arm.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

On Tue, 15 Jan 2019 at 20:47, Ard Biesheuvel <ard.biesheuvel@linaro.org> wrote:
>
> kaslr_early_init() is called with the kernel mapped at its
> link time offset, and if it returns with a non-zero offset,
> the kernel is unmapped and remapped again at the randomized
> offset.
>
> During its execution, kaslr_early_init() also randomizes the
> base of the module region and of the linear mapping of DRAM,
> and sets two variables accordingly. However, since these
> variables are assigned with the caches on, they may get lost
> during the cache maintenance that occurs when unmapping and
> remapping the kernel, so ensure that these values are cleaned
> to the PoC.
>
> Fixes: f80fb3a3d508 ("arm64: add support for kernel ASLR")
> Cc: <stable@vger.kernel.org> # v4.6+
> Signed-off-by: Ard Biesheuvel <ard.biesheuvel@linaro.org>

On an affected kernel build, I see the following variables sharing the
same 64-byte cacheline

ffff00001100bd18 R module_alloc_base
ffff00001100bd20 R memstart_addr
ffff00001100bd28 R arm64_dma_phys_limit
ffff00001100bd30 R kimage_voffset
ffff00001100bd38 R vabits_user

and we now have the following code in head.S (line 330)

adr_l x6, vabits_user
str x5, [x6]
dmb sy
dc ivac, x6 // Invalidate potentially stale cache line

which is invoked after kaslr_early_init() returns.


> ---
>  arch/arm64/kernel/kaslr.c | 8 ++++++--
>  1 file changed, 6 insertions(+), 2 deletions(-)
>
> diff --git a/arch/arm64/kernel/kaslr.c b/arch/arm64/kernel/kaslr.c
> index f0e6ab8abe9c..ba6b41790fcd 100644
> --- a/arch/arm64/kernel/kaslr.c
> +++ b/arch/arm64/kernel/kaslr.c
> @@ -14,6 +14,7 @@
>  #include <linux/sched.h>
>  #include <linux/types.h>
>
> +#include <asm/cacheflush.h>
>  #include <asm/fixmap.h>
>  #include <asm/kernel-pgtable.h>
>  #include <asm/memory.h>
> @@ -43,7 +44,7 @@ static __init u64 get_kaslr_seed(void *fdt)
>         return ret;
>  }
>
> -static __init const u8 *get_cmdline(void *fdt)
> +static __init const u8 *kaslr_get_cmdline(void *fdt)
>  {
>         static __initconst const u8 default_cmdline[] = CONFIG_CMDLINE;
>
> @@ -109,7 +110,7 @@ u64 __init kaslr_early_init(u64 dt_phys)
>          * Check if 'nokaslr' appears on the command line, and
>          * return 0 if that is the case.
>          */
> -       cmdline = get_cmdline(fdt);
> +       cmdline = kaslr_get_cmdline(fdt);
>         str = strstr(cmdline, "nokaslr");
>         if (str == cmdline || (str > cmdline && *(str - 1) == ' '))
>                 return 0;
> @@ -169,5 +170,8 @@ u64 __init kaslr_early_init(u64 dt_phys)
>         module_alloc_base += (module_range * (seed & ((1 << 21) - 1))) >> 21;
>         module_alloc_base &= PAGE_MASK;
>
> +       __flush_dcache_area(&module_alloc_base, sizeof(module_alloc_base));
> +       __flush_dcache_area(&memstart_offset_seed, sizeof(memstart_offset_seed));
> +
>         return offset;
>  }
> --
> 2.17.1
>

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
