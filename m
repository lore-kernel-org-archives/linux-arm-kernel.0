Return-Path: <SRS0=niBm=QV=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_MUTT autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 677D7C43381
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Thu, 14 Feb 2019 16:13:37 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 27B94222A1
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Thu, 14 Feb 2019 16:13:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="DqIhXwm3";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="iFDCIgXA"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 27B94222A1
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:
	Message-ID:Subject:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=+UIw75ZjHxnDXYmjc7rPDyG84CjWTTCgDp/6WpKOlpA=; b=DqIhXwm3WFSNj3
	ezU170NJM+J8NmOOn2oxfBEBLkteWs75AnjHMD3KRwAork9rjNg3ZEVVVBSElzCA9VvQXUU+N9/BA
	WiD+xRg1U7A23T8tA3plvaX/Oggx1ylsDzJ5GTgP3Lu5Hb5sSerSr8upyDcAvnlcwa+Lv+L0wRbUZ
	bS+7RXuhyt6eycBZWU7OoGelAnpMupnWu8Go3No5n0zUqm/hNA+sfg1+77GMNHGZphFV3tsHyKuvd
	BbD16QGz4CRXzpejE5VPITooZ/Iqd81LVX+qJr4Qv5z7lXeBNUHT02BtpGVie6LUykqx9UJ/adX55
	KFKls5HOxkopph+n0WSg==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1guJdi-0001AA-A8; Thu, 14 Feb 2019 16:13:30 +0000
Received: from casper.infradead.org ([2001:8b0:10b:1236::1])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1guJdO-0000qM-PK
 for linux-arm-kernel@bombadil.infradead.org; Thu, 14 Feb 2019 16:13:10 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
 References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
 Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
 Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
 List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=rW614HOg3YSJL40UDQLMTq9BvSqAJti3VKoVRHcA2HI=; b=iFDCIgXACa3zz2mv2bohc03GD
 pflPzIPMWrDIFasHNAl0UbHJqhOZrZ57sox5roteh5q0obQmQ3tjPtAcGinNVOoSEr02n7wg+aTZ/
 xI+RVPrsXastIZ3UvEI6SMyyashGiq+02W98mNt3wHPMsw5LlA/eW9Zu3OorvGQiIe9U1d0oLCwBd
 foA/UF9jaqxLdOxLJhnbDP25PLrYt1Tu7SYjgiohfUhhoqW67HFUM0YStxXCarZTPaYKHk6U0CGfn
 0RyvCTvloP5+zeFbLXfGgjvuUSVa22PBO+a43D17T0Hf7FAjmqvKNS3gmnl3BwNfb/s8RnpzICCdP
 X3sdjZfIA==;
Received: from usa-sjc-mx-foss1.foss.arm.com ([217.140.101.70]
 helo=foss.arm.com)
 by casper.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
 id 1guJMx-0003C8-AW
 for linux-arm-kernel@lists.infradead.org; Thu, 14 Feb 2019 15:56:14 +0000
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 16378EBD;
 Thu, 14 Feb 2019 07:56:10 -0800 (PST)
Received: from lakrids.cambridge.arm.com (usa-sjc-imap-foss1.foss.arm.com
 [10.72.51.249])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id D6EFC3F575;
 Thu, 14 Feb 2019 07:56:08 -0800 (PST)
Date: Thu, 14 Feb 2019 15:56:06 +0000
From: Mark Rutland <mark.rutland@arm.com>
To: "Zhang, Lei" <zhang.lei@jp.fujitsu.com>
Subject: Re: [PATCH v4] arm64: Add workaround for Fujitsu A64FX erratum 010001
Message-ID: <20190214155605.GC27547@lakrids.cambridge.arm.com>
References: <8898674D84E3B24BA3A2D289B872026A6A311EAE@G01JPEXMBKW03>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <8898674D84E3B24BA3A2D289B872026A6A311EAE@G01JPEXMBKW03>
User-Agent: Mutt/1.11.1+11 (2f07cb52) (2018-12-01)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190214_155611_687304_A7246205 
X-CRM114-Status: GOOD (  46.62  )
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
Cc: 'Catalin Marinas' <catalin.marinas@arm.com>,
 'Will Deacon' <will.deacon@arm.com>, 'James Morse' <james.morse@arm.com>,
 "'linux-arm-kernel@lists.infradead.org'"
 <linux-arm-kernel@lists.infradead.org>,
 "'linux-kernel@vger.kernel.org'" <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

