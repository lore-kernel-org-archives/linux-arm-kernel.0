From: tim.bird@am.sony.com (Tim Bird)
Date: Tue, 2 Apr 2013 14:08:46 -0700
Subject: RFC: right way to conditional-ize some macros for LTO
In-Reply-To: <1364907037.3650.54.camel@linaro1.home>
References: <5155E28A.30509@am.sony.com>
 <1364907037.3650.54.camel@linaro1.home>
Message-ID: <515B48DE.4000808@am.sony.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 04/02/2013 05:50 AM, Jon Medhurst (Tixy) wrote:
> On Fri, 2013-03-29 at 11:50 -0700, Tim Bird wrote:
>> The macros themselves seem empty.  Can someone tell me what they do?
>> What is the status of these macros?  Are they even needed?
> 
> The names of the macros are for Thumb2 instructions which are redundant
> when building for the ARM instruction set. Newer toolchains which
> support the unified assembler syntax will effectively ignore them and I
> guess these empty macros are there so people can write assembler which
> will compile with older toolchains.
> 
>> Could they be
>> made conditional on something like NEED_IT_MACROS, and then have that set only
>> in the arch/arm/kernel/kprobes-test-thumb.c, before the unified.h is included?
> 
> That file needs the real Thumb2 instructions, not empty macros, and
> indeed it doesn't use them, because it is only compiled when
> CONFIG_THUMB2_KERNEL=y and that selects CONFIG_ARM_ASM_UNIFIED and those
> 'it' macro's are guarded by #ifndef CONFIG_ARM_ASM_UNIFIED.
> 
> Note, there are other files which use the 'it' instructions, e.g.
> arch/arm/include/asm/futex.h.
> 
>> I would like get this minor issue resolved in mainline, to make it easier for Andi
>> to get his LTO work upstream and have it work with ARM.
>>
>> Any suggestions are welcome.
> 
> If your toolchain supports the unified assembler syntax, you could try
> enabling CONFIG_ARM_ASM_UNIFIED in ARM builds.

Thanks very much!  It may well be that any toolchain capable of supporting
LTO will support the unified assembler syntax, in which case it would make
sense for LTO to enable this, on ARM.  I'll check it out.
 -- Tim

=============================
Tim Bird
Architecture Group Chair, CE Workgroup of the Linux Foundation
Senior Staff Engineer, Sony Network Entertainment
=============================
