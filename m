From: arnd@arndb.de (Arnd Bergmann)
Date: Sun, 2 Sep 2012 18:49:53 +0000
Subject: [PATCH 4/4] ARM: ks8695: convert to generic time and clocksource
In-Reply-To: <CACRpkdZ0Gw5H_yRcN2CmC+F8NtUcySTrLehuzZdWrbDwL4HHWw@mail.gmail.com>
References: <1346264842-20411-1-git-send-email-linus.walleij@linaro.org>
 <504057A8.7030302@snapgear.com>
 <CACRpkdZ0Gw5H_yRcN2CmC+F8NtUcySTrLehuzZdWrbDwL4HHWw@mail.gmail.com>
Message-ID: <201209021849.54348.arnd@arndb.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Friday 31 August 2012, Linus Walleij wrote:
> On Fri, Aug 31, 2012 at 8:20 AM, Greg Ungerer <gerg@snapgear.com> wrote:
> 
> > Ok, tested on a KS8695 based machine. Boots and runs, obviously
> > clock is basically working. But 'date' never shows the time
> > increasing:
> >
> >   # date
> >   Thu Jan  1 00:00:00 UTC 1970
> >   # date
> >   Thu Jan  1 00:00:00 UTC 1970
> >   # date
> >   Thu Jan  1 00:00:00 UTC 1970
> >   #
> >
> > And yes, that did work before applying this patch :-)
> 
> That mean clockevent is running but not clocksource.
> 
> And I think that is because I forgot a ~ in the mask for disabling
> the T1 timer, so setting up the clockevent disables the clocksource ...
> 
> I'll send out a fixed version, plese test!
> 
> (BTW I had not clue the 68K maintainer had a platform like
> this, fun!)

Note that this platform is one of those we talked about removing
from the kernel for potentially being completely unused. Do we have
reason to believe that people are still using ks8695 for anything
with new kernels?

If any of you are doing that, we'll definitely keep the port around,
the idea is not to break anything that people are actually using.
In that case, I would like to see a MAINTAINERS entry for the platform
so we have a contact for someone who is able to ack and maybe test
patches.

	Arnd
