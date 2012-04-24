From: broonie@opensource.wolfsonmicro.com (Mark Brown)
Date: Tue, 24 Apr 2012 13:36:40 +0100
Subject: device-tree vs gpio-leds gpio_blink_set
In-Reply-To: <CACRpkdZ4RSiqrHU60auvCx9xxZp5CQQzjis+Xz6EVMA+7-8_eg@mail.gmail.com>
References: <20120423072745.678323582@rtp-net.org>
 <201204231122.43481.arnd@arndb.de>
 <20120423174924.GA457@sirena.org.uk>
 <CACRpkdZ4RSiqrHU60auvCx9xxZp5CQQzjis+Xz6EVMA+7-8_eg@mail.gmail.com>
Message-ID: <20120424123639.GC13747@opensource.wolfsonmicro.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Apr 24, 2012 at 02:24:16PM +0200, Linus Walleij wrote:
> On Mon, Apr 23, 2012 at 7:49 PM, Mark Brown

> > Another idea would be to use pinctrl and represent the blink as a
> > special function. ?Not sure that's sensible though.

> I would rather say that anything automatically toggling
> a GPIO pin on/off at specified intervals is HW-controlled
> GPIO PWM.

Yes, that's not a million miles away from what I was thinking - the
followup to what I was thinking was that the other function would be a
PWM function.  It's feeling like we might want some sort of generic
interface for handling situations like this and like the open drain
simulation code which was recently added to gpiolib where we end up
crossing subsystems.  In principle you should always use the subsystem
you want directly, the issue comes about when you want to use multiple
sets of functionality and still fall back on the emulations.

> So this would be something that gets to be modeled in the
> PWM subsystem, but there is no such thing (I know Sascha et
> al was working on that at one point.)

Thierry took over the work and last time I saw it things looked like
they were pretty much ready for merge, I'd really expect to see the code
in 3.5 based on the previous state (in fact I was pretty surprised 
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 836 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20120424/c0ba85ea/attachment.sig>
