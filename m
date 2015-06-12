From: ulli.kroll@googlemail.com (Hans Ulli Kroll)
Date: Fri, 12 Jun 2015 16:05:48 +0200 (CEST)
Subject: [PATCH 01/15] ARM: kill off set_irq_flags usage
In-Reply-To: <1433874401-27161-2-git-send-email-robh@kernel.org>
References: <1433874401-27161-1-git-send-email-robh@kernel.org>
 <1433874401-27161-2-git-send-email-robh@kernel.org>
Message-ID: <alpine.LNX.2.00.1506121604200.30841@localhost>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org



On Tue, 9 Jun 2015, Rob Herring wrote:

> set_irq_flags is ARM specific with custom flags which have genirq
> equivalents. Convert drivers to use the genirq interfaces directly, so we
> can kill off set_irq_flags. The translation of flags is as follows:
> 
> IRQF_VALID -> !IRQ_NOREQUEST
> IRQF_PROBE -> !IRQ_NOPROBE
> IRQF_NOAUTOEN -> IRQ_NOAUTOEN
> 
> For IRQs managed by an irqdomain, the irqdomain core code handles clearing
> and setting IRQ_NOREQUEST already, so there is no need to do this in
> .map() functions and we can simply remove the set_irq_flags calls. Some
> users also set IRQ_NOPROBE and this has been maintained although it is not
> clear that is really needed. There appears to be a great deal of blind
> copy and paste of this code.
> 

for mach-gemini
Signed-off-by: Hans Ulli Kroll <ulli.kroll@googlemail.com>
y
