From: khilman@ti.com (Kevin Hilman)
Date: Wed, 05 Jan 2011 08:54:48 -0800
Subject: [PATCH] OMAP: GPIO: fix _set_gpio_triggering() for OMAP2+
In-Reply-To: <AANLkTi=-9soJBeSGGUmcKNckzV651y=uJ9co9rByJyQB@mail.gmail.com>
	(Charulatha Varadarajan's message of "Wed, 5 Jan 2011 15:52:50 +0530")
References: <1293620491-7201-1-git-send-email-ext-mika.1.westerberg@nokia.com>
	<87aajg7dzu.fsf@ti.com> <1294181154.18162.39.camel@localhost>
	<20110104231721.GO7771@atomide.com>
	<AANLkTi=-9soJBeSGGUmcKNckzV651y=uJ9co9rByJyQB@mail.gmail.com>
Message-ID: <87oc7v1eav.fsf@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Charu,

"Varadarajan, Charulatha" <charu@ti.com> writes:

> On Wed, Jan 5, 2011 at 04:47, Tony Lindgren <tony@atomide.com> wrote:
>> * Kevin Hilman <khilman@ti.com> [110104 14:45]:
>>> On Tue, 2011-01-04 at 09:52 -0800, Kevin Hilman wrote:
>>> > Mika Westerberg <ext-mika.1.westerberg@nokia.com> writes:
>>> >
>>> > > In case on OMAP2+ we call set_24xx_gpio_triggering() instead of
>>> > > updating reg and l values. However, at the end of the function we
>>> > > perform a write:
>>> > >
>>> > > ? __raw_writel(l, reg);
>>> > >
>>> > > So on OMAP2+ we end up writing 0 to the bank->base which is not
>>> > > correct (typically this points to GPIO_REVISION register).
>>> > >
>>> > > Fix this by returning immediately after call to
>>> > > set_24xx_gpio_triggering().
>>> > >
>>> > > Signed-off-by: Mika Westerberg <ext-mika.1.westerberg@nokia.com>
>>> >
>>> > Acked-by: Kevin Hilman <khilman@ti.com>
>>> >
>>> > Tony, this should be added to omap-for-linus as it fixes a problem in
>>> > the recently merged GPIO omap_device/hwmod conversion.
>
> One clarification - This problem should be existing since the following commit
> 92105bb70634abacc08bbe12bf6f888fbd7dad38
> which was introduced on Sep 7, 2005
>
> FYI, this part of the code remained untouched during GPIO omap_device/hwmod
> conversion.
>

OK, thanks for the clarification.

I had assumed it was recent changes since the patch didn't apply
cleanly, but am glad to be wrong. :)

Kevin
