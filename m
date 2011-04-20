From: tglx@linutronix.de (Thomas Gleixner)
Date: Wed, 20 Apr 2011 11:34:39 +0200 (CEST)
Subject: genirq: Implement a generic interrupt chip
In-Reply-To: <4DAE9764.2090609@codeaurora.org>
References: <20110416211221.853079766@linutronix.de>
	<20110416211307.117340150@linutronix.de>
	<4DAE9764.2090609@codeaurora.org>
Message-ID: <alpine.LFD.2.02.1104201133570.3111@ionos>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, 20 Apr 2011, Abhijeet Dharmapurikar wrote:
> On 04/16/2011 02:14 PM, Thomas Gleixner wrote:
> > +#else
> > +static inline void irq_gc_lock(struct irq_chip_generic *gc) { }
> > +static inline void irq_gc_unlock(struct irq_chip_generic *gc) { }
> > +#endif
> > +
> 
> Shall we create a new header file for this, lets say geneirc_irq_chip.h? The
> generic irq chip api is different from what  irq.h provides, I think

And that header includes irq.h then. Where is the point ?
