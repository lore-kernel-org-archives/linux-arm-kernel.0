From: u.kleine-koenig@pengutronix.de (Uwe =?iso-8859-1?Q?Kleine-K=F6nig?=)
Date: Wed, 9 Feb 2011 21:39:00 +0100
Subject: [RFC,PATCH 1/3] Add a common struct clk
In-Reply-To: <4D52F73A.4010707@bluewatersys.com>
References: <1297233693.242364.862698430999.1.gpush@pororo>
	<4D52F73A.4010707@bluewatersys.com>
Message-ID: <20110209203900.GT27982@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Ryan,

On Thu, Feb 10, 2011 at 09:21:14AM +1300, Ryan Mallon wrote:
> > +int clk_enable(struct clk *clk)
> > +{
> > +	unsigned long flags;
> > +	int ret = 0;
> > +
> > +	spin_lock_irqsave(&clk->enable_lock, flags);
> 
> 	WARN_ON(clk->prepare_count == 0); ?
This is added in patch 3/3

Best regards
Uwe

-- 
Pengutronix e.K.                           | Uwe Kleine-K?nig            |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
