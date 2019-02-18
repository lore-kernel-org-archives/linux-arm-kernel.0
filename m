Return-Path: <SRS0=ULCN=QZ=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4A53BC43381
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Mon, 18 Feb 2019 15:32:35 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id F3E60217D7
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Mon, 18 Feb 2019 15:32:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="EsPscCR+"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org F3E60217D7
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:
	Message-ID:Subject:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=YRtylLDoT7xfiVLGVyOaX8qHpH10L8uSOWfIjEdHWp4=; b=EsPscCR+9vods2
	/tvMr0q6AMf37oOwMd62y51NHKq7tV8Il8uvi49aovsabr77H2A52fOgCqfYq3ZGdLf6kUqlOhIjw
	xquPOqM5yP1RDl73d3s+x50GCh7mqC9mFHWVBHTmsDr/18VAS3zAQUIVTOgClu1qwvVFkHro239FX
	GfVo+5V5tSlZgYQq4Bwj+Zk5Iu17QkF6d8H6AdFUWbOwQsqHickFg5XTVUru2GgIcjyOfjlN6XEDb
	UyT6MYeDUOk7o5gCSkm/NZjGfA/vhmM+DXLRBvMgYAFVF6iRlvrvXr3vgcGCr1hf3YE3bkXzh1lm7
	OUBKfNWMOacDTYAxdqVw==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gvkuC-0000B9-NA; Mon, 18 Feb 2019 15:32:28 +0000
Received: from foss.arm.com ([217.140.101.70])
 by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gvku1-0000A0-Ce
 for linux-arm-kernel@lists.infradead.org; Mon, 18 Feb 2019 15:32:26 +0000
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 183A815AB;
 Mon, 18 Feb 2019 07:32:16 -0800 (PST)
Received: from localhost (unknown [10.37.6.16])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 1E5E53F675;
 Mon, 18 Feb 2019 07:32:07 -0800 (PST)
Date: Mon, 18 Feb 2019 15:32:06 +0000
From: Andrew Murray <andrew.murray@arm.com>
To: Dave Martin <Dave.Martin@arm.com>
Subject: Re: [PATCH 2/6] arm64: HWCAP: add support for ELF_HWCAP2
Message-ID: <20190218153205.GA35031@e119886-lin.cambridge.arm.com>
References: <1549459868-45992-1-git-send-email-andrew.murray@arm.com>
 <1549459868-45992-3-git-send-email-andrew.murray@arm.com>
 <20190207113121.GF3567@e103592.cambridge.arm.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20190207113121.GF3567@e103592.cambridge.arm.com>
User-Agent: Mutt/1.10.1+81 (426a6c1) (2018-08-26)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190218_073220_383532_5E85AFA1 
X-CRM114-Status: GOOD (  33.19  )
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

On Thu, Feb 07, 2019 at 11:31:24AM +0000, Dave Martin wrote:
> On Wed, Feb 06, 2019 at 01:31:04PM +0000, Andrew Murray wrote:
> > As we will exhaust the first 32 bits of ELF_HWCAP let's start
> > exposing ELF_HWCAP2 to userspace.
> > 
> > Whilst it's possible to use the remaining 32 bits of ELF_HWCAP, we
> > prefer to expand into ELF_HWCAP2 in order to provide a consistent
> > view to userspace between ILP32 and LP64.
> > 
> > To reduce complexity and allow for future expansion, we now
> > represent hwcaps in the kernel as ordinals and use a
> > KERNEL_HWCAP_ prefix. This allows us to support automatic feature
> > based module loading for all our hwcaps.
> > 
> > We introduce cpu_set_feature to set hwcaps in the relevant
> > elf_hwcapX variable which compliments the existing cpu_have_feature
> > helper. These helpers allow us to clean up existing direct uses of
> > elf_hwcap.
> > 
> > Signed-off-by: Andrew Murray <andrew.murray@arm.com>
> > ---
> 
> [...]
> 
> > diff --git a/arch/arm64/include/asm/cpufeature.h b/arch/arm64/include/asm/cpufeature.h
> > index dfcfba7..15d939e 100644
> > --- a/arch/arm64/include/asm/cpufeature.h
> > +++ b/arch/arm64/include/asm/cpufeature.h
> > @@ -18,11 +18,10 @@
> >   * In the arm64 world (as in the ARM world), elf_hwcap is used both internally
> >   * in the kernel and for user space to keep track of which optional features
> >   * are supported by the current system. So let's map feature 'x' to HWCAP_x.
> > - * Note that HWCAP_x constants are bit fields so we need to take the log.
> >   */
> >  
> > -#define MAX_CPU_FEATURES	(8 * sizeof(elf_hwcap))
> > -#define cpu_feature(x)		ilog2(HWCAP_ ## x)
> > +#define MAX_CPU_FEATURES	(2 * 8 * sizeof(unsigned long))
> 
> Doesn't this make 2 * 8 * 8 == 128?
> 
> Maybe just say "64".  We open-code 32 later anyway.

