From: jeremy.kerr@canonical.com (Jeremy Kerr)
Date: Mon, 02 May 2011 09:09:46 +0800
Subject: [PATCH 01/10] Add a common struct clk
In-Reply-To: <4DBDC3B5.7070808@gmail.com>
References: <1302894495-6879-1-git-send-email-s.hauer@pengutronix.de>
	<1302894495-6879-2-git-send-email-s.hauer@pengutronix.de>
	<4DBDC3B5.7070808@gmail.com>
Message-ID: <1304298586.2686.29.camel@pororo>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Rob,

> > +int clk_prepare(struct clk *clk)
> > +{
> > +	int ret = 0;
> > +
> 
> Shouldn't all these functions have some clk pointer checks:
> 
> 	if (IS_ERR_OR_NULL(clk))
> 		return -EINVAL;
> 

No, I'd prefer not to. The driver code should be responsible for passing
a valid pointer here, by doing this check once (where the clock is
initially acquired through clk_get), rather than the core code doing it
on each function call.

Cheers,


Jeremy
