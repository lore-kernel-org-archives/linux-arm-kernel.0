From: plyatov@gmail.com (Igor Plyatov)
Date: Sun, 12 Dec 2010 22:52:50 +0300
Subject: [PATCH v4] mach-at91: Support for gsia18s board added
In-Reply-To: <20101212142200.GG8665@n2100.arm.linux.org.uk>
References: <1292000411-6691-1-git-send-email-plyatov@gmail.com>
	<20101212005048.GH19897@game.jcrosoft.org>
	<1292135848.2456.19.camel@homepc>
	<20101212140727.GI19897@game.jcrosoft.org>
	<20101212142200.GG8665@n2100.arm.linux.org.uk>
Message-ID: <1292183570.8737.33.camel@homepc>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Dear Russell,

> On Sun, Dec 12, 2010 at 03:07:27PM +0100, Jean-Christophe PLAGNIOL-VILLARD wrote:
> > On 09:37 Sun 12 Dec     , Igor Plyatov wrote:
> > > Dear Jean-Christophe,
> > > 
> > > > On 20:00 Fri 10 Dec     , Igor Plyatov wrote:
> > > > > +/*
> > > > > + * Up to date linux/arch/arm/tools/mach-types database required to support this.
> 
> Please wrap comments.

This comment exactly 80 characters long, but anyway I will split it into
two strings in next version of this patch.

> > > > > +MACHINE_START(GSIA18S, "GS_IA18_S")
> > > > > +*/
> > > > > +MACHINE_START(STAMP9G20, "GS_IA18_S")
> > > > if you do this you must use system_rev to identify the board
> > > 
> > > I can cite Christian Glindkamp:
> > > "And for different carrier boards, system_rev does not make sense at
> > > all."
> > > 
> > > Please, use more testimony why it is required to use system_rev here.
> > > Yours position does not clear for me.
> > > You can point me to the right documentation or discussion about this
> > > requirements in the mail archives...
> >
> > two bards with the same machine id NACK as we can not compile them in the same
> > kernel and this a target we all work on to allow
> > if you want to tuse the same machine id as I did for other boards you must use
> > system_rev or any detection to identify tehm
> 
> Well, the platform was registered into the machine database on 10th
> December, so it's missed my recent update to the file queued for the next
> -rc.

Just to clarify: my gsia18s machine number will be added into
linux-2.6.37-rc6?

Does this mean that I must wait for rc6 and then send my patch with new
machine name or I can send it now?

> I also notice that the name has been changed - machine_is_gsia18s() vs
> MACH_TYPE_GS_IA18_S / CONFIG_MACH_GS_IA18_S.  This means I'll simply
> delete it from any future updates until someone talks to me about fixing
> the entry, exactly as I'm doing with a bunch of others who also haven't
> contacted me.
> 
> All it takes is an email and the entry gets quickly fixed...

Russel, please fix it to more readable "gsia18s" and "*_GSIA18S" for my
3234 machine.
Old names with two underscores ("gs_ia18_s" and "*_GS_IA18_S") was very
hard to read in the source code.

Best regards!
--
Igor Plyatov
