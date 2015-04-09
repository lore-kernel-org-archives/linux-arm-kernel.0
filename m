From: takahiro.akashi@linaro.org (AKASHI Takahiro)
Date: Thu, 09 Apr 2015 12:53:58 +0900
Subject: [v3 1/5] arm64: kvm: add a cpu tear-down function
In-Reply-To: <20150408130221.GA5977@leverpostej>
References: <1427953216-11737-1-git-send-email-takahiro.akashi@linaro.org>
 <1427953216-11737-2-git-send-email-takahiro.akashi@linaro.org>
 <20150408130221.GA5977@leverpostej>
Message-ID: <5525F7D6.2040304@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 04/08/2015 10:02 PM, Mark Rutland wrote:
>> +	/* We're now in idmap, disable MMU */
>> +1:	mrs	x0, sctlr_el2
>> +	and	x1, x0, #SCTLR_EL2_EE
>> +	orr	x0, x0, x1		// preserve endianness of EL2
>> +	ldr	x1, =SCTLR_EL2_FLAGS
>> +	eor	x1, x1, xzr
>> +	bic	x0, x0, x1		// Clear SCTL_M and etc
>> +	msr	sctlr_el2, x0
>> +	isb
>
> This can instead be:
>
> 1:	mrs	x0, sctlr_el2
> 	ldr	x1, =SCTLR_EL2_FLAGS
> 	bic	x0, x0, x1
> 	msr	sctlr_el2, x0
> 	isb
>
> As SCTLR_EL2_FLAGS doesn't contain the EE bit.

Oops. I will fix it.

Thanks,
-Takahiro AKASHI

> Mark.
>
