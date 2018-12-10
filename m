Return-Path: <SRS0=/awj=OT=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2B890C5CFFE
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Mon, 10 Dec 2018 13:52:48 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id F00242086D
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Mon, 10 Dec 2018 13:52:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="H9TeAQNL"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org F00242086D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:Date:
	Message-ID:From:References:To:Subject:Reply-To:Content-ID:Content-Description
	:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=qmOBx4+zQ2C+ckMQpqRaoPQxIpA6TMqZJ5mEpTzUo+c=; b=H9TeAQNLlmOZVz
	GSusplUhjmY5nbvF8dh1H5wPoxhK0A9NQ1NB0nxclpwMJb7lLNyYQIzZXv0bepWFt0naF+aU1YIor
	4fr43j+4MzKJssL7NKV6vC7Z5SL3QAxi6O6rCQspArNNbYDJX0UaWF7pMet+yy4tyOZHlT3Yk25/9
	4wKfOMFG/7WFJliojA5D0ijmNlPQN+IW2Y/Lh8ex0ORmWn2oaIlQtdEE8VA3yw7tamxO7KGE0dq9Q
	JgN8t61TapQmRE1zJVH5M7S9C62IM/zBMgk/oXWRyov05tbe4CKa7RRiIQHukNpsi8oZEwkwIrv3Y
	z4XJ8Fc/8qtEwBSKzOcw==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gWLzD-0002Bd-LG; Mon, 10 Dec 2018 13:52:39 +0000
Received: from foss.arm.com ([217.140.101.70])
 by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gWLz6-0002Ah-HO
 for linux-arm-kernel@lists.infradead.org; Mon, 10 Dec 2018 13:52:37 +0000
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 7DFC81596;
 Mon, 10 Dec 2018 05:52:20 -0800 (PST)
Received: from [10.1.196.55] (e112269-lin.cambridge.arm.com [10.1.196.55])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 6D41F3F575;
 Mon, 10 Dec 2018 05:52:19 -0800 (PST)
Subject: Re: [PATCH 03/12] arm/arm64: Provide a wrapper for SMCCC 1.1 calls
To: Mark Rutland <mark.rutland@arm.com>
References: <20181128144527.44710-1-steven.price@arm.com>
 <20181128144527.44710-4-steven.price@arm.com>
 <20181210102736.2iluzzfuryfnf4rk@lakrids.cambridge.arm.com>
From: Steven Price <steven.price@arm.com>
Message-ID: <32c77d11-047d-cc78-7be2-9a7a72b08deb@arm.com>
Date: Mon, 10 Dec 2018 13:52:17 +0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.3.0
MIME-Version: 1.0
In-Reply-To: <20181210102736.2iluzzfuryfnf4rk@lakrids.cambridge.arm.com>
Content-Language: en-GB
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20181210_055235_318902_435376F3 
X-CRM114-Status: GOOD (  23.67  )
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
Cc: Marc Zyngier <marc.zyngier@arm.com>,
 Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will.deacon@arm.com>,
 kvmarm@lists.cs.columbia.edu, linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

On 10/12/2018 10:27, Mark Rutland wrote:
> On Wed, Nov 28, 2018 at 02:45:18PM +0000, Steven Price wrote:
>> SMCCC 1.1 calls may use either HVC or SMC depending on the PSCI
>> conduit. Rather than coding this in every call site provide a macro
>> which uses the correct instruction. The macro also handles the case
>> where no PSCI conduit is configured returning a not supported error
>> in res, along with returning the conduit used for the call.
>>
>> This allow us to remove some duplicated code and will be useful later
>> when adding paravirtualized time hypervisor calls.
>>
>> Signed-off-by: Steven Price <steven.price@arm.com>
>> ---
>>  include/linux/arm-smccc.h | 44 +++++++++++++++++++++++++++++++++++++++
>>  1 file changed, 44 insertions(+)
>>
>> diff --git a/include/linux/arm-smccc.h b/include/linux/arm-smccc.h
>> index 18863d56273c..b047009e7a0a 100644
>> --- a/include/linux/arm-smccc.h
>> +++ b/include/linux/arm-smccc.h
>> @@ -311,5 +311,49 @@ asmlinkage void __arm_smccc_hvc(unsigned long a0, unsigned long a1,
>>  #define SMCCC_RET_NOT_SUPPORTED			-1
>>  #define SMCCC_RET_NOT_REQUIRED			-2
>>  
>> +/* Like arm_smccc_1_1* but always returns SMCCC_RET_NOT_SUPPORTED.
>> + * Used when the PSCI conduit is not defined. The empty asm statement
>> + * avoids compiler warnings about unused variables.
>> + */
>> +#define __fail_smccc_1_1(...)						\
>> +	do {								\
>> +		__declare_args(__count_args(__VA_ARGS__), __VA_ARGS__);	\
>> +		asm ("" __constraints(__count_args(__VA_ARGS__)));	\
>> +		if (___res)						\
>> +			___res->a0 = SMCCC_RET_NOT_SUPPORTED;		\
>> +	} while (0)
>> +
>> +/*
>> + * arm_smccc_1_1() - make an SMCCC v1.1 compliant call
>> + *
>> + * This is a variadic macro taking one to eight source arguments, and
>> + * an optional return structure.
>> + *
>> + * @a0-a7: arguments passed in registers 0 to 7
>> + * @res: result values from registers 0 to 3
>> + *
>> + * This macro will make either an HVC call or an SMC call depending on the
>> + * current PSCI conduit. If no valid conduit is available then -1
>> + * (SMCCC_RET_NOT_SUPPORTED) is returned in @res.a0 (if supplied).
>> + *
>> + * The return value also provides the conduit that was used.
>> + */
>> +#define arm_smccc_1_1(...) ({						\
> 
> As a minor nit, could we please give call this something like
> arm_smccc_1_1_call() or arm_smccc_1_1_invoke(), to make it clear what
> action this performs?

Sure, arm_smccc_1_1_call() works for me.

> I had some patches [1] cleaning up the SMCCC API, it would be nice if we
> could pick up some of those as preparatory bits, before we spread some
> of the current design warts (e.g. SMCCC depending on PSCI definitions).

Looks like a similar approach, just extended to include
s/PSCI_CONDUIT/SMCCC_CONDUIT/ and making arm_smccc_1_1_* return res.
Would you like me to drop this (and the next) patch in favour of yours?

Thanks,

Steve

> Thanks,
> Mark.
> 
> [1] git://git.kernel.org/pub/scm/linux/kernel/git/mark/linux.git arm64/smccc-cleanup
> 
>> +		int method = psci_ops.conduit;				\
>> +		switch (method) {					\
>> +		case PSCI_CONDUIT_HVC:					\
>> +			arm_smccc_1_1_hvc(__VA_ARGS__);			\
>> +			break;						\
>> +		case PSCI_CONDUIT_SMC:					\
>> +			arm_smccc_1_1_smc(__VA_ARGS__);			\
>> +			break;						\
>> +		default:						\
>> +			__fail_smccc_1_1(__VA_ARGS__);			\
>> +			method = PSCI_CONDUIT_NONE;			\
>> +			break;						\
>> +		}							\
>> +		method;							\
>> +	})
>> +
>>  #endif /*__ASSEMBLY__*/
>>  #endif /*__LINUX_ARM_SMCCC_H*/
>> -- 
>> 2.19.2
>>
> _______________________________________________
> kvmarm mailing list
> kvmarm@lists.cs.columbia.edu
> https://lists.cs.columbia.edu/mailman/listinfo/kvmarm
> 


_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
