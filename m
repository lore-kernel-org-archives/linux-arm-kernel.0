From: u.kleine-koenig@pengutronix.de (Uwe =?iso-8859-1?Q?Kleine-K=F6nig?=)
Date: Sat, 24 Jul 2010 10:51:12 +0200
Subject: [PATCH 06/11] ARM: omap: move omapfb_reserve_sdram() to .init.text
In-Reply-To: <20100723211535.GD750@n2100.arm.linux.org.uk>
References: <1279915120-4373-1-git-send-email-u.kleine-koenig@pengutronix.de>
	<1279915120-4373-6-git-send-email-u.kleine-koenig@pengutronix.de>
	<20100723211535.GD750@n2100.arm.linux.org.uk>
Message-ID: <20100724085112.GA694@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Jul 23, 2010 at 10:15:35PM +0100, Russell King - ARM Linux wrote:
> On Fri, Jul 23, 2010 at 09:58:29PM +0200, Uwe Kleine-K?nig wrote:
> > omapfb_reserve_sdram() is only called by omap1_map_common_io() and
> > _omap2_map_common_io() that both live in .init.text.  So this is save
> > for omapfb_reserve_sdram(), too.
> 
> NAK.  This clashes with the memblock stuff.
OK, I will recheck after .36-rc1.

Thanks
Uwe

-- 
Pengutronix e.K.                           | Uwe Kleine-K?nig            |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
