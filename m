From: dave.long@linaro.org (David Long)
Date: Fri, 21 Nov 2014 01:16:38 -0500
Subject: [PATCH v3 5/5] arm64: Add HAVE_REGS_AND_STACK_ACCESS_API feature
In-Reply-To: <20141118145228.GN18842@arm.com>
References: <1416292375-29560-1-git-send-email-dave.long@linaro.org>
 <1416292375-29560-6-git-send-email-dave.long@linaro.org>
 <20141118145228.GN18842@arm.com>
Message-ID: <546ED8C6.8050003@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 11/18/14 09:52, Will Deacon wrote:
> Hi David,
>
> On Tue, Nov 18, 2014 at 06:32:55AM +0000, David Long wrote:
>> From: "David A. Long" <dave.long@linaro.org>
>>
>> Add HAVE_REGS_AND_STACK_ACCESS_API feature for arm64.
>
> [...]
>
>> diff --git a/arch/arm64/include/asm/ptrace.h b/arch/arm64/include/asm/ptrace.h
>> index d3e782a..24cc048 100644
>> --- a/arch/arm64/include/asm/ptrace.h
>> +++ b/arch/arm64/include/asm/ptrace.h
>> @@ -111,6 +111,8 @@ struct pt_regs {
>>   	u64 syscallno;
>>   };
>>
>> +#define MAX_REG_OFFSET (offsetof(struct pt_regs, orig_x0))
>
> Is orig_x0 actually useful to this API? If not, we could instead operate on
> the user_pt_regs structure, and define the maximum offset in terms of sizeof
> that.
>

I agree.  I don't think the orig_x0 field should be exposed through this 
API.

>> +#define ARM_cpsr	pstate
>> +#define ARM_pc		pc
>> +#define ARM_sp		sp
>> +#define ARM_lr		regs[30]
>> +#define ARM_fp		regs[29]
>> +#define ARM_x28		regs[28]
>> +#define ARM_x27		regs[27]
>
> [...]
>
> I don't think we need these #defines.
>
> Will

These are used in the REG_OFFSET_NAME macro.  This is all borrowed from 
arch/arm/ code.  I didn't see a need to redesign it.

-dl