I guess 128 would have been correct if we use all the bits of
each ELF_HWCAP{,2} - but we chose to limit each ELF_HWCAP to be
32 bits.

I'll set this to 64 as you suggest.

> 
> > +#define cpu_feature(x)		(KERNEL_HWCAP_ ## x)
> >  
> >  #ifndef __ASSEMBLY__
> >  
> > @@ -396,9 +395,20 @@ extern struct static_key_false arm64_const_caps_ready;
> >  
> >  bool this_cpu_has_cap(unsigned int cap);
> >  
> > +static inline void cpu_set_feature(unsigned int num)
> > +{
> > +	if (num < 32)
> > +		elf_hwcap |= BIT(num);
> > +	else
> > +		elf_hwcap2 |= BIT(num - 32);
> > +}
> > +
> >  static inline bool cpu_have_feature(unsigned int num)
> >  {
> > -	return elf_hwcap & (1UL << num);
> > +	if (num < 32)
> > +		return elf_hwcap & BIT(num);
> > +	else
> > +		return elf_hwcap2 & BIT(num - 32);
> >  }
> 
> Nit: I worry a bit that people will blithely pass HWCAP_foo to these,
> not realising that the interface has changed.

Yeah this would be an easy mistake to make.

> 
> Can we do something like the following:
> 
> static inline bool __cpu_have_feature(unsigned int num)
> {
> 	if (WARN_ON(num >= 64))
> 		return false;
> 
> 	if (num < 32)
> 		return elf_hwcap & BIT(num);
> 	else
> 		return elf_hwcap2 & BIT(num);
> }
> 
> #define cpu_have_feature(name) __cpu_have_feature(cpu_feature(name))

It took me a while to figure out what the benefit of the above line
is - this means that callers of cpu_have_feature must use the unprefixed
feature name (e.g. SHA512), anything else such as (KERNEL_HWCAP_SHA512
or HWCAP_SHA512) would result in a compile time error. Whereas without
this users could pass KERNEL_HWCAP_x or HWCAP_x without compile errors
yet resulting in incorrectly passing a bitfield when using HWCAP_x.

> 
> 
> In compiletime-constant cases, the compiler should simply delete the
> WARN.

Is this really needed? Surely this would only come into play when a user
directly calls __cpu_have_feature. I think this is overkill, especially
as __cpu_have_feature is a new function.


>  A couple of cases in the cpufeatures and /proc/cpuinfo code would
> need to use __cpu_have_feature directly and would retain the WARN, but
> that's not fastpath and probably not the end of the world, plus we
> get an additional debugging aid if that code goes wrong.

But even so, the WARN (for the cpuinfo case) is unlikely to ever be hit.

The challenge with this approach is print_cpu_modalias (drivers/base/cpu.c),
this also uses cpu_have_feature - this expects cpu_have_feature to take
an ordinal. How can we work around this?

