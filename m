From: dave.martin@linaro.org (Dave Martin)
Date: Thu, 7 Apr 2011 10:36:37 +0100
Subject: [RFC PATCH] ARM: fiq: Refactor {get,set}_fiq_regs() for Thumb-2
In-Reply-To: <alpine.LFD.2.00.1104061329520.28032@xanadu.home>
References: <1302085787-15069-1-git-send-email-dave.martin@linaro.org>
	<alpine.LFD.2.00.1104061329520.28032@xanadu.home>
Message-ID: <BANLkTi=eA1vQDjLF_JAJhFEjhXKfw_G_xQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Apr 6, 2011 at 6:37 PM, Nicolas Pitre <nicolas.pitre@linaro.org> wrote:
> On Wed, 6 Apr 2011, Dave Martin wrote:
>
>> ?* To remove the risk of inconvenient register allocation decisions
>> ? ?by the compiler, these functions are separated out as pure
>> ? ?assembler.
>>
>> ?* The apcs frame manipulation code is not applicable for Thumb-2
>> ? ?(and also not easily compatible). ?Since it's not essential to
>> ? ?have a full frame on these leaf assembler functions, the frame
>> ? ?manipulation is removed, in the interests of simplicity.
>>
>> ?* Split up ldm/stm instructions to be compatible with Thumb-2,
>> ? ?as well as avoiding instruction forms deprecated on >= ARMv7.
>>
>> Signed-off-by: Dave Martin <dave.martin@linaro.org>
>
> I like. ?Minor nit:
>
>> +/*
>> + * Taking an interrupt in FIQ mode is death, so both these functions
>> + * disable irqs for the duration. ?Note - these functions are almost
>> + * entirely coded in assembly.
>> + */
>
> I think it is obvious the last sentence may go, especially since
> "almost" is not exactly true anymore.

Actually, my local fixes tidied that away too... I'll repost, since
there are other errors too...

>
> Other than that:
>
> Reviewed-by: Nicolas Pitre <nicolas.pitre@linaro.org>

Thanks

---Dave
