Return-Path: <SRS0=qRPW=OW=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_PASS,T_MIXED_ES autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1A990C65BAE
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Thu, 13 Dec 2018 18:45:51 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E05C320879
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Thu, 13 Dec 2018 18:45:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="dp26y7sU";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="ffmxQaxg"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E05C320879
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:To:Subject:Message-ID:Date:From:
	In-Reply-To:References:MIME-Version:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=zzn+RgNMVJYphO7oMIfpY45P5KXoW2NNvE32P1wzen4=; b=dp26y7sUJIHMEh
	o016CVFqHdvXMGxALOvC+Rkt14Yz93XJdzScpM5GbupQoHvKN5PTuCF+iEDArO767VWfUdg4Eodlx
	0hPxiL1BL55mejSYqqE2SFsI8BExwBRVGtXk8rm5tzcXpy9adL6J9ChapaYAPOMo8KRBfD22KS5iE
	LhCLjlg4Um7+3hcyPCtynfqkClutDhX/6h8K4n7MsntDyhkGkZRkw7ZvwmQeTatkVw2GwdbwXTz2h
	scjqc9qbJjGc8lbPtTo01RsDOskA9qOwRM6rmHF42bJjmEN9iWnxXPfYzq93kZ16SxDYcS8l9GmcT
	H3zkF9/NfDdkgXFzIJaA==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gXVzY-0001Cw-Vc; Thu, 13 Dec 2018 18:45:48 +0000
Received: from mail-it1-x143.google.com ([2607:f8b0:4864:20::143])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gXVzW-0001CX-BH
 for linux-arm-kernel@lists.infradead.org; Thu, 13 Dec 2018 18:45:47 +0000
Received: by mail-it1-x143.google.com with SMTP id o19so5186852itg.5
 for <linux-arm-kernel@lists.infradead.org>;
 Thu, 13 Dec 2018 10:45:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=wEojp9pG2vP+AzPVWQ1D1d0nfcnh02AyVDBO0xJY+HA=;
 b=ffmxQaxgyogGAO7C/0Tn5QChPHg2VfsebeEv9g1lhTh5V6gj4sEb3WfeSgedxR1Owj
 bSZ2HakicCosIPI0NF86zq+zaNihGFPiPrqspix3q051OB9PlrL3QzVHSQfbzfyE0ETD
 J10YnkQB3mUjV0HgpyYs289dGHqAB+Pwdkxbg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=wEojp9pG2vP+AzPVWQ1D1d0nfcnh02AyVDBO0xJY+HA=;
 b=jVMJTCcoILL13IPbpsngQCwozYJzad5tSY33/UVILycYwUmDFn9B0p3nCnBpdJ0me6
 OLFq/Mvn+oU3W3nb9oKl4A1xhCWHCHIHqI2aKYbLQOs3waGgxqItD+8ne8df/a9P1kcE
 Ol8evEtesTw0zfPZeCD22w4FzJyg3KIRHH9rL0oS+XatNMZjusxUhahdV48oGpbRvcf6
 VRlZjtXp6xhi7EfJu38nBD3+MQP8Dn3DGxnUvXBz3DFFR/x8bKbebNAT+6dOBUBQ/hst
 G2jgDTOC/A2HPsDA9jTrLL+oVU9WcBkCR/fHHTxLoZBDBkOqF9Q1i2fj4mys6yDuBkVt
 V/Cw==
X-Gm-Message-State: AA+aEWYXCr6mePXhVbsmaJggWdVcLbu5uiZOTwv6LGT6jTNRAeVaK1Py
 nfwp/USyQXSZJZcG1lXzMWLyCZdrmlDChAt/Fe15F85Bt7w=
X-Google-Smtp-Source: AFSGD/XHixTFdRFRKbPzssQnY0vCdv26pmaLgqca/WvPgtyihJIUwtz4RuAh54w7Fz+IWPSjDGHH2bUNTkOLNZIozZ8=
X-Received: by 2002:a02:4c9:: with SMTP id 192mr23788156jab.2.1544726735085;
 Thu, 13 Dec 2018 10:45:35 -0800 (PST)
MIME-Version: 1.0
References: <20181213172036.14504-1-ard.biesheuvel@linaro.org>
 <20181213180530.GB18185@edgewater-inn.cambridge.arm.com>
In-Reply-To: <20181213180530.GB18185@edgewater-inn.cambridge.arm.com>
From: Ard Biesheuvel <ard.biesheuvel@linaro.org>
Date: Thu, 13 Dec 2018 19:45:23 +0100
Message-ID: <CAKv+Gu_WGrauh095zw1ApXawdAsE7ARVP6ycjV0qztNEFTncDQ@mail.gmail.com>
Subject: Re: [RFC PATCH 0/4] arm64: kpti: use nG mappings unless KPTI is force
 disabled
To: Will Deacon <will.deacon@arm.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20181213_104546_400470_722824F7 
X-CRM114-Status: GOOD (  27.59  )
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
Cc: John Garry <john.garry@huawei.com>, Robin Murphy <robin.murphy@arm.com>,
 linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
 "Suzuki K. Poulose" <suzuki.poulose@arm.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

