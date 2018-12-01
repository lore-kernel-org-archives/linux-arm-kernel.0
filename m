Return-Path: <SRS0=4WgJ=OK=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.5 required=3.0 tests=DKIMWL_WL_HIGH,
	DKIM_ADSP_CUSTOM_MED,DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 16E95C04EB9
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Sat,  1 Dec 2018 23:12:08 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id CD960206B7
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Sat,  1 Dec 2018 23:12:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="kBzz3plR";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=google.com header.i=@google.com header.b="nQ1bQWrh"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CD960206B7
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=google.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:To:Subject:Message-ID:Date:From:
	In-Reply-To:References:MIME-Version:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=ApAIG2Os7Feiym/vmEF6MUZHIeOwCJWMmpiNkkg7D8M=; b=kBzz3plRXpBn8R
	z+lOJff0pPXgQLBEG2LTO/TZgLGIwPo+XkXNxcwG1LFIu3xrbsKyOaJ0xlfQAiyOmX6AqLnVB5j94
	BxjBDSNkXUjDqbrX0RrGwOzcjH/inuZowXBnST9fty5g+mpllVi55RxZeowxRejZ4kYei/fpEFU/b
	P18fNmsFVvRVK4gboqx3oSVyJe2/52OL4uK9wUBybt8klXPI3QO2/Vm7umdFI94SNVkFcRq3Gl+vZ
	AdKywlnQSuSSFMU0J9PS7tOWdLVyQATYGZtMKPYTRnBHQQaSQoa2LxPHoV/21fvCOHyWiCScIV/Vn
	QDTUrthzu+HHULiFo2iQ==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gTEQe-0005v6-Cs; Sat, 01 Dec 2018 23:12:04 +0000
Received: from mail-pl1-x642.google.com ([2607:f8b0:4864:20::642])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gTEQZ-0005uT-7x
 for linux-arm-kernel@lists.infradead.org; Sat, 01 Dec 2018 23:12:01 +0000
Received: by mail-pl1-x642.google.com with SMTP id p8so4591354plo.2
 for <linux-arm-kernel@lists.infradead.org>;
 Sat, 01 Dec 2018 15:11:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=tLJfpw/dqiewcUllkb4+KjGBaSNpPKgO9G4q/y4bKbY=;
 b=nQ1bQWrhjUk+rXrmnVaOYYpfIkpsJ7VPaxzb5KIgOcKEKsEefb4AqUFB7gMhoK57gj
 PbloSOPYn4AfLpInm5fHhlAQ/bdwcLgH6ddajDHkLywwjVTeKPmJ94kIzPJApzBObLC3
 Bp3iQQ0toKHOAiGCPmLQG0UW6wAFCF8A88OzhkjzI4m2CmkSKkkh5PO8Ch5Cy0uwYThx
 TNooxNThI0u9S8oHcL3Z6a7Ty0hx5ZcSgl5ocsj21mt17cQ6Agc1i4MRwWuc45NZpTKo
 QxEWUcuNd2PQ7RWHLhmA6QckhD+ws+XFkCaf+hJEbKyOHu72Hk9XhL0xQcx9eyc8bGaj
 eyzw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=tLJfpw/dqiewcUllkb4+KjGBaSNpPKgO9G4q/y4bKbY=;
 b=AgLKZc7iq4/JcylpACQMrVLnMnphRuznRYHM5JW5dJi9mUnVZUWq7Qpxg8pVtaMs29
 5OL5wY2tLXrPGfEmFOxHd1xZdC07BZ4/T43HDLFJCouUI3NQN13cFuSR3FEJM8WOTRTv
 oE1jNkGjdEQOWgRDHGuqkpMT+vtncA9b20ivBtNgmRgFNPXFbHVR2J+rJRIL6y7cDKa5
 S5PuXPh6MrpDtLlcykscLoe2HvNhhdeNNMOxWDVhny0Ox8ZZF+S0oV7gQD8La0vx1z/T
 MP7HuupqWwqGWfGqXdAjDd7O1vb+7+XxFMn3FLAzQZevj2Bm09Dmdwi4k72QHnTx67YR
 Z2ZQ==
