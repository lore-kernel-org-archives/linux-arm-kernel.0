From: sboyd@codeaurora.org (Stephen Boyd)
Date: Tue, 08 Nov 2011 11:14:11 -0800
Subject: [PATCHv3 2/2] msm: Support DEBUG_LL on MSM8660 and MSM8960
In-Reply-To: <alpine.LFD.2.02.1111081406220.3307@xanadu.home>
References: <1320777184-22446-1-git-send-email-sboyd@codeaurora.org>
 <1320777184-22446-3-git-send-email-sboyd@codeaurora.org>
 <alpine.LFD.2.02.1111081406220.3307@xanadu.home>
Message-ID: <4EB97F83.3070509@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 11/08/11 11:08, Nicolas Pitre wrote:
> Independently from this patch, I was wondering about this code:
>
>> +	.macro	senduart, rd, rx
>> +#ifdef CONFIG_MSM_HAS_DEBUG_UART_HS
>> +	@ Write the 1 character to UARTDM_TF
>> +	str	\rd, [\rx, #0x70]
>> +#else
>>  	teq	\rx, #0
>>  	strne	\rd, [\rx, #0x0C]
>> +#endif
>>  	.endm
> Why testing for zero in the #else part?  The upper level code should 
> never call this macro with a null byte.
>

I was wondering the same thing, I don't know why that test for null is
there. I will dust off the old 7201a (literally) and see what I can find
out. It certainly looks unnecessary.

-- 
Sent by an employee of the Qualcomm Innovation Center, Inc.
The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum.
