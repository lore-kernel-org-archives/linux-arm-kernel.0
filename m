From: dave.long@linaro.org (David Long)
Date: Thu, 21 Jul 2016 10:50:53 -0400
Subject: [PATCH v15 04/10] arm64: Kprobes with single stepping support
In-Reply-To: <20160720154956.GE25890@e104818-lin.cambridge.arm.com>
References: <1467995754-32508-1-git-send-email-dave.long@linaro.org>
 <1467995754-32508-5-git-send-email-dave.long@linaro.org>
 <20160720154956.GE25890@e104818-lin.cambridge.arm.com>
Message-ID: <5790E14D.8030904@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 07/20/2016 11:49 AM, Catalin Marinas wrote:
> On Fri, Jul 08, 2016 at 12:35:48PM -0400, David Long wrote:
>> +#define MIN_STACK_SIZE(addr)	(on_irq_stack(addr, raw_smp_processor_id()) ? \
>> +	min((unsigned long)IRQ_STACK_SIZE,	\
>> +	IRQ_STACK_PTR(raw_smp_processor_id()) - (addr)) : \
>> +	min((unsigned long)MAX_STACK_SIZE,	\
>> +	(unsigned long)current_thread_info() + THREAD_START_SP - (addr)))
>
> I presume you've never tested the on_irq_stack() path in this macro.
>

The combined patches were run through the test suite we've been using 
all along.  Apparently that either does not test jprobes on functions 
using the interrupt stack or somehow just didn't happen to cause an 
overwrite of something critical.

-dl
