Return-Path: <SRS0=0OAT=OM=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.7 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_NEOMUTT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8BF85C04EB9
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Mon,  3 Dec 2018 16:01:31 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5F93E20848
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Mon,  3 Dec 2018 16:01:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="ExTiImdx";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="OwyVsF2V"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5F93E20848
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:
	Message-ID:Subject:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=0RObBix+u6dRVwcvPSmyexMpRdDFiIVl7Ui4+a8Suog=; b=ExTiImdxBgvP2S
	BzgUqQGhcrQbEYqVXCXHqgDeLD7DY/H9xBf8e+GqCQPcCx5tobCKY2kWy2YepgsmusJsh2yVwhtZW
	NxhO8QtcxRCzTH0r+2FSEVEy+q65pqyf0HFtFUzIgFAfQTlehc9vxUsfvxHQBzKWLN1iSf5MspZZ+
	yb/OfxoNkSht1tjN4iTrTxao494pSIofoDuCkWl4zfXYsKHYzzdh0yyq+tE2/bZ76YSF7cRCFJrYb
	5W6msBzSwFE1f1tww+rIGlXEKKLGAAsfGHS6Ustr3Rf8e7kSEv1fwiBONzbuYLGwKZ+biXxwOnpWU
	J/PrzpSoPZID3n79GLIA==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gTqew-0000CH-Bs; Mon, 03 Dec 2018 16:01:22 +0000
Received: from mail-wm1-x341.google.com ([2a00:1450:4864:20::341])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gTqeg-0000Ar-JH
 for linux-arm-kernel@lists.infradead.org; Mon, 03 Dec 2018 16:01:08 +0000
Received: by mail-wm1-x341.google.com with SMTP id z18so6432946wmc.4
 for <linux-arm-kernel@lists.infradead.org>;
 Mon, 03 Dec 2018 08:00:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=date:from:to:cc:subject:message-id:references:mime-version
 :content-disposition:in-reply-to:user-agent;
 bh=LlQl10sTapvckaKcDkeHqBIHgcPLtKEdv5p1b9Bnto4=;
 b=OwyVsF2VQ57Hdn/gtOT8NeDjj846jYMCoy9ncQlU7KhgB3zSRkSwhwcNsqDN/O2td+
 by86L6HZK0GZqeeXDkIWYBYYUKvPqKCq5Qm3xOGd7S8/HvFGBDIo6D3fBpp/3ZxGih9i
 Ze7zmWcp8ULY7+YBz6DEazDQxGFfebl5sAmAA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to:user-agent;
 bh=LlQl10sTapvckaKcDkeHqBIHgcPLtKEdv5p1b9Bnto4=;
 b=ewenKMXB5gEMsSnowNMHR1JLI7AvsXO+ees25xp9pfRDDUTrkXn+I0vhM7u3hj6PzR
 N+Vnz0THgkIhkFNti6fwOe8XaPYOOIgnGCKWZEgtVgjfE5OGgrggqhdZh9XaKDpq+3qH
 EUCfx4pzjODeuUdhsgxVDsVWvpOtUpp4WesonikrVxnkxR5yRtfuAXmzdjVUbA+Bw3Rv
 O5P8tKr8JrdnbgRQodGkInckbXXQnY48vPKabmDRAQvWhBuCIGuXGgHuBs1l8C0vvHFq
 +fOa/vDGIxQTNZBtzOPQeMHaFD/5aV1HFDm7FXG68H7MHxXXUKVqMh3k3+zC/tp8HAak
 1Ewg==
X-Gm-Message-State: AA+aEWaeDSOkm4HOCkYQnbQrBfoGwYE89SWA6ArG73lmKbG+JUhCn95F
 5+sh0IgtgRyRhAXD8Ep5FbyjHQ==
X-Google-Smtp-Source: AFSGD/UU0Sw7OaQwlBIyozUPHYUYP17cM9x9TQG2WMkItE220KN9RTa0FmToJgg628a3q3PyA1T+7A==
X-Received: by 2002:a1c:8851:: with SMTP id k78mr8979378wmd.51.1543852853966; 
 Mon, 03 Dec 2018 08:00:53 -0800 (PST)
