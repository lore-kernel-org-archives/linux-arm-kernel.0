From: andrew@lunn.ch (Andrew Lunn)
Date: Thu, 5 Jul 2012 15:54:49 +0200
Subject: [PATCH v2 01/12] ARM: Orion: DT support for IRQ and GPIO
 Controllers
In-Reply-To: <201207051347.38887.arnd@arndb.de>
References: <1341325365-21393-1-git-send-email-andrew@lunn.ch>
 <201207051225.55390.arnd@arndb.de> <20120705130819.GV17534@lunn.ch>
 <201207051347.38887.arnd@arndb.de>
Message-ID: <20120705135449.GZ17534@lunn.ch>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

> > Orion use generic chip interrupts, both for the main interrupts and
> > the GPIO interrupts. This does not yet support irq domain, so i have
> > to layer a legacy domain on top. The legacy domain needs to know the
> > first IRQ and the number of IRQs. For the primary IRQs that is
> > easy. However, GPIO IRQ is not so easy, it depends on how many primary
> > IRQs there are. This is not fixed. Orion5x has 32, Dove 64, kirkwood,
> > 64, and mv78xx0 has 96. I need to know this number when adding the
> > GPIO secondary IRQ legacy domain. By calling orion_gpio_of_init() in
> > the orion_add_irq_domain() i have this number to hand. If i used to
> > entries in the match table, i would have to put this number into some
> > global variable, or somehow ask the IRQ subsystem what the next free
> > IRQ number is.
> 
> But couldn't you store the number of interrupts for the primary controller
> in a local variable? I think the of_irq code already guarantees that
> the parent is probed first.

Sure i could. But what is the advantage of that?

     Andrew
