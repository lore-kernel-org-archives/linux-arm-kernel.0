Return-Path: <SRS0=tmGn=OI=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 46A98C43441
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Thu, 29 Nov 2018 18:02:11 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E351521019
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Thu, 29 Nov 2018 18:02:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="lgbbiWdU"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E351521019
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:
	Message-ID:Subject:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=/EDc8hdda8ypEp0o4sA/+6kdgLKRJW+1ibLspQcjXCM=; b=lgbbiWdUMlBCL2
	qEupx6joCT4FQc/lOBXJzGKRrx0M40POFvyIwIXl32D1kmVFZT5OYc2fEar146mIesAerdTrdk9sW
	M94NTo8NioLFQqvCN1XK+9KxD9XgXncbiV4JBRLB0ciaozmpQB97mhmSC1HMUYJKTWt3jYevtUnb/
	OkLguEi+H2NgI37QjtLt+jyVA4ieKtyC/mM1cZVZsGQhyXzwn6zZODOOiLApfPO/uOzNHscYHaaHA
	TGvw90waJtDvxj4orfD4QR4g2BBQp5seXPrfSVlQT7cYgsLwt11EbNNgtDrsXHPwz0ShXBOlqrbET
	oxXmzsIVG1PVr101bo+A==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gSQda-00071J-Ex; Thu, 29 Nov 2018 18:02:06 +0000
Received: from usa-sjc-mx-foss1.foss.arm.com ([217.140.101.70]
 helo=foss.arm.com)
 by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gSQcx-0006Pt-H5
 for linux-arm-kernel@lists.infradead.org; Thu, 29 Nov 2018 18:01:33 +0000
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 39433EBD;
 Thu, 29 Nov 2018 10:01:20 -0800 (PST)
Received: from edgewater-inn.cambridge.arm.com
 (usa-sjc-imap-foss1.foss.arm.com [10.72.51.249])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 088EA3F575;
 Thu, 29 Nov 2018 10:01:20 -0800 (PST)
Received: by edgewater-inn.cambridge.arm.com (Postfix, from userid 1000)
 id 865D91AE0FD4; Thu, 29 Nov 2018 18:01:38 +0000 (GMT)
Date: Thu, 29 Nov 2018 18:01:38 +0000
From: Will Deacon <will.deacon@arm.com>
To: Andrey Konovalov <andreyknvl@google.com>
Subject: Re: [PATCH v12 20/25] kasan, arm64: add brk handler for inline
 instrumentation
Message-ID: <20181129180138.GB4318@arm.com>
References: <cover.1543337629.git.andreyknvl@google.com>
 <e825441eda1dbbbb7f583f826a66c94e6f88316a.1543337629.git.andreyknvl@google.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <e825441eda1dbbbb7f583f826a66c94e6f88316a.1543337629.git.andreyknvl@google.com>
User-Agent: Mutt/1.5.23 (2014-03-12)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20181129_100128_673688_6A5C9897 
X-CRM114-Status: GOOD (  22.77  )
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
 Kate Stewart <kstewart@linuxfoundation.org>, linux-doc@vger.kernel.org,
 Catalin Marinas <catalin.marinas@arm.com>,
 Paul Lawrence <paullawrence@google.com>, linux-mm@kvack.org,
 Alexander Potapenko <glider@google.com>,
 Chintan Pandya <cpandya@codeaurora.org>, Christoph Lameter <cl@linux.com>,
 Ingo Molnar <mingo@kernel.org>, Jacob Bramley <Jacob.Bramley@arm.com>,
 Ruben Ayrapetyan <Ruben.Ayrapetyan@arm.com>, Mark Brand <markbrand@google.com>,
 kasan-dev@googlegroups.com, linux-sparse@vger.kernel.org,
 Geert Uytterhoeven <geert@linux-m68k.org>,
 linux-arm-kernel@lists.infradead.org,
 Andrey Ryabinin <aryabinin@virtuozzo.com>, Dave Martin <dave.martin@arm.com>,
 Evgeniy Stepanov <eugenis@google.com>, Vishwath Mohan <vishwath@google.com>,
 Arnd Bergmann <arnd@arndb.de>, linux-kbuild@vger.kernel.org,
 Marc Zyngier <marc.zyngier@arm.com>,
 Ramana Radhakrishnan <Ramana.Radhakrishnan@arm.com>,
 Mike Rapoport <rppt@linux.vnet.ibm.com>, Dmitry Vyukov <dvyukov@google.com>,
 Kostya Serebryany <kcc@google.com>, Jann Horn <jannh@google.com>,
 Ard Biesheuvel <ard.biesheuvel@linaro.org>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 Nick Desaulniers <ndesaulniers@google.com>, linux-kernel@vger.kernel.org,
 "Eric W . Biederman" <ebiederm@xmission.com>, Lee Smith <Lee.Smith@arm.com>,
 Andrew Morton <akpm@linux-foundation.org>,
 "Kirill A . Shutemov" <kirill.shutemov@linux.intel.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

