Return-Path: <SRS0=fpAU=QP=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_SIGNED,DKIM_VALID,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_MUTT autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 21F16C169C4
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri,  8 Feb 2019 16:01:23 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id DABFB2086C
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri,  8 Feb 2019 16:01:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="Wz3x5lGl";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="PegaWPt3"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DABFB2086C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:
	Message-ID:Subject:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=YcxFoCFJxr+Fv/QmsUx2w+5V7vbNZnb5o8RxjYNEd54=; b=Wz3x5lGlKc2rpx
	RLHvYC28367vvhA1MFvnnRtDNfg9A3c2g7HIjHpy78grZBwdLE6UYa0rRsf3jDsmw+uWJuyGOj2PG
	C3KIbMbMSVTxuwjsc3Ka3Pn+WVr10GNJuTFd+XKZj/ne8WQU4PYwzD328YsGKmiKTQfxnSQlAxjOW
	AtqEGmLgovwoibI3vuPSHuyuICTE3R9TI6rylAMwNNAGfHn9xjZB4yMI120DstqTsYaVnQfzSbzbD
	/vPUHopIeOj36D5Ci/XD2TtO+fneqZe+95JBVcQEMmPxeikwr6A9pTLQZLpRqneQEroGCQ9OqIm6Z
	I175E5DQxkB5sYBHK7uA==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gs8af-0000Kg-8o; Fri, 08 Feb 2019 16:01:21 +0000
Received: from mail-ed1-x543.google.com ([2a00:1450:4864:20::543])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gs8ZX-0008Ew-U6
 for linux-arm-kernel@lists.infradead.org; Fri, 08 Feb 2019 16:00:14 +0000
Received: by mail-ed1-x543.google.com with SMTP id b14so3181578edt.6
 for <linux-arm-kernel@lists.infradead.org>;
 Fri, 08 Feb 2019 08:00:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=date:from:to:cc:subject:message-id:references:mime-version
 :content-disposition:in-reply-to:user-agent;
 bh=OSulq3lvXqbyFxTDC1tKNbLEzrnsSrdFhhsO0c+emWk=;
 b=PegaWPt354clt0Nf2kBLiRyOeBlcq+KTIwHGkpto8vdEOFAHq3pPgvQjdCpS8yMSer
 NwbChSq0wto5jUClfp34wusOL4r4SGOIsDi2vLzRyD4zSg1MLB7hShhzpB0xs7WqR1/w
 SaF5zzDISG2OZHeNI2gpR+eOodfNosAEs3AGCR81hwxgxQieeYbfegzvPCQCSDeLAbCq
 sBTKElVDT7UllZyS/x2jzu60mAPG2uB/F8zuEgdjHYwptiv3gvKMj0IDMMR9BaUSYljV
 d4LT+9LA+s6ToqyFKDdUyfiL/80teYStlDGCEFVyzU6a4V1oQc990Y71ugct94IHMKkP
 6/Iw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to:user-agent;
 bh=OSulq3lvXqbyFxTDC1tKNbLEzrnsSrdFhhsO0c+emWk=;
 b=j6woFcSk/yyF5mFZ5UbVUAyMEa0cF9H80a3AXxt3yTa5O6qfIvp5EbhW8H8qYnCyRL
 QSJNCBMZqupBo8mPF7nUtcMTFVggBAFANgbotZ+hn8bwiueecHh2A4V3YDfq0xBuajhz
 A6BIgZyJx/0Syc7TZ4V88jSzWrw97T6SevE1XATCxRfY9IfOiYzfvVsqwDo/5OabDoKI
 GLiSleUh6JrIObGpmgMWrS1rgcFRdtttzhNkGGA1xM2f4L+fLEnnDzJJSNpzp8cEoAmm
 8ad51BrO5AxrvWNa2V3W62nwInr9ILrwkDcUKUGLoYJ/Jm6ek7stPj9RtcYTe/Je5Z2K
 VoPQ==
X-Gm-Message-State: AHQUAubyWOcYrJXAOc249pnBSoljKfBzZ6VcTe2LX+SzUPi1PR3+NPY8
 plrruNX4tO0szaG46Skj52Y=
X-Google-Smtp-Source: AHgI3IbkGyP7JBxpm3YWvtKeNBT4rPelXWKTqOEdwPlIDJ9mKAqYRNkp+l66Pr+P4qex9ZaOGKYWtQ==
X-Received: by 2002:aa7:c352:: with SMTP id j18mr17153720edr.295.1549641610084; 
 Fri, 08 Feb 2019 08:00:10 -0800 (PST)