X-Gm-Message-State: AA+aEWa5RPosvIpy3kNghdMi32YlbfDKCdFpoXKSMK2dwk68RkPWjQpZ
 +rG9XbYTldCkQSL2+OAHhNUz7C1I81WDmW2tCD9m5w==
X-Google-Smtp-Source: AFSGD/WOKZoQkY2Tpv21/87ipFhkUy3T4toTRt2fmI8ve13wTPAAAooelqiQkOJYPmuzwbjKTJKXJ6fTk+1B985A3f0=
X-Received: by 2002:a17:902:4464:: with SMTP id
 k91mr10871954pld.13.1543705906654; 
 Sat, 01 Dec 2018 15:11:46 -0800 (PST)
MIME-Version: 1.0
References: <20181201135734.10060-1-ard.biesheuvel@linaro.org>
In-Reply-To: <20181201135734.10060-1-ard.biesheuvel@linaro.org>
From: Nick Desaulniers <ndesaulniers@google.com>
Date: Sat, 1 Dec 2018 15:11:35 -0800
Message-ID: <CAKwvOdnyNedX1G4qo1MQSVTcTYij_zE0MW6W9ncFCsxCcssAPQ@mail.gmail.com>
Subject: Re: [RFT PATCH] arm64: add support for building the KASLR kernel with
 LLVM lld
To: Ard Biesheuvel <ard.biesheuvel@linaro.org>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20181201_151159_312106_3BEFB64D 
X-CRM114-Status: GOOD (  23.05  )
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

Ard, thanks again for this patch set!  I'm impressed with your skills
with linker scripts (and assembly); something I don't get to work with
day to day.

On Sat, Dec 1, 2018 at 5:57 AM Ard Biesheuvel <ard.biesheuvel@linaro.org> wrote:
>
> Work around some differences in the behavior of ld.lld as compared
> to lb.bfd:

s/lb/ld/

> - pass the -z notext and -z norelro options to convince the linker to
>   permit text relocations, and relro sections that are non-adjacent
>   (both of which are irrelevant for bare metal executables such as the
>   kernel)

-z notext is also an implicit default for ld.bfd as per:
https://bugs.llvm.org/show_bug.cgi?id=39810#c7
(so this addition is no functional change for bfd, just helps lld)

> - move the definition of some __efistub_ decorated section markers to
>   the linker script, which permits us to assign them as relative
>   quantities (since using an intermediate assignment loses the section
>   relative property when using ld.lld)

I've filed https://bugs.llvm.org/show_bug.cgi?id=39857 to follow up on
this lld bug.

> - handle .eh_frame and .gnu.hash sections to avoid them from being
>   emitted between .head.text and .text, screwing up the section layout.
>
> Cc: Nick Desaulniers <ndesaulniers@google.com>
> Cc: Peter Smith <peter.smith@linaro.org>
> Signed-off-by: Ard Biesheuvel <ard.biesheuvel@linaro.org>
> ---
>
> With this patch and [0] applied on top of today's arm64/for-next/core [1],
> I can create a working KASLR kernel using ld.lld (using LLD 6 from
> Debian Buster)

I applied the following 3 patches to mainline:
http://lists.infradead.org/pipermail/linux-arm-kernel/2018-November/616512.html:
[PATCH] arm64: drop linker script hack to hide efistub symbols
http://lists.infradead.org/pipermail/linux-arm-kernel/2018-December/616754.html:
[RFT PATCH] arm64: relocatable: build the kernel as a proper shared
library
http://lists.infradead.org/pipermail/linux-arm-kernel/2018-December/616765.html:
[RFT PATCH] arm64: add support for building the KASLR kernel with LLVM
lld

(last one is this patch)
and was able to compile, link, and QEMU boot:
1. ld.bfd CONFIG_RANDOMIZE_BASE=n
2. ld.bfd CONFIG_RANDOMIZE_BASE=y
3. ld.lld CONFIG_RANDOMIZE_BASE=n
4. ld.lld CONFIG_RANDOMIZE_BASE=y

Tested-by: Nick Desaulniers <ndesaulniers@google.com>

I'll do further testing on metal next week, but I'm quite confident
with the QEMU boot tests.
Thanks again, Ard!

