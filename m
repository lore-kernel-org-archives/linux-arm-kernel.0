From: ithamar.adema@team-embedded.nl (Ithamar R. Adema)
Date: Thu, 17 Mar 2011 23:18:35 +0100
Subject: [PATCH 7/9] lpc2k: Add EmbeddedArtists LPC2478 Developer's Kit
	board
In-Reply-To: <083DF309106F364B939360100EC290F80B15AC2B39@eu1rdcrdc1wx030.exi.nxp.com>
References: <1300377264-10843-1-git-send-email-ithamar.adema@team-embedded.nl>
	<1300377264-10843-8-git-send-email-ithamar.adema@team-embedded.nl>
	<083DF309106F364B939360100EC290F80B15AC2B39@eu1rdcrdc1wx030.exi.nxp.com>
Message-ID: <1300400315.2138.103.camel@team-embedded-2>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, 2011-03-17 at 23:07 +0100, Kevin Wells wrote:
> > +
> > +#define EXTPOLAR	0x14c
> > +
> > +static unsigned long mfp_cfgs[] = {
> 
> Should this be initdata?

Yes, good catch!

> > +MACHINE_START(LPC2478OEM, "Embedded Artists LPC2478 OEM Board")
> 
> Just a nit, but the machine ID should probably be unique to this
> board and not the 2478, ie EA2478OEM. If someone else releases a
> LPC2478 based board, it can't use this same id. This would apply
> to the filename too (lpc2478oem.c) - the name is somewhat generic
> and might be better named something like plat-ea2478oem.c.

True, a more concise name there would be helpful. It is a bit of a
mixture since the LPC2478OEM is just the CPU board, and the 'Developer's
Kit' includes a baseboard with peripheral devices.

I'll come up with a better name for it, it will just require another
board registration and update of arch/arm/tools/mach-types :(

Regards,

Ithamar.
