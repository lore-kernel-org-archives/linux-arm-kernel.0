From: magnus.damm@gmail.com (Magnus Damm)
Date: Fri, 17 Dec 2010 20:39:15 +0900
Subject: [PATCH 01/03] ARM: mach-shmobile: SMP base support
In-Reply-To: <20101217084211.GZ9937@n2100.arm.linux.org.uk>
References: <20101214075647.11275.25933.sendpatchset@t400s>
	<20101214075655.11275.95963.sendpatchset@t400s>
	<20101217084211.GZ9937@n2100.arm.linux.org.uk>
Message-ID: <AANLkTi=ziv-ejjEbQaV-vKj8mytHNesjxL_+-H9iu4ey@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Dec 17, 2010 at 5:42 PM, Russell King - ARM Linux
<linux@arm.linux.org.uk> wrote:
> On Tue, Dec 14, 2010 at 04:56:55PM +0900, Magnus Damm wrote:
>> +/*
>> + * Reset vector for secondary CPUs.
>> + * This will be mapped at address 0 by SBAR register.
>> + * We need _long_ jump to the physical address.
>> + */
>> + ? ? .align ?12
>> +ENTRY(shmobile_secondary_vector)
>> + ? ? ldr ? ? pc, 1f
>> +1: ? .long ? secondary_startup - CONFIG_PAGE_OFFSET + CONFIG_MEMORY_START
>
> BTW, why not use - PAGE_OFFSET + PHYS_OFFSET here? ?Both these macros
> are available for use in assembly code - just include asm/memory.h.

Sure, good point. This was actually the only part of this series that
I wasn't 100% satisfied with.

Will send a patch on top of this series during early next week.

Thanks,

/ magnus
