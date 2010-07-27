From: u.kleine-koenig@pengutronix.de (Uwe =?iso-8859-1?Q?Kleine-K=F6nig?=)
Date: Tue, 27 Jul 2010 17:32:31 +0200
Subject: [PATCH] gpio: remove spurious gpio_unexport debug error.
In-Reply-To: <20100726153236.ead96c88.akpm@linux-foundation.org>
References: <1279832758-25442-1-git-send-email-gbean@codeaurora.org>
	<20100723045807.GA14875@pengutronix.de>
	<20100726153236.ead96c88.akpm@linux-foundation.org>
Message-ID: <20100727153231.GA7072@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello Andrew,

On Mon, Jul 26, 2010 at 03:32:36PM -0700, Andrew Morton wrote:
> On Fri, 23 Jul 2010 06:58:07 +0200
> Uwe Kleine-K__nig <u.kleine-koenig@pengutronix.de> wrote:
> 
> > Hello,
> > 
> > On Thu, Jul 22, 2010 at 02:05:58PM -0700, Gregory Bean wrote:
> > > Make gpio_unexport generate success instead of an -EINVAL
> > > if asked to unexport a line which is not exported, because
> > > the only result of that condition is a pr_debug
> > > which complains of what is really a harmless no-op:
> > > when an unexported gpio is unexported again, nothing happens.
> > > That's not a failure, just a trivial border case.
> > > Since gpio_free calls gpio_unexport unconditionally
> > > and exported gpio lines are uncommon, most calls to
> > > gpio_free with debug flags enabled generate -EINVAL
> > > warnings in the log, causing unnecessary stress.
> > I noticed that a few days ago, too.  Just didn't come around to fix it
> > myself.
> >  
> > > Signed-off-by: Gregory Bean <gbean@codeaurora.org>
> > Acked-by: Uwe Kleine-K__nig <u.kleine-koenig@pengutronix.de>
> > 
> 
> Jon got there first ;)
OK, then he can get my ack, too.

Thanks
Uwe

-- 
Pengutronix e.K.                           | Uwe Kleine-K?nig            |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
