From: u.kleine-koenig@pengutronix.de (Uwe =?iso-8859-1?Q?Kleine-K=F6nig?=)
Date: Wed, 17 Mar 2010 10:13:49 +0100
Subject: [PATCH 1/2] [ARM] [IMX]: Removed superfluous checks for
	argument validity.
In-Reply-To: <1268809916-6525-1-git-send-email-vzapolskiy@gmail.com>
References: <1268809916-6525-1-git-send-email-vzapolskiy@gmail.com>
Message-ID: <20100317091349.GA16150@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello Vladimir,

On Wed, Mar 17, 2010 at 10:11:55AM +0300, Vladimir Zapolskiy wrote:
> The checks for clk argument are doubled in __clk_disable() and
> __clk_enable() functions and thus may be skipped in clk_disable() and
> clk_enable() bodies.
Maybe better get rid of the test in __clk_{en,dis}able, as these are
called more often?  Actually I think even a WARN_ON(clk == NULL ||
IS_ERR(clk)) would be OK.

Best regards
Uwe

-- 
Pengutronix e.K.                           | Uwe Kleine-K?nig            |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
