Return-Path: <SRS0=KsRD=PT=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 18CD4C43387
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri, 11 Jan 2019 13:58:56 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id DDD6E214D8
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri, 11 Jan 2019 13:58:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="KsvHwY0a"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DDD6E214D8
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:
	Message-ID:Subject:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=rmjk2zPKK0TsUxU1cCBHWjRCgWI998JZtk78bm2IeZk=; b=KsvHwY0aWFR4n4
	8hScZVIyecbh61j+4uKj3jnbX2aveFW8Hnb8u6yFNIUP+rcRQulG/zb1Gx8vEYArMyCi3DkjSyqmN
	BYraq8apDfKOHedUyd76sWULzILWU7pKHIYx4OT7tRIcrOjLJ6IO+lWAal/ovILPnmN9a3YpapuDW
	ruZ9nbxfZpun5Kil42PUricy1yRCtJJXNjNAM5rDULHOrU5RNEpCMcnNsIqVD2Ot5tEFLw6dpFpKD
	rTYhyDbdtbqgRXfHDzQfaXU9MhSwDI2r9jSrCA56u1GW/9aGEOruaE1VHXQyG8ifCoMC3G9kYNYiB
	RVPUvNKigtq83zVWK9mA==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1ghxKn-0002Gz-K1; Fri, 11 Jan 2019 13:58:53 +0000
Received: from usa-sjc-mx-foss1.foss.arm.com ([217.140.101.70]
 helo=foss.arm.com)
 by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
 id 1ghxKj-0002GY-8u
 for linux-arm-kernel@lists.infradead.org; Fri, 11 Jan 2019 13:58:51 +0000
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 93426EBD;
 Fri, 11 Jan 2019 05:58:46 -0800 (PST)
Received: from e103592.cambridge.arm.com (usa-sjc-imap-foss1.foss.arm.com
 [10.72.51.249])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 5F0FA3F6CF;
 Fri, 11 Jan 2019 05:58:45 -0800 (PST)
Date: Fri, 11 Jan 2019 13:58:42 +0000
From: Dave Martin <Dave.Martin@arm.com>
To: Kristina Martsenko <kristina.martsenko@arm.com>
Subject: Re: [PATCH v2] arm64: add ptrace regsets for ptrauth key management
Message-ID: <20190111135842.GB3547@e103592.cambridge.arm.com>
References: <20190110193508.31888-1-kristina.martsenko@arm.com>
 <d2bcfb3a-3668-693c-2fd4-3814b473375c@arm.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <d2bcfb3a-3668-693c-2fd4-3814b473375c@arm.com>
User-Agent: Mutt/1.5.23 (2014-03-12)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190111_055849_327453_86BD8945 
X-CRM114-Status: GOOD (  40.35  )
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

On Thu, Jan 10, 2019 at 07:41:15PM +0000, Kristina Martsenko wrote:
> On 10/01/2019 19:35, Kristina Martsenko wrote:
> > Add two new ptrace regsets, which can be used to request and change the
> > pointer authentication keys of a thread. NT_ARM_PACA_KEYS gives access
> > to the instruction/data address keys, and NT_ARM_PACG_KEYS to the
> > generic authentication key. The keys are also part of the core dump file
> > of the process.
> > 
> > The regsets are only exposed if the kernel is compiled with
> > CONFIG_CHECKPOINT_RESTORE=y, as the intended use case is checkpointing
> > and restoring processes that are using pointer authentication. Normally
> > applications or debuggers should not need to know the keys (and exposing
> > the keys is a security risk), so the regsets are not exposed by default.

Although we can live with this, I still think it gives a false sense of
safety.

Can we come up with an scenario where an attacker with ptrace or
coredump access can do more damage with access to the pointer auth keys
than without?

A lot of systems will run with CONFIG_CHECKPOINT_RESTORE=y (like
packaged Debian kernels for example).  And more paranoid systems already
restrict or disable ptrace anyway.

