Return-Path: <SRS0=3lKL=PX=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5530AC43444
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Tue, 15 Jan 2019 19:32:43 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1CF0520859
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Tue, 15 Jan 2019 19:32:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="cacZeDWy"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1CF0520859
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:Date:
	Message-ID:References:To:Subject:From:Reply-To:Content-ID:Content-Description
	:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=Cx+vKufzj2pajReExzhGO/09FekQm9fzA3KaO0eg7AM=; b=cacZeDWyKiTCki
	WpaHftyXu1Knsz+Iiyv2icrrYBfqRLePS8cS61tLcxa5w/gVinXoHASmk2C0bajfvwS7u4/WjKMVQ
	QAi+xBy25VQlS64hKZ5ERz6CGlO4TDjb26xNNLOKm1ZrhtnEA8GJMJacsuRw/hXw43so8gYpLRdMC
	+u9ffpcAXaK8gAx0v9pgQ7f9FE7MX0y+Ivx83XkXQZvVwLVoep9icbmcz8XNoataLAm+oHtFkmsXy
	QEJ2nfwjhvZYhLmM2ZkcTeQ+E66GSeVn9zIahChgZAUpwpVZ4L9X3CUDyTrQInVszzC9DBZq7fbuT
	tCdM8ySUEnW0JNIQSUDA==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gjURy-0001Yz-9v; Tue, 15 Jan 2019 19:32:38 +0000
Received: from foss.arm.com ([217.140.101.70])
 by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gjURv-0001Nc-Eo
 for linux-arm-kernel@lists.infradead.org; Tue, 15 Jan 2019 19:32:37 +0000
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 55D89EBD;
 Tue, 15 Jan 2019 11:32:33 -0800 (PST)
Received: from [10.1.197.21] (usa-sjc-imap-foss1.foss.arm.com [10.72.51.249])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id
 2DE473FAA1; Tue, 15 Jan 2019 11:32:32 -0800 (PST)
From: Kristina Martsenko <kristina.martsenko@arm.com>
Subject: Re: [PATCH v2] arm64: add ptrace regsets for ptrauth key management
To: Dave Martin <Dave.Martin@arm.com>
References: <20190110193508.31888-1-kristina.martsenko@arm.com>
 <d2bcfb3a-3668-693c-2fd4-3814b473375c@arm.com>
 <20190111135842.GB3547@e103592.cambridge.arm.com>
Message-ID: <911e27a9-d199-9a64-8a2e-597733af5854@arm.com>
Date: Tue, 15 Jan 2019 19:32:30 +0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.4.0
MIME-Version: 1.0
In-Reply-To: <20190111135842.GB3547@e103592.cambridge.arm.com>
Content-Language: en-US
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190115_113235_508722_844B2478 
X-CRM114-Status: GOOD (  30.21  )
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

On 11/01/2019 13:58, Dave Martin wrote:
> On Thu, Jan 10, 2019 at 07:41:15PM +0000, Kristina Martsenko wrote:
>> On 10/01/2019 19:35, Kristina Martsenko wrote:
>>> Add two new ptrace regsets, which can be used to request and change the
>>> pointer authentication keys of a thread. NT_ARM_PACA_KEYS gives access
>>> to the instruction/data address keys, and NT_ARM_PACG_KEYS to the
>>> generic authentication key. The keys are also part of the core dump file
>>> of the process.
>>>
>>> The regsets are only exposed if the kernel is compiled with
>>> CONFIG_CHECKPOINT_RESTORE=y, as the intended use case is checkpointing
>>> and restoring processes that are using pointer authentication. Normally
>>> applications or debuggers should not need to know the keys (and exposing
>>> the keys is a security risk), so the regsets are not exposed by default.
> 
> Although we can live with this, I still think it gives a false sense of
> safety.
> 
> Can we come up with an scenario where an attacker with ptrace or
> coredump access can do more damage with access to the pointer auth keys
> than without?
> 
> A lot of systems will run with CONFIG_CHECKPOINT_RESTORE=y (like
> packaged Debian kernels for example).  And more paranoid systems already
> restrict or disable ptrace anyway.

I can't think of such a scenario, as ptrace gives access to registers
and memory anyway. But I probably haven't thought of all scenarios.

There are other ptrace options that are only available when
CONFIG_CHECKPOINT_RESTORE=y, such as PTRACE_SECCOMP_GET_FILTER.

I think Will had a preference for having this depend on
CONFIG_CHECKPOINT_RESTORE, so I will keep it for now.

