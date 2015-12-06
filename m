From: jungseoklee85@gmail.com (Jungseok Lee)
Date: Sun, 6 Dec 2015 22:15:19 +0900
Subject: [PATCH v8 1/4] arm64: Store struct task_info in sp_el0
In-Reply-To: <20151204132743.GH10123@e104818-lin.cambridge.arm.com>
References: <1449226948-14251-1-git-send-email-james.morse@arm.com>
 <1449226948-14251-2-git-send-email-james.morse@arm.com>
 <20151204132743.GH10123@e104818-lin.cambridge.arm.com>
Message-ID: <7D8904A9-7A41-4258-B88F-ABA2F1136331@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Dec 4, 2015, at 10:27 PM, Catalin Marinas wrote:

Hi Catalin,

> On Fri, Dec 04, 2015 at 11:02:25AM +0000, James Morse wrote:
>> --- a/arch/arm64/kernel/entry.S
>> +++ b/arch/arm64/kernel/entry.S
> [...]
>> @@ -599,6 +606,8 @@ ENTRY(cpu_switch_to)
>> 	ldp	x29, x9, [x8], #16
>> 	ldr	lr, [x8]
>> 	mov	sp, x9
>> +	and	x9, x9, #~(THREAD_SIZE - 1)
>> +	msr	sp_el0, x9
>> 	ret
>> ENDPROC(cpu_switch_to)
> 
> At the beginning of the cpu_switch_to function, could we do
> "mrs x9, sp_el0" instead to avoid the "and ... ~(THREAD_SIZE-1)"?
> 
> Otherwise:
> 
> Reviewed-by: Catalin Marinas <catalin.marinas@arm.com>

Thanks for reviewing this one!

If this one is picked up without re-spin, it would be better to change
the word 'task_info' in the subject to 'thread_info' for clarification.

Best Regards
Jungseok Lee
