From: u.kleine-koenig@pengutronix.de (Uwe =?iso-8859-1?Q?Kleine-K=F6nig?=)
Date: Thu, 25 Nov 2010 08:42:44 +0100
Subject: [PATCH 1/1] arm: imx: share imx5x_register_gpios for mach-mx5
In-Reply-To: <AANLkTimvcAS3BmjtaYCMzHcv=q2znS2zy_Dto_OMJeWh@mail.gmail.com>
References: <1290695312-30031-1-git-send-email-linuxzsc@gmail.com>
	<20101125062924.GD4693@pengutronix.de>
	<AANLkTimvcAS3BmjtaYCMzHcv=q2znS2zy_Dto_OMJeWh@mail.gmail.com>
Message-ID: <20101125074244.GE4693@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hey Richard,

On Thu, Nov 25, 2010 at 02:44:48PM +0800, Richard Zhao wrote:
> > IMO the machine files shouldn't need to know how many gpio banks are
> > available. ?This is a per-SoC thing and so should be set in a SoC function.
> But we don't have SoC level device file.
Check how I did it for imx{1,21,27,25} in arch/arm/plat-mxc/gpio.c.

> > How do you want to continue this change? ?mx51 and mx53 have the same
> > number of ports? ?Does mx50 have more or less? ?The addresses are the
> > same?
> mx53 and mx50 have similar memory map. but mx51 is different.  Sorry,
> I forgot upstream version IO_ADDR can not handler differnt SoC base
> addr offset.
It might even work in this case, still I prefer a more explicit way.

>              It can not be shared with mx51, but it can be shared with
> mx50/53, correct? May plan is mx53/50 share
> arch/arm/plat-mxc/include/mach/mx5x.h file.
mx5x.h is for mx50 and mx53 but not mx51?  No please.

Best regards
Uwe

-- 
Pengutronix e.K.                           | Uwe Kleine-K?nig            |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