On Tue, Nov 27, 2018 at 05:55:38PM +0100, Andrey Konovalov wrote:
> Tag-based KASAN inline instrumentation mode (which embeds checks of shadow
> memory into the generated code, instead of inserting a callback) generates
> a brk instruction when a tag mismatch is detected.
> 
> This commit adds a tag-based KASAN specific brk handler, that decodes the
> immediate value passed to the brk instructions (to extract information
> about the memory access that triggered the mismatch), reads the register
> values (x0 contains the guilty address) and reports the bug.
> 
> Reviewed-by: Andrey Ryabinin <aryabinin@virtuozzo.com>
> Reviewed-by: Dmitry Vyukov <dvyukov@google.com>
> Signed-off-by: Andrey Konovalov <andreyknvl@google.com>
> ---
>  arch/arm64/include/asm/brk-imm.h |  2 +
>  arch/arm64/kernel/traps.c        | 68 +++++++++++++++++++++++++++++++-
>  include/linux/kasan.h            |  3 ++
>  3 files changed, 71 insertions(+), 2 deletions(-)
> 
> diff --git a/arch/arm64/include/asm/brk-imm.h b/arch/arm64/include/asm/brk-imm.h
> index ed693c5bcec0..2945fe6cd863 100644
> --- a/arch/arm64/include/asm/brk-imm.h
> +++ b/arch/arm64/include/asm/brk-imm.h
> @@ -16,10 +16,12 @@
>   * 0x400: for dynamic BRK instruction
>   * 0x401: for compile time BRK instruction
>   * 0x800: kernel-mode BUG() and WARN() traps
> + * 0x9xx: tag-based KASAN trap (allowed values 0x900 - 0x9ff)
>   */
>  #define FAULT_BRK_IMM			0x100
>  #define KGDB_DYN_DBG_BRK_IMM		0x400
>  #define KGDB_COMPILED_DBG_BRK_IMM	0x401
>  #define BUG_BRK_IMM			0x800
> +#define KASAN_BRK_IMM			0x900
>  
>  #endif
> diff --git a/arch/arm64/kernel/traps.c b/arch/arm64/kernel/traps.c
> index 5f4d9acb32f5..04bdc53716ef 100644
> --- a/arch/arm64/kernel/traps.c
> +++ b/arch/arm64/kernel/traps.c
> @@ -35,6 +35,7 @@
>  #include <linux/sizes.h>
>  #include <linux/syscalls.h>
>  #include <linux/mm_types.h>
> +#include <linux/kasan.h>
>  
>  #include <asm/atomic.h>
>  #include <asm/bug.h>
> @@ -284,10 +285,14 @@ void arm64_notify_die(const char *str, struct pt_regs *regs,
>  	}
>  }
>  
> -void arm64_skip_faulting_instruction(struct pt_regs *regs, unsigned long size)
> +void __arm64_skip_faulting_instruction(struct pt_regs *regs, unsigned long size)
>  {
>  	regs->pc += size;
> +}
>  
> +void arm64_skip_faulting_instruction(struct pt_regs *regs, unsigned long size)
> +{
> +	__arm64_skip_faulting_instruction(regs, size);
>  	/*
>  	 * If we were single stepping, we want to get the step exception after
>  	 * we return from the trap.
> @@ -959,7 +964,7 @@ static int bug_handler(struct pt_regs *regs, unsigned int esr)
>  	}
>  
>  	/* If thread survives, skip over the BUG instruction and continue: */
> -	arm64_skip_faulting_instruction(regs, AARCH64_INSN_SIZE);
> +	__arm64_skip_faulting_instruction(regs, AARCH64_INSN_SIZE);

Why do you want to avoid the single-step logic here? Given that we're
skipping over the brk instruction, why wouldn't you want that to trigger
a step exception if single-step is enabled?

Will

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
