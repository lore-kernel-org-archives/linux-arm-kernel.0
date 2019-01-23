Return-Path: <SRS0=uP4V=P7=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D947BC282C0
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Wed, 23 Jan 2019 17:38:07 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A8AE920870
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Wed, 23 Jan 2019 17:38:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="n5l05ADo"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A8AE920870
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:
	Message-ID:Subject:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=Vji3Q9Ogi1Dlz0F3uYyDF5RRwDAD04neFNENSucjP6c=; b=n5l05ADoW7+znz
	FvzNFFcjflZnGJTlPZTYjzkGdIs8oXWagejCPUW5bO8H1SbcNaGvGEDmmop0PSGuK2uj1gnHKj2Kf
	LH7no8qnK3wqt6tTpbOMYpyrNchLNkFenrLqEKb9h/rA3lBdfieub2I1jRzbWXkfecj4XvX9mX9BP
	lLPOY2eiapQM2W+9BzU9dkxZQeqHuRTi50CQXX8dQYJkrcT2ri9PRJhN4SL2Fm9Nf/jHqOwusI/Dj
	65CtgPOiFDlE3Su7RUJY/YTWowsEjkb8EEEJslcHOaxKAlIgMX6y782Lb+xO2jrl25hJlQtMKElLX
	5608cQl22OS1jSer/CLQ==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gmMTV-0001eV-V2; Wed, 23 Jan 2019 17:38:05 +0000
Received: from usa-sjc-mx-foss1.foss.arm.com ([217.140.101.70]
 helo=foss.arm.com)
 by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gmMTK-0001ds-Uk
 for linux-arm-kernel@lists.infradead.org; Wed, 23 Jan 2019 17:38:03 +0000
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 4F01FEBD;
 Wed, 23 Jan 2019 09:37:54 -0800 (PST)
Received: from e103592.cambridge.arm.com (usa-sjc-imap-foss1.foss.arm.com
 [10.72.51.249])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 1B0F83F5C1;
 Wed, 23 Jan 2019 09:37:52 -0800 (PST)
Date: Wed, 23 Jan 2019 17:37:50 +0000
From: Dave Martin <Dave.Martin@arm.com>
To: Kristina Martsenko <kristina.martsenko@arm.com>
Subject: Re: [PATCH v3] arm64: add ptrace regsets for ptrauth key management
Message-ID: <20190123173750.GM3578@e103592.cambridge.arm.com>
References: <20190123153519.7874-1-kristina.martsenko@arm.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20190123153519.7874-1-kristina.martsenko@arm.com>
User-Agent: Mutt/1.5.23 (2014-03-12)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190123_093755_007979_597B3416 
X-CRM114-Status: GOOD (  32.72  )
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

On Wed, Jan 23, 2019 at 03:35:19PM +0000, Kristina Martsenko wrote:
> Add two new ptrace regsets, which can be used to request and change the
> pointer authentication keys of a thread. NT_ARM_PACA_KEYS gives access
> to the instruction/data address keys, and NT_ARM_PACG_KEYS to the
> generic authentication key. The keys are also part of the core dump file
> of the process.

Is there a use case for including these in the coredump?  Perhaps it
would make sense to suppress them.  If the core code doesn't make that
easy it may not be worth it though.

Including the keys in a coredump doesn't feel like a security risk,
unless the checkpoint restore folks have a way of resurrecting dead
processes from coredumps.  Otherwise, (statistically) no new process
will have the same keys anyway.

> The regsets are only exposed if the kernel is compiled with
> CONFIG_CHECKPOINT_RESTORE=y, as the only intended use case is
> checkpointing and restoring processes that are using pointer
> authentication. (This can be changed later if there are other use
> cases.)
> 
> Signed-off-by: Kristina Martsenko <kristina.martsenko@arm.com>

I think this looks nicer overall.

A few comments, which are all nits except for the questions about the
memset() calls.

