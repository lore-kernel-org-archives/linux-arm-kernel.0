From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Sun, 12 Dec 2010 14:22:00 +0000
Subject: [PATCH v4] mach-at91: Support for gsia18s board added
In-Reply-To: <20101212140727.GI19897@game.jcrosoft.org>
References: <1292000411-6691-1-git-send-email-plyatov@gmail.com>
	<20101212005048.GH19897@game.jcrosoft.org>
	<1292135848.2456.19.camel@homepc>
	<20101212140727.GI19897@game.jcrosoft.org>
Message-ID: <20101212142200.GG8665@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sun, Dec 12, 2010 at 03:07:27PM +0100, Jean-Christophe PLAGNIOL-VILLARD wrote:
> On 09:37 Sun 12 Dec     , Igor Plyatov wrote:
> > Dear Jean-Christophe,
> > 
> > > On 20:00 Fri 10 Dec     , Igor Plyatov wrote:
> > > > +/*
> > > > + * Up to date linux/arch/arm/tools/mach-types database required to support this.

Please wrap comments.

> > > > +MACHINE_START(GSIA18S, "GS_IA18_S")
> > > > +*/
> > > > +MACHINE_START(STAMP9G20, "GS_IA18_S")
> > > if you do this you must use system_rev to identify the board
> > 
> > I can cite Christian Glindkamp:
> > "And for different carrier boards, system_rev does not make sense at
> > all."
> > 
> > Please, use more testimony why it is required to use system_rev here.
> > Yours position does not clear for me.
> > You can point me to the right documentation or discussion about this
> > requirements in the mail archives...
>
> two bards with the same machine id NACK as we can not compile them in the same
> kernel and this a target we all work on to allow
> if you want to tuse the same machine id as I did for other boards you must use
> system_rev or any detection to identify tehm

Well, the platform was registered into the machine database on 10th
December, so it's missed my recent update to the file queued for the next
-rc.

I also notice that the name has been changed - machine_is_gsia18s() vs
MACH_TYPE_GS_IA18_S / CONFIG_MACH_GS_IA18_S.  This means I'll simply
delete it from any future updates until someone talks to me about fixing
the entry, exactly as I'm doing with a bunch of others who also haven't
contacted me.

All it takes is an email and the entry gets quickly fixed...
