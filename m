From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Fri, 23 Jul 2010 22:15:35 +0100
Subject: [PATCH 06/11] ARM: omap: move omapfb_reserve_sdram() to .init.text
In-Reply-To: <1279915120-4373-6-git-send-email-u.kleine-koenig@pengutronix.de>
References: <1279915120-4373-1-git-send-email-u.kleine-koenig@pengutronix.de>
	<1279915120-4373-6-git-send-email-u.kleine-koenig@pengutronix.de>
Message-ID: <20100723211535.GD750@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Jul 23, 2010 at 09:58:29PM +0200, Uwe Kleine-K?nig wrote:
> omapfb_reserve_sdram() is only called by omap1_map_common_io() and
> _omap2_map_common_io() that both live in .init.text.  So this is save
> for omapfb_reserve_sdram(), too.

NAK.  This clashes with the memblock stuff.
