Return-Path: <SRS0=DN+v=OP=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.7 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_NEOMUTT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 98B23C04EB8
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Thu,  6 Dec 2018 14:07:42 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 66EBF20892
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Thu,  6 Dec 2018 14:07:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="pMbDuEPF";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="UmuU97v0"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 66EBF20892
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:
	Message-ID:Subject:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=cxJBexqJ+W+3qc6FPAZCzI3dpgLiGfo7sw5CdCHAIkQ=; b=pMbDuEPFjmQLZ4
	r1hyE7/8sVXY7a76LmuCqxC6PsaRTNay83benpndEYKGaE3v7UUpmqSK+al6oRC8HLouEGQRsF675
	9nDD8XpBRpTfK9am3gAxbHDza1BM7ioowUDf5acntfo4XDRyqLSPGc4nwfimj1IAu97oQcGmBnQC4
	hyg5KldQX5uh1tn1HKWS/Smm44KTb97e2L9b6zjthevwG/CDvqarTLKWL2rC9ng7YROeLvGXUZudM
	Yq+XBDBbDqDzTPn634qFXw09z2pWYPf8nOHXnVsexdpC5N6mJ39K6jMFqYGrcbIODO64aCc2EexKW
	YHgG5VMkNarEuaYvwBQA==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gUuJY-00078u-H4; Thu, 06 Dec 2018 14:07:40 +0000
Received: from mail-wm1-x341.google.com ([2a00:1450:4864:20::341])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gUuJR-00077a-2V
 for linux-arm-kernel@lists.infradead.org; Thu, 06 Dec 2018 14:07:38 +0000
Received: by mail-wm1-x341.google.com with SMTP id y139so1099809wmc.5
 for <linux-arm-kernel@lists.infradead.org>;
 Thu, 06 Dec 2018 06:07:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=date:from:to:cc:subject:message-id:references:mime-version
 :content-disposition:in-reply-to:user-agent;
 bh=mrLQohKt3Zd4tuJsYkErScQ9F7yT3CKumXJ2/9XoJ7E=;
 b=UmuU97v0dECMyw4EJIt9lW+d20XfcZXGQFmnW7vIWPnCOUf+sGziZH+3SB8t0Z99lG
 tj9b9a9Hcc5hWs4EDLZ0jJOdmNNGzmf6wkrC1O2uJwR9IOWsMu/V6uXaKm0nzfI5o+2N
 5NhRHBpZy8N763cn9zx9YNMXEdDgJKssT6tQg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to:user-agent;
 bh=mrLQohKt3Zd4tuJsYkErScQ9F7yT3CKumXJ2/9XoJ7E=;
 b=Z3maUewvAlVTTY2ljWOD5IGbyojl1ouQ7kMiNZdb/Xuger+3UnbWP59YJKJuRKXRn7
 39W+78s3jlE+lCl3xuEa0TYNjuzj1XxNaF0AzNny8bl2NxB5nek79iebqODAxpI50qsL
 QxCk9ZARCFMlMtLw+vBX+QJty6jKC3LuTJLkh7lZaiMiUnUYFZ3JpXmgwdIEUUcQksug
 jnoj98J/+8rm+gaNjcZnxYNR6HKtomhCAYIDhE7PIxkZMsaD49dl6deIm3ZEvOjHewY2
 P6gYpG4IMnWRkm2NqxAb67joOjKZz9ySeswfGTSrJQWjm3iWmZGi5mgbbKEK3TAx412u
 Fo+Q==
X-Gm-Message-State: AA+aEWauMWzrkP4cWNLWvnEDYhUTD8z/X+ObHuguh7c68wo7CRvAKAgE
 3fVYCkDvD3h3rlZjZWWVFJSXIw==
