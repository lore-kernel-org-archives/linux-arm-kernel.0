Return-Path: <SRS0=vaNk=PS=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0B401C43387
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Thu, 10 Jan 2019 17:04:27 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D0A4E20685
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Thu, 10 Jan 2019 17:04:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="lC0bS+we";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="YQsixwVJ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D0A4E20685
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:To:Subject:Message-ID:Date:From:
	In-Reply-To:References:MIME-Version:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=gcvX8s4DrHZLKxyTpQ4B54AwsQHUKjn9bds8ieOmbU8=; b=lC0bS+wetBQN3C
	sKrUpNvO7sl0ZARm0wRQgUVX6ijloVU376i8oOUjJ2ZFS3x0D0w8M7xz70lUeN1Mg6LMB3jFtyAbg
	ku0tI2mmFRQJ8sIG29jdiWbHHsPrdinHxVjxKGip/wiDE8rdCNQ/aMuaE+1Py7AzUpHj6Ep4DLGMf
	xRDVlKLibCqzZxIaN7dTV07o2lMCo2kiQtAEoUTwL4jJ+KpK27iPnP3p80m0G4DIiL5zu62xs+sg/
	6/3StxfZcp/4lzoGohtuICqvyVDiOKVj6t6h7aNe8l6bxeQW3WZw0/AeKjP9mwlhxnZsHq0zgiEdp
	SZu+8NaqIljFd6SInwyw==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1ghdkd-0006va-2q; Thu, 10 Jan 2019 17:04:15 +0000
Received: from mail-io1-xd44.google.com ([2607:f8b0:4864:20::d44])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1ghdkZ-0006vG-3G
 for linux-arm-kernel@lists.infradead.org; Thu, 10 Jan 2019 17:04:13 +0000
Received: by mail-io1-xd44.google.com with SMTP id r200so9482151iod.11
 for <linux-arm-kernel@lists.infradead.org>;
 Thu, 10 Jan 2019 09:04:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=0Fh2NXYiwwtZb6jv+4H5ykTsUQ/C3haChtu7Pr6Is0M=;
 b=YQsixwVJ6m+FEpBHKu++EVmX6HizWc2cLKpQT6B/AcQ8r1Ir7mg4LyKMsOqe8Izh9j
 6GaqLuNy0STv+d70ksN8Eyyo+4L0PUdYV/Bipi58kvn1yRsNTbSqpdiEAxVz5t3eNdts
 P0eA9QGHMgiLDTFGYIg/G7B0W8Ki9MvazufRw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=0Fh2NXYiwwtZb6jv+4H5ykTsUQ/C3haChtu7Pr6Is0M=;
 b=HEUxVlNPkqDQ3xlCInNxiv8/HNKuZ9uXyzTLM/s0swGcgmQxfSMdQ7gjrSklDgxsOO
 XhoJDqLJHO4DwRlrvH4IAPQzVtkO6rI2JSqjtl8HodvIH2+JUIr5XRB4Bkv+91UexCrh
 DnmH25qZoKor6m36YGYwIHxCbaoBD7yvRWdMPUGuPomt+HtriqYEbJjM3BCMCXHLULZB
 LKVizmHK05a0+WafFjicPuPwflqoIO7tPefJp9hIo/Q9fFppSoncjeU9as8OFPEGPPUJ
 8KHExFzeA/nibUiRuOpuantWp+CMKBlF8BIXqwwihsFJLqt5pUiYqmjnbWFi/32FjyZx
 wTdg==
X-Gm-Message-State: AJcUukcSmBQwNNLVtkgfeEFCxoifwuzGHWCxp37ThN57ZKS9qhsTm5iG
 1IZfj2fXqP9sNz60SeMjd6/FgG2e4chp4DtbDV6nUw==
X-Google-Smtp-Source: ALg8bN5JnI1LD7p1VexVJerO8DXMU2SNLqjl2IEsIYzV40dXOjoKKKrjMmWTAZGbm58Bdwf0RVy55VOR7fLT1jg1d6Q=
X-Received: by 2002:a6b:5d01:: with SMTP id r1mr6895357iob.170.1547139849790; 
 Thu, 10 Jan 2019 09:04:09 -0800 (PST)
MIME-Version: 1.0
References: <20190110105143.27008-1-will.deacon@arm.com>
In-Reply-To: <20190110105143.27008-1-will.deacon@arm.com>
From: Ard Biesheuvel <ard.biesheuvel@linaro.org>
Date: Thu, 10 Jan 2019 18:03:58 +0100
Message-ID: <CAKv+Gu8gJd6QSsB1X904g22+cE3m5SZcTRY-g+ro548BvCzS+w@mail.gmail.com>
Subject: Re: [PATCH v2] arm64: kpti: Avoid rewriting early page tables when
 KASLR is enabled
