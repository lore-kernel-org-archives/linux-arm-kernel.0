Return-Path: <SRS0=4WgJ=OK=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=DKIMWL_WL_HIGH,
	DKIM_ADSP_CUSTOM_MED,DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7031AC04EB9
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Sat,  1 Dec 2018 22:55:49 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 344A62082F
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Sat,  1 Dec 2018 22:55:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="EeXx9ri8";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=google.com header.i=@google.com header.b="p5cHhBu0"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 344A62082F
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=google.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:To:Subject:Message-ID:Date:From:
	In-Reply-To:References:MIME-Version:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=yGEclDVUOVYgA3BRT9nMWnxmh35DYio1+W+4Hy2AV14=; b=EeXx9ri8gv1Ky0
	Sryp4wu76KLiUCjeepFrkzCITi2h3Kx3xrb5FF+10pselK9fBQxQFLK7vGCotlAuaoemBRhLLrUPc
	epSvc9cQcGlTux4yG5tYui6H8ZpESETXaf6Fr0PXSyBxtsqxjvPY7CkhwO1lI2SNVaN5C8c2Mz2Wq
	NVzxgjsJQ41Kmvn5its/zkUfxrpc1LhY2xwQ7hhU5Qdp5wMHBGiICmwCgfuM9Yrfy5eyKDBd2S2fD
	bN8UFzDO5XpD+gHC459rt6MZ3NJoqPnyWI+dHzhk5nrPd5VAVXMwEn6kXF9yofsIPcEWcz/9Utskx
	hU45S4QXBJHX7YQmSObA==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gTEAp-0001Ab-EY; Sat, 01 Dec 2018 22:55:43 +0000
Received: from mail-pg1-x542.google.com ([2607:f8b0:4864:20::542])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gTEAl-00019W-EH
 for linux-arm-kernel@lists.infradead.org; Sat, 01 Dec 2018 22:55:41 +0000
Received: by mail-pg1-x542.google.com with SMTP id g189so4057551pgc.5
 for <linux-arm-kernel@lists.infradead.org>;
 Sat, 01 Dec 2018 14:55:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=nBUJ0IFlPK3Tms0vcrgiSv4z/0dbbc+fHkmxnLPZSb4=;
 b=p5cHhBu0PT5VSs1jljAHm0gBgsd033XgqhbF+Jv8lVDb68zrbFCT2P9ORbnLdhfY1O
 txuuNzeqsS6zeOaa/92IiEKZbSubIlXnkxIkQ79z8EdPULbVY1nyaaj2kHCE5FfU8yev
 6+7PWixvlBYnWdXG0EjeftPUNDA6EbVnvFf3+V1mofA/PIkFxkMIY5juQuy9Yk6Zvm39
 pasc/ZUDxCd3qoSbzkb1W22+HltaC65j13KypgDXSeQuyDc4QtXAIU5dA3n9zHZwBXtq
 detN33UfHvDZ01tS/XGGyBkIxugmBU+LbWJ6V5KonD2pjGgIlI7QLfbm+AbdzKEXjqX4
 roWA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=nBUJ0IFlPK3Tms0vcrgiSv4z/0dbbc+fHkmxnLPZSb4=;
 b=EzDHMEK/YaXF/GXrVvraPCIglY04gLJWlOEetfTS1iErbpTIMBoTBt2ot+Y1PAO1VK
 2acV1GUVnsxEC9nxTcYw6cW/v/3RhC1zHdVuUXjnny0AZO0OThoRs9H34NBZbLljVkWd
 muwsFALqXUhYWVdAlVhOsF+NN1MG6+0vkMr2hND7NQg3JTKKxbrwiz26uQ0zIkUR2blP
 qXwu9HIj/8R9IXRRvNK6vS5cW6Wi7RupN1nIP9+t8SaWyD5zJULgntSL//ITcVV7lwcW
 LK9Vjgqpt9PU0xaOmsLDuRC1zCipEq42rra7IbvxMAOMrUzQbFBNRRJGI933n9sta3le
 qgJA==
X-Gm-Message-State: AA+aEWba5cMzJMlwiN0YsnN1Yuom64sEcQ2lpbZ82hQmGiPWwndvQixU
 L/z3Urd4h5ZN1Uxz22kjNChNPlhxOfl+x16Bxklykw==
X-Google-Smtp-Source: AFSGD/VSWxeNE5lHp450NVUl6Ciw7+OX/4iugeemyfXLtMcWN52Q3Hjaf7VgkH7foznvnypzWB6tHkad9ky15crvzPc=
X-Received: by 2002:a62:109b:: with SMTP id 27mr10379511pfq.227.1543704927954; 
 Sat, 01 Dec 2018 14:55:27 -0800 (PST)
MIME-Version: 1.0
References: <20181201115324.20847-1-ard.biesheuvel@linaro.org>
In-Reply-To: <20181201115324.20847-1-ard.biesheuvel@linaro.org>
From: Nick Desaulniers <ndesaulniers@google.com>
Date: Sat, 1 Dec 2018 14:55:16 -0800
Message-ID: <CAKwvOdnRV8cf5BrT5WMT36YeSAZEidtKuNBWdBq28+=TexwReg@mail.gmail.com>
Subject: Re: [RFT PATCH] arm64: relocatable: build the kernel as a proper
 shared library
