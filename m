From: broonie@kernel.org (Mark Brown)
Date: Wed, 18 Mar 2015 11:36:35 +0000
Subject: [PATCH] spi: trigger trace event for message-done before
 mesg->complete
In-Reply-To: <1426674448-8246-1-git-send-email-u.kleine-koenig@pengutronix.de>
References: <1426674448-8246-1-git-send-email-u.kleine-koenig@pengutronix.de>
Message-ID: <20150318113635.GB2869@sirena.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Mar 18, 2015 at 11:27:28AM +0100, Uwe Kleine-K?nig wrote:
> With spidev the mesg->complete callback points to spidev_complete.
> Calling this unblocks spidev_sync and so spidev_sync_write finishes. As
> the struct spi_message just read is a local variable in
> spidev_sync_write and recording the trace event accesses this message
> the recording is better done first. The same can happen for
> spidev_sync_read.

Applied, thanks.  I'm a bit suspicious that the changelog talks only
about spidev though...
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 473 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20150318/bc861a72/attachment.sig>