To: Will Deacon <will.deacon@arm.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190110_090411_141213_1F38AF77 
X-CRM114-Status: GOOD (  26.76  )
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
Cc: linux-arm-kernel <linux-arm-kernel@lists.infradead.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

On Thu, 10 Jan 2019 at 11:51, Will Deacon <will.deacon@arm.com> wrote:
>
> A side effect of commit c55191e96caa ("arm64: mm: apply r/o permissions
> of VM areas to its linear alias as well") is that the linear map is
> created with page granularity, which means that transitioning the early
> page table from global to non-global mappings when enabling kpti can
> take a significant amount of time during boot.
>
> Given that most CPU implementations do not require kpti, this mainly
> impacts KASLR builds where kpti is forcefully enabled. However, in these
> situations we know early on that non-global mappings are required and
> can avoid the use of global mappings from the beginning. The only gotcha
> is Cavium erratum #27456, which we must detect based on the MIDR value
> of the boot CPU.
>
> Cc: Ard Biesheuvel <ard.biesheuvel@linaro.org>
> Reported-by: John Garry <john.garry@huawei.com>
> Signed-off-by: Will Deacon <will.deacon@arm.com>

Reviewed-by: Ard Biesheuvel <ard.biesheuvel@linaro.org>

> ---
>
> v2: Fix module builds by exporting kimage_vaddr and avoiding references
>     to cavium_erratum_27456_cpus. Minor comment tweaks.
>
>  arch/arm64/include/asm/mmu.h          | 41 +++++++++++++++++++++++++++++++++++
>  arch/arm64/include/asm/pgtable-prot.h |  4 ++--
>  arch/arm64/kernel/cpu_errata.c        |  2 +-
>  arch/arm64/kernel/cpufeature.c        |  9 ++++++--
>  arch/arm64/kernel/head.S              |  1 +
>  5 files changed, 52 insertions(+), 5 deletions(-)
>
> diff --git a/arch/arm64/include/asm/mmu.h b/arch/arm64/include/asm/mmu.h
> index 43596b1a5897..bbb47402cd2b 100644
> --- a/arch/arm64/include/asm/mmu.h
> +++ b/arch/arm64/include/asm/mmu.h
> @@ -16,6 +16,8 @@
>  #ifndef __ASM_MMU_H
>  #define __ASM_MMU_H
>
> +#include <asm/cputype.h>
> +
>  #define MMCF_AARCH32   0x1     /* mm context flag for AArch32 executables */
>  #define USER_ASID_BIT  48
>  #define USER_ASID_FLAG (UL(1) << USER_ASID_BIT)
> @@ -44,6 +46,45 @@ static inline bool arm64_kernel_unmapped_at_el0(void)
>                cpus_have_const_cap(ARM64_UNMAP_KERNEL_AT_EL0);
>  }
>
> +static inline bool arm64_kernel_use_ng_mappings(void)
> +{
> +       bool tx1_bug;
> +
> +       /* What's a kpti? Use global mappings if we don't know. */
> +       if (!IS_ENABLED(CONFIG_UNMAP_KERNEL_AT_EL0))
> +               return false;
> +
> +       /*
> +        * Note: this function is called before the CPU capabilities have
> +        * been configured, so our early mappings will be global. If we
> +        * later determine that kpti is required, then
> +        * kpti_install_ng_mappings() will make them non-global.
> +        */
> +       if (!IS_ENABLED(CONFIG_RANDOMIZE_BASE))
> +               return arm64_kernel_unmapped_at_el0();
> +
> +       /*
> +        * KASLR is enabled so we're going to be enabling kpti on non-broken
> +        * CPUs regardless of their susceptibility to Meltdown. Rather
> +        * than force everybody to go through the G -> nG dance later on,
> +        * just put down non-global mappings from the beginning.
> +        */
> +       if (!IS_ENABLED(CONFIG_CAVIUM_ERRATUM_27456)) {
> +               tx1_bug = false;
> +#ifndef MODULE
> +       } else if (!static_branch_likely(&arm64_const_caps_ready)) {
> +               extern const struct midr_range cavium_erratum_27456_cpus[];
> +
> +               tx1_bug = is_midr_in_range_list(read_cpuid_id(),
> +                                               cavium_erratum_27456_cpus);
> +#endif
> +       } else {
> +               tx1_bug = __cpus_have_const_cap(ARM64_WORKAROUND_CAVIUM_27456);
> +       }
> +
> +       return !tx1_bug && kaslr_offset() > 0;
> +}
> +
>  typedef void (*bp_hardening_cb_t)(void);
>
>  struct bp_hardening_data {
> diff --git a/arch/arm64/include/asm/pgtable-prot.h b/arch/arm64/include/asm/pgtable-prot.h
> index 78b942c1bea4..986e41c4c32b 100644
> --- a/arch/arm64/include/asm/pgtable-prot.h
> +++ b/arch/arm64/include/asm/pgtable-prot.h
> @@ -37,8 +37,8 @@
>  #define _PROT_DEFAULT          (PTE_TYPE_PAGE | PTE_AF | PTE_SHARED)
>  #define _PROT_SECT_DEFAULT     (PMD_TYPE_SECT | PMD_SECT_AF | PMD_SECT_S)
>
> -#define PTE_MAYBE_NG           (arm64_kernel_unmapped_at_el0() ? PTE_NG : 0)
> -#define PMD_MAYBE_NG           (arm64_kernel_unmapped_at_el0() ? PMD_SECT_NG : 0)
> +#define PTE_MAYBE_NG           (arm64_kernel_use_ng_mappings() ? PTE_NG : 0)
> +#define PMD_MAYBE_NG           (arm64_kernel_use_ng_mappings() ? PMD_SECT_NG : 0)
>
>  #define PROT_DEFAULT           (_PROT_DEFAULT | PTE_MAYBE_NG)
>  #define PROT_SECT_DEFAULT      (_PROT_SECT_DEFAULT | PMD_MAYBE_NG)
> diff --git a/arch/arm64/kernel/cpu_errata.c b/arch/arm64/kernel/cpu_errata.c
> index 09ac548c9d44..9950bb0cbd52 100644
> --- a/arch/arm64/kernel/cpu_errata.c
> +++ b/arch/arm64/kernel/cpu_errata.c
> @@ -553,7 +553,7 @@ static const struct midr_range arm64_repeat_tlbi_cpus[] = {
>  #endif
>
>  #ifdef CONFIG_CAVIUM_ERRATUM_27456
> -static const struct midr_range cavium_erratum_27456_cpus[] = {
> +const struct midr_range cavium_erratum_27456_cpus[] = {
>         /* Cavium ThunderX, T88 pass 1.x - 2.1 */
>         MIDR_RANGE(MIDR_THUNDERX, 0, 0, 1, 1),
>         /* Cavium ThunderX, T81 pass 1.0 */
> diff --git a/arch/arm64/kernel/cpufeature.c b/arch/arm64/kernel/cpufeature.c
> index 4f272399de89..f6d84e2c92fe 100644
> --- a/arch/arm64/kernel/cpufeature.c
> +++ b/arch/arm64/kernel/cpufeature.c
> @@ -983,7 +983,7 @@ static bool unmap_kernel_at_el0(const struct arm64_cpu_capabilities *entry,
>
>         /* Useful for KASLR robustness */
>         if (IS_ENABLED(CONFIG_RANDOMIZE_BASE))
> -               return true;
> +               return kaslr_offset() > 0;
>
>         /* Don't force KPTI for CPUs that are not vulnerable */
>         if (is_midr_in_range_list(read_cpuid_id(), kpti_safe_list))
> @@ -1003,7 +1003,12 @@ kpti_install_ng_mappings(const struct arm64_cpu_capabilities *__unused)
>         static bool kpti_applied = false;
>         int cpu = smp_processor_id();
>
> -       if (kpti_applied)
> +       /*
> +        * We don't need to rewrite the page-tables if either we've done
> +        * it already or we have KASLR enabled and therefore have not
> +        * created any global mappings at all.
> +        */
> +       if (kpti_applied || kaslr_offset() > 0)
>                 return;
>
>         remap_fn = (void *)__pa_symbol(idmap_kpti_install_ng_mappings);
> diff --git a/arch/arm64/kernel/head.S b/arch/arm64/kernel/head.S
> index c7213674cb24..15d79a8e5e5e 100644
> --- a/arch/arm64/kernel/head.S
> +++ b/arch/arm64/kernel/head.S
> @@ -475,6 +475,7 @@ ENDPROC(__primary_switched)
>
>  ENTRY(kimage_vaddr)
>         .quad           _text - TEXT_OFFSET
> +EXPORT_SYMBOL(kimage_vaddr)
>
>  /*
>   * If we're fortunate enough to boot at EL2, ensure that the world is
> --
> 2.11.0
>

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
