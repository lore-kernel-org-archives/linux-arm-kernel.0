From: marc.zyngier@arm.com (Marc Zyngier)
Date: Mon, 11 Dec 2017 15:22:58 +0000
Subject: [PATCH v2 01/19] arm64: asm-offsets: Avoid clashing DMA
 definitions
In-Reply-To: <20171211150307.GV10595@n2100.armlinux.org.uk>
References: <20171211144937.4537-1-marc.zyngier@arm.com>
 <20171211144937.4537-2-marc.zyngier@arm.com>
 <20171211150307.GV10595@n2100.armlinux.org.uk>
Message-ID: <44ae7c94-61af-fba6-a32f-37a31f536895@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 11/12/17 15:03, Russell King - ARM Linux wrote:
> On Mon, Dec 11, 2017 at 02:49:19PM +0000, Marc Zyngier wrote:
>> asm-offsets.h contains a few DMA related definitions that have
>> the exact same name than the enum members they are derived from.
>>
>> While this is not a problem so far, it will become an issue if
>> both asm-offsets.h and include/linux/dma-direction.h: are pulled
>> by the same file.
> 
> Umm.  asm-offsets.h is only supposed to be included by assembly files.
> Assembly files would not be able to include linux/dma-direction.h
> So this shouldn't be a problem.
> 
> The same could be true of things like CLOCK_REALTIME etc.
> 
> Just don't do it.  Keep asm-offsets.h as something that gets included
> by assembly and only assembly.

That'd be true if C code never used anything that is exposed by
asm-offsets.h. Unfortunately, things like our alternative patching
relies on generating assembly (or rather, using assembly generated data
structures). For more details, please see patch 4 in the same series.

Thanks,

	M.
-- 
Jazz is not dead. It just smells funny...
