From: u.kleine-koenig@pengutronix.de (Uwe =?iso-8859-1?Q?Kleine-K=F6nig?=)
Date: Wed, 6 Apr 2011 13:06:23 +0200
Subject: [PATCH 5/5] driver core: let dev_set_drvdata return int
	instead of void as it can fail
In-Reply-To: <BANLkTikVpacjh1EsQQoaQRN3j-kxxjr7qA@mail.gmail.com>
References: <20110301153438.GB15633@suse.de>
	<1302081865-2962-5-git-send-email-u.kleine-koenig@pengutronix.de>
	<BANLkTikVpacjh1EsQQoaQRN3j-kxxjr7qA@mail.gmail.com>
Message-ID: <20110406110623.GC13963@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello,

On Wed, Apr 06, 2011 at 11:36:46AM +0200, Micha? Miros?aw wrote:
> 2011/4/6 Uwe Kleine-K?nig <u.kleine-koenig@pengutronix.de>:
> > Signed-off-by: Uwe Kleine-K?nig <u.kleine-koenig@pengutronix.de>
> > ---
> > Hello,
> >
> > I wasn't sure what to return when dev_set_drvdata is called with
> > dev=NULL. ?I choosed 0, but -EINVAL would be OK for me, too. What do you
> > think?
> 
> Why not just BUG_ON(!dev)? Is there a case when you might call this
> with dev==NULL that's not a driver bug?
I think BUG_ON is too harsh. Will resend with -EINVAL.

Best regards
Uwe

-- 
Pengutronix e.K.                           | Uwe Kleine-K?nig            |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
