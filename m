Return-Path: <SRS0=P47x=QF=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E1721C169C4
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Tue, 29 Jan 2019 20:49:11 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A700E2087E
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Tue, 29 Jan 2019 20:49:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="d+Yiv/fc"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A700E2087E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:
	Message-ID:Subject:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=y4naUAk4u7RE/ec0UmUtbTw2mjEkupjh12DvA+J7rKM=; b=d+Yiv/fc3woqbj
	3EXcUVNdAgjCjH9un1Q8zPSsK/Hd5x3z7gxBk0HtM+c48s2q1/4o6I82E+nslWKsHYh16hxM8cwNf
	7IZ5RtAzwcq2naYz3FpAfVuthS+iDUrKT+r2e/V05a0kP8ce0y8RHYc9rhgo3z+1Or0KCaBQxyhDB
	2bqida3OtEBVtUxIXqY4u7PpZSRVUchIA0FO4R4F9jfUcXAdH+mDqVace5hMsa2ykz96FcCHq4Mhm
	eS/C4NOuMZzX0gfpLO+XT614+Yq/m4TFiaSOHxPHXOsu4k+tmMQ29JVEEpJCYbYgEvIN3bRJtNOIY
	xp3vD6HnrwdwghgRm2eQ==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1goaJh-0005la-45; Tue, 29 Jan 2019 20:49:09 +0000
Received: from usa-sjc-mx-foss1.foss.arm.com ([217.140.101.70]
 helo=foss.arm.com)
 by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
 id 1goaJc-0005l3-Je
 for linux-arm-kernel@lists.infradead.org; Tue, 29 Jan 2019 20:49:06 +0000
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id E7255A78;
 Tue, 29 Jan 2019 12:48:59 -0800 (PST)
Received: from e103592.cambridge.arm.com (usa-sjc-imap-foss1.foss.arm.com
 [10.72.51.249])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id B2DCE3F59C;
 Tue, 29 Jan 2019 12:48:58 -0800 (PST)
Date: Tue, 29 Jan 2019 20:48:56 +0000
From: Dave Martin <Dave.Martin@arm.com>
To: Kristina Martsenko <kristina.martsenko@arm.com>
Subject: Re: [PATCH v3] arm64: add ptrace regsets for ptrauth key management
Message-ID: <20190129191904.GA3567@e103592.cambridge.arm.com>
References: <20190123153519.7874-1-kristina.martsenko@arm.com>
 <20190123173750.GM3578@e103592.cambridge.arm.com>
 <02c2e38e-2e04-9867-6f7d-cf79e4f49c12@arm.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <02c2e38e-2e04-9867-6f7d-cf79e4f49c12@arm.com>
User-Agent: Mutt/1.5.23 (2014-03-12)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190129_124904_661838_9655E538 
X-CRM114-Status: GOOD (  40.75  )
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

On Tue, Jan 29, 2019 at 06:44:38PM +0000, Kristina Martsenko wrote:
> On 23/01/2019 17:37, Dave Martin wrote:
> > On Wed, Jan 23, 2019 at 03:35:19PM +0000, Kristina Martsenko wrote:
> >> Add two new ptrace regsets, which can be used to request and change the
> >> pointer authentication keys of a thread. NT_ARM_PACA_KEYS gives access
> >> to the instruction/data address keys, and NT_ARM_PACG_KEYS to the
> >> generic authentication key. The keys are also part of the core dump file
> >> of the process.
> > 
> > Is there a use case for including these in the coredump?  Perhaps it
> > would make sense to suppress them.  If the core code doesn't make that
> > easy it may not be worth it though.
> 
> From what I can see there is no proper way to exclude the keys from the
> core dump. There is an ->active() callback on struct user_regset, which
> could be implemented to always return 0, which would exclude the keys
> from the core dump. But while the callback seems to currently only be
> used for the core dump, its purpose seems to be more general, so I don't
> think it would be right to have it always return 0.

OK, if there's no straightforward answer here, I suggest we leave it
as-is, especially if nothing else handles this specially.

[...]

