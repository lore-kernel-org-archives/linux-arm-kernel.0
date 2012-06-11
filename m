From: marex@denx.de (Marek Vasut)
Date: Mon, 11 Jun 2012 12:53:17 +0200
Subject: [PATCH 1/2 V3] MXS: Set I2C timing registers for mxs-i2c
In-Reply-To: <20120611073036.GG2552@S2101-09.ap.freescale.net>
References: <1339242351-8797-1-git-send-email-marex@denx.de>
 <201206101353.06018.marex@denx.de>
 <20120611073036.GG2552@S2101-09.ap.freescale.net>
Message-ID: <201206111253.17314.marex@denx.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Dear Shawn Guo,

> On Sun, Jun 10, 2012 at 01:53:05PM +0200, Marek Vasut wrote:
> > > +struct mxs_i2c_speed_config {
> > > +	uint32_t	timing0;
> > > +	uint32_t	timing1;
> > > +	uint32_t	timing2;
> > > +};
> > > +
> > > +/* Timing values for the default 24MHz clock supplied into the i2c
> > > block.
> > 
> > Thinking about these further -- does anyone have any idea how these
> > numbers were derived? And possibly even formula for that?
> > 
> > And maybe we should somehow make sure the source runs on 24MHz (how?).
> 
> There is nothing about I2C clock mentioned in CLKCTRL chapter.  I just
> contacted design team and was told that I2C clock sources from APBX
> (xbus) clock and always runs at the same frequency there.

Ok, then can you please try asking them how to exactly compute the values in 
timing0-timing2 registers? So we don't have to hardcode them like it's done now?

Best regards,
Marek Vasut
