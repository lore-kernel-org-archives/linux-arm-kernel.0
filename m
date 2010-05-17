From: w.sang@pengutronix.de (Wolfram Sang)
Date: Mon, 17 May 2010 14:00:32 +0200
Subject: [PATCH] phy/marvell: Add special settings for D-Link DNS-323
	rev C1
In-Reply-To: <1274096214.21352.735.camel@pasglop>
References: <1274056058.21352.697.camel@pasglop>
	<20100517005942.GB27301@pengutronix.de>
	<1274058457.21352.711.camel@pasglop>
	<1274096214.21352.735.camel@pasglop>
Message-ID: <20100517120032.GI22781@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org


> The problem is that the fixups are called -after- the config_init()
> callback of the PHY driver. However, the marvell m88e1118 PHY driver
> will unconditionally reset the LEDs setting.

Haven't checked, just an idea: Is it possible to change the init of the driver
to use Read-Modify-Write and thus keep your settings?

-- 
Pengutronix e.K.                           | Wolfram Sang                |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
-------------- next part --------------
A non-text attachment was scrubbed...
Name: not available
Type: application/pgp-signature
Size: 197 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20100517/98bf2188/attachment.sig>
