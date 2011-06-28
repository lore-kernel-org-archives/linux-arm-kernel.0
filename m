From: nicolas.ferre@atmel.com (Nicolas Ferre)
Date: Tue, 28 Jun 2011 14:13:39 +0200
Subject: [PATCH] AT91: add AT91SAM9X5 dummy configuration variable
In-Reply-To: <20110628103549.GG2612@legolas.emea.dhcp.ti.com>
References: <1309260927-11411-1-git-send-email-nicolas.ferre@atmel.com>
	<20110628103549.GG2612@legolas.emea.dhcp.ti.com>
Message-ID: <4E09C573.2030607@atmel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Le 28/06/2011 12:35, Felipe Balbi :
> On Tue, Jun 28, 2011 at 01:35:27PM +0200, Nicolas Ferre wrote:
>> Add this Kconfig variable to ease the submission of this chip support.
>> As this chip/board inclusion is dealayed due to deep consolidation of
>> arm/mach-at91 sources, we include this dummy configuration variable to allow
>> submission of SAM9x5 related drivers in other subsystems.
> 
> Why are the drivers even depending on this ? They should be portable
> enough. Can you share a few drivers so we have a look ?

Yes sure. The dependence is only on the Kconfig side: I plan to make
some drivers dependent on this configuration variable.
The goal is to submit the final driver addition without having to send
again a correction to the Kconfig after the chip/board support is merged.

This will ease the submission process at the cost of a two lines dummy
patch and will remove interdependence between subsystem trees: it worth
it, is not it?

> IMHO, the whole idea of the consolidation is beyond arch/arm, drivers
> should be affected too.

Yes sure, I also understood like this.
I will not spread ARCH_AT91SAM9X5 ifdef in driver code...

Best regards,
-- 
Nicolas Ferre
