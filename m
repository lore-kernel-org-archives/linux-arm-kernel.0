From: wsa@the-dreams.de (Wolfram Sang)
Date: Sun, 18 Jan 2015 12:42:55 +0100
Subject: [PATCH v5 2/3] i2c: iproc: Add Broadcom iProc I2C Driver
In-Reply-To: <20150118111759.GG22880@pengutronix.de>
References: <rjui@broadcom.com>
 <1421451737-7107-1-git-send-email-rjui@broadcom.com>
 <1421451737-7107-3-git-send-email-rjui@broadcom.com>
 <54BB795C.6040402@broadcom.com>
 <20150118094741.GE22880@pengutronix.de>
 <20150118110658.GA1113@katana>
 <20150118111759.GG22880@pengutronix.de>
Message-ID: <20150118114255.GB1113@katana>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sun, Jan 18, 2015 at 12:17:59PM +0100, Uwe Kleine-K?nig wrote:
> Hello Wolfram,
> 
> On Sun, Jan 18, 2015 at 12:06:58PM +0100, Wolfram Sang wrote:
> > On Sun, Jan 18, 2015 at 10:47:41AM +0100, Uwe Kleine-K?nig wrote:
> > > On Sun, Jan 18, 2015 at 10:14:04AM +0100, Arend van Spriel wrote:
> > > > On 01/17/15 00:42, Ray Jui wrote:
> > > > >+	complete_all(&iproc_i2c->done);
> > > > 
> > > > Looking over this code it seems to me there is always a single
> > > > process waiting for iproc_i2c->done to complete. So using complete()
> > > > here would suffice.
> > > Yeah, there is always only a single thread waiting. That means both
> > > complete and complete_all are suitable. AFAIK there is no reason to pick
> > > one over the other in this case.
> > 
> > Clarity?
> And which do you consider more clear? complete_all might result in the
> question: "Is there >1 waiter?" and complete might yield to "What about
> the other waiters?". If you already know there is only one, both are on
> par on clarity. Might only be me?! I don't care much.

It is minor, I agree: If I read complete_all, I assume there is
something fishy if there is only one waiter. It doesn't match. It might
work, but I'll wonder if this is accidently or intentionally.

-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 819 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20150118/29bbc836/attachment.sig>
