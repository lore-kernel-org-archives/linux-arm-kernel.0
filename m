From: jeremy.kerr@canonical.com (Jeremy Kerr)
Date: Wed, 21 Jul 2010 11:09:15 +0200
Subject: [RFC,PATCH 3/3] arm: remove machine_desc.io_pg_offst and .phys_io
In-Reply-To: <20100721085024.GD6009@n2100.arm.linux.org.uk>
References: <1279073377.400469.233833413341.0.gpush@pororo>
	<1279073377.404006.432977736300.3.gpush@pororo>
	<AANLkTilsIR36GNlbpZHt3FB5Dp2msedtUMFRSlZ-N-w9@mail.gmail.com>
	<20100720100448.GB32702@n2100.arm.linux.org.uk>
	<1279621292.27276.19.camel@pororo.lan>
	<1279629158.27276.29.camel@pororo.lan>
	<20100721085024.GD6009@n2100.arm.linux.org.uk>
Message-ID: <1279703355.27276.100.camel@pororo.lan>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Russell,

> It's extremely unlikely to have a UART at address 0 (because that's by
> default where the CPU jumps to on reset.)  That's not to say it could
> never happen - it's possible to hard-wire the CPU into 'hivec' mode
> where it'll instead jump to 0xffff0000.  In that case, if you're sane
> you'd put your SDRAM at 0x00000000.

OK, the patch I have just posted is a bit of a hack that does the 0x0
check; happy to do this a different way.

So, the simplest solution seems to be to make the uart mapping code
dependent on !DEBUG_ICEDCC (but leave the code there to add the mappings
for ARCH_NETWINDER, ARCH_CATS and ARCH_RPC). Would you like a new patch
for this?

Cheers,


Jeremy
