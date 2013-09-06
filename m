From: behanw@converseincode.com (Behan Webster)
Date: Fri, 06 Sep 2013 18:50:45 -0400
Subject: [PATCH 1/5] arm: LLVMLinux: Add current_stack_pointer macro for
 ARM
In-Reply-To: <yw1xmwnp1txm.fsf@unicorn.mansr.com>
References: <1378502899-1241-1-git-send-email-behanw@converseincode.com>
 <1378502899-1241-2-git-send-email-behanw@converseincode.com>
 <yw1xmwnp1txm.fsf@unicorn.mansr.com>
Message-ID: <522A5C45.5030709@converseincode.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 09/06/13 18:12, M?ns Rullg?rd wrote:
> behanw at converseincode.com writes:
>
>> +#define current_stack_pointer ({ \
>> +	unsigned long current_sp; \
>> +	asm ("mov %0, r13" : "=r" (current_sp)); \
>> +	current_sp; \
>> +})
> Why do you use 'r13' rather than the more common 'sp' alias?
Originally we were using LLVM's Integrated Assembler (IA), which didn't 
allow for that alias if I remember correctly. However, now we're using 
gas because IA only supports Unified Assembly Language grammar, and not 
the extensions that are common in the kernel code.

I can resubmit using that alias (after the rest of the discussion).

Behan

-- 
Behan Webster
behanw at converseincode.com
