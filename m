From: u.kleine-koenig@pengutronix.de (Uwe =?iso-8859-1?Q?Kleine-K=F6nig?=)
Date: Wed, 18 Mar 2015 14:32:26 +0100
Subject: [PATCH] spi: trigger trace event for message-done before
 mesg->complete
In-Reply-To: <20150318113635.GB2869@sirena.org.uk>
References: <1426674448-8246-1-git-send-email-u.kleine-koenig@pengutronix.de>
 <20150318113635.GB2869@sirena.org.uk>
Message-ID: <20150318133226.GR10068@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Mar 18, 2015 at 11:36:35AM +0000, Mark Brown wrote:
> On Wed, Mar 18, 2015 at 11:27:28AM +0100, Uwe Kleine-K?nig wrote:
> > With spidev the mesg->complete callback points to spidev_complete.
> > Calling this unblocks spidev_sync and so spidev_sync_write finishes. As
> > the struct spi_message just read is a local variable in
> > spidev_sync_write and recording the trace event accesses this message
> > the recording is better done first. The same can happen for
> > spidev_sync_read.
> 
> Applied, thanks.  I'm a bit suspicious that the changelog talks only
> about spidev though...
That's my workflow. Maybe the important thing here is also that I use
-rt?!

Best regards
Uwe

-- 
Pengutronix e.K.                           | Uwe Kleine-K?nig            |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