On Thu, Feb 14, 2019 at 07:26:24AM +0000, Zhang, Lei wrote:
> Hi guys,
> 
> Thanks for your comments.
> I am sending the revised patch, version 4, which includes a whole
> description of the patch.
> 
> This patch adds a workaround for Fujitsu A64FX erratum 010001
> 
> There are some discussions on former versions, as follows:
> 
> [PATCH] arm64 memory accesses may cause undefined fault on Fujitsu-A64FX
>   https://lkml.org/lkml/2019/1/18/403
>   
> [PATCH v2 0/1] arm64: Add workaround for Fujitsu A64FX erratum 010001
>   https://lkml.org/lkml/2019/1/22/137
>   
> [PATCH v2 1/1] arm64: Add workaround for Fujitsu A64FX erratum 010001
>   https://lkml.org/lkml/2019/1/22/138
>   
> [PATCH v3 0/1] arm64: Add workaround for Fujitsu A64FX erratum 010001
>   https://www.spinics.net/lists/arm-kernel/msg703111.html
>   
> [v3,1/1] Arm64: Add workaround for Fujitsu A64FX erratum 010001
>   https://patchwork.kernel.org/patch/10786139/
> 
> Please merge this patch.
> 
> Note that this patch is for the linux-5.0-rc2 which set TCR_ELx.NFD1 to '1'
> only once in the boot sequence and does not set TCR_ELx.NFD0.
> If the newer kernel handles TCR_ELx.{NFD0,NFD1} in different way,
> I will update the patch as soon as possible.
> 
> 
> Changes since [v3]
> 
>  * Add description of the patch.
>  * Add dependency to Kconfig.
>   - Set default value of FUJITSU_ERRATUM_010001 depends on RANDOMIZE_BASE.
> 
> Changes since [v2]
> 
>  * Change TCR_ELx.NFD1.
>   - Set TCR_ELx.NFD1 to 0 when entry kernel.
>   - Set TCR_ELx.NFD1 to 1 when exit kernel.
> 
> Changes since [v1]
> 
>  * Use the errata framework to work around for Fujitsu A64FX erratum 010001.
> 
> 
> 
> On the Fujitsu-A64FX cores ver(1.0, 1.1), memory access may
> cause an undefined fault (Data abort, DFSC=0b111111).
> This fault occurs under a specific hardware condition when a
> load/store instruction performs an address translation.
> Any load/store instruction, except non-fault access
> including Armv8 and SVE might cause this undefined fault.
> 
> Since this erratum occurs only when TCR_ELx.NFD1=1,
> I keep TCR_ELx.NFD1=0 during EL1/EL2.
> 
> By doing above, the erratum occurs only in EL0.
> I deal with this erratum in EL0 by a new fault handler
> which ignores this undefined fault.
> 
> Signed-off-by: Zhang Lei <zhang.lei@jp.fujitsu.com>
> ---
>  Documentation/arm64/silicon-errata.txt |  1 +
>  arch/arm64/Kconfig                     | 23 +++++++++++++++++++++++
>  arch/arm64/include/asm/cpucaps.h       |  3 ++-
>  arch/arm64/include/asm/cputype.h       |  4 ++++
>  arch/arm64/kernel/cpu_errata.c         |  8 ++++++++
>  arch/arm64/kernel/entry.S              | 16 ++++++++++++++++
>  arch/arm64/mm/fault.c                  | 16 +++++++++++++++-
>  arch/arm64/mm/proc.S                   | 20 ++++++++++++++++++++
>  8 files changed, 89 insertions(+), 2 deletions(-)
> 
> diff --git a/Documentation/arm64/silicon-errata.txt b/Documentation/arm64/silicon-errata.txt
> index 1f09d04..26d64e9 100644
> --- a/Documentation/arm64/silicon-errata.txt
> +++ b/Documentation/arm64/silicon-errata.txt
> @@ -80,3 +80,4 @@ stable kernels.
>  | Qualcomm Tech. | Falkor v1       | E1009           | QCOM_FALKOR_ERRATUM_1009    |
>  | Qualcomm Tech. | QDF2400 ITS     | E0065           | QCOM_QDF2400_ERRATUM_0065   |
>  | Qualcomm Tech. | Falkor v{1,2}   | E1041           | QCOM_FALKOR_ERRATUM_1041    |
> +| Fujitsu        | A64FX           | E#010001        | FUJITSU_ERRATUM_010001      |
> diff --git a/arch/arm64/Kconfig b/arch/arm64/Kconfig
> index a4168d3..7c76c66 100644
> --- a/arch/arm64/Kconfig
> +++ b/arch/arm64/Kconfig
> @@ -643,6 +643,29 @@ config QCOM_FALKOR_ERRATUM_E1041
>  
>  	  If unsure, say Y.
>  
> +config FUJITSU_ERRATUM_010001
> +	bool "Fujitsu-A64FX erratum E#010001: Undefined fault may occur wrongly"
> +        depends on RANDOMIZE_BASE
> +        default RANDOMIZE_BASE
> +	help
> +	  This option adds workaround for Fujitsu-A64FX erratum E#010001.
> +	  On some variants of the Fujitsu-A64FX cores ver(1.0, 1.1), memory accesses
> +	  may cause undefined fault (Data abort, DFSC=0b111111).
> +	  This fault occurs under a specific hardware condition when a load/store
> +          instruction performs an address translation using:
> +	  case-1  TTBR0_EL1 with TCR_EL1.NFD0 == 1.
> +	  case-2  TTBR0_EL2 with TCR_EL2.NFD0 == 1.
> +	  case-3  TTBR1_EL1 with TCR_EL1.NFD1 == 1.
> +	  case-4  TTBR1_EL2 with TCR_EL2.NFD1 == 1.
> +
> +	  The workaround is to set '0' to TCR_ELx.NFD1 at kernel-entry,
> +	  to set '1' at kernel-exit. And also replace the fault handler
> +	  for Data abort DFSC=0b111111 with a new fault handler to ignore this
> +	  undefined fault.
> +	  The workaround only affect the Fujitsu-A64FX.

