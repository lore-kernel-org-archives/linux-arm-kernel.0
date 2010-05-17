From: benh@kernel.crashing.org (Benjamin Herrenschmidt)
Date: Mon, 17 May 2010 22:08:17 +1000
Subject: [PATCH] phy/marvell: Add special settings for D-Link DNS-323
	rev C1
In-Reply-To: <20100517120032.GI22781@pengutronix.de>
References: <1274056058.21352.697.camel@pasglop>
	<20100517005942.GB27301@pengutronix.de>
	<1274058457.21352.711.camel@pasglop>
	<1274096214.21352.735.camel@pasglop>
	<20100517120032.GI22781@pengutronix.de>
Message-ID: <1274098097.21352.737.camel@pasglop>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, 2010-05-17 at 14:00 +0200, Wolfram Sang wrote:
> > The problem is that the fixups are called -after- the config_init()
> > callback of the PHY driver. However, the marvell m88e1118 PHY driver
> > will unconditionally reset the LEDs setting.
> 
> Haven't checked, just an idea: Is it possible to change the init of
> the driver to use Read-Modify-Write and thus keep your settings?

Well, the driver just unconditionally blasts the whole register and
the value I want to put there is also a "raw" value of the whole
register based on what the vendor code puts in there (in their old
2.6.12 based port).

So with only that at hand and no documentation for the actual PHY chip,
I don't see a simple solution here.

Cheers,
Ben.
