From: liuj97@gmail.com (Jiang Liu)
Date: Wed, 25 Sep 2013 23:50:40 +0800
Subject: [PATCH v1 1/7] arm64: introduce basic aarch64 instruction decoding
 helpers
In-Reply-To: <5242DE0F.1080601@codeaurora.org>
References: <1380105868-31985-1-git-send-email-liuj97@gmail.com>
 <1380105868-31985-2-git-send-email-liuj97@gmail.com>
 <5242DE0F.1080601@codeaurora.org>
Message-ID: <52430650.90300@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 09/25/2013 08:58 PM, Christopher Covington wrote:
> Hi Jiang,
> 
> On 09/25/2013 06:44 AM, Jiang Liu wrote:
> 
> [...]
> 
>> diff --git a/arch/arm64/kernel/insn.c b/arch/arm64/kernel/insn.c
> 
> [...]
> 
>> +static int aarch64_insn_cls[] = {
>> +	AARCH64_INSN_CLS_UNKNOWN,	/* 0 0 X X */
>> +	AARCH64_INSN_CLS_UNKNOWN,	/* 0 0 X X */
>> +	AARCH64_INSN_CLS_UNKNOWN,	/* 0 0 X X */
>> +	AARCH64_INSN_CLS_UNKNOWN,	/* 0 0 X X */
>> +	AARCH64_INSN_CLS_LDST,		/* X 1 X 0 */
>> +	AARCH64_INSN_CLS_DP_REG,	/* X 1 0 1 */
>> +	AARCH64_INSN_CLS_LDST,		/* X 1 X 0 */
>> +	AARCH64_INSN_CLS_DP_FPSIMD,	/* 0 1 1 1 */
>> +	AARCH64_INSN_CLS_DP_IMM,	/* 1 0 0 X */
>> +	AARCH64_INSN_CLS_DP_IMM,	/* 1 0 0 X */
>> +	AARCH64_INSN_CLS_BR_SYS,	/* 1 0 1 X */
>> +	AARCH64_INSN_CLS_BR_SYS,	/* 1 0 1 X */
>> +	AARCH64_INSN_CLS_LDST,		/* X 1 X 0 */
>> +	AARCH64_INSN_CLS_DP_REG,	/* X 1 0 1 */
>> +	AARCH64_INSN_CLS_LDST,		/* X 1 X 0 */
>> +	AARCH64_INSN_CLS_DP_FPSIMD,	/* 1 1 1 1 */
>> +};
> 
> As I read this, I was initially puzzled as to why there are duplicate entries
> in the list. Since the data structure doesn't really support don't-cares,
> perhaps it would be clearer to use 1's and 0's instead of X's.
Thanks for review, Chris!
I will try to improve the comments in next version.

> 
> [...]
> 
> Thanks,
> Christopher
> 