I think that per Will's last comment, the expectation was that NFD1
would be configured once in C code, rather than in the entry assembly.

Your code seems to expect KPTI is enabled, and if that's the case, NFD1
doesn't provide much security benefit, and it would be vastly simpler to
set this in a cpufeature callback.

Does A64FX require KPTI?

> +
> +	  If unsure, say Y.
> +
>  endmenu
>  
>  
> diff --git a/arch/arm64/include/asm/cpucaps.h b/arch/arm64/include/asm/cpucaps.h
> index 82e9099..3a0b375 100644
> --- a/arch/arm64/include/asm/cpucaps.h
> +++ b/arch/arm64/include/asm/cpucaps.h
> @@ -60,7 +60,8 @@
>  #define ARM64_HAS_ADDRESS_AUTH_IMP_DEF		39
>  #define ARM64_HAS_GENERIC_AUTH_ARCH		40
>  #define ARM64_HAS_GENERIC_AUTH_IMP_DEF		41
> +#define ARM64_WORKAROUND_FUJITSU_A64FX_0100001 42
>  
> -#define ARM64_NCAPS				42
> +#define ARM64_NCAPS				43
>  
>  #endif /* __ASM_CPUCAPS_H */
> diff --git a/arch/arm64/include/asm/cputype.h b/arch/arm64/include/asm/cputype.h
> index 951ed1a..70203f9 100644
> --- a/arch/arm64/include/asm/cputype.h
> +++ b/arch/arm64/include/asm/cputype.h
> @@ -76,6 +76,7 @@
>  #define ARM_CPU_IMP_BRCM		0x42
>  #define ARM_CPU_IMP_QCOM		0x51
>  #define ARM_CPU_IMP_NVIDIA		0x4E
> +#define ARM_CPU_IMP_FUJITSU		0x46
>  
>  #define ARM_CPU_PART_AEM_V8		0xD0F
>  #define ARM_CPU_PART_FOUNDATION		0xD00
> @@ -104,6 +105,8 @@
>  #define NVIDIA_CPU_PART_DENVER		0x003
>  #define NVIDIA_CPU_PART_CARMEL		0x004
>  
> +#define FUJITSU_CPU_PART_A64FX		0x001
> +
>  #define MIDR_CORTEX_A53 MIDR_CPU_MODEL(ARM_CPU_IMP_ARM, ARM_CPU_PART_CORTEX_A53)
>  #define MIDR_CORTEX_A57 MIDR_CPU_MODEL(ARM_CPU_IMP_ARM, ARM_CPU_PART_CORTEX_A57)
>  #define MIDR_CORTEX_A72 MIDR_CPU_MODEL(ARM_CPU_IMP_ARM, ARM_CPU_PART_CORTEX_A72)
> @@ -122,6 +125,7 @@
>  #define MIDR_QCOM_KRYO MIDR_CPU_MODEL(ARM_CPU_IMP_QCOM, QCOM_CPU_PART_KRYO)
>  #define MIDR_NVIDIA_DENVER MIDR_CPU_MODEL(ARM_CPU_IMP_NVIDIA, NVIDIA_CPU_PART_DENVER)
>  #define MIDR_NVIDIA_CARMEL MIDR_CPU_MODEL(ARM_CPU_IMP_NVIDIA, NVIDIA_CPU_PART_CARMEL)
> +#define MIDR_FUJITSU_A64FX MIDR_CPU_MODEL(ARM_CPU_IMP_FUJITSU, FUJITSU_CPU_PART_A64FX)
>  
>  #ifndef __ASSEMBLY__
>  
> diff --git a/arch/arm64/kernel/cpu_errata.c b/arch/arm64/kernel/cpu_errata.c
> index 9950bb0..fc0737f 100644
> --- a/arch/arm64/kernel/cpu_errata.c
> +++ b/arch/arm64/kernel/cpu_errata.c
> @@ -739,6 +739,14 @@ static bool has_ssbd_mitigation(const struct arm64_cpu_capabilities *entry,
>  		ERRATA_MIDR_RANGE(MIDR_CORTEX_A76, 0, 0, 2, 0),
>  	},
>  #endif
> +#ifdef CONFIG_FUJITSU_ERRATUM_010001
> +	{
> +		.desc = "Fujitsu erratum 010001",
> +		.capability = ARM64_WORKAROUND_FUJITSU_A64FX_0100001,
> +		ERRATA_MIDR_RANGE(MIDR_FUJITSU_A64FX, 0, 0, 1, 0),
> +	},
> +#endif
> +
>  	{
>  	}
>  };
> diff --git a/arch/arm64/kernel/entry.S b/arch/arm64/kernel/entry.S
> index 0ec0c46..34a4f44 100644
> --- a/arch/arm64/kernel/entry.S
> +++ b/arch/arm64/kernel/entry.S
> @@ -940,6 +940,14 @@ alternative_if ARM64_WORKAROUND_QCOM_FALKOR_E1003
>  	dsb	nsh
>  alternative_else_nop_endif
>  #endif /* CONFIG_QCOM_FALKOR_ERRATUM_1003 */
> +#ifdef CONFIG_FUJITSU_CPU_PART_A64FX
> +alternative_if ARM64_WORKAROUND_FUJITSU_A64FX_0100001
> +	mrs	\tmp, tcr_el1
> +	and	\tmp, \tmp, #0xffbfffffffffffff

