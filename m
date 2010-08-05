From: kevin.wells@nxp.com (Kevin Wells)
Date: Thu, 5 Aug 2010 19:14:19 +0200
Subject: [PATCH 15/19] SPI: amba-pl022: move probe and remove to
	.devinit and	.devexit resp.
In-Reply-To: <1281017333-5563-15-git-send-email-u.kleine-koenig@pengutronix.de>
References: <20100805140813.GA13859@pengutronix.de>
	<1281017333-5563-15-git-send-email-u.kleine-koenig@pengutronix.de>
Message-ID: <083DF309106F364B939360100EC290F80AC3A54D15@eu1rdcrdc1wx030.exi.nxp.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

> The driver can be bound via sysfs after the .init sections are already
> discarded, so pl022_probe must not be in .init.text.  If there is no
> remove
> function the driver can still be unbound without any callback being run.
> So pl022_remove must not be in .exit.text.
> 
> This fixes a section mismatch reported by modpost.
> 

This fix was in Grant Likely's spi tree earlier this week.
