From: broonie@kernel.org (Mark Brown)
Date: Thu, 28 Apr 2016 12:22:49 +0100
Subject: [PATCH] spi: imx: Add pm-runtime autosuspend
In-Reply-To: <1461841411-26529-1-git-send-email-mpa@pengutronix.de>
References: <1461841411-26529-1-git-send-email-mpa@pengutronix.de>
Message-ID: <20160428112249.GL3217@sirena.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Apr 28, 2016 at 01:03:31PM +0200, Markus Pargmann wrote:
> Currently for each transfer the two clocks are enabled and disabled. For
> heavy SPI usage this can lead to a significant overhead.

Really?  If the system is loaded the normal effect is that we will get
an equivalent effect from the SPI message thread - I'm curious what the
numbers are here.  This doesn't seem like something we should be doing
in individual drivers if it makes a difference.
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 473 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20160428/8bef037e/attachment.sig>
