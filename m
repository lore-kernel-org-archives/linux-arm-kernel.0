From: davem@davemloft.net (David Miller)
Date: Thu, 22 Jul 2010 14:12:45 -0700 (PDT)
Subject: [PATCH] fec: use interrupt for MDIO completion indication
In-Reply-To: <20100721125113.GA2651@pengutronix.de>
References: <4C3E812C.10303@canonical.com>
	<20100715040956.GA7690@jasper.tkos.co.il>
	<20100721125113.GA2651@pengutronix.de>
Message-ID: <20100722.141245.165337920.davem@davemloft.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Wolfram Sang <w.sang@pengutronix.de>
Date: Wed, 21 Jul 2010 14:51:13 +0200

> From: Wolfram Sang <w.sang@pengutronix.de>
> Subject: [PATCH] net/fec: restore interrupt mask after software-reset in fec_stop()
> 
> After the change from mdio polling to irq, it became necessary to
> restore the interrupt mask after resetting the chip in fec_stop().
> Otherwise, with all irqs disabled, no communication with the PHY will be
> possible after e.g. un-/replugging the cable and the device gets
> stalled.
> 
> Signed-off-by: Wolfram Sang <w.sang@pengutronix.de>

Applied.