If this has to be written in assembly, it would be better as:

	bic	\tmp, \tmp, #TCR_NFD1
	
> +	msr	tcr_el1,\tmp
> +	isb
> +alternative_else_nop_endif
> +#endif /* CONFIG_FUJITSU_CPU_PART_A64FX */
>  	.endm
>  
>  	.macro tramp_unmap_kernel, tmp
> @@ -952,6 +960,14 @@ alternative_else_nop_endif
>  	 * it's only needed by Cavium ThunderX, which requires KPTI to be
>  	 * disabled.
>  	 */
> +#ifdef CONFIG_FUJITSU_CPU_PART_A64FX
> +alternative_if ARM64_WORKAROUND_FUJITSU_A64FX_0100001
> +	mrs	\tmp, tcr_el1
> +	orr	\tmp, \tmp, #0x40000000000000

Likewise:
	
	orr	\tmp, \tmp, #TCR_NFD1

> +	msr	tcr_el1,\tmp
> +	isb
> +alternative_else_nop_endif
> +#endif /* CONFIG_FUJITSU_CPU_PART_A64FX */
>  	.endm
>  
>  	.macro tramp_ventry, regsize = 64
> diff --git a/arch/arm64/mm/fault.c b/arch/arm64/mm/fault.c
> index efb7b2c..1bf0377 100644
> --- a/arch/arm64/mm/fault.c
> +++ b/arch/arm64/mm/fault.c
> @@ -666,6 +666,20 @@ static int do_sea(unsigned long addr, unsigned int esr, struct pt_regs *regs)
>  	return 0;
>  }
>  
> +static int do_bad_unknown_63(unsigned long addr, unsigned int esr, struct pt_regs *regs)
> +{
> +	/*
> +	 * On some variants of the Fujitsu-A64FX cores ver(1.0, 1.1),
> +	 * memory accesses may spuriously trigger data aborts with
> +	 * DFSC=0b111111.
> +	 */
> +	if (IS_ENABLED(CONFIG_FUJITSU_ERRATUM_010001) &&
> +		cpus_have_cap(ARM64_WORKAROUND_FUJITSU_A64FX_0100001))
> +			return 0;
> +	return do_bad(addr, esr, regs);
> +}

