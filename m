From: santosh.shilimkar@ti.com (Shilimkar, Santosh)
Date: Fri, 26 Feb 2010 00:28:36 +0530
Subject: [RESEND][PATCH/RFC] OMAP2: serial.c: Fix number of uarts in
	early_init
In-Reply-To: <20100225185734.GI28173@atomide.com>
References: <1267090819-17796-1-git-send-email-swirl@gmx.li>
	<20100225184355.GF28173@atomide.com>
	<EAF47CD23C76F840A9E7FCE10091EFAB02C43BF5EC@dbde02.ent.ti.com>
	<20100225185734.GI28173@atomide.com>
Message-ID: <EAF47CD23C76F840A9E7FCE10091EFAB02C43BF5ED@dbde02.ent.ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

> -----Original Message-----
> From: Tony Lindgren [mailto:tony at atomide.com]
> Sent: Friday, February 26, 2010 12:28 AM
> To: Shilimkar, Santosh
> Cc: Thomas Weber; Aguirre, Sergio; linux-omap at vger.kernel.org; Russell King; Kevin Hilman; Pandita,
> Vikram; Syed, Rafiuddin; linux-arm-kernel at lists.infradead.org; linux-kernel at vger.kernel.org; Thomas
> Weber
> Subject: Re: [RESEND][PATCH/RFC] OMAP2: serial.c: Fix number of uarts in early_init
> 
> * Shilimkar, Santosh <santosh.shilimkar@ti.com> [100225 10:51]:
> >
> > > -----Original Message-----
> > > From: Tony Lindgren [mailto:tony at atomide.com]
> > > Sent: Friday, February 26, 2010 12:14 AM
> > > To: Thomas Weber; Aguirre, Sergio
> > > Cc: linux-omap at vger.kernel.org; Russell King; Kevin Hilman; Shilimkar, Santosh; Pandita, Vikram;
> > > Syed, Rafiuddin; linux-arm-kernel at lists.infradead.org; linux-kernel at vger.kernel.org; Thomas Weber
> > > Subject: Re: [RESEND][PATCH/RFC] OMAP2: serial.c: Fix number of uarts in early_init
> > >
> > > * Thomas Weber <swirl@gmx.li> [100225 01:36]:
> > > >
> > > > The omap_serial_early_init prints the following errors:
> > > >
> > > > Could not get uart4_ick
> > > > Could not get uart4_fck
> > > >
> > > > because all the uarts available in omap_uart[] will be initialized.
> > > > Only omap4430 and omap3630 have 4 uarts at the moment.
> > > > This patch reduces the number of uarts when cpu is not omap4430 or
> > > > omap3630.
> > >
> > > ..and I only patched omap_serial_init and forgot about
> > > the omap_serial_early_init..
> > >
> > > Looks good to me, Sergio, care to test and Ack this? Also, sounds
> > > like we still need to patch omap4 for uart4 for the clocks.
> > >
> > Clocks will be take care automatically by "nr_ports" for omap4 too
> > with this patch. Below clock changes are just cosmetic ones, isn't it ?
> >
> > Am I missing something?
> 
> Yes sorry, I'm referring to "[RFC][PATCH 0/3] OMAP3630: UART4 startup"
> series to fix the uart4 issues for 3630, not omap4.
> 
OK

Regards,
Santosh