>
> [0] https://marc.info/?l=linux-arm-kernel&m=154366528003912
> [1] https://git.kernel.org/pub/scm/linux/kernel/git/arm64/linux.git/log/?h=for-next/core
>
>  arch/arm64/Makefile             |  2 +-
>  arch/arm64/kernel/image.h       |  5 -----
>  arch/arm64/kernel/vmlinux.lds.S | 10 ++++++++++
>  3 files changed, 11 insertions(+), 6 deletions(-)
>
> diff --git a/arch/arm64/Makefile b/arch/arm64/Makefile
> index 7221494bcf60..8978f60779c4 100644
> --- a/arch/arm64/Makefile
> +++ b/arch/arm64/Makefile
> @@ -18,7 +18,7 @@ ifeq ($(CONFIG_RELOCATABLE), y)
>  # Pass --no-apply-dynamic-relocs to restore pre-binutils-2.27 behaviour
>  # for relative relocs, since this leads to better Image compression
>  # with the relocation offsets always being zero.
> -LDFLAGS_vmlinux                += -shared -Bsymbolic \
> +LDFLAGS_vmlinux                += -shared -Bsymbolic -z notext -z norelro \
>                         $(call ld-option, --no-apply-dynamic-relocs)
>  endif
>
> diff --git a/arch/arm64/kernel/image.h b/arch/arm64/kernel/image.h
> index 8da289dc843a..628c2fbf8939 100644
> --- a/arch/arm64/kernel/image.h
> +++ b/arch/arm64/kernel/image.h
> @@ -73,8 +73,6 @@
>
>  #ifdef CONFIG_EFI
>
> -__efistub_stext_offset = stext - _text;
> -
>  /*
>   * The EFI stub has its own symbol namespace prefixed by __efistub_, to
>   * isolate it from the kernel proper. The following symbols are legally
> @@ -102,9 +100,6 @@ __efistub___memmove         = __pi_memmove;
>  __efistub___memset             = __pi_memset;
>  #endif
>
> -__efistub__text                        = _text;
> -__efistub__end                 = _end;
> -__efistub__edata               = _edata;
>  __efistub_screen_info          = screen_info;
>
>  #endif
> diff --git a/arch/arm64/kernel/vmlinux.lds.S b/arch/arm64/kernel/vmlinux.lds.S
> index 9ba4016090b1..cf3ad76f339f 100644
> --- a/arch/arm64/kernel/vmlinux.lds.S
> +++ b/arch/arm64/kernel/vmlinux.lds.S
> @@ -98,12 +98,15 @@ SECTIONS
>                 EXIT_CALL
>                 *(.discard)
>                 *(.discard.*)
> +               *(.eh_frame)
>         }
>
>         . = KIMAGE_VADDR + TEXT_OFFSET;
>
>         .head.text : {
>                 _text = .;
> +               PROVIDE(__efistub__text = .);
> +
>                 HEAD_TEXT
>         }
>         .text : {                       /* Real text segment            */
> @@ -206,6 +209,9 @@ SECTIONS
>         .hash : {
>                 *(.hash)
>         }
> +       .gnu.hash : {
> +               *(.gnu.hash)
> +       }
>         __rela_offset   = ABSOLUTE(ADDR(.rela.dyn) - KIMAGE_VADDR);
>         __rela_size     = SIZEOF(.rela.dyn);
>  #endif
> @@ -239,6 +245,7 @@ SECTIONS
>         PECOFF_EDATA_PADDING
>         __pecoff_data_rawsize = ABSOLUTE(. - __initdata_begin);
>         _edata = .;
> +       PROVIDE(__efistub__edata = .);
>
>         BSS_SECTION(0, 0, 0)
>
> @@ -249,12 +256,15 @@ SECTIONS
>
>         __pecoff_data_size = ABSOLUTE(. - __initdata_begin);
>         _end = .;
> +       PROVIDE(__efistub__end = .);
>
>         STABS_DEBUG
>
>         HEAD_SYMBOLS
>  }
>
> +PROVIDE(__efistub_stext_offset = stext - _text);
> +
>  #ifdef CONFIG_RELOCATABLE
>  VERSION {
>         /* mark all symbols as local so they are not listed in .dynsym */
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
