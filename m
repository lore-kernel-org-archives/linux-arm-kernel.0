From: viresh.linux@gmail.com (viresh kumar)
Date: Wed, 21 Mar 2012 19:48:26 +0530
Subject: [PATCH] ARM: SPEAr600: Add device-tree support to SPEAr600 boards
In-Reply-To: <201203211404.35847.arnd@arndb.de>
References: <1331650032-15274-1-git-send-email-sr@denx.de>
 <201203211236.37891.arnd@arndb.de>
 <CAOh2x==J4qkp29w+v=GWORBua-DE3yb0MRGOtBLyELxbGZwcuA@mail.gmail.com>
 <201203211404.35847.arnd@arndb.de>
Message-ID: <CAOh2x=mtjvitkhz=BXOZPAaKZ2i3QQuKrYA3HcHNERHhF5xFoA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Mar 21, 2012 at 7:34 PM, Arnd Bergmann <arnd@arndb.de> wrote:
> On Wednesday 21 March 2012, viresh kumar wrote:
>> - Pinmux: I would remove our padmux and use pinmux, but what about its
>> DT support.
>> ? I know stephen had few patches for it, but don't know there
>> progress. I don't want to
>> ? do stuff twice. First add support for it in board and the *.dts files.
>
> AFAICT, the pinmux DT binding should be ready for v3.5, I don't think it
> made it into v3.4.

So, i can add stuff in board file for pinmux for now?

> I've looked at this earlier today out of curiosity and found:
>
> clock.c: almost identical, can be easily merged, or both copies
> ? ? ? ? kept around during transition.

Would make it very confusing if we merge these two. Some clock
structures are same, but others are not. Mostly differences are in the
macros (or bit positions in registers), rather than hierarchy. So, i would
like to keep them separate. But still have a look again to see if they can
really be merged.

> misc_regs.h: can be merged into clock.c

it has more than clock stuff. it is used in pinmux and some other places too,
that may not be in mainline for now.

> Once you have taken care of these, files, you can enable building 3xx
> and 6xx together, and move the contents of mach-spear3xx, mach-spear6xx
> and plat-spear into one directory.

plat-spear would be required for 13xx too. So, merging 3xx and 6xx only would
be possible.

> Ok, excellent. Note that there is no requirement to do it all in the order
> you line out above. You can always get support for new stuff into the
> existing platform without cleaning up all of it right away, as long as you
> have a good balance between cleanups and new functionality.

Ya. I just wanted to get some hands on experience with this new stuff, before
touching 13xx.

> In particular, you don't have to start using pinctrl and the common clk
> immediately for spear3xx, although you might find that it helps you.

But, can i update padmux and clock framework of SPEAr platform? Because
without the latest code for both padmux and clock, other code for SPEAr
might not be that effective or usable.

> For spear13xx, the platform being completely new, I would however ask
> you to use those from the start.

Sure.

--
viresh
