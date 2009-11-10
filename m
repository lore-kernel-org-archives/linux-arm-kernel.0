From: daniel@caiaq.de (Daniel Mack)
Date: Tue, 10 Nov 2009 08:28:18 +0100
Subject: enabling EXT_WAKEUP interrupts on PXA3xx
In-Reply-To: <4AF91498.3060503@compulab.co.il>
References: <4AF91498.3060503@compulab.co.il>
Message-ID: <20091110072818.GN14091@buzzloop.caiaq.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Nov 10, 2009 at 09:22:00AM +0200, Mike Rapoport wrote:
> We need to enable EXT_WAKEUP interrupts on PXA3xx and I wonder what would be the
> best way to do it.
> I see two possibilities:
> 1) add 'if (irq == IRQ_WAKEUPx)' statements to pxa_{un}mask_irq functions in
> arch/arm/mach-pxa/irq.c
> 2) register additional irq_chip in arch/arm/mach-pxa/pxa3xx.c that will be
> responsible for handling EXT_WAKEUP (and probably other pxa3xx specific) interrupts.
> 
> What do you prefer?

I'm just calling

  enable_irq_wake(IRQ_WAKEUP0);
  
from my board support code, and it works fine - no need to change
anything else.

Daniel
