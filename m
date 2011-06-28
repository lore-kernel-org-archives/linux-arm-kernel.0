From: balbi@ti.com (Felipe Balbi)
Date: Tue, 28 Jun 2011 15:26:51 +0300
Subject: [PATCH] AT91: add AT91SAM9X5 dummy configuration variable
In-Reply-To: <4E09C573.2030607@atmel.com>
References: <1309260927-11411-1-git-send-email-nicolas.ferre@atmel.com>
	<20110628103549.GG2612@legolas.emea.dhcp.ti.com>
	<4E09C573.2030607@atmel.com>
Message-ID: <20110628122650.GK2612@legolas.emea.dhcp.ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

On Tue, Jun 28, 2011 at 02:13:39PM +0200, Nicolas Ferre wrote:
> Le 28/06/2011 12:35, Felipe Balbi :
> > On Tue, Jun 28, 2011 at 01:35:27PM +0200, Nicolas Ferre wrote:
> >> Add this Kconfig variable to ease the submission of this chip support.
> >> As this chip/board inclusion is dealayed due to deep consolidation of
> >> arm/mach-at91 sources, we include this dummy configuration variable to allow
> >> submission of SAM9x5 related drivers in other subsystems.
> > 
> > Why are the drivers even depending on this ? They should be portable
> > enough. Can you share a few drivers so we have a look ?
> 
> Yes sure. The dependence is only on the Kconfig side: I plan to make
> some drivers dependent on this configuration variable.
> The goal is to submit the final driver addition without having to send
> again a correction to the Kconfig after the chip/board support is merged.

my point is that the drivers shouldn't need that ;-) Are the controllers
Atmel's specific or are you guys sourcing from somewhere else ?

> This will ease the submission process at the cost of a two lines dummy
> patch and will remove interdependence between subsystem trees: it worth
> it, is not it?

if you remove any architecture dependency from the driver, why do you
even need these two lines ? ;-)

> > IMHO, the whole idea of the consolidation is beyond arch/arm, drivers
> > should be affected too.
> 
> Yes sure, I also understood like this.
> I will not spread ARCH_AT91SAM9X5 ifdef in driver code...

yet you will prevent the driver from being easily used by other
architectures. What will happen is that a certain amount of:

depends on (ARCH_AT91SAM9X5 || ARCH_FOO || ARCH_BAR || ARCH_BAZ)

will continue to proliferate.

Here are a few questions:

i) The drivers you're willing to send, are those for Atmel's IPs or are
	the IPs sourced from some other company ?

ii) Even if they are Atmel-specific, do you see the possibility of Atmel
	licensing them ?

iii) Does your driver current depend on asm/ or mach/ headers ?

iv) Is there a generic header which you could use instead of asm/ mach/ ?

If you could share the driver, it would be easier to review on that one.

-- 
balbi
-------------- next part --------------
A non-text attachment was scrubbed...
Name: not available
Type: application/pgp-signature
Size: 490 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20110628/af4fe8d8/attachment.sig>