Received: from archlinux-ryzen ([2a01:4f9:2a:1fae::2])
 by smtp.gmail.com with ESMTPSA id s46sm717960edd.9.2019.02.08.08.00.08
 (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
 Fri, 08 Feb 2019 08:00:09 -0800 (PST)
Date: Fri, 8 Feb 2019 09:00:07 -0700
From: Nathan Chancellor <natechancellor@gmail.com>
To: Julien Thierry <julien.thierry@arm.com>
Subject: Re: [PATCH v10 12/25] arm64: irqflags: Use ICC_PMR_EL1 for interrupt
 masking
Message-ID: <20190208160007.GA26005@archlinux-ryzen>
References: <1548946743-38979-1-git-send-email-julien.thierry@arm.com>
 <1548946743-38979-13-git-send-email-julien.thierry@arm.com>
 <20190208043543.GA5040@archlinux-ryzen>
 <a5c2aacd-f607-c73e-d636-9cfc73c1fde0@arm.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <a5c2aacd-f607-c73e-d636-9cfc73c1fde0@arm.com>
User-Agent: Mutt/1.11.3 (2019-02-01)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190208_080012_138481_D7D6458C 
X-CRM114-Status: GOOD (  25.31  )
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
Cc: mark.rutland@arm.com, Nick Desaulniers <ndesaulniers@google.com>,
 daniel.thompson@linaro.org, Ard Biesheuvel <ard.biesheuvel@linaro.org>,
 marc.zyngier@arm.com, catalin.marinas@arm.com, will.deacon@arm.com,
 linux-kernel@vger.kernel.org, christoffer.dall@arm.com, james.morse@arm.com,
 Oleg Nesterov <oleg@redhat.com>, joel@joelfernandes.org,
 linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

On Fri, Feb 08, 2019 at 09:36:48AM +0000, Julien Thierry wrote:
> Hi Nathan,
> 
> On 08/02/2019 04:35, Nathan Chancellor wrote:
> > On Thu, Jan 31, 2019 at 02:58:50PM +0000, Julien Thierry wrote:
> 
> [...]
> 
> > 
> > Hi Julien,
> > 
> > This patch introduced a slew of Clang warnings:
> > 
> > In file included from arch/arm64/kernel/signal.c:21:
> > In file included from include/linux/compat.h:10:
> > In file included from include/linux/time.h:6:
> > In file included from include/linux/seqlock.h:36:
> > In file included from include/linux/spinlock.h:54:
> > In file included from include/linux/irqflags.h:16:
> > arch/arm64/include/asm/irqflags.h:50:10: warning: value size does not match register size specified by the constraint and modifier [-Wasm-operand-widths]
> >                 : "r" (GIC_PRIO_IRQON)
> >                        ^
> > arch/arm64/include/asm/ptrace.h:39:25: note: expanded from macro 'GIC_PRIO_IRQON'
> > #define GIC_PRIO_IRQON          0xf0
> >                                 ^
> > arch/arm64/include/asm/irqflags.h:46:44: note: use constraint modifier "w"
> >                 "msr_s  " __stringify(SYS_ICC_PMR_EL1) ",%0\n"
> >                                                          ^~
> >                                                          %w0
> 
> I'm not sure I get the relevance of this kind of warnings from Clang.
> Had it been an output operand I could understand the concern of having a
> variable too small to store the register value. But here it's an input
> operand being place in a wider register...
> 
> > arch/arm64/include/asm/alternative.h:286:29: note: expanded from macro 'ALTERNATIVE'
> >         _ALTERNATIVE_CFG(oldinstr, newinstr, __VA_ARGS__, 1)
> >                                    ^
> > arch/arm64/include/asm/alternative.h:88:30: note: expanded from macro '_ALTERNATIVE_CFG'
> >         __ALTERNATIVE_CFG(oldinstr, newinstr, feature, IS_ENABLED(cfg), 0)
> >                                     ^
> > arch/arm64/include/asm/alternative.h:76:2: note: expanded from macro '__ALTERNATIVE_CFG'
> >         newinstr "\n"                                                   \
> >         ^
> > In file included from arch/arm64/kernel/signal.c:21:
> > In file included from include/linux/compat.h:10:
> > In file included from include/linux/time.h:6:
> > In file included from include/linux/seqlock.h:36:
> > In file included from include/linux/spinlock.h:54:
> > In file included from include/linux/irqflags.h:16:
> > arch/arm64/include/asm/irqflags.h:61:10: warning: value size does not match register size specified by the constraint and modifier [-Wasm-operand-widths]
> >                 : "r" (GIC_PRIO_IRQOFF)
> >                        ^
> > arch/arm64/include/asm/ptrace.h:40:26: note: expanded from macro 'GIC_PRIO_IRQOFF'
> > #define GIC_PRIO_IRQOFF         (GIC_PRIO_IRQON & ~0x80)
> >                                 ^
> > arch/arm64/include/asm/irqflags.h:58:45: note: use constraint modifier "w"
> >                 "msr_s  " __stringify(SYS_ICC_PMR_EL1) ", %0",
> >                                                           ^
> > arch/arm64/include/asm/irqflags.h:94:10: warning: value size does not match register size specified by the constraint and modifier [-Wasm-operand-widths]
> >                 : "r" (GIC_PRIO_IRQOFF)
> >                        ^
> > arch/arm64/include/asm/ptrace.h:40:26: note: expanded from macro 'GIC_PRIO_IRQOFF'
> > #define GIC_PRIO_IRQOFF         (GIC_PRIO_IRQON & ~0x80)
> >                                 ^
> > arch/arm64/include/asm/irqflags.h:91:18: note: use constraint modifier "w"
> >                         "csel   %0, %0, %2, eq",
> >                                         ^~
> >                                         %w2
> > arch/arm64/include/asm/alternative.h:286:29: note: expanded from macro 'ALTERNATIVE'
> >         _ALTERNATIVE_CFG(oldinstr, newinstr, __VA_ARGS__, 1)
> >                                    ^
> > arch/arm64/include/asm/alternative.h:88:30: note: expanded from macro '_ALTERNATIVE_CFG'
> >         __ALTERNATIVE_CFG(oldinstr, newinstr, feature, IS_ENABLED(cfg), 0)
> >                                     ^
> > arch/arm64/include/asm/alternative.h:76:2: note: expanded from macro '__ALTERNATIVE_CFG'
> >         newinstr "\n"                                                   \
> >         ^
> > 3 warnings generated.
> > 
> > 
> > I am not sure if they should be fixed with Clang's suggestion of a
> > constraint modifier or a cast like commit 1b57ec8c7527 ("arm64: io:
> > Ensure value passed to __iormb() is held in a 64-bit register"), hence
> > this message.
> > 
> 
> Clang's suggestion would not work as MSR instructions do not operate on
> 32-bit general purpose registers. Seeing that PMR is a 32-bit register,
> I'd avoid adding UL for the GIC_PRIO_IRQ* constants.
> 
> So I'd recommend just casting the the asm inline operands to unsigned
> long. This should only affect the 3 locations
> arch/arm64/include/asm/irqflags.h.
> 
> Does the following patch work for you?

Hi Julien,

Yes it does, thank you for the quick response and fix!

Nathan

> 
> Thanks,
> 
> -- 
> Julien Thierry
> 
> 
> -->
> 
> From e839dec632bbf440efe8314751138ba46324078c Mon Sep 17 00:00:00 2001
> From: Julien Thierry <julien.thierry@arm.com>
> Date: Fri, 8 Feb 2019 09:21:58 +0000
> Subject: [PATCH] arm64: irqflags: Fix clang build warnings
> 
> Clang complains when passing asm operands that are smaller than the
> registers they are mapped to:
> 
> arch/arm64/include/asm/irqflags.h:50:10: warning: value size does not
> 	match register size specified by the constraint and modifier
> 	[-Wasm-operand-widths]
>                 : "r" (GIC_PRIO_IRQON)
> 
> Fix it by casting the affected input operands to a type of the correct
> size.
> 
> Reported-by: Nathan Chancellor <natechancellor@gmail.com>
> Signed-off-by: Julien Thierry <julien.thierry@arm.com>

Tested-by: Nathan Chancellor <natechancellor@gmail.com>

> ---
>  arch/arm64/include/asm/irqflags.h | 6 +++---
>  1 file changed, 3 insertions(+), 3 deletions(-)
> 
> diff --git a/arch/arm64/include/asm/irqflags.h b/arch/arm64/include/asm/irqflags.h
> index d4597b2..43d8366 100644
> --- a/arch/arm64/include/asm/irqflags.h
> +++ b/arch/arm64/include/asm/irqflags.h
> @@ -47,7 +47,7 @@ static inline void arch_local_irq_enable(void)
>  		"dsb	sy",
>  		ARM64_HAS_IRQ_PRIO_MASKING)
>  		:
> -		: "r" (GIC_PRIO_IRQON)
> +		: "r" ((unsigned long) GIC_PRIO_IRQON)
>  		: "memory");
>  }
>  
> @@ -58,7 +58,7 @@ static inline void arch_local_irq_disable(void)
>  		"msr_s  " __stringify(SYS_ICC_PMR_EL1) ", %0",
>  		ARM64_HAS_IRQ_PRIO_MASKING)
>  		:
> -		: "r" (GIC_PRIO_IRQOFF)
> +		: "r" ((unsigned long) GIC_PRIO_IRQOFF)
>  		: "memory");
>  }
>  
> @@ -91,7 +91,7 @@ static inline unsigned long arch_local_save_flags(void)
>  			"csel	%0, %0, %2, eq",
>  			ARM64_HAS_IRQ_PRIO_MASKING)
>  		: "=&r" (flags), "+r" (daif_bits)
> -		: "r" (GIC_PRIO_IRQOFF)
> +		: "r" ((unsigned long) GIC_PRIO_IRQOFF)
>  		: "memory");
>  
>  	return flags;
> -- 
> 1.9.1
> 
> 

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
