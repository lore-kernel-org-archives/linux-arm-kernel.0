From: u.kleine-koenig@pengutronix.de (Uwe =?iso-8859-1?Q?Kleine-K=F6nig?=)
Date: Wed, 5 Sep 2012 10:02:49 +0200
Subject: [PATCH 13/25] macintosh/mediabay: add a const qualifier
In-Reply-To: <1346812817.2257.23.camel@pasglop>
References: <1343034810-3386-1-git-send-email-u.kleine-koenig@pengutronix.de>
 <1343034810-3386-14-git-send-email-u.kleine-koenig@pengutronix.de>
 <1346812817.2257.23.camel@pasglop>
Message-ID: <20120905080249.GI28643@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello,

On Wed, Sep 05, 2012 at 12:40:17PM +1000, Benjamin Herrenschmidt wrote:
> On Mon, 2012-07-23 at 11:13 +0200, Uwe Kleine-K?nig wrote:
> > This prepares *of_device_id.data becoming const. Without this change
> > the following warning would occur:
> > 
> > 	drivers/macintosh/mediabay.c: In function 'media_bay_attach':
> > 	drivers/macintosh/mediabay.c:589:11: warning: assignment discards 'const' qualifier from pointer target type [enabled by default]
> > 
> > Signed-off-by: Uwe Kleine-K?nig <u.kleine-koenig@pengutronix.de>
> > ---
> 
> Ack all of these assuming you test built (I didn't).
"all" means the two mediabay patches? And yes, they are all built
tested.

>                                                      Do you need me to
> carry any of this via the powerpc tree ?
The patch that adds the const to of_device_id depends[1] on this patch.
And the other mediabay is only valid after that const is added. So the
easiest is if the series is pulled in one go. Arnd intended to let Linus
pull it for 3.6-rc1 but it was missed because of a communication
problem. So I intend to get it in during the 3.7 merge window.

Best regards
Uwe

[1] it's only a soft depend, because the result is "only" a warning, but
still.

-- 
Pengutronix e.K.                           | Uwe Kleine-K?nig            |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
