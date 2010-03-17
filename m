From: vzapolskiy@gmail.com (Vladimir Zapolskiy)
Date: Wed, 17 Mar 2010 13:34:50 +0300
Subject: [PATCH 1/2] [ARM] [IMX]: Removed superfluous checks for argument
	validity.
In-Reply-To: <20100317091349.GA16150@pengutronix.de>
References: <1268809916-6525-1-git-send-email-vzapolskiy@gmail.com>
	<20100317091349.GA16150@pengutronix.de>
Message-ID: <acc484891003170334p133ee328y2d1b17533b672ac5@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello Uwe,

__clk_enable() and __clk_disable() are recursive with another arguments,
that means it is hardly possible to remove the checks from them.

2010/3/17 Uwe Kleine-K?nig <u.kleine-koenig@pengutronix.de>

> Hello Vladimir,
>
> On Wed, Mar 17, 2010 at 10:11:55AM +0300, Vladimir Zapolskiy wrote:
> > The checks for clk argument are doubled in __clk_disable() and
> > __clk_enable() functions and thus may be skipped in clk_disable() and
> > clk_enable() bodies.
> Maybe better get rid of the test in __clk_{en,dis}able, as these are
> called more often?  Actually I think even a WARN_ON(clk == NULL ||
> IS_ERR(clk)) would be OK.
>
> Best regards
> Uwe
>
> With best wishes,
Vladimir
-------------- next part --------------
An HTML attachment was scrubbed...
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20100317/08a7f91b/attachment-0001.htm>
