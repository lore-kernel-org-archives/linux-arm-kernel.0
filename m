From: marc.zyngier@arm.com (Marc Zyngier)
Date: Fri, 07 Aug 2015 11:33:54 +0100
Subject: [PATCH TRIVIAL] Enable GICv2m on ARM virt machine
In-Reply-To: <00f901d0d0fa$b8168770$28439650$@samsung.com>
References: <00f501d0ce9c$4d57bcc0$e8073640$@samsung.com>
 <55C471D0.8050400@arm.com> <00f901d0d0fa$b8168770$28439650$@samsung.com>
Message-ID: <55C48992.6060700@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 07/08/15 11:20, Pavel Fedin wrote:
> Hello!
> 
>> You may want to add a comment about the dependency chain that requires
>> the generic msi.h.
> 
>  The error i get is:
> --- cut ---
> In file included from kernel/irq/chip.c:14:0:
> include/linux/msi.h:123:21: fatal error: asm/msi.h: No such file or directory
>  #include <asm/msi.h>
>                      ^
> --- cut ---
> 
> This portion in linux/msi.h sits under #ifdef CONFIG_GENERIC_MSI_IRQ_DOMAIN, which is activated by
> the following chain:
> ARM_GIC_V2M => PCI_MSI_IRQ_DOMAIN => GENERIC_MSI_IRQ_DOMAIN
> 
>  Do i need to respin just because of comment?

That's for Russell to decide, really. But I feel that adding an include
file that affects the whole architecture (and not just a single
platform) deserves an explanation in the commit log.

Thanks,

	M.
-- 
Jazz is not dead. It just smells funny...
