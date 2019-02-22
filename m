Return-Path: <SRS0=2lwk=Q5=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ED05FC43381
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri, 22 Feb 2019 11:47:53 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id BB84C2081B
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri, 22 Feb 2019 11:47:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="cLoqNQjE"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BB84C2081B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:
	Message-ID:Subject:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=+CW4Bpswp9oFPNEn3tmSREuxXdkZImpkpUxb+XNfScU=; b=cLoqNQjEDvWo+r
	IhdKfFpeG0OVDBswHH32OrHgmzXEjwKqBPjIv5lYtLj286zUIKGNhlGvyBbfC2jqjKZqmOQj204eO
	X2npQiecrttLdfmKVW19/IdXLjLULSh4QFDLNCzHEOj5d5T26f7e9OnHfYeBZ+tPbDWsuwV48GpPy
	uMSwtf8UhS4QPcDwd3ZSXUbnxC80lJx7+D+86gSvj0McPRlmJop9zZH0Zc5CrsAqWG/mV6OS+NpMA
	coQU3AGKWb8p3ogQXD+couV1wkPx4Yei+xqF8SXnuKhRo4YNzF+iy8zH0Kq96XwTeco9RZjZUHOnV
	RPmqWzm+YGS9vEDp3znA==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gx9J0-0000JC-Si; Fri, 22 Feb 2019 11:47:50 +0000
Received: from usa-sjc-mx-foss1.foss.arm.com ([217.140.101.70]
 helo=foss.arm.com)
 by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gx9Ix-0000Hf-Vp
 for linux-arm-kernel@lists.infradead.org; Fri, 22 Feb 2019 11:47:49 +0000
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 6B5D2A78;
 Fri, 22 Feb 2019 03:47:47 -0800 (PST)
Received: from lakrids.cambridge.arm.com (usa-sjc-imap-foss1.foss.arm.com
 [10.72.51.249])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 7E4133F5C1;
 Fri, 22 Feb 2019 03:47:46 -0800 (PST)
Date: Fri, 22 Feb 2019 11:47:44 +0000
From: Mark Rutland <mark.rutland@arm.com>
To: Julien Thierry <julien.thierry@arm.com>
Subject: Re: [PATCH] arm64: Rename get_thread_info()
Message-ID: <20190222114743.GD42419@lakrids.cambridge.arm.com>
References: <1550827970-9355-1-git-send-email-julien.thierry@arm.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <1550827970-9355-1-git-send-email-julien.thierry@arm.com>
User-Agent: Mutt/1.11.1+11 (2f07cb52) (2018-12-01)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190222_034748_039288_57B9098B 
X-CRM114-Status: GOOD (  18.84  )
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
Cc: Catalin Marinas <catalin.marinas@arm.com>,
 Will Deacon <will.deacon@arm.com>, linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

On Fri, Feb 22, 2019 at 09:32:50AM +0000, Julien Thierry wrote:
> The assembly macro get_thread_info() actually returns a task_struct and is
> analogous to the current/get_current macro/function.
> 
> While it could be argued that thread_info sits at the start of
> task_struct and the intention could have been to return a thread_info,
> instances of loads from/stores to the address obtained from
> get_thread_info() use offsets that are generated with
> offsetof(struct task_struct, [...]).
> 
> Rename get_thread_info() to state it returns a task_struct.
> 
> Signed-off-by: Julien Thierry <julien.thierry@arm.com>
> Cc: Catalin Marinas <catalin.marinas@arm.com>
> Cc: Will Deacon <will.deacon@arm.com>

I should have done this along with the TI_* -> TSK_TI_* renaming. FWIW:

Acked-by: Mark Rutland <mark.rutland@arm.com>

Thanks,
Mark.

> ---
>  arch/arm64/include/asm/asm-uaccess.h | 2 +-
>  arch/arm64/include/asm/assembler.h   | 6 +++---
>  arch/arm64/kernel/entry.S            | 4 ++--
>  3 files changed, 6 insertions(+), 6 deletions(-)
> 
> diff --git a/arch/arm64/include/asm/asm-uaccess.h b/arch/arm64/include/asm/asm-uaccess.h
> index 4128bec..f74909b 100644
> --- a/arch/arm64/include/asm/asm-uaccess.h
> +++ b/arch/arm64/include/asm/asm-uaccess.h
> @@ -24,7 +24,7 @@
>  	.endm
> 
>  	.macro	__uaccess_ttbr0_enable, tmp1, tmp2
> -	get_thread_info \tmp1
> +	get_current_task \tmp1
>  	ldr	\tmp1, [\tmp1, #TSK_TI_TTBR0]	// load saved TTBR0_EL1
>  	mrs	\tmp2, ttbr1_el1
>  	extr    \tmp2, \tmp2, \tmp1, #48
> diff --git a/arch/arm64/include/asm/assembler.h b/arch/arm64/include/asm/assembler.h
> index 7acf243..9c5c876 100644
> --- a/arch/arm64/include/asm/assembler.h
> +++ b/arch/arm64/include/asm/assembler.h
> @@ -528,9 +528,9 @@
>  	.endm
> 
>  /*
> - * Return the current thread_info.
> + * Return the current task_struct.
>   */
> -	.macro	get_thread_info, rd
> +	.macro	get_current_task, rd
>  	mrs	\rd, sp_el0
>  	.endm
> 
> @@ -713,7 +713,7 @@
> 
>  	.macro		if_will_cond_yield_neon
>  #ifdef CONFIG_PREEMPT
> -	get_thread_info	x0
> +	get_current_task	x0
>  	ldr		x0, [x0, #TSK_TI_PREEMPT]
>  	sub		x0, x0, #PREEMPT_DISABLE_OFFSET
>  	cbz		x0, .Lyield_\@
> diff --git a/arch/arm64/kernel/entry.S b/arch/arm64/kernel/entry.S
> index 6bf7e12..c50a7a7 100644
> --- a/arch/arm64/kernel/entry.S
> +++ b/arch/arm64/kernel/entry.S
> @@ -185,7 +185,7 @@ alternative_cb_end
> 
>  	.else
>  	add	x21, sp, #S_FRAME_SIZE
> -	get_thread_info tsk
> +	get_current_task tsk
>  	/* Save the task's original addr_limit and set USER_DS */
>  	ldr	x20, [tsk, #TSK_TI_ADDR_LIMIT]
>  	str	x20, [sp, #S_ORIG_ADDR_LIMIT]
> @@ -1104,7 +1104,7 @@ ENTRY(ret_from_fork)
>  	cbz	x19, 1f				// not a kernel thread
>  	mov	x0, x20
>  	blr	x19
> -1:	get_thread_info tsk
> +1:	get_current_task tsk
>  	b	ret_to_user
>  ENDPROC(ret_from_fork)
>  NOKPROBE(ret_from_fork)
> --
> 1.9.1

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
