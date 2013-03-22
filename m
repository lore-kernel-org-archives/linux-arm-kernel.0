From: arnd@arndb.de (Arnd Bergmann)
Date: Fri, 22 Mar 2013 16:00:45 +0000
Subject: [PATCH 03/04] ARM: shmobile: r8a73a4 IRQC support
In-Reply-To: <CANqRtoTQhbk0sjZfvCY3qR2-x5p1gvZ0F+o3ZkAddufddYUk+g@mail.gmail.com>
References: <20130312045559.19701.77841.sendpatchset@w520>
 <201303141343.04328.arnd@arndb.de>
 <CANqRtoTQhbk0sjZfvCY3qR2-x5p1gvZ0F+o3ZkAddufddYUk+g@mail.gmail.com>
Message-ID: <201303221600.45844.arnd@arndb.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Friday 15 March 2013, Magnus Damm wrote:
> On Thu, Mar 14, 2013 at 10:43 PM, Arnd Bergmann <arnd@arndb.de> wrote:
> > On Thursday 14 March 2013, Magnus Damm wrote:

> > Coming back to INTC, are you planning to use the same binding for A and C?
> 
> I was not planning on that, no. To be honest, at this point I am not
> sure which way forward is best for A).
> 
> > Which of them the binding you posted earlier for?
> 
> Regarding A), I wrote some local DT prototype patches for INTC a year
> or two ago, showing how things could be done and how we can start
> using DT. Then I handed the job over to other people. However, from
> there my advice of incremental development was ignored and instead
> more complete bindings were developed directly without much review. So
> I wouldn't say that I posted the bindings myself. Right now I'm very
> hands-off in that area.

Ok.

> As for C), those DT bindings were done by me. They are however not
> compatible with A). The hardware is different. C) is basically a
> special case subset of A).

Makes sense.

> > When I looked at the existing code, I had the impression that doing a
> > binding for just the SH-Mobile SoCs that have an ARM core in them
> > (including those that also have an SH core) would be much easier than
> > doing a binding that also covers the older SH SoCs, since those are
> > much less uniform.
> 
> I agree that in some cases it may make sense to split the SH bits from
> ARM, but I wonder how much we would win for the INTC.
> 
> Right now I'm considering converting r8a7740 to use B) and C) (if
> possible), and if so then the only ARM SoC using A) for main interrupt
> controller left is sh7372.
> 
> For sh7372 we could simply try to use C) for board-level interrupts
> (and board level DT) but keep the SoC portion in C with A) until the
> SoC is being phased out. Or we could have a simple compatible
> "renesas,intc-sh7372" with tables in C using irq domain to support DT,
> but that would be exactly as my first incremental development task
> that wasn't followed...
> 
> What would you do?

Both of htese approaches sound fine. If there is only a single odd
one out, it makes sense to have a hardwired implementation for that
one. I rejected that approach originally because I wanted something
more generic, and it seems you have done exactly that with the
irq-renesas-intc-irqpin driver.

	Arnd
