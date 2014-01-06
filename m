From: santosh.shilimkar@ti.com (Santosh Shilimkar)
Date: Mon, 6 Jan 2014 14:33:47 -0500
Subject: Regression (ARM) arch/arm/mm/init.c doesn't build without
 CONFIG_ARM_PATCH_PHYS_VIRT.
In-Reply-To: <m3ha9gx63v.fsf@t19.piap.pl>
References: <m38uv1uuzr.fsf@t19.piap.pl> <m3ha9gx63v.fsf@t19.piap.pl>
Message-ID: <52CB051B.1040808@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Monday 06 January 2014 02:28 PM, Krzysztof Ha?asa wrote:
> Russell, Santosh,
> 
> the unneeded commit causing regression is still in place. Please try to
> compile an ARM kernel without CONFIG_ARM_PATCH_PHYS_VIRT and with
> CONFIG_ZONE_DMA and see for yourself, if you don't believe me.
> 
> Please be aware that this commit fixes nothing, its only function is
> causing the regression - so we don't lose anything by reverting it.
> 
I am afraid you didn't understood what the fix is if you say above.
arm_dma_limit is broken without this fix for LPAE machines with
memory starting 4 GB physical boundary.

Regards,
Santosh