X-Google-Smtp-Source: AFSGD/VuBwY3hV6UF2pPBo1+kokfEApcL4yyEGJdnr2177AM/Ki8Dt+pW3gUt8MYRwavhA45czNNgg==
X-Received: by 2002:a1c:7306:: with SMTP id d6mr9347766wmb.98.1544105240991;
 Thu, 06 Dec 2018 06:07:20 -0800 (PST)
Received: from holly.lan (cpc141214-aztw34-2-0-cust773.18-1.cable.virginm.net.
 [86.9.19.6])
 by smtp.gmail.com with ESMTPSA id l15sm663737wrw.4.2018.12.06.06.07.18
 (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
 Thu, 06 Dec 2018 06:07:19 -0800 (PST)
Date: Thu, 6 Dec 2018 14:07:16 +0000
From: Daniel Thompson <daniel.thompson@linaro.org>
To: Christophe Leroy <christophe.leroy@c-s.fr>
Subject: Re: [PATCH 2/2] kgdb/treewide: constify struct kgdb_arch arch_kgdb_ops
Message-ID: <20181206140716.apapnpmdk3nrn7i3@holly.lan>
References: <75bbcdd1e9277d66ebb06e349dda304bd01ce761.1543957194.git.christophe.leroy@c-s.fr>
 <6b1a19ffa0da02cff9b82b866ba31d57478501ce.1543957194.git.christophe.leroy@c-s.fr>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <6b1a19ffa0da02cff9b82b866ba31d57478501ce.1543957194.git.christophe.leroy@c-s.fr>
User-Agent: NeoMutt/20180716
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20181206_060733_115077_48CB2A45 
X-CRM114-Status: GOOD (  21.33  )
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
Cc: Rich Felker <dalias@libc.org>,
 "Gustavo A. R. Silva" <gustavo@embeddedor.com>,
 Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 Will Deacon <will.deacon@arm.com>, linux-kernel@vger.kernel.org,
 Paul Mackerras <paulus@samba.org>, sparclinux@vger.kernel.org,
 linux-hexagon@vger.kernel.org, Yoshinori Sato <ysato@users.sourceforge.jp>,
 linux-sh@vger.kernel.org, Michael Ellerman <mpe@ellerman.id.au>,
 x86@kernel.org, Russell King <linux@armlinux.org.uk>,
 Ingo Molnar <mingo@redhat.com>, Catalin Marinas <catalin.marinas@arm.com>,
 James Hogan <jhogan@kernel.org>, linux-snps-arc@lists.infradead.org,
 uclinux-h8-devel@lists.sourceforge.jp, linux-mips@vger.kernel.org,
 Borislav Petkov <bp@alien8.de>, nios2-dev@lists.rocketboards.org,
 Thomas Gleixner <tglx@linutronix.de>, linux-arm-kernel@lists.infradead.org,
 Michal Simek <monstr@monstr.eu>, Vineet Gupta <vgupta@synopsys.com>,
 Randy Dunlap <rdunlap@infradead.org>, Douglas Anderson <dianders@chromium.org>,
 Ralf Baechle <ralf@linux-mips.org>, Richard Kuo <rkuo@codeaurora.org>,
 Paul Burton <paul.burton@mips.com>, Jason Wessel <jason.wessel@windriver.com>,
 kgdb-bugreport@lists.sourceforge.net, Ley Foon Tan <lftan@altera.com>,
 linuxppc-dev@lists.ozlabs.org, "David S. Miller" <davem@davemloft.net>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

On Wed, Dec 05, 2018 at 04:41:11AM +0000, Christophe Leroy wrote:
> checkpatch.pl reports the following:
> 
>   WARNING: struct kgdb_arch should normally be const
>   #28: FILE: arch/mips/kernel/kgdb.c:397:
>   +struct kgdb_arch arch_kgdb_ops = {
> 
> This report makes sense, as all other ops struct, this
> one should also be const. This patch does the change.
> 
> Signed-off-by: Christophe Leroy <christophe.leroy@c-s.fr>

Acked-by: Daniel Thompson <daniel.thompson@linaro.org>

Similar to https://patchwork.kernel.org/patch/10701129/ I would be more
comfortable to see a resend with the relevant arch maintainers
explicitly called out with a Cc: entry here.


> ---
>  arch/arc/kernel/kgdb.c        | 2 +-
>  arch/arm/kernel/kgdb.c        | 2 +-
>  arch/arm64/kernel/kgdb.c      | 2 +-
>  arch/h8300/kernel/kgdb.c      | 2 +-
>  arch/hexagon/kernel/kgdb.c    | 2 +-
>  arch/microblaze/kernel/kgdb.c | 2 +-
>  arch/mips/kernel/kgdb.c       | 2 +-
>  arch/nios2/kernel/kgdb.c      | 2 +-
>  arch/powerpc/kernel/kgdb.c    | 2 +-
>  arch/sh/kernel/kgdb.c         | 2 +-
>  arch/sparc/kernel/kgdb_32.c   | 2 +-
>  arch/sparc/kernel/kgdb_64.c   | 2 +-
>  arch/x86/kernel/kgdb.c        | 2 +-
>  include/linux/kgdb.h          | 2 +-
>  14 files changed, 14 insertions(+), 14 deletions(-)
> 
> diff --git a/arch/arc/kernel/kgdb.c b/arch/arc/kernel/kgdb.c
> index 9a3c34af2ae8..bfd04b442e36 100644
> --- a/arch/arc/kernel/kgdb.c
> +++ b/arch/arc/kernel/kgdb.c
> @@ -204,7 +204,7 @@ void kgdb_roundup_cpus(unsigned long flags)
>  	local_irq_disable();
>  }
>  
> -struct kgdb_arch arch_kgdb_ops = {
> +const struct kgdb_arch arch_kgdb_ops = {
>  	/* breakpoint instruction: TRAP_S 0x3 */
>  #ifdef CONFIG_CPU_BIG_ENDIAN
>  	.gdb_bpt_instr		= {0x78, 0x7e},
> diff --git a/arch/arm/kernel/kgdb.c b/arch/arm/kernel/kgdb.c
> index caa0dbe3dc61..21a6d5958955 100644
> --- a/arch/arm/kernel/kgdb.c
> +++ b/arch/arm/kernel/kgdb.c
> @@ -274,7 +274,7 @@ int kgdb_arch_remove_breakpoint(struct kgdb_bkpt *bpt)
>   * and we handle the normal undef case within the do_undefinstr
>   * handler.
>   */
> -struct kgdb_arch arch_kgdb_ops = {
> +const struct kgdb_arch arch_kgdb_ops = {
>  #ifndef __ARMEB__
>  	.gdb_bpt_instr		= {0xfe, 0xde, 0xff, 0xe7}
>  #else /* ! __ARMEB__ */
> diff --git a/arch/arm64/kernel/kgdb.c b/arch/arm64/kernel/kgdb.c
> index a20de58061a8..fe1d1f935b90 100644
> --- a/arch/arm64/kernel/kgdb.c
> +++ b/arch/arm64/kernel/kgdb.c
> @@ -357,7 +357,7 @@ void kgdb_arch_exit(void)
>  	unregister_die_notifier(&kgdb_notifier);
>  }
>  
> -struct kgdb_arch arch_kgdb_ops;
> +const struct kgdb_arch arch_kgdb_ops;
>  
>  int kgdb_arch_set_breakpoint(struct kgdb_bkpt *bpt)
>  {
> diff --git a/arch/h8300/kernel/kgdb.c b/arch/h8300/kernel/kgdb.c
> index 1a1d30cb0609..602e478afbd5 100644
> --- a/arch/h8300/kernel/kgdb.c
> +++ b/arch/h8300/kernel/kgdb.c
> @@ -129,7 +129,7 @@ void kgdb_arch_exit(void)
>  	/* Nothing to do */
>  }
>  
> -struct kgdb_arch arch_kgdb_ops = {
> +const struct kgdb_arch arch_kgdb_ops = {
>  	/* Breakpoint instruction: trapa #2 */
>  	.gdb_bpt_instr = { 0x57, 0x20 },
>  };
> diff --git a/arch/hexagon/kernel/kgdb.c b/arch/hexagon/kernel/kgdb.c
> index 16c24b22d0b2..f1924d483e78 100644
> --- a/arch/hexagon/kernel/kgdb.c
> +++ b/arch/hexagon/kernel/kgdb.c
> @@ -83,7 +83,7 @@ struct dbg_reg_def_t dbg_reg_def[DBG_MAX_REG_NUM] = {
>  	{ "syscall_nr", GDB_SIZEOF_REG, offsetof(struct pt_regs, syscall_nr)},
>  };
>  
> -struct kgdb_arch arch_kgdb_ops = {
> +const struct kgdb_arch arch_kgdb_ops = {
>  	/* trap0(#0xDB) 0x0cdb0054 */
>  	.gdb_bpt_instr = {0x54, 0x00, 0xdb, 0x0c},
>  };
> diff --git a/arch/microblaze/kernel/kgdb.c b/arch/microblaze/kernel/kgdb.c
> index 6366f69d118e..130cd0f064ce 100644
> --- a/arch/microblaze/kernel/kgdb.c
> +++ b/arch/microblaze/kernel/kgdb.c
> @@ -143,7 +143,7 @@ void kgdb_arch_exit(void)
>  /*
>   * Global data
>   */
> -struct kgdb_arch arch_kgdb_ops = {
> +const struct kgdb_arch arch_kgdb_ops = {
>  #ifdef __MICROBLAZEEL__
>  	.gdb_bpt_instr = {0x18, 0x00, 0x0c, 0xba}, /* brki r16, 0x18 */
>  #else
> diff --git a/arch/mips/kernel/kgdb.c b/arch/mips/kernel/kgdb.c
> index 31eff1bec577..edfdc2ec2d16 100644
> --- a/arch/mips/kernel/kgdb.c
> +++ b/arch/mips/kernel/kgdb.c
> @@ -394,7 +394,7 @@ int kgdb_arch_handle_exception(int vector, int signo, int err_code,
>  	return -1;
>  }
>  
> -struct kgdb_arch arch_kgdb_ops = {
> +const struct kgdb_arch arch_kgdb_ops = {
>  #ifdef CONFIG_CPU_BIG_ENDIAN
>  	.gdb_bpt_instr = { spec_op << 2, 0x00, 0x00, break_op },
>  #else
> diff --git a/arch/nios2/kernel/kgdb.c b/arch/nios2/kernel/kgdb.c
> index 117859122d1c..37b25f844a2d 100644
> --- a/arch/nios2/kernel/kgdb.c
> +++ b/arch/nios2/kernel/kgdb.c
> @@ -165,7 +165,7 @@ void kgdb_arch_exit(void)
>  	/* Nothing to do */
>  }
>  
> -struct kgdb_arch arch_kgdb_ops = {
> +const struct kgdb_arch arch_kgdb_ops = {
>  	/* Breakpoint instruction: trap 30 */
>  	.gdb_bpt_instr = { 0xba, 0x6f, 0x3b, 0x00 },
>  };
> diff --git a/arch/powerpc/kernel/kgdb.c b/arch/powerpc/kernel/kgdb.c
> index 59c578f865aa..bdb588b1d8fb 100644
> --- a/arch/powerpc/kernel/kgdb.c
> +++ b/arch/powerpc/kernel/kgdb.c
> @@ -477,7 +477,7 @@ int kgdb_arch_remove_breakpoint(struct kgdb_bkpt *bpt)
>  /*
>   * Global data
>   */
> -struct kgdb_arch arch_kgdb_ops;
> +const struct kgdb_arch arch_kgdb_ops;
>  
>  static int kgdb_not_implemented(struct pt_regs *regs)
>  {
> diff --git a/arch/sh/kernel/kgdb.c b/arch/sh/kernel/kgdb.c
> index 4f04c6638a4d..a24c48446e98 100644
> --- a/arch/sh/kernel/kgdb.c
> +++ b/arch/sh/kernel/kgdb.c
> @@ -382,7 +382,7 @@ void kgdb_arch_exit(void)
>  	unregister_die_notifier(&kgdb_notifier);
>  }
>  
> -struct kgdb_arch arch_kgdb_ops = {
> +const struct kgdb_arch arch_kgdb_ops = {
>  	/* Breakpoint instruction: trapa #0x3c */
>  #ifdef CONFIG_CPU_LITTLE_ENDIAN
>  	.gdb_bpt_instr		= { 0x3c, 0xc3 },
> diff --git a/arch/sparc/kernel/kgdb_32.c b/arch/sparc/kernel/kgdb_32.c
> index 639c8e54530a..7580775a14b9 100644
> --- a/arch/sparc/kernel/kgdb_32.c
> +++ b/arch/sparc/kernel/kgdb_32.c
> @@ -166,7 +166,7 @@ void kgdb_arch_set_pc(struct pt_regs *regs, unsigned long ip)
>  	regs->npc = regs->pc + 4;
>  }
>  
> -struct kgdb_arch arch_kgdb_ops = {
> +const struct kgdb_arch arch_kgdb_ops = {
>  	/* Breakpoint instruction: ta 0x7d */
>  	.gdb_bpt_instr		= { 0x91, 0xd0, 0x20, 0x7d },
>  };
> diff --git a/arch/sparc/kernel/kgdb_64.c b/arch/sparc/kernel/kgdb_64.c
> index a68bbddbdba4..5d6c2d287e85 100644
> --- a/arch/sparc/kernel/kgdb_64.c
> +++ b/arch/sparc/kernel/kgdb_64.c
> @@ -195,7 +195,7 @@ void kgdb_arch_set_pc(struct pt_regs *regs, unsigned long ip)
>  	regs->tnpc = regs->tpc + 4;
>  }
>  
> -struct kgdb_arch arch_kgdb_ops = {
> +const struct kgdb_arch arch_kgdb_ops = {
>  	/* Breakpoint instruction: ta 0x72 */
>  	.gdb_bpt_instr		= { 0x91, 0xd0, 0x20, 0x72 },
>  };
> diff --git a/arch/x86/kernel/kgdb.c b/arch/x86/kernel/kgdb.c
> index 8e36f249646e..e7effc02f13c 100644
> --- a/arch/x86/kernel/kgdb.c
> +++ b/arch/x86/kernel/kgdb.c
> @@ -804,7 +804,7 @@ int kgdb_arch_remove_breakpoint(struct kgdb_bkpt *bpt)
>  				  (char *)bpt->saved_instr, BREAK_INSTR_SIZE);
>  }
>  
> -struct kgdb_arch arch_kgdb_ops = {
> +const struct kgdb_arch arch_kgdb_ops = {
>  	/* Breakpoint instruction: */
>  	.gdb_bpt_instr		= { 0xcc },
>  	.flags			= KGDB_HW_BREAKPOINT,
> diff --git a/include/linux/kgdb.h b/include/linux/kgdb.h
> index e465bb15912d..3bf313311cca 100644
> --- a/include/linux/kgdb.h
> +++ b/include/linux/kgdb.h
> @@ -281,7 +281,7 @@ struct kgdb_io {
>  	int			is_console;
>  };
>  
> -extern struct kgdb_arch		arch_kgdb_ops;
> +extern const struct kgdb_arch		arch_kgdb_ops;
>  
>  extern unsigned long kgdb_arch_pc(int exception, struct pt_regs *regs);
>  
> -- 
> 2.13.3
> 

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
