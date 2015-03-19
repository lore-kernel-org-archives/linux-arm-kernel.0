From: broonie@kernel.org (Mark Brown)
Date: Thu, 19 Mar 2015 11:51:12 +0000
Subject: [PATCH] spi: trigger trace event for message-done before
 mesg->complete
In-Reply-To: <20150319114842.GU10068@pengutronix.de>
References: <1426674448-8246-1-git-send-email-u.kleine-koenig@pengutronix.de>
 <20150318113635.GB2869@sirena.org.uk>
 <20150318133226.GR10068@pengutronix.de>
 <20150318135854.GI2869@sirena.org.uk>
 <20150318144854.GS10068@pengutronix.de>
 <20150319112430.GP2869@sirena.org.uk>
 <20150319114842.GU10068@pengutronix.de>
Message-ID: <20150319115112.GS2869@sirena.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Mar 19, 2015 at 12:48:42PM +0100, Uwe Kleine-K?nig wrote:
> On Thu, Mar 19, 2015 at 11:24:30AM +0000, Mark Brown wrote:

> > Sure, but it's better to write it up in terms of a generic driver - it's
> > the difference between "let's work around this driver" and "the core
> > isn't doing the right thing for drivers here".

> OK, so something like:

> spi: trigger trace event for message-done before mesg->complete
> 
> The message's complete callback might (permissibly) free the memory that
> holds the message. As recording the trace event for the end of a
> transfer accesses this message the recording is better done first.

Yes, that's the sort of thing I was looking for - it just makes the
review a bit easier.
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 473 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20150319/3e2f9f1f/attachment.sig>