Received: from holly.lan (cpc141214-aztw34-2-0-cust773.18-1.cable.virginm.net.
 [86.9.19.6])
 by smtp.gmail.com with ESMTPSA id l20sm31443927wrb.93.2018.12.03.08.00.52
 (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
 Mon, 03 Dec 2018 08:00:53 -0800 (PST)
Date: Mon, 3 Dec 2018 16:00:50 +0000
From: Daniel Thompson <daniel.thompson@linaro.org>
To: Douglas Anderson <dianders@chromium.org>
Subject: Re: [PATCH v6 1/4] kgdb: Remove irq flags from roundup
Message-ID: <20181203160050.vebvvdiuki2iuczg@holly.lan>
References: <20181127173839.34328-1-dianders@chromium.org>
 <20181127173839.34328-2-dianders@chromium.org>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20181127173839.34328-2-dianders@chromium.org>
User-Agent: NeoMutt/20180716
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20181203_080106_631689_94159CB9 
X-CRM114-Status: GOOD (  23.85  )
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
Cc: linux-mips@linux-mips.org, Michal Hocko <mhocko@suse.com>,
 Benjamin Herrenschmidt <benh@kernel.crashing.org>, linux-sh@vger.kernel.org,
 Peter Zijlstra <peterz@infradead.org>,
 Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will.deacon@arm.com>,
 Rich Felker <dalias@libc.org>, Paul Mackerras <paulus@samba.org>,
 Michael Ellerman <mpe@ellerman.id.au>, "H. Peter Anvin" <hpa@zytor.com>,
 sparclinux@vger.kernel.org, Stephen Rothwell <sfr@canb.auug.org.au>,
 Yoshinori Sato <ysato@users.sourceforge.jp>, linux-hexagon@vger.kernel.org,
 x86@kernel.org, Russell King <linux@armlinux.org.uk>,
 Ingo Molnar <mingo@redhat.com>, kgdb-bugreport@lists.sourceforge.net,
 James Hogan <jhogan@kernel.org>, linux-snps-arc@lists.infradead.org,
 Huang Ying <ying.huang@intel.com>, Mike Rapoport <rppt@linux.vnet.ibm.com>,
 Borislav Petkov <bp@alien8.de>, Thomas Gleixner <tglx@linutronix.de>,
 linux-arm-kernel@lists.infradead.org,
 Christophe Leroy <christophe.leroy@c-s.fr>, Vineet Gupta <vgupta@synopsys.com>,
 linux-kernel@vger.kernel.org, Ralf Baechle <ralf@linux-mips.org>,
 Richard Kuo <rkuo@codeaurora.org>, Paul Burton <paul.burton@mips.com>,
 Jason Wessel <jason.wessel@windriver.com>,
 Andrew Morton <akpm@linux-foundation.org>, linuxppc-dev@lists.ozlabs.org,
 "David S. Miller" <davem@davemloft.net>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

On Tue, Nov 27, 2018 at 09:38:36AM -0800, Douglas Anderson wrote:
> The function kgdb_roundup_cpus() was passed a parameter that was
> documented as:
> 
> > the flags that will be used when restoring the interrupts. There is
> > local_irq_save() call before kgdb_roundup_cpus().
> 
> Nobody used those flags.  Anyone who wanted to temporarily turn on
> interrupts just did local_irq_enable() and local_irq_disable() without
> looking at them.  So we can definitely remove the flags.
> 
> Signed-off-by: Douglas Anderson <dianders@chromium.org>
> Acked-by: Will Deacon <will.deacon@arm.com>
> ---
> 
> Changes in v6: None
> Changes in v5: None
> Changes in v4: None
> Changes in v3: None
> Changes in v2:
> - Removing irq flags separated from fixing lockdep splat.
> 
>  arch/arc/kernel/kgdb.c     | 2 +-
>  arch/arm/kernel/kgdb.c     | 2 +-
>  arch/arm64/kernel/kgdb.c   | 2 +-
>  arch/hexagon/kernel/kgdb.c | 9 ++-------
>  arch/mips/kernel/kgdb.c    | 2 +-
>  arch/powerpc/kernel/kgdb.c | 2 +-
>  arch/sh/kernel/kgdb.c      | 2 +-
>  arch/sparc/kernel/smp_64.c | 2 +-
>  arch/x86/kernel/kgdb.c     | 9 ++-------

Again, please formally Cc: the arch maintainers in the patch header
(just after your Signed-off-by: if I'm not being explicitly clear).


Daniel.

>  include/linux/kgdb.h       | 9 ++-------
>  kernel/debug/debug_core.c  | 2 +-
>  11 files changed, 14 insertions(+), 29 deletions(-)
> 
> diff --git a/arch/arc/kernel/kgdb.c b/arch/arc/kernel/kgdb.c
> index 9a3c34af2ae8..0932851028e0 100644
> --- a/arch/arc/kernel/kgdb.c
> +++ b/arch/arc/kernel/kgdb.c
> @@ -197,7 +197,7 @@ static void kgdb_call_nmi_hook(void *ignored)
>  	kgdb_nmicallback(raw_smp_processor_id(), NULL);
>  }
>  
> -void kgdb_roundup_cpus(unsigned long flags)
> +void kgdb_roundup_cpus(void)
>  {
>  	local_irq_enable();
>  	smp_call_function(kgdb_call_nmi_hook, NULL, 0);
> diff --git a/arch/arm/kernel/kgdb.c b/arch/arm/kernel/kgdb.c
> index caa0dbe3dc61..f21077b077be 100644
> --- a/arch/arm/kernel/kgdb.c
> +++ b/arch/arm/kernel/kgdb.c
> @@ -175,7 +175,7 @@ static void kgdb_call_nmi_hook(void *ignored)
>         kgdb_nmicallback(raw_smp_processor_id(), get_irq_regs());
>  }
>  
> -void kgdb_roundup_cpus(unsigned long flags)
> +void kgdb_roundup_cpus(void)
>  {
>         local_irq_enable();
>         smp_call_function(kgdb_call_nmi_hook, NULL, 0);
> diff --git a/arch/arm64/kernel/kgdb.c b/arch/arm64/kernel/kgdb.c
> index a20de58061a8..12c339ff6e75 100644
> --- a/arch/arm64/kernel/kgdb.c
> +++ b/arch/arm64/kernel/kgdb.c
> @@ -289,7 +289,7 @@ static void kgdb_call_nmi_hook(void *ignored)
>  	kgdb_nmicallback(raw_smp_processor_id(), get_irq_regs());
>  }
>  
> -void kgdb_roundup_cpus(unsigned long flags)
> +void kgdb_roundup_cpus(void)
>  {
>  	local_irq_enable();
>  	smp_call_function(kgdb_call_nmi_hook, NULL, 0);
> diff --git a/arch/hexagon/kernel/kgdb.c b/arch/hexagon/kernel/kgdb.c
> index 16c24b22d0b2..012e0e230ac2 100644
> --- a/arch/hexagon/kernel/kgdb.c
> +++ b/arch/hexagon/kernel/kgdb.c
> @@ -119,17 +119,12 @@ void kgdb_arch_set_pc(struct pt_regs *regs, unsigned long pc)
>  
>  /**
>   * kgdb_roundup_cpus - Get other CPUs into a holding pattern
> - * @flags: Current IRQ state
>   *
>   * On SMP systems, we need to get the attention of the other CPUs
>   * and get them be in a known state.  This should do what is needed
>   * to get the other CPUs to call kgdb_wait(). Note that on some arches,
>   * the NMI approach is not used for rounding up all the CPUs. For example,
> - * in case of MIPS, smp_call_function() is used to roundup CPUs. In
> - * this case, we have to make sure that interrupts are enabled before
> - * calling smp_call_function(). The argument to this function is
> - * the flags that will be used when restoring the interrupts. There is
> - * local_irq_save() call before kgdb_roundup_cpus().
> + * in case of MIPS, smp_call_function() is used to roundup CPUs.
>   *
>   * On non-SMP systems, this is not called.
>   */
> @@ -139,7 +134,7 @@ static void hexagon_kgdb_nmi_hook(void *ignored)
>  	kgdb_nmicallback(raw_smp_processor_id(), get_irq_regs());
>  }
>  
> -void kgdb_roundup_cpus(unsigned long flags)
> +void kgdb_roundup_cpus(void)
>  {
>  	local_irq_enable();
>  	smp_call_function(hexagon_kgdb_nmi_hook, NULL, 0);
> diff --git a/arch/mips/kernel/kgdb.c b/arch/mips/kernel/kgdb.c
> index eb6c0d582626..2b05effc17b4 100644
> --- a/arch/mips/kernel/kgdb.c
> +++ b/arch/mips/kernel/kgdb.c
> @@ -219,7 +219,7 @@ static void kgdb_call_nmi_hook(void *ignored)
>  	set_fs(old_fs);
>  }
>  
> -void kgdb_roundup_cpus(unsigned long flags)
> +void kgdb_roundup_cpus(void)
>  {
>  	local_irq_enable();
>  	smp_call_function(kgdb_call_nmi_hook, NULL, 0);
> diff --git a/arch/powerpc/kernel/kgdb.c b/arch/powerpc/kernel/kgdb.c
> index 59c578f865aa..b0e804844be0 100644
> --- a/arch/powerpc/kernel/kgdb.c
> +++ b/arch/powerpc/kernel/kgdb.c
> @@ -124,7 +124,7 @@ static int kgdb_call_nmi_hook(struct pt_regs *regs)
>  }
>  
>  #ifdef CONFIG_SMP
> -void kgdb_roundup_cpus(unsigned long flags)
> +void kgdb_roundup_cpus(void)
>  {
>  	smp_send_debugger_break();
>  }
> diff --git a/arch/sh/kernel/kgdb.c b/arch/sh/kernel/kgdb.c
> index 4f04c6638a4d..cc57630f6bf2 100644
> --- a/arch/sh/kernel/kgdb.c
> +++ b/arch/sh/kernel/kgdb.c
> @@ -319,7 +319,7 @@ static void kgdb_call_nmi_hook(void *ignored)
>  	kgdb_nmicallback(raw_smp_processor_id(), get_irq_regs());
>  }
>  
> -void kgdb_roundup_cpus(unsigned long flags)
> +void kgdb_roundup_cpus(void)
>  {
>  	local_irq_enable();
>  	smp_call_function(kgdb_call_nmi_hook, NULL, 0);
> diff --git a/arch/sparc/kernel/smp_64.c b/arch/sparc/kernel/smp_64.c
> index 4792e08ad36b..f45d876983f1 100644
> --- a/arch/sparc/kernel/smp_64.c
> +++ b/arch/sparc/kernel/smp_64.c
> @@ -1014,7 +1014,7 @@ void flush_dcache_page_all(struct mm_struct *mm, struct page *page)
>  }
>  
>  #ifdef CONFIG_KGDB
> -void kgdb_roundup_cpus(unsigned long flags)
> +void kgdb_roundup_cpus(void)
>  {
>  	smp_cross_call(&xcall_kgdb_capture, 0, 0, 0);
>  }
> diff --git a/arch/x86/kernel/kgdb.c b/arch/x86/kernel/kgdb.c
> index 8e36f249646e..ac6291a4178d 100644
> --- a/arch/x86/kernel/kgdb.c
> +++ b/arch/x86/kernel/kgdb.c
> @@ -422,21 +422,16 @@ static void kgdb_disable_hw_debug(struct pt_regs *regs)
>  #ifdef CONFIG_SMP
>  /**
>   *	kgdb_roundup_cpus - Get other CPUs into a holding pattern
> - *	@flags: Current IRQ state
>   *
>   *	On SMP systems, we need to get the attention of the other CPUs
>   *	and get them be in a known state.  This should do what is needed
>   *	to get the other CPUs to call kgdb_wait(). Note that on some arches,
>   *	the NMI approach is not used for rounding up all the CPUs. For example,
> - *	in case of MIPS, smp_call_function() is used to roundup CPUs. In
> - *	this case, we have to make sure that interrupts are enabled before
> - *	calling smp_call_function(). The argument to this function is
> - *	the flags that will be used when restoring the interrupts. There is
> - *	local_irq_save() call before kgdb_roundup_cpus().
> + *	in case of MIPS, smp_call_function() is used to roundup CPUs.
>   *
>   *	On non-SMP systems, this is not called.
>   */
> -void kgdb_roundup_cpus(unsigned long flags)
> +void kgdb_roundup_cpus(void)
>  {
>  	apic->send_IPI_allbutself(APIC_DM_NMI);
>  }
> diff --git a/include/linux/kgdb.h b/include/linux/kgdb.h
> index e465bb15912d..05e5b2eb0d32 100644
> --- a/include/linux/kgdb.h
> +++ b/include/linux/kgdb.h
> @@ -178,21 +178,16 @@ kgdb_arch_handle_exception(int vector, int signo, int err_code,
>  
>  /**
>   *	kgdb_roundup_cpus - Get other CPUs into a holding pattern
> - *	@flags: Current IRQ state
>   *
>   *	On SMP systems, we need to get the attention of the other CPUs
>   *	and get them into a known state.  This should do what is needed
>   *	to get the other CPUs to call kgdb_wait(). Note that on some arches,
>   *	the NMI approach is not used for rounding up all the CPUs. For example,
> - *	in case of MIPS, smp_call_function() is used to roundup CPUs. In
> - *	this case, we have to make sure that interrupts are enabled before
> - *	calling smp_call_function(). The argument to this function is
> - *	the flags that will be used when restoring the interrupts. There is
> - *	local_irq_save() call before kgdb_roundup_cpus().
> + *	in case of MIPS, smp_call_function() is used to roundup CPUs.
>   *
>   *	On non-SMP systems, this is not called.
>   */
> -extern void kgdb_roundup_cpus(unsigned long flags);
> +extern void kgdb_roundup_cpus(void);
>  
>  /**
>   *	kgdb_arch_set_pc - Generic call back to the program counter
> diff --git a/kernel/debug/debug_core.c b/kernel/debug/debug_core.c
> index 65c0f1363788..f3cadda45f07 100644
> --- a/kernel/debug/debug_core.c
> +++ b/kernel/debug/debug_core.c
> @@ -593,7 +593,7 @@ static int kgdb_cpu_enter(struct kgdb_state *ks, struct pt_regs *regs,
>  
>  	/* Signal the other CPUs to enter kgdb_wait() */
>  	else if ((!kgdb_single_step) && kgdb_do_roundup)
> -		kgdb_roundup_cpus(flags);
> +		kgdb_roundup_cpus();
>  #endif
>  
>  	/*
> -- 
> 2.20.0.rc0.387.gc7a69e6b6c-goog
> 

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
