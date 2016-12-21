From: u.kleine-koenig@pengutronix.de (Uwe =?iso-8859-1?Q?Kleine-K=F6nig?=)
Date: Wed, 21 Dec 2016 14:25:19 +0100
Subject: [v4, 3/3] ARM: dts: vf610-zii-dev-rev-b: Remove 'fixed-link'
 from DSA ports
In-Reply-To: <1482325125-15725-1-git-send-email-nikita.yoush@cogentembedded.com>
References: <1482131877-6097-3-git-send-email-andrew.smirnov@gmail.com>
 <1482325125-15725-1-git-send-email-nikita.yoush@cogentembedded.com>
Message-ID: <20161221132519.bkkqyfk3beow7nc5@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Dec 21, 2016 at 03:58:45PM +0300, Nikita Yushchenko wrote:
> > Remove 'fixed-link' nodes from DSA ports since they are not needed (they
> > are not limiting link's speed and the ports will be configured to their
> > maximux speed as a default)
> >
> > Suggested-by: Andrew Lunn <andrew@lunn.ch>
> > Signed-off-by: Andrey Smirnov <andrew.smirnov@gmail.com>
> 
> With this patch, ports connected to revB's second switch stop working.

This is probably because without a fixed-link node the phy-mode setting
isn't applied by the driver.

Best regards
Uwe

-- 
Pengutronix e.K.                           | Uwe Kleine-K?nig            |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
