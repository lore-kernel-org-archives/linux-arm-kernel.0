Return-Path: <SRS0=Ql45=PY=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A78F9C43387
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Wed, 16 Jan 2019 15:13:21 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 640AE205C9
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Wed, 16 Jan 2019 15:13:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="FIjvZXL6"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 640AE205C9
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:
	Message-ID:Subject:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=LtRmoLT3SIiY8wpza+WPDQ/OGXvP0/9T0FeM1V+1vPA=; b=FIjvZXL6w89U8a
	Q6+NbpiOEo3nt8Kq0fws6nx0RWSyMAlN4lIkkAZJRUGgEYgnNQ9yauDymk7XhlGyha3MzBfSb28w7
	pimdm2v4fvzq3NacUS+snuquRtVRdHG1VpFI0OzGL/LG2Jm0itl4HxlX8PcrEc6avmPwnpuX3tEah
	jrLf5g8AKwi1n4BOont81XmRjCWLp7y6spXP0UUPIj3hYI496K3aOyU+avHhn4sApPwpJOzjtU9we
	LwdRGQPD8t9pN3Doa38CP/aClero3Q1wGXYuLHg1qEFFz9VT5PUJRzgLadkZr3Jz4xi3DT2rjt8y9
	hZ7gdKIN0zQ8iPzJvXsw==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gjmsW-00019f-C6; Wed, 16 Jan 2019 15:13:16 +0000
Received: from usa-sjc-mx-foss1.foss.arm.com ([217.140.101.70]
 helo=foss.arm.com)
 by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gjmsS-000198-Rt
 for linux-arm-kernel@lists.infradead.org; Wed, 16 Jan 2019 15:13:14 +0000
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id EE43580D;
 Wed, 16 Jan 2019 07:13:09 -0800 (PST)
Received: from e103592.cambridge.arm.com (usa-sjc-imap-foss1.foss.arm.com
 [10.72.51.249])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id B9B5C3F5C1;
 Wed, 16 Jan 2019 07:13:08 -0800 (PST)
Date: Wed, 16 Jan 2019 15:13:03 +0000
From: Dave Martin <Dave.Martin@arm.com>
To: Kristina Martsenko <kristina.martsenko@arm.com>
Subject: Re: [PATCH v2] arm64: add ptrace regsets for ptrauth key management
Message-ID: <20190116151254.GA3578@e103592.cambridge.arm.com>
References: <20190110193508.31888-1-kristina.martsenko@arm.com>
 <d2bcfb3a-3668-693c-2fd4-3814b473375c@arm.com>
 <20190111135842.GB3547@e103592.cambridge.arm.com>
 <911e27a9-d199-9a64-8a2e-597733af5854@arm.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <911e27a9-d199-9a64-8a2e-597733af5854@arm.com>
User-Agent: Mutt/1.5.23 (2014-03-12)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190116_071312_913803_5F973606 
X-CRM114-Status: GOOD (  44.40  )
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
 Catalin Marinas <catalin.marinas@arm.com>, Amit Kachhap <amit.kachhap@arm.com>,
 Will Deacon <will.deacon@arm.com>, linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

On Tue, Jan 15, 2019 at 07:32:30PM +0000, Kristina Martsenko wrote:
> On 11/01/2019 13:58, Dave Martin wrote:
> > On Thu, Jan 10, 2019 at 07:41:15PM +0000, Kristina Martsenko wrote:
> >> On 10/01/2019 19:35, Kristina Martsenko wrote:
> >>> Add two new ptrace regsets, which can be used to request and change the
> >>> pointer authentication keys of a thread. NT_ARM_PACA_KEYS gives access
> >>> to the instruction/data address keys, and NT_ARM_PACG_KEYS to the
> >>> generic authentication key. The keys are also part of the core dump file
> >>> of the process.
> >>>
> >>> The regsets are only exposed if the kernel is compiled with
> >>> CONFIG_CHECKPOINT_RESTORE=y, as the intended use case is checkpointing
> >>> and restoring processes that are using pointer authentication. Normally
> >>> applications or debuggers should not need to know the keys (and exposing
> >>> the keys is a security risk), so the regsets are not exposed by default.
> > 
> > Although we can live with this, I still think it gives a false sense of
> > safety.
> > 
> > Can we come up with an scenario where an attacker with ptrace or
> > coredump access can do more damage with access to the pointer auth keys
> > than without?
> > 
> > A lot of systems will run with CONFIG_CHECKPOINT_RESTORE=y (like
> > packaged Debian kernels for example).  And more paranoid systems already
> > restrict or disable ptrace anyway.
> 
> I can't think of such a scenario, as ptrace gives access to registers
> and memory anyway. But I probably haven't thought of all scenarios.
> 
> There are other ptrace options that are only available when
> CONFIG_CHECKPOINT_RESTORE=y, such as PTRACE_SECCOMP_GET_FILTER.
> 
> I think Will had a preference for having this depend on
> CONFIG_CHECKPOINT_RESTORE, so I will keep it for now.

