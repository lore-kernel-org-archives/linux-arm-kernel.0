From: sfking@fdwdc.com (Steven King)
Date: Thu, 17 Jan 2013 08:50:43 -0800
Subject: [PATCH 0/4] gpio: introduce descriptor-based interface
In-Reply-To: <50F7E83E.8000105@uclinux.org>
References: <1357629535-26033-1-git-send-email-acourbot@nvidia.com>
 <CACRpkda6dqAj+DzrMCnKET7Z9PtuW0+k9ea3YDL8Z1D=oFVRpQ@mail.gmail.com>
 <50F7E83E.8000105@uclinux.org>
Message-ID: <201301170850.43655.sfking@fdwdc.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thursday 17 January 2013 4:02:06 am Greg Ungerer wrote:
> Hi Linus,
>
> (My gerg at snapgear.com email no longer gets to me, gerg at uclinux.org is
> the best direct email for me now).
>
> On 01/17/2013 09:15 PM, Linus Walleij wrote:
> > On Thu, Jan 10, 2013 at 11:08 AM, Arnd Bergmann <arnd@arndb.de> wrote:
> >> I've tried to find platforms that don't yet use GPIOLIB and fortunately
> >> there are very few left:
> >>
> >> I found two that provide the generic gpio interfaces when gpiolib
> >> is disabled, but use gpiolib otherwise for the same hardware,
> >> arch/m68k/include/asm/mcfgpio.h and arch/blackfin/include/asm/gpio.h.
> >> I would assume that we can simply remove the non-gpiolib shortcut
> >> here at cost of a small overhead.
> >
> > Geert/Greg: interested in looking into this issue?
> >
> > The GPIO maintainers want to get rid of non-gpiolib platforms.
>
> Steven King did most of the ColdFire GPIO work (CC'ed on this).
> Steven: are you happy to drop the non-gpiolib support?
>
> Regards
> Greg

Well, my concern is the small, single chip platforms with limited ram and 
speeds measured in MHz.  My goal was that these platforms that had very basic 
gpio needs, no offboard gpio, just toggling a few pins for spi or whatever, 
could do that without pulling in a bunch of code they dont need.  I realize 
that for x86 or arm people with their giga Hz cpus with gigabytes of ram, its 
no big deal, but my little 60 MHz coldfire v2s with only 16 megs of ram (and 
even more constraining, 2 megs of flash) need all the help they can get.

I haven't been keeping up with the kernel list of late, can someone point me 
to what''s being discussed so I can see what were talking about here?