On Thu, 13 Dec 2018 at 19:05, Will Deacon <will.deacon@arm.com> wrote:
>
> Hi Ard,
>
> On Thu, Dec 13, 2018 at 06:20:31PM +0100, Ard Biesheuvel wrote:
> > John reports [0] that recent changes to the way the linear region is mapped
> > is causing ~30 seconds stalls on boot, and this turns out to be due to the
> > way we remap the linear space with nG mappings when enabling KPTI, which
> > occurs with the MMU and caches off. Recent kernels map the linear region down
> > to pages by default, so that restricted permissions can be applied at page
> > granularity (so that module .text and .rodata are no longer writable via
> > the linear map), and so the number of page table entries that require
> > updating from G to nG is much higher, resulting in the observed delays.
> >
> > This series refactors the logic that tests whether KPTI should be enabled
> > so that the conditions that apply regardless of CPU identification are
> > evaluated early, allowing us to create the mappings of the kernel and
> > the linear region with nG attributes from the outset.
> >
> > Patches #1 to #3 implement this so that we only create these nG mappings
> > if KPTI is force enabled.
> >
> > As a followup, #4 may be applied, which inverts the logic so that nG mappings
> > are always created, unless KPTI is forced off. This allows us to get rid
> > of the slow and complex asm routines that make this change later on, which
> > is where the boot delays occur.
>
> I think I'd like to keep those for now, since it would be nice to use global
> mappings for the vast majority of CPUs that are not affected by kpti.
>
> I had a crack at the problem and ended up with a slightly simpler diff
> below.
>
> Will
>
> --->8
>
> diff --git a/arch/arm64/include/asm/mmu.h b/arch/arm64/include/asm/mmu.h
> index 7689c7aa1d77..feb05f7b46b1 100644
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
> @@ -44,6 +46,28 @@ static inline bool arm64_kernel_unmapped_at_el0(void)
>                cpus_have_const_cap(ARM64_UNMAP_KERNEL_AT_EL0);
>  }
>
> +static inline bool arm64_kernel_use_ng_mappings(void)
> +{
> +       bool tx1_bug = false;
> +
> +       if (!IS_ENABLED(CONFIG_UNMAP_KERNEL_AT_EL0))
> +               return false;
> +
> +       if (!IS_ENABLED(CONFIG_RANDOMIZE_BASE))
> +               return arm64_kernel_unmapped_at_el0();
> +

This is all pretty subtle, but it looks correct to me. We are relying on the

> +       if (IS_ENABLED(CONFIG_CAVIUM_ERRATUM_27456)) {
> +               extern const struct midr_range cavium_erratum_27456_cpus[];
> +
> +               tx1_bug = static_branch_likely(&arm64_const_caps_ready) ?
> +                         cpus_have_const_cap(ARM64_WORKAROUND_CAVIUM_27456) :
> +                         is_midr_in_range_list(read_cpuid_id(),
> +                                               cavium_erratum_27456_cpus);
> +       }
> +
> +       return !tx1_bug;

Should we make this !tx1_bug && kaslr_offset() > 0 ? That way, we take
'nokaslr' on the command line into account as well (see my patch #1)

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
> index ff2fda3a98e1..2c42f57cf529 100644
> --- a/arch/arm64/kernel/cpu_errata.c
> +++ b/arch/arm64/kernel/cpu_errata.c
> @@ -539,7 +539,7 @@ static const struct midr_range arm64_harden_el2_vectors[] = {
>  #endif
>
>  #ifdef CONFIG_CAVIUM_ERRATUM_27456
> -static const struct midr_range cavium_erratum_27456_cpus[] = {
> +const struct midr_range cavium_erratum_27456_cpus[] = {
>         /* Cavium ThunderX, T88 pass 1.x - 2.1 */
>         MIDR_RANGE(MIDR_THUNDERX, 0, 0, 1, 1),
>         /* Cavium ThunderX, T81 pass 1.0 */
> diff --git a/arch/arm64/kernel/cpufeature.c b/arch/arm64/kernel/cpufeature.c
> index 7ea0b2f20262..c68f6ad6722f 100644
> --- a/arch/arm64/kernel/cpufeature.c
> +++ b/arch/arm64/kernel/cpufeature.c
> @@ -1006,6 +1006,9 @@ kpti_install_ng_mappings(const struct arm64_cpu_capabilities *__unused)
>         if (kpti_applied)
>                 return;
>
> +       if (IS_ENABLED(CONFIG_RANDOMIZE_BASE) && __kpti_forced <= 0)
> +               return;
> +

This is only called if the capability is detected, right? So how could
__kpti_forced be negative in this case?

In any case, I don't think __kpti_forced is relevant here: if we enter
this function, we can exit early if arm64_kernel_use_ng_mappings() is
guaranteed never to have returned 'false' at any point, and since we
know we won't enter this function on TX1, testing for KASLR should be
sufficient (but please include kaslr_offset() > 0)


>         remap_fn = (void *)__pa_symbol(idmap_kpti_install_ng_mappings);
>
>         cpu_install_idmap();

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