If we always left NFD1 clear on A64FX, we would not need this exception
handler, as this should never occur.

> +
> +
>  static const struct fault_info fault_info[] = {
>  	{ do_bad,		SIGKILL, SI_KERNEL,	"ttbr address size fault"	},
>  	{ do_bad,		SIGKILL, SI_KERNEL,	"level 1 address size fault"	},
> @@ -730,7 +744,7 @@ static int do_sea(unsigned long addr, unsigned int esr, struct pt_regs *regs)
>  	{ do_bad,		SIGKILL, SI_KERNEL,	"unknown 60"			},
>  	{ do_bad,		SIGKILL, SI_KERNEL,	"section domain fault"		},
>  	{ do_bad,		SIGKILL, SI_KERNEL,	"page domain fault"		},
> -	{ do_bad,		SIGKILL, SI_KERNEL,	"unknown 63"			},
> +	{ do_bad_unknown_63,	SIGKILL, SI_KERNEL,	"unknown 63"			},
>  };
>  
>  int handle_guest_sea(phys_addr_t addr, unsigned int esr)
> diff --git a/arch/arm64/mm/proc.S b/arch/arm64/mm/proc.S
> index 73886a5..75f7d99 100644
> --- a/arch/arm64/mm/proc.S
> +++ b/arch/arm64/mm/proc.S
> @@ -453,9 +453,29 @@ ENTRY(__cpu_setup)
>  	 * Set/prepare TCR and TTBR. We use 512GB (39-bit) address range for
>  	 * both user and kernel.
>  	 */
> +#ifdef CONFIG_FUJITSU_ERRATUM_010001
>  	ldr	x10, =TCR_TxSZ(VA_BITS) | TCR_CACHE_FLAGS | TCR_SMP_FLAGS | \
>  			TCR_TG_FLAGS | TCR_KASLR_FLAGS | TCR_ASID16 | \
>  			TCR_TBI0 | TCR_A1 | TCR_KASAN_FLAGS
> +	/* Can use x19/x20/x5 */
> +	mrs     x19, midr_el1
> +	/* ERRATA_MIDR_RANGE(MIDR_FUJITSU_A64FX, 0, 0, 1, 0) */
> +	mov	w20, #0x10	//#16
> +	movk	w20, #0x460f, lsl #16
> +	mov	w5, #0xffefffff
> +	and	w19, w5, w19
> +	/* cmp midr_el1 with ERRATA_MIDR_RANGE(MIDR_FUJITSU_A64FX, 0, 0, 1, 0) */
> +	cmp     w19, w20
> +	b.ne	2f
> +	ldr	x10, =TCR_TxSZ(VA_BITS) | TCR_CACHE_FLAGS | TCR_SMP_FLAGS | \
> +			TCR_TG_FLAGS | TCR_ASID16 | \
> +			TCR_TBI0 | TCR_A1 | TCR_KASAN_FLAGS
> +2:	nop
> +#else
> +	ldr	x10, =TCR_TxSZ(VA_BITS) | TCR_CACHE_FLAGS | TCR_SMP_FLAGS | \
> +			TCR_TG_FLAGS | TCR_KASLR_FLAGS | TCR_ASID16 | \
> +			TCR_TBI0 | TCR_A1 | TCR_KASAN_FLAGS
> +#endif

Please do this detection and reconfiguration of TCR in C code, rather
than in the __cpu_setup code.

In proc.S you can have:

#if defined(CONFIG_RANDOMIZE_BASE) && !defined(CONFIG_FUJITSU_ERRATUM_010001)
#define KASLR_FLAGS	TCR_NFD1
#else
#define KASLR_FLAGS	0
#endif

... and in cpu_errata.c you can enable NFD1 on any CPU which is not
A64FX.

Thanks,
Mark.

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
