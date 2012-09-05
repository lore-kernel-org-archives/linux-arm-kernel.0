From: benh@kernel.crashing.org (Benjamin Herrenschmidt)
Date: Wed, 05 Sep 2012 19:23:43 +1000
Subject: [PATCH 13/25] macintosh/mediabay: add a const qualifier
In-Reply-To: <20120905080249.GI28643@pengutronix.de>
References: <1343034810-3386-1-git-send-email-u.kleine-koenig@pengutronix.de>
 <1343034810-3386-14-git-send-email-u.kleine-koenig@pengutronix.de>
 <1346812817.2257.23.camel@pasglop> <20120905080249.GI28643@pengutronix.de>
Message-ID: <1346837023.2257.57.camel@pasglop>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, 2012-09-05 at 10:02 +0200, Uwe Kleine-K?nig wrote:
> Hello,
> 
> On Wed, Sep 05, 2012 at 12:40:17PM +1000, Benjamin Herrenschmidt wrote:
> > On Mon, 2012-07-23 at 11:13 +0200, Uwe Kleine-K?nig wrote:
> > > This prepares *of_device_id.data becoming const. Without this change
> > > the following warning would occur:
> > > 
> > > 	drivers/macintosh/mediabay.c: In function 'media_bay_attach':
> > > 	drivers/macintosh/mediabay.c:589:11: warning: assignment discards 'const' qualifier from pointer target type [enabled by default]
> > > 
> > > Signed-off-by: Uwe Kleine-K?nig <u.kleine-koenig@pengutronix.de>
> > > ---
> > 
> > Ack all of these assuming you test built (I didn't).
> "all" means the two mediabay patches? And yes, they are all built
> tested.

Yeah, anything powerpc you had in your series, but the two mediabay ones
are what I spotted when digging through stuff today :-)

> >                                                      Do you need me to
> > carry any of this via the powerpc tree ?
> The patch that adds the const to of_device_id depends[1] on this patch.
> And the other mediabay is only valid after that const is added. So the
> easiest is if the series is pulled in one go. Arnd intended to let Linus
> pull it for 3.6-rc1 but it was missed because of a communication
> problem. So I intend to get it in during the 3.7 merge window.

Ok, I'm happy for Arnd to carry all of these, I trust his
judgement/review for that stuff including for ppc specific bits.

Cheers,
Ben.

> Best regards
> Uwe
> 
> [1] it's only a soft depend, because the result is "only" a warning, but
> still.
> 
