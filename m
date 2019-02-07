Return-Path: <SRS0=LcWp=QO=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 23937C282C2
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Thu,  7 Feb 2019 11:31:38 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E510221904
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Thu,  7 Feb 2019 11:31:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="N2mwqxze"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E510221904
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:
	Message-ID:Subject:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=0JmxbB4S8OUCAzbbcsJKWbZCcuH69WJ7gjdQF4NmqhA=; b=N2mwqxzePk4kl1
	I3LLD/6pztqD/6puekf9RjSnjl3xSPdCxNb3yRVI+0KB17Bs+PrwAC1nd22p+yARhd8CVEH+WdVrL
	K4cq76j9fb8O2hAEEb0aCXhrj0A/LJ001yF6KSdgabUpnR2J9U8rtSuM6Cha9adiMUrJ0R525EzxV
	EjngnDw7mYOWinEs+tqxaiTc2YAnKbPTWuAgDUinHGVCFMLtA6engmMwnsQAiIdyzY+zAUTMwClDY
	A7rdyjCYbFSh95hMks39DJVwZw6nwkVlx+GSlS9L7goqSWOAbhP0zsN/eiBMMlQCR43BtY4fz2E2T
	DmMSPw9oR8bihqt5/l6g==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1grhu2-0007N9-IF; Thu, 07 Feb 2019 11:31:34 +0000
Received: from foss.arm.com ([217.140.101.70])
 by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
 id 1grhtz-0007Mf-0s
 for linux-arm-kernel@lists.infradead.org; Thu, 07 Feb 2019 11:31:32 +0000
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 8BBA5A78;
 Thu,  7 Feb 2019 03:31:27 -0800 (PST)
Received: from e103592.cambridge.arm.com (usa-sjc-imap-foss1.foss.arm.com
 [10.72.51.249])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 7B2D83F675;
 Thu,  7 Feb 2019 03:31:26 -0800 (PST)
Date: Thu, 7 Feb 2019 11:31:24 +0000
From: Dave Martin <Dave.Martin@arm.com>
To: Andrew Murray <andrew.murray@arm.com>
Subject: Re: [PATCH 2/6] arm64: HWCAP: add support for ELF_HWCAP2
Message-ID: <20190207113121.GF3567@e103592.cambridge.arm.com>
References: <1549459868-45992-1-git-send-email-andrew.murray@arm.com>
 <1549459868-45992-3-git-send-email-andrew.murray@arm.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <1549459868-45992-3-git-send-email-andrew.murray@arm.com>
User-Agent: Mutt/1.5.23 (2014-03-12)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190207_033131_079216_BB0433AA 
X-CRM114-Status: GOOD (  25.28  )
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
Cc: Szabolcs Nagy <Szabolcs.Nagy@arm.com>,
 Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will.deacon@arm.com>,
 linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

On Wed, Feb 06, 2019 at 01:31:04PM +0000, Andrew Murray wrote:
> As we will exhaust the first 32 bits of ELF_HWCAP let's start
> exposing ELF_HWCAP2 to userspace.
> 
> Whilst it's possible to use the remaining 32 bits of ELF_HWCAP, we
> prefer to expand into ELF_HWCAP2 in order to provide a consistent
> view to userspace between ILP32 and LP64.
> 
> To reduce complexity and allow for future expansion, we now
> represent hwcaps in the kernel as ordinals and use a
> KERNEL_HWCAP_ prefix. This allows us to support automatic feature
> based module loading for all our hwcaps.
> 
> We introduce cpu_set_feature to set hwcaps in the relevant
> elf_hwcapX variable which compliments the existing cpu_have_feature
> helper. These helpers allow us to clean up existing direct uses of
> elf_hwcap.
> 
> Signed-off-by: Andrew Murray <andrew.murray@arm.com>
> ---

[...]

> diff --git a/arch/arm64/include/asm/cpufeature.h b/arch/arm64/include/asm/cpufeature.h
> index dfcfba7..15d939e 100644
> --- a/arch/arm64/include/asm/cpufeature.h
> +++ b/arch/arm64/include/asm/cpufeature.h
> @@ -18,11 +18,10 @@
>   * In the arm64 world (as in the ARM world), elf_hwcap is used both internally
>   * in the kernel and for user space to keep track of which optional features
>   * are supported by the current system. So let's map feature 'x' to HWCAP_x.
> - * Note that HWCAP_x constants are bit fields so we need to take the log.
>   */
>  
> -#define MAX_CPU_FEATURES	(8 * sizeof(elf_hwcap))
> -#define cpu_feature(x)		ilog2(HWCAP_ ## x)
> +#define MAX_CPU_FEATURES	(2 * 8 * sizeof(unsigned long))

