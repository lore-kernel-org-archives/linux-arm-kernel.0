From: madhu.cr@ti.com (Madhusudhan)
Date: Mon, 14 Dec 2009 11:43:34 -0600
Subject: [PATCH] mmc: move regulator handling to core
In-Reply-To: <20091212005854.GV28375@buzzloop.caiaq.de>
References: <1259844390-10541-1-git-send-email-daniel@caiaq.de>
	<4B17CADB.1070406@nokia.com>
	<20091203192044.GJ14091@buzzloop.caiaq.de>
	<4B181BB4.1020800@nokia.com>
	<20091204115805.GS14091@buzzloop.caiaq.de>
	<20091212005854.GV28375@buzzloop.caiaq.de>
Message-ID: <006501ca7ce4$f5b04c80$544ff780@am.dhcp.ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org



> -----Original Message-----
> From: Daniel Mack [mailto:daniel at caiaq.de]
> Sent: Friday, December 11, 2009 6:59 PM
> To: Adrian Hunter
> Cc: Matt Fleming; David Brownell; Eric Miao; Linus Walleij; Lavinen Jarkko
> (Nokia-D/Helsinki); Mark Brown; linux-mmc at vger.kernel.org; linux-
> kernel at vger.kernel.org; madhu.cr at ti.com >> Madhusudhan Chikkature; Cliff
> Brake; Russell King; Pierre Ossman; Robert Jarzmik; Andrew Morton; linux-
> arm-kernel at lists.infradead.org; Liam Girdwood
> Subject: Re: [PATCH] mmc: move regulator handling to core
> 
> On Fri, Dec 04, 2009 at 12:58:05PM +0100, Daniel Mack wrote:
> > > >On Thu, Dec 03, 2009 at 04:27:39PM +0200, Adrian Hunter wrote:
> >
> > > >>What about arch/arm/mach-omap2/mmc-twl4030.c ?
> > > >
> > > >Argh, missed that one. And this particular case doesn't fit to my
> > > >modifications. I don't know the code well ...  We would need to
> > > >have a struct mmc_host * in all the functions there calling
> > > >mmc_regulator_{set,get}_ocr. Any idea how to resolve that?
> > > >
> > >
> > > Pass it down from the omap_hsmmc driver.
> >
> > It's not that easy, unfortunately, because this code does not conform to
> > all the other mmc host drivers in tree.
> >
> > I don't understand why things are done the way it is currently
> > implemented. Why isn't there a mmc_host for each slot, and why is a
> > regulator reference acquired for each slot, and not once for the whole
> > device?
> >
> > Even with the default 'vcc' supply factored out to the mmc core, the
> > 'vmmc_aux' regulator would still need some extra attention, but I would
> > also do that from the omap_hsmmc driver rather than in the plaform
> > support code.
> >
> > Moving the regulator handling to the mmc core would require a major
> > cleanup to all this code, but I don't have such hardware to test my
> > modifications. Can anyone help here?

The mmc-twl4030 wrapper is being used by many
platforms(2430sdp,omap3_beagle,LDP,Overo,Omap3EVM,Pandora,3430SDP,Nokia_RX51
,Zoom2,Zoom3,3630SDP,CM_T35,IGEP0020).

I have access only to 3430Sdp, Zoom2 and Zoom3. I can test your changes on
these platforms. Would that help?

Regards,
Madhu
> 
> Can anyone of the OMAP people help sort this out?
> 
> Thanks,
> Daniel
