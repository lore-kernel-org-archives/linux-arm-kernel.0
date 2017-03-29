From: u.kleine-koenig@pengutronix.de (Uwe =?iso-8859-1?Q?Kleine-K=F6nig?=)
Date: Wed, 29 Mar 2017 21:39:03 +0200
Subject: [PATCH v2 1/2] mtd: nand: orion: fix clk handling
In-Reply-To: <20170329193607.GA24737@gandalf>
References: <20170327180208.13414-1-gmbnomis@gmail.com>
 <20170327181949.isafnqsnxkzed5nv@pengutronix.de>
 <20170329193607.GA24737@gandalf>
Message-ID: <20170329193903.u2wmutwz3bodholp@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Mar 29, 2017 at 09:36:08PM +0200, Simon Baatz wrote:
> On Mon, Mar 27, 2017 at 08:19:49PM +0200, Uwe Kleine-K?nig wrote:
> > you could to the following here instead:
> > 
> > 	info->clk = devm_clk_get(&pdev->dev, NULL);
> > 	if (IS_ERR(info->clk))
> > 		/*
> > 		 * We ignore all errors here, that's wrong but only for
> > 		 * one commit.
> > 		 */
> > 		info->clk = NULL;
> > 
> > 	ret = clk_prepare_enable(info->clk);
> > 	if (ret) ...
> > 
> 
> Makes sense.  I don't think we should have such a comment, though. 

Yes I agree, I just wanted to prevent people thinking I suggest this
code snipet for optional clock handling and so wanted to write a big
No-No-No onto it.

Best regards
Uwe

-- 
Pengutronix e.K.                           | Uwe Kleine-K?nig            |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
