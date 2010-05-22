From: w.sang@pengutronix.de (Wolfram Sang)
Date: Sat, 22 May 2010 15:06:24 +0200
Subject: [PATCH 1/5] net/phy/marvell: Expose IDs and flags in a .h and
	add dns323 LEDs setup flag
In-Reply-To: <1274525683.1931.139.camel@pasglop>
References: <1274525683.1931.139.camel@pasglop>
Message-ID: <20100522130624.GA28561@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sat, May 22, 2010 at 08:54:43PM +1000, Benjamin Herrenschmidt wrote:
> This moves the various known Marvell PHY IDs to include/linux/marvell_phy.h
> along with dev_flags definitions for use by the driver.

I think this one from the driver should go there, too:

#define M1145_DEV_FLAGS_RESISTANCE      0x00000001

(which makes me wonder how this flag was set as it was not exported before)

and thus yours could be maybe like

#define M1118_DEV_FLAGS_ALT_LED_INIT	0x00000001

(or 1 << 0)

?

Otherwise looks good enough to me.

-- 
Pengutronix e.K.                           | Wolfram Sang                |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
-------------- next part --------------
A non-text attachment was scrubbed...
Name: not available
Type: application/pgp-signature
Size: 197 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20100522/e497ef54/attachment.sig>