>>  #define __ptrauth_key_install(k, v)				\
>>  do {								\
>> -	struct ptrauth_key __pki_v = (v);			\
>> -	write_sysreg_s(__pki_v.lo, SYS_ ## k ## KEYLO_EL1);	\
>> -	write_sysreg_s(__pki_v.hi, SYS_ ## k ## KEYHI_EL1);	\
>> +	write_sysreg_s(v ## _lo, SYS_ ## k ## KEYLO_EL1);	\
>> +	write_sysreg_s(v ## _hi, SYS_ ## k ## KEYHI_EL1);	\
>>  } while (0)
>>  
>>  static inline void ptrauth_keys_switch(struct ptrauth_keys *keys)
>>  {
>>  	if (system_supports_address_auth()) {
>> -		__ptrauth_key_install(APIA, keys->apia);
>> -		__ptrauth_key_install(APIB, keys->apib);
>> -		__ptrauth_key_install(APDA, keys->apda);
>> -		__ptrauth_key_install(APDB, keys->apdb);
>> +		__ptrauth_key_install(APIA, keys->addr_keys.apiakey);
>> +		__ptrauth_key_install(APIB, keys->addr_keys.apibkey);
>> +		__ptrauth_key_install(APDA, keys->addr_keys.apdakey);
>> +		__ptrauth_key_install(APDB, keys->addr_keys.apdbkey);
> 
> Aren't the members of struct user_pac_address_keys split up into
> apiakey_lo, apiakey_hi etc.?

They are, which is why the __ptrauth_key_install macro pastes a "_lo" or
"_hi" at the end of the field name. I don't think this is very nice,
which is one of the reasons why I prefer the other patch (where we keep
the kernel and ptrace structs separate).

> However, I think there's no reason not to pair up the keys in nested
> structs in the user struct, so could we change that struct to be more
> like the old struct ptrauth_key and keep the above code?

We don't currently have any other separate nested structs in the arm64
ptrace userspace interface. Other architectures also seem to only have a
few rare instances of this.

It seems odd to complicate the userspace interface because of a kernel
implementation detail, but if you think it's better I could change the
structs to:

struct user_pac_key {
	__u64		lo;
	__u64		hi;
};

struct user_pac_address_keys {
	struct user_pac_key	apiakey;
	struct user_pac_key	apibkey;
	struct user_pac_key	apdakey;
	struct user_pac_key	apdbkey;
};

struct user_pac_generic_keys {
	struct user_pac_key	apgakey;
};

>>  	}
>>  
>>  	if (system_supports_generic_auth())
>> -		__ptrauth_key_install(APGA, keys->apga);
>> +		__ptrauth_key_install(APGA, keys->gen_keys.apgakey);
>>  }
>>  
>>  extern int ptrauth_prctl_reset_keys(struct task_struct *tsk, unsigned long arg);
>> @@ -80,12 +65,12 @@ static inline unsigned long ptrauth_strip_insn_pac(unsigned long ptr)
>>  #define ptrauth_thread_init_user(tsk)					\
>>  do {									\
>>  	struct task_struct *__ptiu_tsk = (tsk);				\
> 
> Not added by this patch, but __ptiu_tsk doesn't seem to do anything
> except make the subsquent lines more verbose than otherwise (and pollute
> the identifier namespace -- though unlikely to be a problem).
> 
> It may not be worth dropping it now that it's there though.

Using __ptiu_tsk prevents the argument (tsk) from being evaluated twice,
which could have side effects.

>> -	ptrauth_keys_init(&__ptiu_tsk->thread.keys_user);		\
>> -	ptrauth_keys_switch(&__ptiu_tsk->thread.keys_user);		\
>> +	ptrauth_keys_init(&__ptiu_tsk->thread.uw.keys_user);		\
>> +	ptrauth_keys_switch(&__ptiu_tsk->thread.uw.keys_user);		\
>>  } while (0)
>>  
>>  #define ptrauth_thread_switch(tsk)	\
>> -	ptrauth_keys_switch(&(tsk)->thread.keys_user)
>> +	ptrauth_keys_switch(&(tsk)->thread.uw.keys_user)

[...]

>> --- a/arch/arm64/include/uapi/asm/ptrace.h
>> +++ b/arch/arm64/include/uapi/asm/ptrace.h
>> @@ -233,6 +233,24 @@ struct user_pac_mask {
>>  	__u64		insn_mask;
>>  };
>>  
>> +/* pointer authentication keys (NT_ARM_PACA_KEYS, NT_ARM_PACG_KEYS) */
>> +
>> +struct user_pac_address_keys {
>> +	__u64		apiakey_lo;
>> +	__u64		apiakey_hi;
>> +	__u64		apibkey_lo;
>> +	__u64		apibkey_hi;
>> +	__u64		apdakey_lo;
>> +	__u64		apdakey_hi;
>> +	__u64		apdbkey_lo;
>> +	__u64		apdbkey_hi;
>> +};
>> +
>> +struct user_pac_generic_keys {
>> +	__u64		apgakey_lo;
>> +	__u64		apgakey_hi;
>> +};
>> +
> 
> As noted above, I think we could happily have a struct user_pac_key to
> pack up the halves of each key, like the old kernel struct.

See my answer above.

Also note that with this patch we have struct "user_pac_address_keys" in
struct ptrauth_keys, which may be confusing once we start using pointer
authentication in the kernel and use struct ptrauth_keys for kernel keys
as well, not just user keys.

>> @@ -1074,6 +1132,24 @@ static const struct user_regset aarch64_regsets[] = {
>>  		.get = pac_mask_get,
>>  		/* this cannot be set dynamically */
>>  	},
>> +#ifdef CONFIG_CHECKPOINT_RESTORE
> 
> && defined(CONFIG_ARM64_PTR_AUTH) ?

No, this is already inside a larger "#ifdef CONFIG_ARM64_PTR_AUTH" block.

>> +	[REGSET_PACA_KEYS] = {
>> +		.core_note_type = NT_ARM_PACA_KEYS,
>> +		.n = sizeof(struct user_pac_address_keys) / sizeof(u64),
>> +		.size = sizeof(u64),
>> +		.align = sizeof(u64),
>> +		.get = pac_address_keys_get,
>> +		.set = pac_address_keys_set,
>> +	},
>> +	[REGSET_PACG_KEYS] = {
>> +		.core_note_type = NT_ARM_PACG_KEYS,
>> +		.n = sizeof(struct user_pac_generic_keys) / sizeof(u64),
>> +		.size = sizeof(u64),
>> +		.align = sizeof(u64),
>> +		.get = pac_generic_keys_get,
>> +		.set = pac_generic_keys_set,
>> +	},
>> +#endif
>>  #endif
>>  };

Kristina

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