> ---
> 
> Changes in v3:
>  - 128-bit keys in uapi struct, conversions to/from ptrauth_keys fields
>  - Commit message tweaks
> 
>  Documentation/arm64/pointer-authentication.txt |   5 +
>  arch/arm64/include/uapi/asm/ptrace.h           |  13 +++
>  arch/arm64/kernel/ptrace.c                     | 139 +++++++++++++++++++++++++
>  include/uapi/linux/elf.h                       |   2 +
>  4 files changed, 159 insertions(+)
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
> diff --git a/arch/arm64/include/uapi/asm/ptrace.h b/arch/arm64/include/uapi/asm/ptrace.h
> index 28d77c9ed531..d78623acb649 100644
> --- a/arch/arm64/include/uapi/asm/ptrace.h
> +++ b/arch/arm64/include/uapi/asm/ptrace.h
> @@ -233,6 +233,19 @@ struct user_pac_mask {
>  	__u64		insn_mask;
>  };
>  
> +/* pointer authentication keys (NT_ARM_PACA_KEYS, NT_ARM_PACG_KEYS) */
> +
> +struct user_pac_address_keys {
> +	__uint128_t	apiakey;
> +	__uint128_t	apibkey;
> +	__uint128_t	apdakey;
> +	__uint128_t	apdbkey;
> +};
> +
> +struct user_pac_generic_keys {
> +	__uint128_t	apgakey;
> +};
> +
>  #endif /* __ASSEMBLY__ */
>  
>  #endif /* _UAPI__ASM_PTRACE_H */
> diff --git a/arch/arm64/kernel/ptrace.c b/arch/arm64/kernel/ptrace.c
> index 9dce33b0e260..102f71fe0288 100644
> --- a/arch/arm64/kernel/ptrace.c
> +++ b/arch/arm64/kernel/ptrace.c
> @@ -979,6 +979,123 @@ static int pac_mask_get(struct task_struct *target,
>  
>  	return user_regset_copyout(&pos, &count, &kbuf, &ubuf, &uregs, 0, -1);
>  }
> +
> +#ifdef CONFIG_CHECKPOINT_RESTORE
> +static void pac_address_keys_to_user(struct user_pac_address_keys *ukeys,
> +				     struct ptrauth_keys *keys)

const?

> +{
> +	ukeys->apiakey = ((__uint128_t)keys->apia.hi << 64) | keys->apia.lo;

We could have a helper

static __uint128_t key_to_user(struct ptrauth_key const *key)
{
	return (__uint128_t)key->hi << 64 | key->lo;
}

and then do

	ukeys->apiakey = key_to_user(&keys->apia);
	ukeys->apibkey = key_to_user(&keys->apib);

> +	ukeys->apibkey = ((__uint128_t)keys->apib.hi << 64) | keys->apib.lo;
> +	ukeys->apdakey = ((__uint128_t)keys->apda.hi << 64) | keys->apda.lo;
> +	ukeys->apdbkey = ((__uint128_t)keys->apdb.hi << 64) | keys->apdb.lo;
> +}
> +
> +static void pac_address_keys_from_user(struct user_pac_address_keys *ukeys,

const?

> +				       struct ptrauth_keys *keys)

Is the argument order for this function intentional?

It means that for pac_address_keys_to_user() the destination argument is
on the left, but in pac_address_keys_from_user() the destination
argument is on the right.

This is mildly confusing, but because the arguments are of different
types the compiler should catch mistakes (especially if the const is
added appropriately.)

If this is following a pattern already set elsewhere, then fair enough.