> 
> Alternatively, we could bake cpu_feature() into HWCAP_CAP(), making
> it impossible to specify invalid or user-encoded hwcaps there either.
> Then we might justifiably omit the policing in __cpu_have_feature()
> altogether.

This would certainly please checkpatch with respect to line lengths :)

However since this patchset, we now use cpu_have_feature elsewhere, such
as in the crypto drivers.

> 
> >  
> >  /* System capability check for constant caps */
> > diff --git a/arch/arm64/include/asm/hwcap.h b/arch/arm64/include/asm/hwcap.h
> > index 400b80b..05ee9b9 100644
> > --- a/arch/arm64/include/asm/hwcap.h
> > +++ b/arch/arm64/include/asm/hwcap.h
> > @@ -39,12 +39,49 @@
> >  #define COMPAT_HWCAP2_SHA2	(1 << 3)
> >  #define COMPAT_HWCAP2_CRC32	(1 << 4)
> >  
> > +/*
> > + * KERNEL_HWCAP flags - for elf_hwcap (in kernel)
> > + */
> > +#define KERNEL_HWCAP_FP                ilog2(HWCAP_FP)
> > +#define KERNEL_HWCAP_ASIMD             ilog2(HWCAP_ASIMD)
> > +#define KERNEL_HWCAP_EVTSTRM           ilog2(HWCAP_EVTSTRM)
> > +#define KERNEL_HWCAP_AES               ilog2(HWCAP_AES)
> > +#define KERNEL_HWCAP_PMULL             ilog2(HWCAP_PMULL)
> > +#define KERNEL_HWCAP_SHA1              ilog2(HWCAP_SHA1)
> > +#define KERNEL_HWCAP_SHA2              ilog2(HWCAP_SHA2)
> > +#define KERNEL_HWCAP_CRC32             ilog2(HWCAP_CRC32)
> > +#define KERNEL_HWCAP_ATOMICS           ilog2(HWCAP_ATOMICS)
> > +#define KERNEL_HWCAP_FPHP              ilog2(HWCAP_FPHP)
> > +#define KERNEL_HWCAP_ASIMDHP           ilog2(HWCAP_ASIMDHP)
> > +#define KERNEL_HWCAP_CPUID             ilog2(HWCAP_CPUID)
> > +#define KERNEL_HWCAP_ASIMDRDM          ilog2(HWCAP_ASIMDRDM)
> > +#define KERNEL_HWCAP_JSCVT             ilog2(HWCAP_JSCVT)
> > +#define KERNEL_HWCAP_FCMA              ilog2(HWCAP_FCMA)
> > +#define KERNEL_HWCAP_LRCPC             ilog2(HWCAP_LRCPC)
> > +#define KERNEL_HWCAP_DCPOP             ilog2(HWCAP_DCPOP)
> > +#define KERNEL_HWCAP_SHA3              ilog2(HWCAP_SHA3)
> > +#define KERNEL_HWCAP_SM3               ilog2(HWCAP_SM3)
> > +#define KERNEL_HWCAP_SM4               ilog2(HWCAP_SM4)
> > +#define KERNEL_HWCAP_ASIMDDP           ilog2(HWCAP_ASIMDDP)
> > +#define KERNEL_HWCAP_SHA512            ilog2(HWCAP_SHA512)
> > +#define KERNEL_HWCAP_SVE               ilog2(HWCAP_SVE)
> > +#define KERNEL_HWCAP_ASIMDFHM          ilog2(HWCAP_ASIMDFHM)
> > +#define KERNEL_HWCAP_DIT               ilog2(HWCAP_DIT)
> > +#define KERNEL_HWCAP_USCAT             ilog2(HWCAP_USCAT)
> > +#define KERNEL_HWCAP_ILRCPC            ilog2(HWCAP_ILRCPC)
> > +#define KERNEL_HWCAP_FLAGM             ilog2(HWCAP_FLAGM)
> > +#define KERNEL_HWCAP_SSBS              ilog2(HWCAP_SSBS)
> > +#define KERNEL_HWCAP_SB                ilog2(HWCAP_SB)
> > +#define KERNEL_HWCAP_PACA              ilog2(HWCAP_PACA)
> > +#define KERNEL_HWCAP_PACG              ilog2(HWCAP_PACG)
> 
> Nit: Odd spacing?  Personally I wouldn't indent with spaces just so that
> (ilog2() + 32) lines up nicely, but that's just my opinion and not a
> huge deal.
> 
> (The spacing can make subsequent diffs look jagged by default, which
> can be a distraction for reviewers.)

