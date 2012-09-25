From: marex@denx.de (Marek Vasut)
Date: Tue, 25 Sep 2012 13:27:51 +0200
Subject: [PATCH] ARM: mx28: Skip OCOTP FEC MAC setup if in DT
In-Reply-To: <20120925112431.GB14216@S2101-09.ap.freescale.net>
References: <1348195214-26633-1-git-send-email-marex@denx.de>
 <201209251301.46486.marex@denx.de>
 <20120925112431.GB14216@S2101-09.ap.freescale.net>
Message-ID: <201209251327.51723.marex@denx.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Dear Shawn Guo,

> On Tue, Sep 25, 2012 at 01:01:46PM +0200, Marek Vasut wrote:
> > > >  		np = of_find_compatible_node(from, NULL, "fsl,imx28-
fec");
> > > >  		if (!np)
> > > >  		
> > > >  			return;
> > > > 
> > > > +
> > > > +		if (of_get_property(np, "local-mac-address", NULL))
> > > > +			continue;
> > > > +
> > > 
> > > The block should be put after "from" assignment below.
> > 
> > Can you please elaborate why would that be necessary?
> 
> Without assigning 'np' to 'from', the next iteration of 'for' loop
> will still find the first fec node.  Then what's point of 'continue'?

Ewww, you're right.

> Shawn

Best regards,
Marek Vasut
