Return-Path: <SRS0=tBLO=PQ=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 40CFAC43387
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Tue,  8 Jan 2019 17:27:42 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0E63C217D9
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Tue,  8 Jan 2019 17:27:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="Z5NwYaV6";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="OpfAB3SN"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0E63C217D9
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:To:Subject:Message-ID:Date:From:
	In-Reply-To:References:MIME-Version:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=Fe1TldnABG0NELMD0KYbeIWE091Q2hvubkf8bF0hNWs=; b=Z5NwYaV6PkMs8Y
	V459LDIG0zZ8GZRQpqk5AqVKp99G/RpFHuiGrHm1RUE7FRRBx8da5/r3GY080Z7wPZegsdMXuVHDf
	4vNcrk4coHltUpzjX19zXixpVYinjSq5Dq7p1FyBC7RtuoF05uvhbOCw+3uTajAX4TPiliphF+obZ
	j2d9J9LPpdpaKpWUXL9jy1VPHeeQ7r0MnMSdv0DNhKIxz2mUvIpHC+Hkw+oui/c4LXvdssV/9NYL4
	k1J78Jr9abAzxEWroaYtE+oWxLUt7yYF1bey7ZLWGg4tuvgecK2wMOhndxC7j0ECqb3w4EbFTurXz
	mdex7ZZi1Xxo7cb88LFg==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1ggvAD-0002Ba-Az; Tue, 08 Jan 2019 17:27:41 +0000
Received: from mail-io1-xd42.google.com ([2607:f8b0:4864:20::d42])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1ggvAA-0002Ax-5c
 for linux-arm-kernel@lists.infradead.org; Tue, 08 Jan 2019 17:27:39 +0000
Received: by mail-io1-xd42.google.com with SMTP id x6so3752763ioa.9
 for <linux-arm-kernel@lists.infradead.org>;
 Tue, 08 Jan 2019 09:27:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=3n5au1EbShUHH+oZBPJutxmLbrzTs1NDIopWiuHtu/E=;
 b=OpfAB3SN5odwNhc6l7c1tr7nd4reg2cZT+pQuGAUi9fZYeaDI9wxlk8KLLMp19p8dG
 vCmAjX6Eq0gbuj7n9zdUQv9131O3MIjG+mIOHaryrEsOP2jz0hVzam7cf3wESlCSV+9M
 Bp4Dqv5oL+1VE17QiduxKdEgOMGAnuA3yqT74=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=3n5au1EbShUHH+oZBPJutxmLbrzTs1NDIopWiuHtu/E=;
 b=FljCyWk2j+UEFHVR7/rw43/aTC2zyGJ8FUF8mdA/v+OjtGOytg2/FObxubxtKUdTTP
 pMSe71VG8BtemOwutnhg9MWnDOgy2HHEClL+Mry9WAqRE+ShLI0r06Sh2ttJFojjaRMl
 BUstOuqk+B1SvTI67flA35Xu3u3d4TFB515NRaPn1gnWA4YoxEoqb+DC1aQA/6A40Pnb
 lhioEHPTiM9OfcPx6B4PBP1GGz6/iVD+NZSCA6fGfC8t2tXiszyCnJ95PcY6txpwCvVo
 Co7sXz8xhcEFxy5cvhUM/kB38VcwG0BLIO9hMRtJ7/Dn6ITgUv1z53SjsC/msCcTb60D
 h9+Q==
X-Gm-Message-State: AJcUukemOku1QN2ENX5+ro42vpwASJfKhUutBR/FlwykJsOMUc1WsrgQ
 Gvx7VCMwl960BIDiUEVw/nd+ChNJ0jamNNnomvMqDw==
X-Google-Smtp-Source: ALg8bN7OoUiCcVvEvUcn3PXU6SOGmxblIAK9eMZdi8pnsMNYCYS3HET8kcaOVyl15750mT+KwcwJXTYHBKBWmEMPLwI=
X-Received: by 2002:a5d:8410:: with SMTP id i16mr1657966ion.173.1546968456941; 
 Tue, 08 Jan 2019 09:27:36 -0800 (PST)
MIME-Version: 1.0
References: <20190108163753.32418-1-will.deacon@arm.com>
In-Reply-To: <20190108163753.32418-1-will.deacon@arm.com>
From: Ard Biesheuvel <ard.biesheuvel@linaro.org>
Date: Tue, 8 Jan 2019 18:27:25 +0100
Message-ID: <CAKv+Gu_d8FGCRwcYAVmRZupWv-b9uOxHzAbfSGsTFDfMYq_zNQ@mail.gmail.com>
Subject: Re: [PATCH] arm64: kpti: Avoid rewriting early page tables when KASLR
 is enabled
To: Will Deacon <will.deacon@arm.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190108_092738_212563_25D85748 
X-CRM114-Status: GOOD (  25.34  )
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

On Tue, 8 Jan 2019 at 17:38, Will Deacon <will.deacon@arm.com> wrote:
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
> ---
>  arch/arm64/include/asm/mmu.h          | 37 +++++++++++++++++++++++++++++++++++
>  arch/arm64/include/asm/pgtable-prot.h |  4 ++--
>  arch/arm64/kernel/cpu_errata.c        |  2 +-
>  arch/arm64/kernel/cpufeature.c        |  7 ++++++-
>  4 files changed, 46 insertions(+), 4 deletions(-)
>
> diff --git a/arch/arm64/include/asm/mmu.h b/arch/arm64/include/asm/mmu.h
> index 43596b1a5897..06a0c84718d6 100644
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
> @@ -44,6 +46,41 @@ static inline bool arm64_kernel_unmapped_at_el0(void)
>                cpus_have_const_cap(ARM64_UNMAP_KERNEL_AT_EL0);
>  }
>
> +static inline bool arm64_kernel_use_ng_mappings(void)
> +{
> +       bool tx1_bug = false;
> +
> +       /* What's a kpti? Use global mappings if we don't know. */
> +       if (!IS_ENABLED(CONFIG_UNMAP_KERNEL_AT_EL0))
> +               return false;
> +
> +       /*
> +        * Note: this function is called before the CPU capabilities have
> +        * been configured, so our early mappings will be global. If we
> +        * later determine that kpti is required, then the page tables
> +        * will be rewritten by kpti_install_ng_mappings().
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
> +       if (IS_ENABLED(CONFIG_CAVIUM_ERRATUM_27456)) {
> +               extern const struct midr_range cavium_erratum_27456_cpus[];
> +
> +               tx1_bug = static_branch_likely(&arm64_const_caps_ready) ?
> +                         cpus_have_const_cap(ARM64_WORKAROUND_CAVIUM_27456) :
> +                         is_midr_in_range_list(read_cpuid_id(),
> +                                               cavium_erratum_27456_cpus);

This breaks modules due to cavium_erratum_27456_cpus not being exported.


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
> index 4f272399de89..2cac775cd069 100644
> --- a/arch/arm64/kernel/cpufeature.c
> +++ b/arch/arm64/kernel/cpufeature.c
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
> --
> 2.11.0
>

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