I'll convert to tabs, I probably copy pasted and the tabs got converted.

> 
> > +
> >  #ifndef __ASSEMBLY__
> >  /*
> >   * This yields a mask that user programs can use to figure out what
> >   * instruction set this cpu supports.
> >   */
> > -#define ELF_HWCAP		(elf_hwcap)
> > +#define ELF_HWCAP		elf_hwcap
> > +#define ELF_HWCAP2		elf_hwcap2
> 
> Do we need elf_hwcap2 at all?
> 
> We could just have these macros fish the bits out of a single variable,
> or wherever.
> 
> However, it may be better to keep things this way if we want to maintain
> the elf_hwcap in the kernel/module ABI.  See note on EXPORT_SYMBOL_GPL()
> removal for elf_hwcap in the subsequent patch.

OK, I'll leave it as it is.

> 
> >  
> >  #ifdef CONFIG_COMPAT
> >  #define COMPAT_ELF_HWCAP	(compat_elf_hwcap)
> > @@ -60,6 +97,6 @@ enum {
> >  #endif
> >  };
> >  
> > -extern unsigned long elf_hwcap;
> > +extern unsigned long elf_hwcap, elf_hwcap2;
> >  #endif
> >  #endif
> > diff --git a/arch/arm64/include/uapi/asm/hwcap.h b/arch/arm64/include/uapi/asm/hwcap.h
> > index 5f0750c..453b45a 100644
> > --- a/arch/arm64/include/uapi/asm/hwcap.h
> > +++ b/arch/arm64/include/uapi/asm/hwcap.h
> > @@ -18,7 +18,7 @@
> >  #define _UAPI__ASM_HWCAP_H
> >  
> >  /*
> > - * HWCAP flags - for elf_hwcap (in kernel) and AT_HWCAP
> > + * HWCAP flags - for AT_HWCAP
> >   */
> >  #define HWCAP_FP		(1 << 0)
> >  #define HWCAP_ASIMD		(1 << 1)
> > diff --git a/arch/arm64/kernel/cpufeature.c b/arch/arm64/kernel/cpufeature.c
> > index f6d84e2..d10a455 100644
> > --- a/arch/arm64/kernel/cpufeature.c
> > +++ b/arch/arm64/kernel/cpufeature.c
> > @@ -38,6 +38,9 @@
> >  unsigned long elf_hwcap __read_mostly;
> >  EXPORT_SYMBOL_GPL(elf_hwcap);
> >  
> > +unsigned long elf_hwcap2 __read_mostly;
> > +EXPORT_SYMBOL_GPL(elf_hwcap2);
> > +
> 
> Historically nobody used this because it didn't exist, and we don't want
> anybody to use it (since cpu_have_feature() etc. is the preferred
> interface).

In that case I should probably EXPORT_SYMBOL_GPL cpu_have_feature.

> 
> So lose EXPORT_SYMBOL_GPL() here.  (You remove it in any case in a
> subsequent patch, but having it even transiently sends mixed messages
> about the intent.)

No problem.

> 
> [...]
> 
> Otherwise looks reasonable.

Thanks for the review.

Andrew Murray

> 
> Cheers
> ---Dave

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