> > 
> > Signed-off-by: Kristina Martsenko <kristina.martsenko@arm.com>
> > ---
> > 
> > The previous version of this patch was:
> >   https://lore.kernel.org/lkml/20181207183931.4285-12-kristina.martsenko@arm.com/
> > 
> > Changes in v2:
> >  - Convert each field individually between ptrauth_keys and
> >    user_pac_address_keys/user_pac_generic_keys
> 
> For comparison, this is what the patch might look like if we instead
> used struct user_pac_address_keys/user_pac_generic_keys in both ptrace
> and the kernel:
> 
> -- >8 --
> Subject: [PATCH] arm64: add ptrace regsets for ptrauth key management
> 
> Add two new ptrace regsets, which can be used to request and change the
> pointer authentication keys of a thread. NT_ARM_PACA_KEYS gives access
> to the instruction/data address keys, and NT_ARM_PACG_KEYS to the
> generic authentication key. The keys are also part of the core dump file
> of the process.
> 
> The regsets are only exposed if the kernel is compiled with
> CONFIG_CHECKPOINT_RESTORE=y, as the intended use case is checkpointing
> and restoring processes that are using pointer authentication. Normally
> applications or debuggers should not need to know the keys (and exposing
> the keys is a security risk), so the regsets are not exposed by default.
> 
> Signed-off-by: Kristina Martsenko <kristina.martsenko@arm.com>
> ---
>  Documentation/arm64/pointer-authentication.txt |  5 ++
>  arch/arm64/include/asm/pointer_auth.h          | 47 ++++++----------
>  arch/arm64/include/asm/processor.h             |  9 ++-
>  arch/arm64/include/uapi/asm/ptrace.h           | 18 ++++++
>  arch/arm64/kernel/pointer_auth.c               | 19 +++++--
>  arch/arm64/kernel/ptrace.c                     | 76 ++++++++++++++++++++++++++
>  include/uapi/linux/elf.h                       |  2 +
>  7 files changed, 136 insertions(+), 40 deletions(-)
> 
> diff --git a/Documentation/arm64/pointer-authentication.txt b/Documentation/arm64/pointer-authentication.txt
> index a25cd21290e9..5baca42ba146 100644
> --- a/Documentation/arm64/pointer-authentication.txt
> +++ b/Documentation/arm64/pointer-authentication.txt
> @@ -78,6 +78,11 @@ bits can vary between the two. Note that the masks apply to TTBR0
>  addresses, and are not valid to apply to TTBR1 addresses (e.g. kernel
>  pointers).
>  
> +Additionally, when CONFIG_CHECKPOINT_RESTORE is also set, the kernel
> +will expose the NT_ARM_PACA_KEYS and NT_ARM_PACG_KEYS regsets (struct
> +user_pac_address_keys and struct user_pac_generic_keys). These can be
> +used to get and set the keys for a thread.
> +
>  
>  Virtualization
>  --------------
> diff --git a/arch/arm64/include/asm/pointer_auth.h b/arch/arm64/include/asm/pointer_auth.h
> index 15d49515efdd..2fde45d0e24f 100644
> --- a/arch/arm64/include/asm/pointer_auth.h
> +++ b/arch/arm64/include/asm/pointer_auth.h
> @@ -7,60 +7,45 @@
>  
>  #include <asm/cpufeature.h>
>  #include <asm/memory.h>
> +#include <asm/ptrace.h>
>  #include <asm/sysreg.h>
>  
>  #ifdef CONFIG_ARM64_PTR_AUTH
>  /*
> - * Each key is a 128-bit quantity which is split across a pair of 64-bit
> - * registers (Lo and Hi).
> - */
> -struct ptrauth_key {
> -	unsigned long lo, hi;
> -};
> -
> -/*
>   * We give each process its own keys, which are shared by all threads. The keys
>   * are inherited upon fork(), and reinitialised upon exec*().
>   */
>  struct ptrauth_keys {
> -	struct ptrauth_key apia;
> -	struct ptrauth_key apib;
> -	struct ptrauth_key apda;
> -	struct ptrauth_key apdb;
> -	struct ptrauth_key apga;
> +	struct user_pac_address_keys addr_keys;
> +	struct user_pac_generic_keys gen_keys;
>  };
>  
>  static inline void ptrauth_keys_init(struct ptrauth_keys *keys)
>  {
> -	if (system_supports_address_auth()) {
> -		get_random_bytes(&keys->apia, sizeof(keys->apia));
> -		get_random_bytes(&keys->apib, sizeof(keys->apib));
> -		get_random_bytes(&keys->apda, sizeof(keys->apda));
> -		get_random_bytes(&keys->apdb, sizeof(keys->apdb));
> -	}
> +	if (system_supports_address_auth())
> +		get_random_bytes(&keys->addr_keys, sizeof(keys->addr_keys));
>  
>  	if (system_supports_generic_auth())
> -		get_random_bytes(&keys->apga, sizeof(keys->apga));
> +		get_random_bytes(&keys->gen_keys, sizeof(keys->gen_keys));
>  }
>  
>  #define __ptrauth_key_install(k, v)				\
>  do {								\
> -	struct ptrauth_key __pki_v = (v);			\
> -	write_sysreg_s(__pki_v.lo, SYS_ ## k ## KEYLO_EL1);	\
> -	write_sysreg_s(__pki_v.hi, SYS_ ## k ## KEYHI_EL1);	\
> +	write_sysreg_s(v ## _lo, SYS_ ## k ## KEYLO_EL1);	\
> +	write_sysreg_s(v ## _hi, SYS_ ## k ## KEYHI_EL1);	\
>  } while (0)
>  
>  static inline void ptrauth_keys_switch(struct ptrauth_keys *keys)
>  {
>  	if (system_supports_address_auth()) {
> -		__ptrauth_key_install(APIA, keys->apia);
> -		__ptrauth_key_install(APIB, keys->apib);
> -		__ptrauth_key_install(APDA, keys->apda);
> -		__ptrauth_key_install(APDB, keys->apdb);
> +		__ptrauth_key_install(APIA, keys->addr_keys.apiakey);
> +		__ptrauth_key_install(APIB, keys->addr_keys.apibkey);
> +		__ptrauth_key_install(APDA, keys->addr_keys.apdakey);
> +		__ptrauth_key_install(APDB, keys->addr_keys.apdbkey);

Aren't the members of struct user_pac_address_keys split up into
apiakey_lo, apiakey_hi etc.?

However, I think there's no reason not to pair up the keys in nested
structs in the user struct, so could we change that struct to be more
like the old struct ptrauth_key and keep the above code?

>  	}
>  
>  	if (system_supports_generic_auth())
> -		__ptrauth_key_install(APGA, keys->apga);
> +		__ptrauth_key_install(APGA, keys->gen_keys.apgakey);
>  }
>  
>  extern int ptrauth_prctl_reset_keys(struct task_struct *tsk, unsigned long arg);
> @@ -80,12 +65,12 @@ static inline unsigned long ptrauth_strip_insn_pac(unsigned long ptr)
>  #define ptrauth_thread_init_user(tsk)					\
>  do {									\
>  	struct task_struct *__ptiu_tsk = (tsk);				\

Not added by this patch, but __ptiu_tsk doesn't seem to do anything
except make the subsquent lines more verbose than otherwise (and pollute
the identifier namespace -- though unlikely to be a problem).

It may not be worth dropping it now that it's there though.

> -	ptrauth_keys_init(&__ptiu_tsk->thread.keys_user);		\
> -	ptrauth_keys_switch(&__ptiu_tsk->thread.keys_user);		\
> +	ptrauth_keys_init(&__ptiu_tsk->thread.uw.keys_user);		\
> +	ptrauth_keys_switch(&__ptiu_tsk->thread.uw.keys_user);		\
>  } while (0)
>  
>  #define ptrauth_thread_switch(tsk)	\
> -	ptrauth_keys_switch(&(tsk)->thread.keys_user)
> +	ptrauth_keys_switch(&(tsk)->thread.uw.keys_user)
>  
>  #else /* CONFIG_ARM64_PTR_AUTH */
>  #define ptrauth_prctl_reset_keys(tsk, arg)	(-EINVAL)
> diff --git a/arch/arm64/include/asm/processor.h b/arch/arm64/include/asm/processor.h
> index f1a7ab18faf3..f1d41bac9a23 100644
> --- a/arch/arm64/include/asm/processor.h
> +++ b/arch/arm64/include/asm/processor.h
> @@ -137,6 +137,9 @@ struct thread_struct {
>  	struct {
>  		unsigned long	tp_value;	/* TLS register */
>  		unsigned long	tp2_value;
> +#ifdef CONFIG_ARM64_PTR_AUTH
> +		struct ptrauth_keys keys_user;
> +#endif
>  		struct user_fpsimd_state fpsimd_state;
>  	} uw;
>  
> @@ -147,9 +150,6 @@ struct thread_struct {
>  	unsigned long		fault_address;	/* fault info */
>  	unsigned long		fault_code;	/* ESR_EL1 value */
>  	struct debug_info	debug;		/* debugging */
> -#ifdef CONFIG_ARM64_PTR_AUTH
> -	struct ptrauth_keys	keys_user;
> -#endif
>  };
>  
>  static inline void arch_thread_struct_whitelist(unsigned long *offset,
> @@ -159,6 +159,9 @@ static inline void arch_thread_struct_whitelist(unsigned long *offset,
>  	BUILD_BUG_ON(sizeof_field(struct thread_struct, uw) !=
>  		     sizeof_field(struct thread_struct, uw.tp_value) +
>  		     sizeof_field(struct thread_struct, uw.tp2_value) +
> +#ifdef CONFIG_ARM64_PTR_AUTH
> +		     sizeof_field(struct thread_struct, uw.keys_user) +
> +#endif
>  		     sizeof_field(struct thread_struct, uw.fpsimd_state));
>  
>  	*offset = offsetof(struct thread_struct, uw);
> diff --git a/arch/arm64/include/uapi/asm/ptrace.h b/arch/arm64/include/uapi/asm/ptrace.h
> index 28d77c9ed531..0affa43602a5 100644
> --- a/arch/arm64/include/uapi/asm/ptrace.h
> +++ b/arch/arm64/include/uapi/asm/ptrace.h
> @@ -233,6 +233,24 @@ struct user_pac_mask {
>  	__u64		insn_mask;
>  };
>  
> +/* pointer authentication keys (NT_ARM_PACA_KEYS, NT_ARM_PACG_KEYS) */
> +
> +struct user_pac_address_keys {
> +	__u64		apiakey_lo;
> +	__u64		apiakey_hi;
> +	__u64		apibkey_lo;
> +	__u64		apibkey_hi;
> +	__u64		apdakey_lo;
> +	__u64		apdakey_hi;
> +	__u64		apdbkey_lo;
> +	__u64		apdbkey_hi;
> +};
> +
> +struct user_pac_generic_keys {
> +	__u64		apgakey_lo;
> +	__u64		apgakey_hi;
> +};
> +

As noted above, I think we could happily have a struct user_pac_key to
pack up the halves of each key, like the old kernel struct.

>  #endif /* __ASSEMBLY__ */
>  
>  #endif /* _UAPI__ASM_PTRACE_H */
> diff --git a/arch/arm64/kernel/pointer_auth.c b/arch/arm64/kernel/pointer_auth.c
> index c507b584259d..3fd90ec5efb2 100644
> --- a/arch/arm64/kernel/pointer_auth.c
> +++ b/arch/arm64/kernel/pointer_auth.c
> @@ -7,9 +7,16 @@
>  #include <asm/cpufeature.h>
>  #include <asm/pointer_auth.h>
>  
> +
> +#define ptrauth_reset_key(key)					\
> +do {								\
> +	get_random_bytes(&key ## _lo, sizeof(key ## _lo));	\
> +	get_random_bytes(&key ## _hi, sizeof(key ## _hi));	\
> +} while (0)
> +
>  int ptrauth_prctl_reset_keys(struct task_struct *tsk, unsigned long arg)
>  {
> -	struct ptrauth_keys *keys = &tsk->thread.keys_user;
> +	struct ptrauth_keys *keys = &tsk->thread.uw.keys_user;
>  	unsigned long addr_key_mask = PR_PAC_APIAKEY | PR_PAC_APIBKEY |
>  				      PR_PAC_APDAKEY | PR_PAC_APDBKEY;
>  	unsigned long key_mask = addr_key_mask | PR_PAC_APGAKEY;
> @@ -31,15 +38,15 @@ int ptrauth_prctl_reset_keys(struct task_struct *tsk, unsigned long arg)
>  		return -EINVAL;
>  
>  	if (arg & PR_PAC_APIAKEY)
> -		get_random_bytes(&keys->apia, sizeof(keys->apia));
> +		ptrauth_reset_key(keys->addr_keys.apiakey);
>  	if (arg & PR_PAC_APIBKEY)
> -		get_random_bytes(&keys->apib, sizeof(keys->apib));
> +		ptrauth_reset_key(keys->addr_keys.apibkey);
>  	if (arg & PR_PAC_APDAKEY)
> -		get_random_bytes(&keys->apda, sizeof(keys->apda));
> +		ptrauth_reset_key(keys->addr_keys.apdakey);
>  	if (arg & PR_PAC_APDBKEY)
> -		get_random_bytes(&keys->apdb, sizeof(keys->apdb));
> +		ptrauth_reset_key(keys->addr_keys.apdbkey);
>  	if (arg & PR_PAC_APGAKEY)
> -		get_random_bytes(&keys->apga, sizeof(keys->apga));
> +		ptrauth_reset_key(keys->gen_keys.apgakey);
>  
>  	ptrauth_keys_switch(keys);
>  
> diff --git a/arch/arm64/kernel/ptrace.c b/arch/arm64/kernel/ptrace.c
> index 9dce33b0e260..cd537bd669e7 100644
> --- a/arch/arm64/kernel/ptrace.c
> +++ b/arch/arm64/kernel/ptrace.c
> @@ -979,6 +979,60 @@ static int pac_mask_get(struct task_struct *target,
>  
>  	return user_regset_copyout(&pos, &count, &kbuf, &ubuf, &uregs, 0, -1);
>  }
> +
> +#ifdef CONFIG_CHECKPOINT_RESTORE
> +static int pac_address_keys_get(struct task_struct *target,
> +				const struct user_regset *regset,
> +				unsigned int pos, unsigned int count,
> +				void *kbuf, void __user *ubuf)
> +{
> +	if (!system_supports_address_auth())
> +		return -EINVAL;
> +
> +	return user_regset_copyout(&pos, &count, &kbuf, &ubuf,
> +				   &target->thread.uw.keys_user.addr_keys,
> +				   0, -1);
> +}
> +
> +static int pac_address_keys_set(struct task_struct *target,
> +				const struct user_regset *regset,
> +				unsigned int pos, unsigned int count,
> +				const void *kbuf, const void __user *ubuf)
> +{
> +	if (!system_supports_address_auth())
> +		return -EINVAL;
> +
> +	return user_regset_copyin(&pos, &count, &kbuf, &ubuf,
> +				  &target->thread.uw.keys_user.addr_keys,
> +				  0, -1);
> +}
> +
> +static int pac_generic_keys_get(struct task_struct *target,
> +				const struct user_regset *regset,
> +				unsigned int pos, unsigned int count,
> +				void *kbuf, void __user *ubuf)
> +{
> +	if (!system_supports_generic_auth())
> +		return -EINVAL;
> +
> +	return user_regset_copyout(&pos, &count, &kbuf, &ubuf,
> +				   &target->thread.uw.keys_user.gen_keys,
> +				   0, -1);
> +}
> +
> +static int pac_generic_keys_set(struct task_struct *target,
> +				const struct user_regset *regset,
> +				unsigned int pos, unsigned int count,
> +				const void *kbuf, const void __user *ubuf)
> +{
> +	if (!system_supports_generic_auth())
> +		return -EINVAL;
> +
> +	return user_regset_copyin(&pos, &count, &kbuf, &ubuf,
> +				  &target->thread.uw.keys_user.gen_keys,
> +				  0, -1);
> +}
> +#endif /* CONFIG_CHECKPOINT_RESTORE */
>  #endif /* CONFIG_ARM64_PTR_AUTH */
>  
>  enum aarch64_regset {
> @@ -995,6 +1049,10 @@ enum aarch64_regset {
>  #endif
>  #ifdef CONFIG_ARM64_PTR_AUTH
>  	REGSET_PAC_MASK,
> +#ifdef CONFIG_CHECKPOINT_RESTORE
> +	REGSET_PACA_KEYS,
> +	REGSET_PACG_KEYS,
> +#endif
>  #endif
>  };
>  
> @@ -1074,6 +1132,24 @@ static const struct user_regset aarch64_regsets[] = {
>  		.get = pac_mask_get,
>  		/* this cannot be set dynamically */
>  	},
> +#ifdef CONFIG_CHECKPOINT_RESTORE

&& defined(CONFIG_ARM64_PTR_AUTH) ?

> +	[REGSET_PACA_KEYS] = {
> +		.core_note_type = NT_ARM_PACA_KEYS,
> +		.n = sizeof(struct user_pac_address_keys) / sizeof(u64),
> +		.size = sizeof(u64),
> +		.align = sizeof(u64),
> +		.get = pac_address_keys_get,
> +		.set = pac_address_keys_set,
> +	},
> +	[REGSET_PACG_KEYS] = {
> +		.core_note_type = NT_ARM_PACG_KEYS,
> +		.n = sizeof(struct user_pac_generic_keys) / sizeof(u64),
> +		.size = sizeof(u64),
> +		.align = sizeof(u64),
> +		.get = pac_generic_keys_get,
> +		.set = pac_generic_keys_set,
> +	},
> +#endif
>  #endif
>  };
>  

[...]

Cheers
---Dave

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
