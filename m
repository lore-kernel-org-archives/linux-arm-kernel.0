From: u.kleine-koenig@pengutronix.de (Uwe =?iso-8859-1?Q?Kleine-K=F6nig?=)
Date: Tue, 8 Jul 2014 20:26:20 +0200
Subject: [PATCH 1/2] ARM: efm32: switch to properly namespaced location
 property
In-Reply-To: <CAOesGMjJJPJr7GnB=aoydGqtoaTd8wdBYDD92S0+5-y1PJepsA@mail.gmail.com>
References: <20140630154030.GJ14781@pengutronix.de>
 <1404142889-20740-1-git-send-email-u.kleine-koenig@pengutronix.de>
 <CAOesGMjzzYwXKXZLvUVp-nAGf+R4G8eUjK+3CumB8i5LkoRCow@mail.gmail.com>
 <20140708064135.GE7827@pengutronix.de>
 <CAOesGMjJJPJr7GnB=aoydGqtoaTd8wdBYDD92S0+5-y1PJepsA@mail.gmail.com>
Message-ID: <20140708182620.GH7827@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Olof,

On Tue, Jul 08, 2014 at 09:06:13AM -0700, Olof Johansson wrote:
> I really don't want a hodge-podge of whatever someone felt like
> picking as a name at the time. It makes it really hard for newcomers
> to find a good best practices to follow, and over time will result in
> total chaos.
That's right. I did it in good faith. If you think it would be worth to
switch to say "energymicro,location" I think it wouldn't be that hard,
because I think there are no boards in the wild that use a device tree
and don't use the BSP I'm providing where switching is a no brainer.
> 
> What's this binding for anyway? It looks a lot like an ad-hoc pinctrl
> binding for configuring pinout, is that accurate?
Well, it has to do with pinctrl, but it was agreed that managing it with
a single pinctrl device would complicate things considerably and in the
end the device tree wouldn't describe how the hardware looks like but
would result in a lot of complexity just to fit into the Linux pinctrl
model.

See the thread around
http://marc.info/?l=linux-spi&m=137485291802157&w=2 for the glory
details.

Best regards
Uwe

-- 
Pengutronix e.K.                           | Uwe Kleine-K?nig            |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
