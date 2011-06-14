From: shawn.guo@freescale.com (Shawn Guo)
Date: Tue, 14 Jun 2011 20:24:25 +0800
Subject: [PATCH 1/4] mmc: sdhci: fix interrupt storm from card detection
In-Reply-To: <20110614120258.GE5043@pengutronix.de>
References: <1307702572-22066-1-git-send-email-shawn.guo@linaro.org>
	<1307702572-22066-2-git-send-email-shawn.guo@linaro.org>
	<20110614092410.GB5043@pengutronix.de>
	<20110614115557.GF30295@S2100-06.ap.freescale.net>
	<20110614120258.GE5043@pengutronix.de>
Message-ID: <20110614122425.GG30295@S2100-06.ap.freescale.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Jun 14, 2011 at 02:02:58PM +0200, Wolfram Sang wrote:
> 
> > > > The issue was initially found by Eric Benard as below.
> > > > 
> > > > http://permalink.gmane.org/gmane.linux.ports.arm.kernel/108031
> > > > 
> > > > Not sure about other SDHCI based controller, but on Freescale eSDHC,
> > > > the SDHCI_INT_CARD_INSERT bits will be immediately set again when it
> > > > gets cleared, if a card is inserted. The driver need to mask the irq
> > > > to prevent interrupt storm which will freeze the system.  And the
> > > > SDHCI_INT_CARD_REMOVE gets the same situation.
> > > > 
> > > > The patch fixes the problem based on the initial idea from
> > > > Eric Benard.
> > > > 
> > > > Signed-off-by: Shawn Guo <shawn.guo@linaro.org>
> > > > Cc: Eric Benard <eric@eukrea.com>
> > > 
> > > Hmm, that should get enough testing on non-imx (and even non-ARM)
> > > devices. And a comment describing the situation.
> > > 
> > Agreed.  Will add something in commit message to mention the
> > situation.  That's why I hope we can get the patch on mmc-next at
> 
> I actually meant a comment in the code, so it will be obvious for later
> hackers why the "extra" steps are in there...
> 
OK.

-- 
Regards,
Shawn