Doesn't this make 2 * 8 * 8 == 128?

Maybe just say "64".  We open-code 32 later anyway.

> +#define cpu_feature(x)		(KERNEL_HWCAP_ ## x)
>  
>  #ifndef __ASSEMBLY__
>  
> @@ -396,9 +395,20 @@ extern struct static_key_false arm64_const_caps_ready;
>  
>  bool this_cpu_has_cap(unsigned int cap);
>  
> +static inline void cpu_set_feature(unsigned int num)
> +{
> +	if (num < 32)
> +		elf_hwcap |= BIT(num);
> +	else
> +		elf_hwcap2 |= BIT(num - 32);
> +}
> +
>  static inline bool cpu_have_feature(unsigned int num)
>  {
> -	return elf_hwcap & (1UL << num);
> +	if (num < 32)
> +		return elf_hwcap & BIT(num);
> +	else
> +		return elf_hwcap2 & BIT(num - 32);
>  }

Nit: I worry a bit that people will blithely pass HWCAP_foo to these,
not realising that the interface has changed.

Can we do something like the following:

static inline bool __cpu_have_feature(unsigned int num)
{
	if (WARN_ON(num >= 64))
		return false;

	if (num < 32)
		return elf_hwcap & BIT(num);
	else
		return elf_hwcap2 & BIT(num);
}

#define cpu_have_feature(name) __cpu_have_feature(cpu_feature(name))


In compiletime-constant cases, the compiler should simply delete the
WARN.  A couple of cases in the cpufeatures and /proc/cpuinfo code would
need to use __cpu_have_feature directly and would retain the WARN, but
that's not fastpath and probably not the end of the world, plus we
get an additional debugging aid if that code goes wrong.

Alternatively, we could bake cpu_feature() into HWCAP_CAP(), making
it impossible to specify invalid or user-encoded hwcaps there either.
Then we might justifiably omit the policing in __cpu_have_feature()
altogether.

>  
>  /* System capability check for constant caps */
> diff --git a/arch/arm64/include/asm/hwcap.h b/arch/arm64/include/asm/hwcap.h
> index 400b80b..05ee9b9 100644
> --- a/arch/arm64/include/asm/hwcap.h
> +++ b/arch/arm64/include/asm/hwcap.h
> @@ -39,12 +39,49 @@
>  #define COMPAT_HWCAP2_SHA2	(1 << 3)
>  #define COMPAT_HWCAP2_CRC32	(1 << 4)
>  
> +/*
> + * KERNEL_HWCAP flags - for elf_hwcap (in kernel)
> + */
> +#define KERNEL_HWCAP_FP                ilog2(HWCAP_FP)
> +#define KERNEL_HWCAP_ASIMD             ilog2(HWCAP_ASIMD)
> +#define KERNEL_HWCAP_EVTSTRM           ilog2(HWCAP_EVTSTRM)
> +#define KERNEL_HWCAP_AES               ilog2(HWCAP_AES)
> +#define KERNEL_HWCAP_PMULL             ilog2(HWCAP_PMULL)
> +#define KERNEL_HWCAP_SHA1              ilog2(HWCAP_SHA1)
> +#define KERNEL_HWCAP_SHA2              ilog2(HWCAP_SHA2)
> +#define KERNEL_HWCAP_CRC32             ilog2(HWCAP_CRC32)
> +#define KERNEL_HWCAP_ATOMICS           ilog2(HWCAP_ATOMICS)
> +#define KERNEL_HWCAP_FPHP              ilog2(HWCAP_FPHP)
> +#define KERNEL_HWCAP_ASIMDHP           ilog2(HWCAP_ASIMDHP)
> +#define KERNEL_HWCAP_CPUID             ilog2(HWCAP_CPUID)
> +#define KERNEL_HWCAP_ASIMDRDM          ilog2(HWCAP_ASIMDRDM)
> +#define KERNEL_HWCAP_JSCVT             ilog2(HWCAP_JSCVT)
> +#define KERNEL_HWCAP_FCMA              ilog2(HWCAP_FCMA)
> +#define KERNEL_HWCAP_LRCPC             ilog2(HWCAP_LRCPC)
> +#define KERNEL_HWCAP_DCPOP             ilog2(HWCAP_DCPOP)
> +#define KERNEL_HWCAP_SHA3              ilog2(HWCAP_SHA3)
> +#define KERNEL_HWCAP_SM3               ilog2(HWCAP_SM3)
> +#define KERNEL_HWCAP_SM4               ilog2(HWCAP_SM4)
> +#define KERNEL_HWCAP_ASIMDDP           ilog2(HWCAP_ASIMDDP)
> +#define KERNEL_HWCAP_SHA512            ilog2(HWCAP_SHA512)
> +#define KERNEL_HWCAP_SVE               ilog2(HWCAP_SVE)
> +#define KERNEL_HWCAP_ASIMDFHM          ilog2(HWCAP_ASIMDFHM)
> +#define KERNEL_HWCAP_DIT               ilog2(HWCAP_DIT)
> +#define KERNEL_HWCAP_USCAT             ilog2(HWCAP_USCAT)
> +#define KERNEL_HWCAP_ILRCPC            ilog2(HWCAP_ILRCPC)
> +#define KERNEL_HWCAP_FLAGM             ilog2(HWCAP_FLAGM)
> +#define KERNEL_HWCAP_SSBS              ilog2(HWCAP_SSBS)
> +#define KERNEL_HWCAP_SB                ilog2(HWCAP_SB)
> +#define KERNEL_HWCAP_PACA              ilog2(HWCAP_PACA)
> +#define KERNEL_HWCAP_PACG              ilog2(HWCAP_PACG)

