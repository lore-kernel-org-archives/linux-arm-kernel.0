From: tglx@linutronix.de (Thomas Gleixner)
Date: Wed, 20 Apr 2011 10:35:28 +0200 (CEST)
Subject: arm: orion: Use generic irq chip
In-Reply-To: <4DAE979E.6000907@codeaurora.org>
References: <20110416211221.853079766@linutronix.de>
	<20110416211307.498522459@linutronix.de>
	<4DAE979E.6000907@codeaurora.org>
Message-ID: <alpine.LFD.2.00.1104201035070.2744@localhost6.localdomain6>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, 20 Apr 2011, Abhijeet Dharmapurikar wrote:
> > -	for (i = 0; i<  ngpio; i++) {
> > -		unsigned int irq = secondary_irq_base + i;
> > +	gc = irq_alloc_generic_chip("orion_gpio_irq", 1, secondary_irq_base,
> > +				    ochip->base, handle_level_irq);
> 
> should this be 2 instead of 1 ?
> 	gc = irq_alloc_generic_chip("orion_gpio_irq", 2,  ...

Ouch, yes.
