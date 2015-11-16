From: marc.zyngier@arm.com (Marc Zyngier)
Date: Mon, 16 Nov 2015 19:26:28 +0000
Subject: A problem about interrupt when booting a captured kernel
In-Reply-To: <5645B6D3.60305@huawei.com>
References: <5645B6D3.60305@huawei.com>
Message-ID: <564A2DE4.4030702@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 13/11/15 10:09, Yang Yingliang wrote:
> Hi, Marc
> 
> 
>      The kexec will boot a captured kernel while the kernel panic. But
> it boots failed if the kernel panic in handler function of PPI. The 
> reason is that the PPI has not been 'eoi', other interrupts can not be 
> handled when booting  the captured kernel.
> 
>      The kexec will call irq_eoi to end the irqs that have
> IRQD_IRQ_INPROGRESS flag. But PPIs don't have this flag, so it won't be 
> ended.
> 
>     Three ways to solve this problem we can think :
>     1. Is there a way to reset gic like its_reset ?
>     2. Can we add some flag for calling irq_eoi ?
>     3. Just 'eoi' all PPIs without checking flags in kexec.
> 
>      Please give some advice.

Good timing. Please see:

http://lists.infradead.org/pipermail/linux-arm-kernel/2015-November/385383.html

and let me know if that fixes things for you.

Thanks,

	M.
-- 
Jazz is not dead. It just smells funny...
