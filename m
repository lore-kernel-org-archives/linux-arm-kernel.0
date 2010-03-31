From: s.hauer@pengutronix.de (Sascha Hauer)
Date: Wed, 31 Mar 2010 10:12:08 +0200
Subject: [PATCH] netdev/fec.c: add phylib supporting to enable carrier
	detection
In-Reply-To: <20100326102957.GG5539@matterhorn.verdurent.com>
References: <1269597052-10104-1-git-send-email-bryan.wu@canonical.com>
	<20100326102957.GG5539@matterhorn.verdurent.com>
Message-ID: <20100331081208.GP2241@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Mar 26, 2010 at 12:29:57PM +0200, Amit Kucheria wrote:
> On 10 Mar 26, Bryan Wu wrote:
> > BugLink: http://bugs.launchpad.net/bugs/457878
> > 
> >  - removed old MII phy control code
> >  - add phylib supporting
> >  - add ethtool interface to make user space NetworkManager works
> > 
> > Tested on Freescale i.MX51 Babbage board.
> > 
> > This patch is based on a patch from Frederic Rodo <fred.rodo@gmail.com>
> > 
> > Cc: Frederic Rodo <fred.rodo@gmail.com>
> > Signed-off-by: Bryan Wu <bryan.wu@canonical.com>
> 
> While I ack this patch, I wonder if we should add to the various board
> Kconfig options, a dependency select'ing the right phylib for that board.
> 
> This would prevent breakage of ethernet on those boards because they forgot
> to select the right phylib after this change.

I wouldn't go that far. I never saw a board which doesn't work with the
generic phy implementation, so I would only select the specific phy if
I knew that the generic phy does not work.

Sascha


-- 
Pengutronix e.K.                           |                             |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
Peiner Str. 6-8, 31137 Hildesheim, Germany | Phone: +49-5121-206917-0    |
Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-5555 |
