From: arnd@arndb.de (Arnd Bergmann)
Date: Thu, 28 Mar 2013 15:49:49 +0000
Subject: [PATCH 1/2] ARM: irq: Call irqchit_init if no init_irq function
 is specified
In-Reply-To: <20130328153617.GC3368@n2100.arm.linux.org.uk>
References: <1364463704-13692-1-git-send-email-maxime.ripard@free-electrons.com>
 <201303281525.42334.arnd@arndb.de>
 <20130328153617.GC3368@n2100.arm.linux.org.uk>
Message-ID: <201303281549.49990.arnd@arndb.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thursday 28 March 2013, Russell King - ARM Linux wrote:
> On Thu, Mar 28, 2013 at 03:25:42PM +0000, Arnd Bergmann wrote:
> >       if (IS_DEFINED(CONFIG_OF) && !machine_desc->init_irq)
> >               irqchip_init();
> >       else
> >               machine_desc->init_irq();
> > 
> > to the same effect.
> 
> Provided irqchip_init() keeps its prototype visible, then yes.

Yes, I checked that before my reply. We have a few function declarations
that are unfortunately completely hidden when some config symbol is not
defined, but this is not one of them.

	Arnd
