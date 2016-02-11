From: marc.zyngier@arm.com (Marc Zyngier)
Date: Thu, 11 Feb 2016 15:45:26 +0000
Subject: [PATCH] irqchip/gic-v3-its: Fix double EOIR write for LPI in
 EOImode==1
In-Reply-To: <1455197933-26141-1-git-send-email-ashoks@broadcom.com>
References: <1455197933-26141-1-git-send-email-ashoks@broadcom.com>
Message-ID: <56BCAC96.7040509@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 11/02/16 13:38, Ashok Kumar wrote:
> CPU receives SError exception EOI1_NO_INTS_ACTIVE when EOIR
> is written twice in gic_handle_irq and in its_eoi_irq for a
> single LPI in EOImode == 1.
> 
> Now irq_eoi of its_irq_chip calls parent irqchip's(gic_eoimode1_chip/gic_chip)
> irq_eoi handler which handles EOImode 0 and 1 separately.
> 
> This is introduced by
> commit 0b996fd35957a ("irqchip/GICv3: Convert to EOImode == 1")
> 
> Signed-off-by: Ashok Kumar <ashoks@broadcom.com>

Ah, really good catch!

Acked-by: Marc Zyngier <marc.zyngier@arm.com>

I'll try to queue that for -rc4, but it is more likely that it will land
in -rc5...

Thanks,

	M.
-- 
Jazz is not dead. It just smells funny...
