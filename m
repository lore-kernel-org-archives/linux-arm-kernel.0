From: arnd@arndb.de (Arnd Bergmann)
Date: Thu, 19 Feb 2015 09:07:30 +0100
Subject: [PATCH] ARM: make of_device_ids const
In-Reply-To: <CAGUYZuREm+XAO7mD0gxeSftStxUOADHmoZ2ngcKp218FaKOeGw@mail.gmail.com>
References: <1424290796-18475-1-git-send-email-u.kleine-koenig@pengutronix.de>
 <6700107.3fSsY2uIcW@wuerfel>
 <CAGUYZuREm+XAO7mD0gxeSftStxUOADHmoZ2ngcKp218FaKOeGw@mail.gmail.com>
Message-ID: <7609298.ZvCtgk2my8@wuerfel>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thursday 19 February 2015 10:44:49 sanjeev sharma wrote:
> On Thu, Feb 19, 2015 at 2:07 AM, Arnd Bergmann <arnd@arndb.de> wrote:
> > On Wednesday 18 February 2015 21:19:56 Uwe Kleine-K?nig wrote:
> >> of_device_ids (i.e. compatible strings and the respective data) are not
> >> supposed to change at runtime. All functions working with of_device_ids
> >> provided by <linux/of.h> work with const of_device_ids. So mark the
> >> non-const structs in arch/arm as const, too.
> >>
> >> While at it also add some __initconst annotations.
> >>
> >> Acked-by: Jason Cooper <jason@lakedameon.net>
> >> Signed-off-by: Uwe Kleine-K?nig <u.kleine-koenig@pengutronix.de>
> >
> > Applied to fixes branch, thanks!
> >
> >         Arnd
> 
> There are many places in driver also where this need to be fixed.I
> have submitted couple of patches listed below and waiting for the
> response.
> 
> serial:imx make of_device_id array const
> pinctrl: freescale: make of_device_id array const

I'd suggest you send them again after the merge window. Maintainers
often miss patches coming in, or have a long backlog of patches
to look at.

Greg is usually very good at applying patches for the serial drivers
very quickly, but if he hasn't applied the patch within a week, it's
probably not on his radar any more.

For the pinctrl patches, I see that Linus Walleij picked up a couple
of them, and if he missed this one that was probably an oversight, so
just send him a ping or send the patch again with [PATCH RESEND] in
the subject.

	Arnd