> >> diff --git a/arch/arm64/kernel/ptrace.c b/arch/arm64/kernel/ptrace.c
> >> index 9dce33b0e260..102f71fe0288 100644
> >> --- a/arch/arm64/kernel/ptrace.c
> >> +++ b/arch/arm64/kernel/ptrace.c
> >> @@ -979,6 +979,123 @@ static int pac_mask_get(struct task_struct *target,
> >>  
> >>  	return user_regset_copyout(&pos, &count, &kbuf, &ubuf, &uregs, 0, -1);
> >>  }
> >> +
> >> +#ifdef CONFIG_CHECKPOINT_RESTORE
> >> +static void pac_address_keys_to_user(struct user_pac_address_keys *ukeys,
> >> +				     struct ptrauth_keys *keys)
> > 
> > const?
> 
> Done.
> 
> >> +{
> >> +	ukeys->apiakey = ((__uint128_t)keys->apia.hi << 64) | keys->apia.lo;
> > 
> > We could have a helper
> > 
> > static __uint128_t key_to_user(struct ptrauth_key const *key)
> > {
> > 	return (__uint128_t)key->hi << 64 | key->lo;
> > }
> > 
> > and then do
> > 
> > 	ukeys->apiakey = key_to_user(&keys->apia);
> > 	ukeys->apibkey = key_to_user(&keys->apib);
> 
> Done.
> 
> >> +	ukeys->apibkey = ((__uint128_t)keys->apib.hi << 64) | keys->apib.lo;
> >> +	ukeys->apdakey = ((__uint128_t)keys->apda.hi << 64) | keys->apda.lo;
> >> +	ukeys->apdbkey = ((__uint128_t)keys->apdb.hi << 64) | keys->apdb.lo;
> >> +}
> >> +
> >> +static void pac_address_keys_from_user(struct user_pac_address_keys *ukeys,
> > 
> > const?
> 
> Done.
> 
> >> +				       struct ptrauth_keys *keys)
> > 
> > Is the argument order for this function intentional?
> > 
> > It means that for pac_address_keys_to_user() the destination argument is
> > on the left, but in pac_address_keys_from_user() the destination
> > argument is on the right.
> > 
> > This is mildly confusing, but because the arguments are of different
> > types the compiler should catch mistakes (especially if the const is
> > added appropriately.)
> > 
> > If this is following a pattern already set elsewhere, then fair enough.
> 
> I think the order is accidental here. I'll move the destination argument
> to the left.

OK, that sounds fine.