> +{
> +	keys->apia.lo = (unsigned long)ukeys->apiakey;
> +	keys->apia.hi = (unsigned long)(ukeys->apiakey >> 64);

Similarly, we could have 

static struct ptrauth_key key_from_user(__uint128_t ukey)
{
	struct ptrauth_key key = {
		.lo = (unsigned long)ukey;
		.hi = (unsigned long)(ukey >> 64);
	};

	return key;
}

	keys->apia = key_from_user(ukeys->apiakey);
	keys->apib = key_from_user(ukeys->apibkey);

These factorings may be overkill though.

> +	keys->apib.lo = (unsigned long)ukeys->apibkey;
> +	keys->apib.hi = (unsigned long)(ukeys->apibkey >> 64);
> +	keys->apda.lo = (unsigned long)ukeys->apdakey;
> +	keys->apda.hi = (unsigned long)(ukeys->apdakey >> 64);
> +	keys->apdb.lo = (unsigned long)ukeys->apdbkey;
> +	keys->apdb.hi = (unsigned long)(ukeys->apdbkey >> 64);
> +}
> +
> +static int pac_address_keys_get(struct task_struct *target,
> +				const struct user_regset *regset,
> +				unsigned int pos, unsigned int count,
> +				void *kbuf, void __user *ubuf)
> +{
> +	struct ptrauth_keys *keys = &target->thread.keys_user;
> +	struct user_pac_address_keys user_keys;
> +
> +	if (!system_supports_address_auth())
> +		return -EINVAL;
> +
> +	memset(&user_keys, 0, sizeof(user_keys));

Why this memset?

(In particular, we have no similar memset in pac_address_keys_get().
Maybe it's needed for some reason I've missed, but I don't see it.)

> +	pac_address_keys_to_user(&user_keys, keys);
> +
> +	return user_regset_copyout(&pos, &count, &kbuf, &ubuf,
> +				   &user_keys, 0, -1);
> +}
> +
> +static int pac_address_keys_set(struct task_struct *target,
> +				const struct user_regset *regset,
> +				unsigned int pos, unsigned int count,
> +				const void *kbuf, const void __user *ubuf)
> +{
> +	struct ptrauth_keys *keys = &target->thread.keys_user;
> +	struct user_pac_address_keys user_keys;
> +	int ret;
> +
> +	if (!system_supports_address_auth())
> +		return -EINVAL;
> +
> +	pac_address_keys_to_user(&user_keys, keys);
> +	ret = user_regset_copyin(&pos, &count, &kbuf, &ubuf,
> +				 &user_keys, 0, -1);
> +	if (ret)
> +		return ret;
> +	pac_address_keys_from_user(&user_keys, keys);
> +
> +	return 0;
> +}
> +
> +static void pac_generic_keys_to_user(struct user_pac_generic_keys *ukeys,
> +				     struct ptrauth_keys *keys)

const?

> +{
> +	ukeys->apgakey = ((__uint128_t)keys->apga.hi << 64) | keys->apga.lo;
> +}
> +
> +static void pac_generic_keys_from_user(struct user_pac_generic_keys *ukeys,

const?

> +				       struct ptrauth_keys *keys)
> +{
> +	keys->apga.lo = (unsigned long)ukeys->apgakey;
> +	keys->apga.hi = (unsigned long)(ukeys->apgakey >> 64);

(The above helpers could be used here too.)

> +}
> +
> +static int pac_generic_keys_get(struct task_struct *target,
> +				const struct user_regset *regset,
> +				unsigned int pos, unsigned int count,
> +				void *kbuf, void __user *ubuf)
> +{
> +	struct ptrauth_keys *keys = &target->thread.keys_user;
> +	struct user_pac_generic_keys user_keys;
> +
> +	if (!system_supports_generic_auth())
> +		return -EINVAL;
> +
> +	memset(&user_keys, 0, sizeof(user_keys));

Similarly to above, is this needed?

> +	pac_generic_keys_to_user(&user_keys, keys);
> +
> +	return user_regset_copyout(&pos, &count, &kbuf, &ubuf,
> +				   &user_keys, 0, -1);
> +}
> +
> +static int pac_generic_keys_set(struct task_struct *target,
> +				const struct user_regset *regset,
> +				unsigned int pos, unsigned int count,
> +				const void *kbuf, const void __user *ubuf)
> +{
> +	struct ptrauth_keys *keys = &target->thread.keys_user;
> +	struct user_pac_generic_keys user_keys;
> +	int ret;
> +
> +	if (!system_supports_generic_auth())
> +		return -EINVAL;
> +
> +	pac_generic_keys_to_user(&user_keys, keys);
> +	ret = user_regset_copyin(&pos, &count, &kbuf, &ubuf,
> +				 &user_keys, 0, -1);
> +	if (ret)
> +		return ret;
> +	pac_generic_keys_from_user(&user_keys, keys);
> +
> +	return 0;
> +}

[...]

Cheers
---Dave

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
