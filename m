From: thomas.petazzoni@free-electrons.com (Thomas Petazzoni)
Date: Thu, 5 Jul 2012 15:28:40 +0200
Subject: [PATCH v2 01/12] ARM: Orion: DT support for IRQ and GPIO
 Controllers
In-Reply-To: <20120705131522.GW17534@lunn.ch>
References: <1341325365-21393-1-git-send-email-andrew@lunn.ch>
 <1341325365-21393-2-git-send-email-andrew@lunn.ch>
 <20120705110251.596331e0@skate> <20120705094824.GO17534@lunn.ch>
 <20120705145801.4985770d@skate> <20120705131522.GW17534@lunn.ch>
Message-ID: <20120705152840.2aea94cf@skate>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Le Thu, 5 Jul 2012 15:15:22 +0200,
Andrew Lunn <andrew@lunn.ch> a ?crit :

> > > The biggest problem i had, is the interaction between generic chip
> > > interrupts and irqdomain. There has been work to integrate the two,
> > > but its stalled. Either the work needs restarting and completing, or
> > > you need to throw away the use of generic interrupt so that you can
> > > use irqdomain linear. IMHO, throwing away generic interrupt is the
> > > wrong way.
> > 
> > Can you expand on why you think it would be wrong to throw away the
> > usage of irq_chip_generic, compared to implementing directly an
> > irq_chip?
> 
> Basically you are asking, why should i use the framework when i can do
> it by hand.

Agreed :)

> What are the advantages if ignoring the framework and doing it by
> hand?

Many GPIO drivers directly use irq_chip (though it's true some of them
use irq_chip_generic), and the irq_chip_generic framework doesn't have
really proper support for the other new irqdomain framework, so I was
wondering what the best solution was.

I found the proposal from Rob Herring to improve that situation, but
apparently the conclusion from Grant Likely was "Let's discuss this at
the next Connect". That patch set was posted in January, so two Linaro
Connects happened since them, I don't know if progress has been made
here.

I guess I'll just stick to irq_chip_generic + irqdomain_legacy for now.

Best regards,

Thomas
-- 
Thomas Petazzoni, Free Electrons
Kernel, drivers, real-time and embedded Linux
development, consulting, training and support.
http://free-electrons.com