To: Ard Biesheuvel <ard.biesheuvel@linaro.org>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20181201_145539_500637_420471F6 
X-CRM114-Status: GOOD (  21.08  )
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
Cc: Catalin Marinas <catalin.marinas@arm.com>, peter.smith@linaro.org,
 Will Deacon <will.deacon@arm.com>,
 Linux ARM <linux-arm-kernel@lists.infradead.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

On Sat, Dec 1, 2018 at 3:54 AM Ard Biesheuvel <ard.biesheuvel@linaro.org> wrote:
>
> readelf complains about the section layout of vmlinux when building
> with CONFIG_RELOCATABLE=y (for KASLR):
>
>   readelf: Warning: [21]: Link field (0) should index a symtab section.
>   readelf: Warning: [21]: Info field (0) should index a relocatable section.
>
> Also, it seems that our use of '-pie -shared' is contradictory, and
> thus ambiguous. In general, the way KASLR is wired up at the moment
> is highly tailored to how ld.bfd happens to implement (and conflate)
> PIE executables and shared libraries, so given the current effort to
> support other toolchains, let's fix some of these issues as well.
>
> - Drop the -pie linker argument and just leave -shared. In ld.bfd,
>   the differences between them are unclear (except for the ELF type
>   of the produced image [0]) but lld chokes on seeing both at the
>   same time.

This lines up with Peter's suggestion in
https://bugs.llvm.org/show_bug.cgi?id=39810#c15

>
> - Rename the .rela output section to .rela.dyn, as is customary for
>   shared libraries and PIE executables.
>
> - Don't discard the .dynamic, .dynsym, .dynstr and .hash sections.
>   Instead, make sure that they are [mostly] empty by marking all
>   symbols as local, and emit them into the .init segment.
>
> These changes only affect the ELF image, and produce the same binary
> image, with the exception of a couple of bytes of .init data for the
> empty .dynsym and .dynstr sections.
>
> [0] b9dce7f1ba01 ("arm64: kernel: force ET_DYN ELF type for ...")
>
> Cc: Nick Desaulniers <ndesaulniers@google.com>
> Cc: Peter Smith <peter.smith@linaro.org>
> Signed-off-by: Ard Biesheuvel <ard.biesheuvel@linaro.org>

Thanks for this patch Ard!
Boot tested in QEMU w/ and w/o CONFIG_RELOCATABLE=y.
Tested-by: Nick Desaulniers <ndesaulniers@google.com>

> ---
>  arch/arm64/Makefile             |  2 +-
>  arch/arm64/kernel/vmlinux.lds.S | 30 ++++++++++++++++++++++++------
>  2 files changed, 25 insertions(+), 7 deletions(-)
>
> diff --git a/arch/arm64/Makefile b/arch/arm64/Makefile
> index 6cb9fc7e9382..7221494bcf60 100644
> --- a/arch/arm64/Makefile
> +++ b/arch/arm64/Makefile
> @@ -18,7 +18,7 @@ ifeq ($(CONFIG_RELOCATABLE), y)
>  # Pass --no-apply-dynamic-relocs to restore pre-binutils-2.27 behaviour
>  # for relative relocs, since this leads to better Image compression
>  # with the relocation offsets always being zero.
> -LDFLAGS_vmlinux                += -pie -shared -Bsymbolic \
> +LDFLAGS_vmlinux                += -shared -Bsymbolic \
>                         $(call ld-option, --no-apply-dynamic-relocs)
>  endif
>
> diff --git a/arch/arm64/kernel/vmlinux.lds.S b/arch/arm64/kernel/vmlinux.lds.S
> index 03b00007553d..9ba4016090b1 100644
> --- a/arch/arm64/kernel/vmlinux.lds.S
> +++ b/arch/arm64/kernel/vmlinux.lds.S
> @@ -98,8 +98,6 @@ SECTIONS
>                 EXIT_CALL
>                 *(.discard)
>                 *(.discard.*)
> -               *(.interp .dynamic)
> -               *(.dynsym .dynstr .hash)
>         }
>
>         . = KIMAGE_VADDR + TEXT_OFFSET;
> @@ -192,12 +190,25 @@ SECTIONS
>
>         PERCPU_SECTION(L1_CACHE_BYTES)
>
> -       .rela : ALIGN(8) {
> +#ifdef CONFIG_RELOCATABLE
> +       .rela.dyn : ALIGN(8) {
>                 *(.rela .rela*)
>         }
> -
> -       __rela_offset   = ABSOLUTE(ADDR(.rela) - KIMAGE_VADDR);
> -       __rela_size     = SIZEOF(.rela);
> +       .dynamic : {
> +               *(.dynamic)
> +       }
> +       .dynsym : ALIGN(8) {
> +               *(.dynsym)
> +       }
> +       .dynstr : {
> +               *(.dynstr)
> +       }
> +       .hash : {
> +               *(.hash)
> +       }
> +       __rela_offset   = ABSOLUTE(ADDR(.rela.dyn) - KIMAGE_VADDR);
> +       __rela_size     = SIZEOF(.rela.dyn);
> +#endif
>
>         . = ALIGN(SEGMENT_ALIGN);
>         __initdata_end = .;
> @@ -244,6 +255,13 @@ SECTIONS
>         HEAD_SYMBOLS
>  }
>
> +#ifdef CONFIG_RELOCATABLE
> +VERSION {
> +       /* mark all symbols as local so they are not listed in .dynsym */
> +       { local: *; };
> +}
> +#endif
> +
>  /*
>   * The HYP init code and ID map text can't be longer than a page each,
>   * and should not cross a page boundary.
> --
> 2.19.2
>


-- 
Thanks,
~Nick Desaulniers

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
