From: broonie@kernel.org (Mark Brown)
Date: Thu, 19 Mar 2015 11:24:30 +0000
Subject: [PATCH] spi: trigger trace event for message-done before
 mesg->complete
In-Reply-To: <20150318144854.GS10068@pengutronix.de>
References: <1426674448-8246-1-git-send-email-u.kleine-koenig@pengutronix.de>
 <20150318113635.GB2869@sirena.org.uk>
 <20150318133226.GR10068@pengutronix.de>
 <20150318135854.GI2869@sirena.org.uk>
 <20150318144854.GS10068@pengutronix.de>
Message-ID: <20150319112430.GP2869@sirena.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Mar 18, 2015 at 03:48:54PM +0100, Uwe Kleine-K?nig wrote:
> On Wed, Mar 18, 2015 at 01:58:54PM +0000, Mark Brown wrote:

> > My point here is that the analysis of the issue shouldn't depend on
> > spidev in particular, if you need to call out the specific driver you're
> > working with that's an alarm sign that it's doing something weird and
> > perhaps the problem is with the driver.

> This just happens to be the driver I saw the problem with. Don't have
> another spi device on that bus to cross check with other drivers. I
> wouldn't be too concerned here.

Sure, but it's better to write it up in terms of a generic driver - it's
the difference between "let's work around this driver" and "the core
isn't doing the right thing for drivers here".
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 473 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20150319/7062fe0f/attachment.sig>
