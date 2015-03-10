From: alexandre.belloni@free-electrons.com (Alexandre Belloni)
Date: Tue, 10 Mar 2015 22:33:17 +0100
Subject: [PATCH v2 5/6] watchdog: at91sam9: request the irq with
 IRQF_NO_SUSPEND
In-Reply-To: <1592385.fqRVVyPSPE@vostro.rjw.lan>
References: <1425287898-15093-6-git-send-email-boris.brezillon@free-electrons.com>
 <1615214.0rkGfM1gZL@vostro.rjw.lan>
 <20150309075546.GY3989@piout.net>
 <1592385.fqRVVyPSPE@vostro.rjw.lan>
Message-ID: <20150310213317.GK9188@piout.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

On 09/03/2015 at 15:30:01 +0100, Rafael J. Wysocki wrote :
> > > > Actaully, your platform should just refuse to enter suspend-to-RAM
> > > > when hw watchdog is enabled.
> > > 
> > > Quite likely, depending on how exactly the suspend is implemented.
> > >
> > 
> > We've had absolutely zero complain on that. It is quite clear in the
> > datasheet that failing to refresh the watchdog once started will lead to
> > a reset and that it is impossible to stop.
> > It is actually quite convenient to also ensure that you can actually
> > wake up from suspend because that can obviously go wrong.
> 
> I gather then that the suspend implementation is such that touching the
> watchdog periodically while suspended is not a problem.
> 
> Again, can you please tell me how suspend is implemented on at91?
> 

It actually depends on the architecture (at91rm9200, at91sam9 or sama5)
but basically, the clocks are switched off in almost all the peripheral
drivers then the ram self refresh activated, the master clock is
switched off using code running from SRAM and the core is then waiting
for interrupt.


-- 
Alexandre Belloni, Free Electrons
Embedded Linux, Kernel and Android engineering
http://free-electrons.com
