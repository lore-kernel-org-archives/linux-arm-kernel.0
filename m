From: shawn.guo@freescale.com (Shawn Guo)
Date: Wed, 15 Jun 2011 19:24:34 +0800
Subject: sdhci-esdhc-imx -- MMC 10x slower than it should be
In-Reply-To: <20110615105318.GB3097@pengutronix.de>
References: <20110615094001.GA21137@pma.sysgo.com>
	<20110615105318.GB3097@pengutronix.de>
Message-ID: <20110615112433.GB3579@S2100-06.ap.freescale.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Jun 15, 2011 at 12:53:18PM +0200, Wolfram Sang wrote:
> Hi,
> 
> > We are seeing issues with sdhci-esdhc-imx in 2.6.39; performance is
> > not what it should be; it is about 10x lower in fact.
> 
> Which SoC? 25/35/51/53?
> 
> > ...any idea what this comment means? I'd like to eventualy support
> > 8BITBUS...
> 
> 8-Bit bus is not specified in the standard, so it cannot be detected.
> Check other drivers where they use MMC_CAP_8_BIT_DATA.
> 
> > Part of the problem is that esdhc_writeb_le() does translation of bits
> > into breescale format; but readb() does not do translation back, and
> > core code uses read-modify-write on the register, for example when
> > turning on the LED. What to do there? Translate back? Add shadow
> > variable? Get rid of read-modify-write?
> 
> Probably the least ugly solution :/
> 
> > Any ideas why it is slow?
> 
> Your board polls for card-detect, Shawn recently sent a series which
> lets you fix that for mx5.
> 
> ADMA is marked broken in mainline, cause it didn't work with a number of
> cards. Richard sent a patch recently.
> 
The ADMA support is recently added into Freescale BSP.  IOW, the ADMA
does not play on kernel "2.6.34 -with-freescale-patches" either.

-- 
Regards,
Shawn