Nit: Odd spacing?  Personally I wouldn't indent with spaces just so that
(ilog2() + 32) lines up nicely, but that's just my opinion and not a
huge deal.

(The spacing can make subsequent diffs look jagged by default, which
can be a distraction for reviewers.)

> +
>  #ifndef __ASSEMBLY__
>  /*
>   * This yields a mask that user programs can use to figure out what
>   * instruction set this cpu supports.
>   */
> -#define ELF_HWCAP		(elf_hwcap)
> +#define ELF_HWCAP		elf_hwcap
> +#define ELF_HWCAP2		elf_hwcap2

Do we need elf_hwcap2 at all?

We could just have these macros fish the bits out of a single variable,
or wherever.

However, it may be better to keep things this way if we want to maintain
the elf_hwcap in the kernel/module ABI.  See note on EXPORT_SYMBOL_GPL()
removal for elf_hwcap in the subsequent patch.

>  
>  #ifdef CONFIG_COMPAT
>  #define COMPAT_ELF_HWCAP	(compat_elf_hwcap)
> @@ -60,6 +97,6 @@ enum {
>  #endif
>  };
>  
> -extern unsigned long elf_hwcap;
> +extern unsigned long elf_hwcap, elf_hwcap2;
>  #endif
>  #endif
> diff --git a/arch/arm64/include/uapi/asm/hwcap.h b/arch/arm64/include/uapi/asm/hwcap.h
> index 5f0750c..453b45a 100644
> --- a/arch/arm64/include/uapi/asm/hwcap.h
> +++ b/arch/arm64/include/uapi/asm/hwcap.h
> @@ -18,7 +18,7 @@
>  #define _UAPI__ASM_HWCAP_H
>  
>  /*
> - * HWCAP flags - for elf_hwcap (in kernel) and AT_HWCAP
> + * HWCAP flags - for AT_HWCAP
>   */
>  #define HWCAP_FP		(1 << 0)
>  #define HWCAP_ASIMD		(1 << 1)
> diff --git a/arch/arm64/kernel/cpufeature.c b/arch/arm64/kernel/cpufeature.c
> index f6d84e2..d10a455 100644
> --- a/arch/arm64/kernel/cpufeature.c
> +++ b/arch/arm64/kernel/cpufeature.c
> @@ -38,6 +38,9 @@
>  unsigned long elf_hwcap __read_mostly;
>  EXPORT_SYMBOL_GPL(elf_hwcap);
>  
> +unsigned long elf_hwcap2 __read_mostly;
> +EXPORT_SYMBOL_GPL(elf_hwcap2);
> +

Historically nobody used this because it didn't exist, and we don't want
anybody to use it (since cpu_have_feature() etc. is the preferred
interface).

So lose EXPORT_SYMBOL_GPL() here.  (You remove it in any case in a
subsequent patch, but having it even transiently sends mixed messages
about the intent.)

[...]

Otherwise looks reasonable.

Cheers
---Dave

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
