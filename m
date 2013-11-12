From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Tue, 12 Nov 2013 14:41:28 +0000
Subject: Physical memory start contraints in the Linux kernel (Was: Re:
 Xen osstest on Calxeda midway progress (Was: Re: [Xen-devel]
 [xen-unstable test] 21486: tolerable FAIL - PUSHED))
In-Reply-To: <52823C9E.2010007@linaro.org>
References: <osstest-21486-mainreport@xen.org>
 <1384250005.1883.35.camel@kazak.uk.xensource.com>
 <alpine.DEB.2.02.1311121212240.26077@kaball.uk.xensource.com>
 <201311121437.55826.arnd@arndb.de> <52823C9E.2010007@linaro.org>
Message-ID: <20131112144128.GL16735@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Nov 12, 2013 at 02:35:10PM +0000, Julien Grall wrote:
> During some debugging on the Arndale and Midway, I found another  
> constraint with CONFIG_ARM_PATCH_PHYS_VIRT.
> I have noticed that all the kernel physical addresses must be lower than  
> the corresponding virtual addresses. So the delta offset compute in  
> __fixup_pv_table (arch/arm/kernel/head.S) must always be negative.
> If this assertion is not validated, when the kernel will browse the  
> memory bank (sanity_check_info in arch/arm/mm/mmu.c), __phys(...) will  
> compute a wrong address and will result to consider all memory bank as  
> highmem.
>
> After digging in the code, it seems it's due to some optimization during  
> opcode fixup in __fixup_a_pvtable. Is it a wanted constraint?

Are you talking about the code in v3.12 or the code in -next ?
