From: behanw@converseincode.com (Behan Webster)
Date: Fri, 06 Sep 2013 18:54:08 -0400
Subject: [PATCH 1/5] arm: LLVMLinux: Add current_stack_pointer macro for
 ARM
In-Reply-To: <20130906222027.GR6617@n2100.arm.linux.org.uk>
References: <1378502899-1241-1-git-send-email-behanw@converseincode.com>
 <1378502899-1241-2-git-send-email-behanw@converseincode.com>
 <20130906222027.GR6617@n2100.arm.linux.org.uk>
Message-ID: <522A5D10.2040609@converseincode.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 09/06/13 18:20, Russell King - ARM Linux wrote:
> On Fri, Sep 06, 2013 at 05:28:07PM -0400, behanw at converseincode.com wrote:
>> From: Behan Webster <behanw@converseincode.com>
>>
>> A macro to get the current stack pointer which allows for a single place in
>> which to do so with ASM. Before this named registers (a gcc extension) was used
>> to get the stack pointer. Using ASM is a more portable way of getting the stack
>> pointer which works with both gcc and clang.  This macro is of the same name
>> used in the X86 arch.
> This will result in less optimal code - rather than the compiler being
> able to mask directly with 'sp', it's going to have to use this bit of
> assembly to first move it into another register.
I understand. The issue is that clang doesn't support naming registers 
like this. It's a gcc-ism.

I'm not entirely happy with this solution either, but it was what we 
could get to work for both compilers without the use of ifdefs.

Though also not ideal, how about an #ifdef for clang to do it this way, 
otherwise do it with named registers for gcc? Would that be acceptable?

Thanks,

Behan

-- 
Behan Webster
behanw at converseincode.com
