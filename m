From: shawn.guo@freescale.com (Shawn Guo)
Date: Thu, 6 Jan 2011 09:45:19 +0800
Subject: [PATCH v3 08/10] ARM: mxs: add ocotp read function
In-Reply-To: <20110105175617.GD12222@shareable.org>
References: <1294236457-17476-1-git-send-email-shawn.guo@freescale.com>
	<1294236457-17476-9-git-send-email-shawn.guo@freescale.com>
	<20110105161235.GA2112@gallagher>
	<20110105164409.GV25121@pengutronix.de>
	<20110105172501.GB2112@gallagher>
	<20110105175617.GD12222@shareable.org>
Message-ID: <20110106014518.GA17891@freescale.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Jan 05, 2011 at 05:56:17PM +0000, Jamie Lokier wrote:
> Jamie Iles wrote:
> > On Wed, Jan 05, 2011 at 05:44:09PM +0100, Uwe Kleine-K?nig wrote:
> > > Hello Jamie,
> > > On Wed, Jan 05, 2011 at 04:16:46PM +0000, Jamie Iles wrote:
> > > > On Wed, Jan 05, 2011 at 10:07:35PM +0800, Shawn Guo wrote:
> > > > > +	/* check both BUSY and ERROR cleared */
> > > > > +	while ((__raw_readl(ocotp_base) &
> > > > > +		(BM_OCOTP_CTRL_BUSY | BM_OCOTP_CTRL_ERROR)) && --timeout)
> > > > > +		/* nothing */;
> > > > 
> > > > Is it worth using cpu_relax() in these polling loops?
> > > I don't know what cpu_relax does for other platforms, but on ARM it's
> > > just a memory barrier which AFAICT doesn't help here at all (which
> > > doesn't need to be correct).  Why do you think it would be better?
> > 
> > Well I don't see that there's anything broken without cpu_relax() but 
> > using cpu_relax() seems to be the most common way of doing busy polling 
> > loops that I've seen. It's also a bit easier to read than a comment and 
> > semi-colon. Perhaps it's just personal preference.
> 
> cpu_relax() is a hint to the CPU to, for example, save power or be
> less aggressive on the memory bus (to save power or be fairer).
> 
> Currently these architectures do more than just a barrier in cpu_relax():
> x86, IA64, PowerPC, Tile and S390.
> 
> Although it's just a hint on ARM at the moment, it might change in
> future - especially with power mattering on so many ARM systems.
> (Even now, just changing it to a very short udelay might save power
> on existing ARMs without breaking drivers.)
> 
Sounds reasonable.  I would take the suggestion.  Thanks, both Jamie.

-- 
Regards,
Shawn
