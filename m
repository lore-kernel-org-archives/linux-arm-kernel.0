From: u.kleine-koenig@pengutronix.de (Uwe =?iso-8859-1?Q?Kleine-K=F6nig?=)
Date: Wed, 24 Feb 2010 09:46:07 +0100
Subject: sleeping clk_[enable,disable]?
In-Reply-To: <63386a3d1002230632v4c98c79dg4512684f76008a7d@mail.gmail.com>
References: <63386a3d1002230632v4c98c79dg4512684f76008a7d@mail.gmail.com>
Message-ID: <20100224084607.GB8068@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello,

On Tue, Feb 23, 2010 at 03:32:19PM +0100, Linus Walleij wrote:
> A question here:
> 
> If you have a clocking hardware that would actually require
> clk_[enable,disable] to
> sleep in order to ascertain that the clock is actually in the
> requested state when
> you return from these functions, what can you do?
> 
> I could think of several solutions, like:
> 
> * Actually let clk_[enable,disable] sleep, make sure all drivers only calls them
>   in thread context.
> 
> * Impose a state in the clk so it can be "in transition", then an
> additional function
>   clk_is_stable() which will also have to be added to most drivers but had the
>   advantage of not violating the defined clk_[enable,disable] API.
> 
> * Throw in udelay():s after the clk_[enable,disable] calls, with some values
>   that are unfortunately then spread out in the drivers instead of in the
>   clk implementation.
I had a similar problem some time ago, and choosed to let
clk_{en,dis}able sleep.

Best regards
Uwe

-- 
Pengutronix e.K.                           | Uwe Kleine-K?nig            |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
