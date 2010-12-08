From: u.kleine-koenig@pengutronix.de (Uwe =?iso-8859-1?Q?Kleine-K=F6nig?=)
Date: Wed, 8 Dec 2010 11:55:21 +0100
Subject: [PATCHv3] support PMIC mc13892
In-Reply-To: <20101208100138.GB16418@rakim.wolfsonmicro.main>
References: <1291778460-22819-1-git-send-email-yong.shen@freescale.com>
	<1291778460-22819-2-git-send-email-yong.shen@freescale.com>
	<20101208091226.GD18244@pengutronix.de>
	<20101208100138.GB16418@rakim.wolfsonmicro.main>
Message-ID: <20101208105521.GN18244@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Mark,

On Wed, Dec 08, 2010 at 10:01:38AM +0000, Mark Brown wrote:
> On Wed, Dec 08, 2010 at 10:12:26AM +0100, Uwe Kleine-K?nig wrote:
> 
> Please cut unneded context - it makes it much easier to find the new
> text in your replies!
hmm, well you could argue here.  The downside in this case you stripped
the err_alloc label that might be the right place to place my comment
here.  Sometimes I consider it hard what to strip but yes in general I
accede.
 
> > > +	if (ret)
> > > +		goto err_alloc;
> 
> > err_alloc seems wrong.  The goto is taken when reading the revision
> > register fails, not on a failed allocation.
> 
> His code is following the style of naming the exit points after what
> needs to be unwound rather than after the place jumped from which is
> common enough?
Then I'd prefer err_free.

Best regards
Uwe

-- 
Pengutronix e.K.                           | Uwe Kleine-K?nig            |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
