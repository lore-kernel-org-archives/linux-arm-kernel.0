From: a0131933@ti.com (Lokesh Vutla)
Date: Wed, 30 Sep 2015 15:11:54 +0530
Subject: [PATCHv4] arm: omap2: timer: always define omap4_local_timer_init
In-Reply-To: <560B9210.1080700@ti.com>
References: <1443543337-2904-1-git-send-email-balbi@ti.com>
 <560B9210.1080700@ti.com>
Message-ID: <560BAE62.9000503@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org



On Wednesday 30 September 2015 01:11 PM, Lokesh Vutla wrote:
> Hi Felipe,
> 
> On Tuesday 29 September 2015 09:45 PM, Felipe Balbi wrote:
>> omap4_local_timer_init() can be used by other
>> platforms as is. At least AM437x wants to use
>> it. Instead of making omap4-only and providing
>> a stub for builds without OMAP4, we can just
>> make sure that function is always available
>> for all SoCs that need it.
> You might also want to update init_time function pointer for AM43xx in
> board_generic.c or is there any dependency for this patch? With this
> patch alone AM43xx only build is broken.
> 
> arch/arm/mach-omap2/built-in.o:(.arch.info.init+0x54): undefined
> reference to `omap3_gptimer_timer_init'
> Makefile:944: recipe for target 'vmlinux' failed
> make: *** [vmlinux] Error 1
I think the following series needs to be applied.
http://www.mail-archive.com/linux-omap%40vger.kernel.org/msg119840.html
Sorry for the noise.

Thanks and regards,
Lokesh
