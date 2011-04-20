From: gregkh@suse.de (Greg KH)
Date: Wed, 20 Apr 2011 09:17:33 -0700
Subject: [PATCH v2] driver core: let dev_set_drvdata return int instead
	of void as it can fail
In-Reply-To: <20110420074248.GS31131@pengutronix.de>
References: <BANLkTi=MjDqawZx=+fKjaAs5SPfGQDEgVQ@mail.gmail.com>
	<1302547378-14639-1-git-send-email-u.kleine-koenig@pengutronix.de>
	<20110419235812.GA4619@kroah.com>
	<20110420074248.GS31131@pengutronix.de>
Message-ID: <20110420161733.GB25396@suse.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Apr 20, 2011 at 09:42:48AM +0200, Uwe Kleine-K?nig wrote:
> On Tue, Apr 19, 2011 at 04:58:12PM -0700, Greg KH wrote:
> > On Mon, Apr 11, 2011 at 08:42:58PM +0200, Uwe Kleine-K?nig wrote:
> > > Before commit
> > > 
> > > 	b402843 (Driver core: move dev_get/set_drvdata to drivers/base/dd.c)
> > > 
> > > calling dev_set_drvdata with dev=NULL was an unchecked error. After some
> > > discussion about what to return in this case removing the check (and so
> > > producing a null pointer exception) seems fine.
> > > 
> > > Signed-off-by: Uwe Kleine-K?nig <u.kleine-koenig@pengutronix.de>
> > > ---
> > > Hello,
> > > 
> > > @Viresh: as I didn't choose to return -EINVAL I didn't add your Reviewed-by:
> > 
> > I'm confused by this thread, care to resend all of these in a series
> > against the latest linux-next tree?
> No problem, here it comes. This are patches 1 to 4 of the original
> series + v2 of patch 5 (that didn't have 5/5 in the subject).


Thanks, I'll queue these up soon.

greg k-h
