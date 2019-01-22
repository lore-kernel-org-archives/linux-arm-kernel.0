Return-Path: <SRS0=B2vk=P6=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 378ADC282C3
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Tue, 22 Jan 2019 19:08:37 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0C45B20856
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Tue, 22 Jan 2019 19:08:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="fLcXPsKi"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0C45B20856
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:Date:
	Message-ID:References:To:Subject:From:Reply-To:Content-ID:Content-Description
	:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=h6z4qyckhiPQoENrRMagsIr29vR8oR6FQVg+pMaf6Fs=; b=fLcXPsKiiB4gwC
	+TpJQG6s85moLyC2r0a2vr5uYxvnZ68e9QqhKDxoN4oe6GLHRu+GynGo+AVwGeACQVQgqXRCN+4gH
	gPxEgGHD2bo66jx+Cu7a8g2NX+hHn21/yyvShKbMhmAZ8TMj3fG+LfN8bGF5j0eYh2MtR+zDVuKFc
	zuC8T/lUMCTpP5g3TVkzneymzL5GV2M5r07HrrWACVvNKrH/mx6Ov5HD4AD3vniRYYXseEplIAtHf
	+9FkBqlY5XXlSB7P8/HK18N1rtCVHBwnH0OrsiTf+WWg8CsnvGWKm5gyC05Fjl0n3gE0kmTtdgVId
	z0v91kfe4DAwPqWpsLrA==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gm1PT-00027a-Vb; Tue, 22 Jan 2019 19:08:31 +0000
Received: from usa-sjc-mx-foss1.foss.arm.com ([217.140.101.70]
 helo=foss.arm.com)
 by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gm1PQ-00027D-3L
 for linux-arm-kernel@lists.infradead.org; Tue, 22 Jan 2019 19:08:29 +0000
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id B5B45EBD;
 Tue, 22 Jan 2019 11:08:27 -0800 (PST)
Received: from [10.1.197.21] (usa-sjc-imap-foss1.foss.arm.com [10.72.51.249])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id
 A4BF33F5C1; Tue, 22 Jan 2019 11:08:26 -0800 (PST)
From: Kristina Martsenko <kristina.martsenko@arm.com>
Subject: Re: [PATCH v2] arm64: add ptrace regsets for ptrauth key management
To: Dave Martin <Dave.Martin@arm.com>
References: <20190110193508.31888-1-kristina.martsenko@arm.com>
 <d2bcfb3a-3668-693c-2fd4-3814b473375c@arm.com>
 <20190111135842.GB3547@e103592.cambridge.arm.com>
 <911e27a9-d199-9a64-8a2e-597733af5854@arm.com>
 <20190116151254.GA3578@e103592.cambridge.arm.com>
Message-ID: <b8afbda4-c782-ceee-8294-a96a1fec02df@arm.com>
Date: Tue, 22 Jan 2019 19:08:25 +0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.4.0
MIME-Version: 1.0
In-Reply-To: <20190116151254.GA3578@e103592.cambridge.arm.com>
Content-Language: en-US
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190122_110828_144789_D2E1FA2C 
X-CRM114-Status: GOOD (  20.33  )
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

On 16/01/2019 15:13, Dave Martin wrote:
> On Tue, Jan 15, 2019 at 07:32:30PM +0000, Kristina Martsenko wrote:
>> On 11/01/2019 13:58, Dave Martin wrote:
>>> On Thu, Jan 10, 2019 at 07:41:15PM +0000, Kristina Martsenko wrote:
>>>> On 10/01/2019 19:35, Kristina Martsenko wrote:
>>>> @@ -80,12 +65,12 @@ static inline unsigned long ptrauth_strip_insn_pac(unsigned long ptr)
>>>>  #define ptrauth_thread_init_user(tsk)					\
>>>>  do {									\
>>>>  	struct task_struct *__ptiu_tsk = (tsk);				\
>>>
>>> Not added by this patch, but __ptiu_tsk doesn't seem to do anything
>>> except make the subsquent lines more verbose than otherwise (and pollute
>>> the identifier namespace -- though unlikely to be a problem).
>>>
>>> It may not be worth dropping it now that it's there though.
>>
>> Using __ptiu_tsk prevents the argument (tsk) from being evaluated twice,
>> which could have side effects.
> 
> Ah, right.
> 
> Actually, could this be a function instead?  That would avoid multiple-
> evaulation a clean way.

If it were a function, then this file (pointer_auth.h) would need to
#include <linux/sched.h> (for the struct task_struct definition), which
would create a circular header dependency, since sched.h #includes
asm/processor.h, which #includes pointer_auth.h. Alternatively the
function could be moved to pointer_auth.c, but that would prevent it
from being inlined, so I'd prefer to keep it as a macro for now.

>>>> -	ptrauth_keys_init(&__ptiu_tsk->thread.keys_user);		\
>>>> -	ptrauth_keys_switch(&__ptiu_tsk->thread.keys_user);		\
>>>> +	ptrauth_keys_init(&__ptiu_tsk->thread.uw.keys_user);		\
>>>> +	ptrauth_keys_switch(&__ptiu_tsk->thread.uw.keys_user);		\
>>>>  } while (0)
>>>>  
>>>>  #define ptrauth_thread_switch(tsk)	\
>>>> -	ptrauth_keys_switch(&(tsk)->thread.keys_user)
>>>> +	ptrauth_keys_switch(&(tsk)->thread.uw.keys_user)
> 
> Similarly, can this be a function?

Same reasons as above.

> (Technically tsk may be evaulated twice in this macro.  Given the way
> these macros are used, I'm not sure that matters though.)

tsk is only used once here, so I think it's only evaluated once.

>> Also note that with this patch we have struct "user_pac_address_keys" in
>> struct ptrauth_keys, which may be confusing once we start using pointer
>> authentication in the kernel and use struct ptrauth_keys for kernel keys
>> as well, not just user keys.
> 
> Not a big deal either way.
> 
> The main thing to freeze now are the user ABI and the UAPI header.  We
> can refactor the kernel's internal implementation later if we want.

Ok.

Kristina

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
