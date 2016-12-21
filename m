From: andrew@lunn.ch (Andrew Lunn)
Date: Wed, 21 Dec 2016 16:22:30 +0100
Subject: [v4, 3/3] ARM: dts: vf610-zii-dev-rev-b: Remove 'fixed-link'
 from DSA ports
In-Reply-To: <20161221132519.bkkqyfk3beow7nc5@pengutronix.de>
References: <1482131877-6097-3-git-send-email-andrew.smirnov@gmail.com>
 <1482325125-15725-1-git-send-email-nikita.yoush@cogentembedded.com>
 <20161221132519.bkkqyfk3beow7nc5@pengutronix.de>
Message-ID: <20161221152230.GK30952@lunn.ch>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Dec 21, 2016 at 02:25:19PM +0100, Uwe Kleine-K?nig wrote:
> On Wed, Dec 21, 2016 at 03:58:45PM +0300, Nikita Yushchenko wrote:
> > > Remove 'fixed-link' nodes from DSA ports since they are not needed (they
> > > are not limiting link's speed and the ports will be configured to their
> > > maximux speed as a default)
> > >
> > > Suggested-by: Andrew Lunn <andrew@lunn.ch>
> > > Signed-off-by: Andrey Smirnov <andrew.smirnov@gmail.com>
> > 
> > With this patch, ports connected to revB's second switch stop working.
> 
> This is probably because without a fixed-link node the phy-mode setting
> isn't applied by the driver.

Yep, bad suggestion from me. If the phy-mode was not needed, then you
can drop the fixed-link. With the phy-mode, you also need the fixed
link.

Sorry for the wasted time,

	Andrew
