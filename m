From: s.hauer@pengutronix.de (Sascha Hauer)
Date: Thu, 14 Jun 2012 00:03:17 +0200
Subject: [Patch v5 05/13] usb: otg: add basic mxs phy driver support
In-Reply-To: <201206132356.16093.marex@denx.de>
References: <1339590863-10564-1-git-send-email-richard.zhao@freescale.com>
 <1339590863-10564-6-git-send-email-richard.zhao@freescale.com>
 <20120613213312.GD30400@pengutronix.de>
 <201206132356.16093.marex@denx.de>
Message-ID: <20120613220317.GH30400@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Jun 13, 2012 at 11:56:15PM +0200, Marek Vasut wrote:
> Dear Sascha Hauer,
> 
> > 
> > This message is rather useless. It is really not expected for kzalloc
> > to fail. If it fails here you really have problems elsewhere and this
> > message won't help you debugging it.
> 
> It's not useless, but it'll hardly ever be displayed if you run out of memory so 
> badly this kzalloc() will fail.

If you run out of memory while allocating a few bytes it's really
not interesting where exactly this happens. The message won't give
you any hint where you can fix this problem. Also, if you bail out
of a drivers probe function with -ENOMEM you will have a message
in the log anyway.

Sascha


-- 
Pengutronix e.K.                           |                             |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
Peiner Str. 6-8, 31137 Hildesheim, Germany | Phone: +49-5121-206917-0    |
Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-5555 |
