From: olof@lixom.net (Olof Johansson)
Date: Thu, 10 Jul 2014 15:05:29 -0700
Subject: [PATCH 1/2] ARM: efm32: switch to properly namespaced location
 property
In-Reply-To: <20140708182620.GH7827@pengutronix.de>
References: <20140630154030.GJ14781@pengutronix.de>
 <1404142889-20740-1-git-send-email-u.kleine-koenig@pengutronix.de>
 <CAOesGMjzzYwXKXZLvUVp-nAGf+R4G8eUjK+3CumB8i5LkoRCow@mail.gmail.com>
 <20140708064135.GE7827@pengutronix.de>
 <CAOesGMjJJPJr7GnB=aoydGqtoaTd8wdBYDD92S0+5-y1PJepsA@mail.gmail.com>
 <20140708182620.GH7827@pengutronix.de>
Message-ID: <CAOesGMjgX5PWBSD2YP7mTGMWafxBjeMDmzZoPCXb27YPUHEcyw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Jul 8, 2014 at 11:26 AM, Uwe Kleine-K?nig
<u.kleine-koenig@pengutronix.de> wrote:
> Hi Olof,
>
> On Tue, Jul 08, 2014 at 09:06:13AM -0700, Olof Johansson wrote:
>> I really don't want a hodge-podge of whatever someone felt like
>> picking as a name at the time. It makes it really hard for newcomers
>> to find a good best practices to follow, and over time will result in
>> total chaos.
> That's right. I did it in good faith. If you think it would be worth to
> switch to say "energymicro,location" I think it wouldn't be that hard,
> because I think there are no boards in the wild that use a device tree
> and don't use the BSP I'm providing where switching is a no brainer.

Yeah, let's do it now before there are users, if that's OK with you.

>> What's this binding for anyway? It looks a lot like an ad-hoc pinctrl
>> binding for configuring pinout, is that accurate?
> Well, it has to do with pinctrl, but it was agreed that managing it with
> a single pinctrl device would complicate things considerably and in the
> end the device tree wouldn't describe how the hardware looks like but
> would result in a lot of complexity just to fit into the Linux pinctrl
> model.
>
> See the thread around
> http://marc.info/?l=linux-spi&m=137485291802157&w=2 for the glory
> details.

OK, thanks for the background.


-Olof