OK, this is up to the maintainers to judge.  The code works either way,
and I'm not too fussed.

My main concern is that legitimate potential debug uses such as
analysing coredumps or running tasks to detect stack corruption may now
fail to work on a random subset of systems.  But that's hypothetical:
I'm not aware that anyone is actually asking for this ability right now.

We could relax the rules later on though, if people really want this.

> 
> >>  #define __ptrauth_key_install(k, v)				\
> >>  do {								\
> >> -	struct ptrauth_key __pki_v = (v);			\
> >> -	write_sysreg_s(__pki_v.lo, SYS_ ## k ## KEYLO_EL1);	\
> >> -	write_sysreg_s(__pki_v.hi, SYS_ ## k ## KEYHI_EL1);	\
> >> +	write_sysreg_s(v ## _lo, SYS_ ## k ## KEYLO_EL1);	\
> >> +	write_sysreg_s(v ## _hi, SYS_ ## k ## KEYHI_EL1);	\
> >>  } while (0)
> >>  
> >>  static inline void ptrauth_keys_switch(struct ptrauth_keys *keys)
> >>  {
> >>  	if (system_supports_address_auth()) {
> >> -		__ptrauth_key_install(APIA, keys->apia);
> >> -		__ptrauth_key_install(APIB, keys->apib);
> >> -		__ptrauth_key_install(APDA, keys->apda);
> >> -		__ptrauth_key_install(APDB, keys->apdb);
> >> +		__ptrauth_key_install(APIA, keys->addr_keys.apiakey);
> >> +		__ptrauth_key_install(APIB, keys->addr_keys.apibkey);
> >> +		__ptrauth_key_install(APDA, keys->addr_keys.apdakey);
> >> +		__ptrauth_key_install(APDB, keys->addr_keys.apdbkey);
> > 
> > Aren't the members of struct user_pac_address_keys split up into
> > apiakey_lo, apiakey_hi etc.?
> 
> They are, which is why the __ptrauth_key_install macro pastes a "_lo" or
> "_hi" at the end of the field name. I don't think this is very nice,
> which is one of the reasons why I prefer the other patch (where we keep
> the kernel and ptrace structs separate).

Ah, I got confused by the fact that __ptrauth_key_install() is a macro.

Fair enough.

> > However, I think there's no reason not to pair up the keys in nested
> > structs in the user struct, so could we change that struct to be more
> > like the old struct ptrauth_key and keep the above code?
> 
> We don't currently have any other separate nested structs in the arm64
> ptrace userspace interface. Other architectures also seem to only have a
> few rare instances of this.
> 
> It seems odd to complicate the userspace interface because of a kernel
> implementation detail, but if you think it's better I could change the
> structs to:
> 
> struct user_pac_key {
> 	__u64		lo;
> 	__u64		hi;
> };
> 
> struct user_pac_address_keys {
> 	struct user_pac_key	apiakey;
> 	struct user_pac_key	apibkey;
> 	struct user_pac_key	apdakey;
> 	struct user_pac_key	apdbkey;
> };
> 
> struct user_pac_generic_keys {
> 	struct user_pac_key	apgakey;
> };

I don't have a strong opinion really.

There's another option that occurred to me just now, and that's simply
to represent each key as a single __uint128_t in the user regset view
(with the _hi half strictly in the high 64 bits).

This avoids questions about how to represent the halves of the key,
and prevents userspace from accessing half-keys.  How the half-keys
map to system registers is an architectural quirk that userspace perhaps
need not care about.

If you like that approach, you could keep the kernel code as-is for now
and just do the conversion explicitly in the ptrace accessors (as in
your original patch).

> >>  	}
> >>  
> >>  	if (system_supports_generic_auth())
> >> -		__ptrauth_key_install(APGA, keys->apga);
> >> +		__ptrauth_key_install(APGA, keys->gen_keys.apgakey);
> >>  }
> >>  
> >>  extern int ptrauth_prctl_reset_keys(struct task_struct *tsk, unsigned long arg);
> >> @@ -80,12 +65,12 @@ static inline unsigned long ptrauth_strip_insn_pac(unsigned long ptr)
> >>  #define ptrauth_thread_init_user(tsk)					\
> >>  do {									\
> >>  	struct task_struct *__ptiu_tsk = (tsk);				\
> > 
> > Not added by this patch, but __ptiu_tsk doesn't seem to do anything
> > except make the subsquent lines more verbose than otherwise (and pollute
> > the identifier namespace -- though unlikely to be a problem).
> > 
> > It may not be worth dropping it now that it's there though.
> 
> Using __ptiu_tsk prevents the argument (tsk) from being evaluated twice,
> which could have side effects.

Ah, right.

Actually, could this be a function instead?  That would avoid multiple-
evaulation a clean way.

> 
> >> -	ptrauth_keys_init(&__ptiu_tsk->thread.keys_user);		\
> >> -	ptrauth_keys_switch(&__ptiu_tsk->thread.keys_user);		\
> >> +	ptrauth_keys_init(&__ptiu_tsk->thread.uw.keys_user);		\
> >> +	ptrauth_keys_switch(&__ptiu_tsk->thread.uw.keys_user);		\
> >>  } while (0)
> >>  
> >>  #define ptrauth_thread_switch(tsk)	\
> >> -	ptrauth_keys_switch(&(tsk)->thread.keys_user)
> >> +	ptrauth_keys_switch(&(tsk)->thread.uw.keys_user)

Similarly, can this be a function?

(Technically tsk may be evaulated twice in this macro.  Given the way
these macros are used, I'm not sure that matters though.)

> >> --- a/arch/arm64/include/uapi/asm/ptrace.h
> >> +++ b/arch/arm64/include/uapi/asm/ptrace.h
> >> @@ -233,6 +233,24 @@ struct user_pac_mask {
> >>  	__u64		insn_mask;
> >>  };
> >>  
> >> +/* pointer authentication keys (NT_ARM_PACA_KEYS, NT_ARM_PACG_KEYS) */
> >> +
> >> +struct user_pac_address_keys {
> >> +	__u64		apiakey_lo;
> >> +	__u64		apiakey_hi;
> >> +	__u64		apibkey_lo;
> >> +	__u64		apibkey_hi;
> >> +	__u64		apdakey_lo;
> >> +	__u64		apdakey_hi;
> >> +	__u64		apdbkey_lo;
> >> +	__u64		apdbkey_hi;
> >> +};
> >> +
> >> +struct user_pac_generic_keys {
> >> +	__u64		apgakey_lo;
> >> +	__u64		apgakey_hi;
> >> +};
> >> +
> > 
> > As noted above, I think we could happily have a struct user_pac_key to
> > pack up the halves of each key, like the old kernel struct.
> 
> See my answer above.
> 
> Also note that with this patch we have struct "user_pac_address_keys" in
> struct ptrauth_keys, which may be confusing once we start using pointer
> authentication in the kernel and use struct ptrauth_keys for kernel keys
> as well, not just user keys.

Not a big deal either way.

The main thing to freeze now are the user ABI and the UAPI header.  We
can refactor the kernel's internal implementation later if we want.

> 
> >> @@ -1074,6 +1132,24 @@ static const struct user_regset aarch64_regsets[] = {
> >>  		.get = pac_mask_get,
> >>  		/* this cannot be set dynamically */
> >>  	},
> >> +#ifdef CONFIG_CHECKPOINT_RESTORE
> > 
> > && defined(CONFIG_ARM64_PTR_AUTH) ?
> 
> No, this is already inside a larger "#ifdef CONFIG_ARM64_PTR_AUTH" block.

Oh, right.  That starts outside the hunks in the diff, so I missed
it.

> 
> >> +	[REGSET_PACA_KEYS] = {
> >> +		.core_note_type = NT_ARM_PACA_KEYS,
> >> +		.n = sizeof(struct user_pac_address_keys) / sizeof(u64),
> >> +		.size = sizeof(u64),
> >> +		.align = sizeof(u64),
> >> +		.get = pac_address_keys_get,
> >> +		.set = pac_address_keys_set,
> >> +	},
> >> +	[REGSET_PACG_KEYS] = {
> >> +		.core_note_type = NT_ARM_PACG_KEYS,
> >> +		.n = sizeof(struct user_pac_generic_keys) / sizeof(u64),
> >> +		.size = sizeof(u64),
> >> +		.align = sizeof(u64),
> >> +		.get = pac_generic_keys_get,
> >> +		.set = pac_generic_keys_set,
> >> +	},
> >> +#endif
> >>  #endif

Adding a comment on the second #endif to say which #if is ending here
may be useful, but it's no big deal.

Cheers
---Dave

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
