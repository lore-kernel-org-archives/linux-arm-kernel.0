From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Sat, 1 Mar 2014 16:01:14 +0000
Subject: [PATCH] irq: Changed the return type of irq_chip.irq_startup()
 from unsigned int to int
In-Reply-To: <alpine.DEB.2.02.1403011629540.18573@ionos.tec.linutronix.de>
References: <CACh+v5Nkuct0J65OHcnSd6Dfq4EyfafY8RpTvdwKXUA7A8_+Xw@mail.gmail.com>
 <1393521679-32331-1-git-send-email-jjhiblot@traphandler.com>
 <7150036.UpHTd1PK1K@radagast>
 <alpine.DEB.2.02.1403011629540.18573@ionos.tec.linutronix.de>
Message-ID: <20140301160114.GE21483@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sat, Mar 01, 2014 at 04:31:13PM +0100, Thomas Gleixner wrote:
> On Fri, 28 Feb 2014, James Hogan wrote:
> > On Thursday 27 February 2014 18:21:19 Jean-Jacques Hiblot wrote:
> > >  drivers/irqchip/irq-metag.c               | 4 ++--
> > 
> > I think you've missed out drivers/irqchip/irq-metag-ext.c
> 
> There is a good reason why I asked to do this with coccinelle.

Go easy, not everyone understands that complex tool - I certainly don't.
I ended up deleting it from my system after several failed attempts, and
I came to the conclusion that to use it properly, you also needed a Julia
installed along side you to learn how to write its scripts.

The big problem is it /doesn't/ do what it advertises to - I ended up
writing expression after expression to make it detect all the various
forms of what I wanted it to, which as I understand the tool is precisely
the opposite of what you're supposed to do with it.

I ended up coming to the conclusion that a well formed sed and/or grep
expression was far more useful and effective than trying to figure out
coccinelle.

-- 
FTTC broadband for 0.8mile line: now at 9.7Mbps down 460kbps up... slowly
improving, and getting towards what was expected from it.
