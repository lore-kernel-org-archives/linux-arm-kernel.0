From: w.sang@pengutronix.de (Wolfram Sang)
Date: Tue, 14 Jun 2011 11:24:10 +0200
Subject: [PATCH 1/4] mmc: sdhci: fix interrupt storm from card detection
In-Reply-To: <1307702572-22066-2-git-send-email-shawn.guo@linaro.org>
References: <1307702572-22066-1-git-send-email-shawn.guo@linaro.org>
	<1307702572-22066-2-git-send-email-shawn.guo@linaro.org>
Message-ID: <20110614092410.GB5043@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Jun 10, 2011 at 06:42:49PM +0800, Shawn Guo wrote:
> The issue was initially found by Eric Benard as below.
> 
> http://permalink.gmane.org/gmane.linux.ports.arm.kernel/108031
> 
> Not sure about other SDHCI based controller, but on Freescale eSDHC,
> the SDHCI_INT_CARD_INSERT bits will be immediately set again when it
> gets cleared, if a card is inserted. The driver need to mask the irq
> to prevent interrupt storm which will freeze the system.  And the
> SDHCI_INT_CARD_REMOVE gets the same situation.
> 
> The patch fixes the problem based on the initial idea from
> Eric Benard.
> 
> Signed-off-by: Shawn Guo <shawn.guo@linaro.org>
> Cc: Eric Benard <eric@eukrea.com>

Hmm, that should get enough testing on non-imx (and even non-ARM)
devices. And a comment describing the situation.

-- 
Pengutronix e.K.                           | Wolfram Sang                |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
-------------- next part --------------
A non-text attachment was scrubbed...
Name: not available
Type: application/pgp-signature
Size: 198 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20110614/43d260b1/attachment.sig>
