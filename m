From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Wed, 21 Jul 2010 09:50:24 +0100
Subject: [RFC,PATCH 3/3] arm: remove machine_desc.io_pg_offst and .phys_io
In-Reply-To: <1279629158.27276.29.camel@pororo.lan>
References: <1279073377.400469.233833413341.0.gpush@pororo>
	<1279073377.404006.432977736300.3.gpush@pororo>
	<AANLkTilsIR36GNlbpZHt3FB5Dp2msedtUMFRSlZ-N-w9@mail.gmail.com>
	<20100720100448.GB32702@n2100.arm.linux.org.uk>
	<1279621292.27276.19.camel@pororo.lan>
	<1279629158.27276.29.camel@pororo.lan>
Message-ID: <20100721085024.GD6009@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Jul 20, 2010 at 02:32:38PM +0200, Jeremy Kerr wrote:
> Hi all,
> 
> > OK, so I should request Stephen to add this branch to linux-next,
> > including the fixups?
> > 
> 
> Hm, before I do that I should probably work out what to do in the
> CONFIG_DEBUG_ICEDCC case. How about returning 0x0 as the phys address in
> this case (ie, addruart -> mov \rp, #0), and skip setting up the mapping
> if addruart gives this zero address?

It's extremely unlikely to have a UART at address 0 (because that's by
default where the CPU jumps to on reset.)  That's not to say it could
never happen - it's possible to hard-wire the CPU into 'hivec' mode
where it'll instead jump to 0xffff0000.  In that case, if you're sane
you'd put your SDRAM at 0x00000000.
