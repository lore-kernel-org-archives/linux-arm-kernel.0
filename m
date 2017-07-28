From: clabbe.montjoie@gmail.com (Corentin Labbe)
Date: Fri, 28 Jul 2017 16:44:24 +0200
Subject: [PATCH 0/3] net-next: stmmac: support future possible different
 internal phy mode
In-Reply-To: <20170728143600.GB2132@lunn.ch>
References: <20170728092818.23419-1-clabbe.montjoie@gmail.com>
 <20170728135544.GD32230@lunn.ch> <20170728142508.GA7221@Red>
 <20170728143600.GB2132@lunn.ch>
Message-ID: <20170728144424.GB7221@Red>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Jul 28, 2017 at 04:36:00PM +0200, Andrew Lunn wrote:
> > > I've probably asked this before: Does the internal PHY use a different
> > > PHY ID in registers 2 and 3?
> > > 
> > 
> > yes
> > 
> > reg2: 0x0044
> > reg3: 0X1500

Copy/paste error, its 1400

> 
> So this is not about loading the correct PHY driver. You can already
> do this based on the PHY IDs...
> 
> This is about selecting which PHY to use. Internal or External?	
> 
>      Andrew

It is too late when we know the PHY ID.
We need to set a syscon for choosing external/internal PHY.
So we can rely only on DT.
