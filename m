From: rjw@rjwysocki.net (Rafael J. Wysocki)
Date: Tue, 10 Mar 2015 23:31:52 +0100
Subject: [PATCH v2 5/6] watchdog: at91sam9: request the irq with
 IRQF_NO_SUSPEND
In-Reply-To: <20150310213317.GK9188@piout.net>
References: <1425287898-15093-6-git-send-email-boris.brezillon@free-electrons.com>
 <1592385.fqRVVyPSPE@vostro.rjw.lan> <20150310213317.GK9188@piout.net>
Message-ID: <1901056.Mqyykpv3e9@vostro.rjw.lan>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tuesday, March 10, 2015 10:33:17 PM Alexandre Belloni wrote:
> Hi,
> 
> On 09/03/2015 at 15:30:01 +0100, Rafael J. Wysocki wrote :
> > > > > Actaully, your platform should just refuse to enter suspend-to-RAM
> > > > > when hw watchdog is enabled.
> > > > 
> > > > Quite likely, depending on how exactly the suspend is implemented.
> > > >
> > > 
> > > We've had absolutely zero complain on that. It is quite clear in the
> > > datasheet that failing to refresh the watchdog once started will lead to
> > > a reset and that it is impossible to stop.
> > > It is actually quite convenient to also ensure that you can actually
> > > wake up from suspend because that can obviously go wrong.
> > 
> > I gather then that the suspend implementation is such that touching the
> > watchdog periodically while suspended is not a problem.
> > 
> > Again, can you please tell me how suspend is implemented on at91?
> > 
> 
> It actually depends on the architecture (at91rm9200, at91sam9 or sama5)
> but basically, the clocks are switched off in almost all the peripheral
> drivers then the ram self refresh activated, the master clock is
> switched off using code running from SRAM and the core is then waiting
> for interrupt.

OK, so it looks like enable_irq_wake() doesn't actually affect the hardware
on those platforms, is that correct?


-- 
I speak only for myself.
Rafael J. Wysocki, Intel Open Source Technology Center.
