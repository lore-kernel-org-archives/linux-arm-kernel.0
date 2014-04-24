From: tim@krieglstein.org (Tim Sander)
Date: Thu, 24 Apr 2014 16:33:38 +0200
Subject: set_fiq_handler: Bad mode in data abort handler detected
In-Reply-To: <20140424103136.GI26756@n2100.arm.linux.org.uk>
References: <2527501.cXAbiV8bqS@dabox>
 <20140424103136.GI26756@n2100.arm.linux.org.uk>
Message-ID: <2181550.Duxpmd4GvD@dabox>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Russell and List
<snip>
> In years gone by, I'd have recommended that the kernel mappings for
> this stuff were done via static mappings, but with DT, that's no
> longer acceptable.  So I guess we have a problem...
To verify that your very plausible hypothesis is right i tried:
timer_memory = __arm_ioremap(0x4280000>>PAGE_SHIFT,0x1000,MT_MEMORY); //also tried MT_DEVICE

the memory at early boot in "zynq_init_late". But this fails and gives 
the following error:

WARNING: CPU: 0 PID: 1 at arch/arm/mm/ioremap.c:301 __arm_ioremap_pfn_caller+0x100/0x184()
which seems to be the only WARN_ON which shows that the pfn is invalid.

Any hints why this call to __arm_ioremap fails?

Also i tried to map with ioremap_nocache during module load but i 
guess this information also gets propagated lazy so it also didn't
work.

Best regards
Tim
