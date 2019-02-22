Return-Path: <SRS0=2lwk=Q5=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2864FC43381
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri, 22 Feb 2019 14:22:19 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id EC04520700
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri, 22 Feb 2019 14:22:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="EqDoxUE/"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EC04520700
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:
	Message-ID:Subject:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=io70WjQ1LYYGzqIxvmwkPbGl7YPW2wsW4QLRQSzSPLg=; b=EqDoxUE/Ika1ns
	3UUwhs++wOoL2QwDGIAjDRor0MFD5HDDaeqExLgzox0el7IQJd2OyCimExqtEM+z7vaMTlLN6tfij
	r97EKSUtgD0BrRsCUIZB2LlRAPs82odpGFJlFP0XvKHRbqmvle1kh2kYvzfRxyveJV/lLresSi/9v
	mq3EG7alTzWpLhwEQqiKPIRD055hTPSxyEbMBD2t4nqHOPu8LI/5FWYhaIecvmFz45/2xHqR2ZMLD
	dONxQ516U/HWwmQscz8i8RWiQ54JTN9vuWaXBjwgOnqD00taHh5wOv502vVVsF6BbqeTkte9vlz4u
	LmdUvRnxh9K33HXRgeYg==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gxBiR-0001p6-St; Fri, 22 Feb 2019 14:22:15 +0000
Received: from foss.arm.com ([217.140.101.70])
 by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gxBiN-0001of-Pj
 for linux-arm-kernel@lists.infradead.org; Fri, 22 Feb 2019 14:22:13 +0000
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 2FB67A78;
 Fri, 22 Feb 2019 06:22:10 -0800 (PST)
Received: from lakrids.cambridge.arm.com (usa-sjc-imap-foss1.foss.arm.com
 [10.72.51.249])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 81EC03F690;
 Fri, 22 Feb 2019 06:22:07 -0800 (PST)
Date: Fri, 22 Feb 2019 14:22:05 +0000
From: Mark Rutland <mark.rutland@arm.com>
To: Vincenzo Frascino <vincenzo.frascino@arm.com>
Subject: Re: [PATCH v5 11/23] arm64: compat: Generate asm offsets for signals
Message-ID: <20190222142204.GK42419@lakrids.cambridge.arm.com>
References: <20190222122430.21180-1-vincenzo.frascino@arm.com>
 <20190222122430.21180-12-vincenzo.frascino@arm.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20190222122430.21180-12-vincenzo.frascino@arm.com>
User-Agent: Mutt/1.11.1+11 (2f07cb52) (2018-12-01)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190222_062211_841720_5CA91AE5 
X-CRM114-Status: GOOD (  12.41  )
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
Cc: linux-arch@vger.kernel.org, Shuah Khan <shuah@kernel.org>,
 Arnd Bergmann <arnd@arndb.de>, Catalin Marinas <catalin.marinas@arm.com>,
 Daniel Lezcano <daniel.lezcano@linaro.org>, Will Deacon <will.deacon@arm.com>,
 Russell King <linux@armlinux.org.uk>, Ralf Baechle <ralf@linux-mips.org>,
 Mark Salyzyn <salyzyn@android.com>, Paul Burton <paul.burton@mips.com>,
 Dmitry Safonov <0x7f454c46@gmail.com>,
 Rasmus Villemoes <linux@rasmusvillemoes.dk>,
 Thomas Gleixner <tglx@linutronix.de>, Peter Collingbourne <pcc@google.com>,
 linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

On Fri, Feb 22, 2019 at 12:24:18PM +0000, Vincenzo Frascino wrote:
> diff --git a/arch/arm64/include/asm/signal32.h b/arch/arm64/include/asm/signal32.h
> index 1f05268f4c6d..a6fd7be1b22a 100644
> --- a/arch/arm64/include/asm/signal32.h
> +++ b/arch/arm64/include/asm/signal32.h
> @@ -52,7 +52,7 @@ struct compat_ucontext {
>  	compat_stack_t			uc_stack;
>  	struct compat_sigcontext	uc_mcontext;
>  	compat_sigset_t			uc_sigmask;
> -	int 				__unused[32 - (sizeof(compat_sigset_t) / sizeof(int))];
> +	int				__unused[32 - (sizeof(compat_sigset_t) / sizeof(int))];

Spurious whitespace change?

> +/* Macros for asm-offsets.c */
> +#define OFFSET_OF_COMPAT_SIGFRAME_REGS (				\
> +			offsetof(struct compat_sigframe, uc) +		\
> +			offsetof(struct compat_ucontext, uc_mcontext) +	\
> +			offsetof(struct compat_sigcontext, arm_r0))
> +
> +#define OFFSET_OF_COMPAT_RT_SIGFRAME_REGS (				\
> +			offsetof(struct compat_rt_sigframe, sig) +	\
> +			offsetof(struct compat_sigframe, uc) +		\
> +			offsetof(struct compat_ucontext, uc_mcontext) +	\
> +			offsetof(struct compat_sigcontext, arm_r0))
> +
>  int compat_setup_frame(int usig, struct ksignal *ksig, sigset_t *set,
>  		       struct pt_regs *regs);
>  int compat_setup_rt_frame(int usig, struct ksignal *ksig, sigset_t *set,
> diff --git a/arch/arm64/kernel/asm-offsets.c b/arch/arm64/kernel/asm-offsets.c
> index 4adb52190a90..afd28ccda174 100644
> --- a/arch/arm64/kernel/asm-offsets.c
> +++ b/arch/arm64/kernel/asm-offsets.c
> @@ -30,6 +30,7 @@
>  #include <asm/fixmap.h>
>  #include <asm/thread_info.h>
>  #include <asm/memory.h>
> +#include <asm/signal32.h>
>  #include <asm/smp_plat.h>
>  #include <asm/suspend.h>
>  #include <linux/kbuild.h>
> @@ -84,6 +85,11 @@ int main(void)
>    DEFINE(S_STACKFRAME,		offsetof(struct pt_regs, stackframe));
>    DEFINE(S_FRAME_SIZE,		sizeof(struct pt_regs));
>    BLANK();
> +#ifdef CONFIG_COMPAT
> +  DEFINE(COMPAT_SIGFRAME_REGS_OFFSET,		OFFSET_OF_COMPAT_SIGFRAME_REGS);
> +  DEFINE(COMPAT_RT_SIGFRAME_REGS_OFFSET,	OFFSET_OF_COMPAT_RT_SIGFRAME_REGS);

Can't we do:

DEFINE(COMPAT_SIGFRAME_REGS_OFFSET,	offsetof(struct compat_sigframe, uc.us_mcontext.arm_r0)
DEFINE(COMPAT_RT_SIGFRAME_REGS_OFFSET,	offsetof(struct compat_rt_sigframe, sig.uc.us_mcontext.arm_r0)

... and avoid the OFFSET_OF_* macros entirely?

Thanks,
Mark.

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
