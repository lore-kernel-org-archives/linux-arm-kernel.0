From: shawn.guo@freescale.com (Shawn Guo)
Date: Thu, 24 Feb 2011 16:18:05 +0800
Subject: [PATCH V3 0/5] sdhci-esdhc-imx: use gpio for write protection
	and card detection
In-Reply-To: <1298469118-25282-1-git-send-email-w.sang@pengutronix.de>
References: <1298469118-25282-1-git-send-email-w.sang@pengutronix.de>
Message-ID: <20110224081803.GA29530@S2100-06.ap.freescale.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Wolfram,

On Wed, Feb 23, 2011 at 02:51:53PM +0100, Wolfram Sang wrote:
> Take #3, changes:
> 
> * also intercept calls to SDHCI_SIGNAL_ENABLE (needed on mx25)
> * remove unconditional BROKEN_CARD_DETECTION (leftover)
> * improved kernel-doc about unused GPIO
> * added tags from Eric
> 
> Tested now by me and Marc on mx35, Eric on mx25/35/51. Arnaud, did you have a
> chance to retest on mx51? What about the FSL guys? :)
> 
I'm testing it on mx25 3ds and mx51 babbage. Both card-detect and
write-protect are working on mx25 3ds, but write-protect has some
problem on babbage, and I need some time to figure it out.

Also it's not testable on mx35 3ds board, as these two "gpio" pins
are routed to a MCU which needs the I2C access.  Do we have this
support on mainline?

-- 
Regards,
Shawn
