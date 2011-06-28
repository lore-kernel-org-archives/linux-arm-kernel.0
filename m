From: plagnioj@jcrosoft.com (Jean-Christophe PLAGNIOL-VILLARD)
Date: Tue, 28 Jun 2011 18:02:52 +0200
Subject: [PATCH] AT91: add AT91SAM9X5 dummy configuration variable
In-Reply-To: <20110628122650.GK2612@legolas.emea.dhcp.ti.com>
References: <1309260927-11411-1-git-send-email-nicolas.ferre@atmel.com>
	<20110628103549.GG2612@legolas.emea.dhcp.ti.com>
	<4E09C573.2030607@atmel.com>
	<20110628122650.GK2612@legolas.emea.dhcp.ti.com>
Message-ID: <20110628160252.GQ17355@game.jcrosoft.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 15:26 Tue 28 Jun     , Felipe Balbi wrote:
> Hi,
> 
> On Tue, Jun 28, 2011 at 02:13:39PM +0200, Nicolas Ferre wrote:
> > Le 28/06/2011 12:35, Felipe Balbi :
> > > On Tue, Jun 28, 2011 at 01:35:27PM +0200, Nicolas Ferre wrote:
> > >> Add this Kconfig variable to ease the submission of this chip support.
> > >> As this chip/board inclusion is dealayed due to deep consolidation of
> > >> arm/mach-at91 sources, we include this dummy configuration variable to allow
> > >> submission of SAM9x5 related drivers in other subsystems.
> > > 
> > > Why are the drivers even depending on this ? They should be portable
> > > enough. Can you share a few drivers so we have a look ?
> > 
> > Yes sure. The dependence is only on the Kconfig side: I plan to make
> > some drivers dependent on this configuration variable.
> > The goal is to submit the final driver addition without having to send
> > again a correction to the Kconfig after the chip/board support is merged.
> 
> my point is that the drivers shouldn't need that ;-) Are the controllers
> Atmel's specific or are you guys sourcing from somewhere else ?
> 
> > This will ease the submission process at the cost of a two lines dummy
> > patch and will remove interdependence between subsystem trees: it worth
> > it, is not it?
> 
> if you remove any architecture dependency from the driver, why do you
> even need these two lines ? ;-)
> 
> > > IMHO, the whole idea of the consolidation is beyond arch/arm, drivers
> > > should be affected too.
> > 
> > Yes sure, I also understood like this.
> > I will not spread ARCH_AT91SAM9X5 ifdef in driver code...
> 
> yet you will prevent the driver from being easily used by other
> architectures. What will happen is that a certain amount of:
> 
> depends on (ARCH_AT91SAM9X5 || ARCH_FOO || ARCH_BAR || ARCH_BAZ)
no I disagree this is done to allow only the drivers on proper arch

and we do not need the multiple depend we usally create a HAVE_xxx config
that the ARCH select and we just depend on it


Best Regards,
J.