> >> +{
> >> +	keys->apia.lo = (unsigned long)ukeys->apiakey;
> >> +	keys->apia.hi = (unsigned long)(ukeys->apiakey >> 64);
> > 
> > Similarly, we could have 
> > 
> > static struct ptrauth_key key_from_user(__uint128_t ukey)
> > {
> > 	struct ptrauth_key key = {
> > 		.lo = (unsigned long)ukey;
> > 		.hi = (unsigned long)(ukey >> 64);
> > 	};
> > 
> > 	return key;
> > }
> > 
> > 	keys->apia = key_from_user(ukeys->apiakey);
> > 	keys->apib = key_from_user(ukeys->apibkey);
> > 
> > These factorings may be overkill though.
> 
> Done.

OK, fair enough.

> >> +	keys->apib.lo = (unsigned long)ukeys->apibkey;
> >> +	keys->apib.hi = (unsigned long)(ukeys->apibkey >> 64);
> >> +	keys->apda.lo = (unsigned long)ukeys->apdakey;
> >> +	keys->apda.hi = (unsigned long)(ukeys->apdakey >> 64);
> >> +	keys->apdb.lo = (unsigned long)ukeys->apdbkey;
> >> +	keys->apdb.hi = (unsigned long)(ukeys->apdbkey >> 64);
> >> +}
> >> +
> >> +static int pac_address_keys_get(struct task_struct *target,
> >> +				const struct user_regset *regset,
> >> +				unsigned int pos, unsigned int count,
> >> +				void *kbuf, void __user *ubuf)
> >> +{
> >> +	struct ptrauth_keys *keys = &target->thread.keys_user;
> >> +	struct user_pac_address_keys user_keys;
> >> +
> >> +	if (!system_supports_address_auth())
> >> +		return -EINVAL;
> >> +
> >> +	memset(&user_keys, 0, sizeof(user_keys));
> > 
> > Why this memset?
> 
> From your previous email [1], I understood that you wanted the user
> struct zeroed to avoid leaking kernel stack to userspace through padding
> bits, even if the keys are 128-bit (or 64-bit) and there shouldn't be
> any padding bits anyway. I don't personally think that the struct needs
> to be zeroed (since there shouldn't be any padding), so if it's alright
> with you I'll remove the memset.
> 
> [1] https://lore.kernel.org/lkml/20181212152347.GY3505@e103592.cambridge.arm.com/
> 
> > (In particular, we have no similar memset in pac_address_keys_get().
> 
> I guess you mean pac_address_keys_set. We only copy the fields into the

Ah yes, sorry.

> kernel struct there, not the padding, so this issue doesn't apply.

I could have explained myself better.

C allows padding to be populated with arbitrary data any time a member
of the struct is written, so there's really no option but to ensure that
the struct contains no padding at all.

Since the affected structs are homogeneous we should be OK here, and
explicitly computing and assiging appropriate values rather than doing
a straight copy minimises the possiblility for unexpected things
happening, as does forbidding half-keys from being modified by
userspace.

So I agree, the memset() doesn't look like it's adding anything and
it can go.

> > Maybe it's needed for some reason I've missed, but I don't see it.)
> > 
> >> +	pac_address_keys_to_user(&user_keys, keys);
> >> +
> >> +	return user_regset_copyout(&pos, &count, &kbuf, &ubuf,
> >> +				   &user_keys, 0, -1);
> >> +}
> >> +
> >> +static int pac_address_keys_set(struct task_struct *target,
> >> +				const struct user_regset *regset,
> >> +				unsigned int pos, unsigned int count,
> >> +				const void *kbuf, const void __user *ubuf)
> >> +{
> >> +	struct ptrauth_keys *keys = &target->thread.keys_user;
> >> +	struct user_pac_address_keys user_keys;
> >> +	int ret;
> >> +
> >> +	if (!system_supports_address_auth())
> >> +		return -EINVAL;
> >> +
> >> +	pac_address_keys_to_user(&user_keys, keys);
> >> +	ret = user_regset_copyin(&pos, &count, &kbuf, &ubuf,
> >> +				 &user_keys, 0, -1);
> >> +	if (ret)
> >> +		return ret;
> >> +	pac_address_keys_from_user(&user_keys, keys);
> >> +
> >> +	return 0;
> >> +}
> >> +
> >> +static void pac_generic_keys_to_user(struct user_pac_generic_keys *ukeys,
> >> +				     struct ptrauth_keys *keys)
> > 
> > const?
> 
> Done.
> 
> >> +{
> >> +	ukeys->apgakey = ((__uint128_t)keys->apga.hi << 64) | keys->apga.lo;
> >> +}
> >> +
> >> +static void pac_generic_keys_from_user(struct user_pac_generic_keys *ukeys,
> > 
> > const?
> 
> Done.
> 
> >> +				       struct ptrauth_keys *keys)
> >> +{
> >> +	keys->apga.lo = (unsigned long)ukeys->apgakey;
> >> +	keys->apga.hi = (unsigned long)(ukeys->apgakey >> 64);
> > 
> > (The above helpers could be used here too.)
> > 
> >> +}
> >> +
> >> +static int pac_generic_keys_get(struct task_struct *target,
> >> +				const struct user_regset *regset,
> >> +				unsigned int pos, unsigned int count,
> >> +				void *kbuf, void __user *ubuf)
> >> +{
> >> +	struct ptrauth_keys *keys = &target->thread.keys_user;
> >> +	struct user_pac_generic_keys user_keys;
> >> +
> >> +	if (!system_supports_generic_auth())
> >> +		return -EINVAL;
> >> +
> >> +	memset(&user_keys, 0, sizeof(user_keys));
> > 
> > Similarly to above, is this needed?
> 
> Same reason as above; I'll remove it.
> 
> Kristina

[...]

OK, thanks
---Dave

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
