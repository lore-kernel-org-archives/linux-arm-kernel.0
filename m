From: boris.brezillon@free-electrons.com (Boris Brezillon)
Date: Tue, 16 Jun 2015 11:07:08 +0200
Subject: [BUG] usb/at91: usb hub does not work
In-Reply-To: <557FE3AB.2060006@aksignal.cz>
References: <Pine.LNX.4.44L0.1506110952460.1465-100000@iolanthe.rowland.org>
 <557AA6AC.1090308@aksignal.cz> <20150613130956.53316080@bbrezillon>
 <20150613131300.18e6247a@bbrezillon> <557FE3AB.2060006@aksignal.cz>
Message-ID: <20150616110708.7ec35d18@bbrezillon>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Jiri,

On Tue, 16 Jun 2015 10:51:55 +0200
Ji?? Prchal <jiri.prchal@aksignal.cz> wrote:

> 
> 
> On 13.6.2015 13:13, Boris Brezillon wrote:
> > On Sat, 13 Jun 2015 13:09:56 +0200
> > Boris Brezillon <boris.brezillon@free-electrons.com> wrote:
> >
> >> Hi Jiri,
> >>
> >> On Fri, 12 Jun 2015 11:30:20 +0200
> >> Ji?? Prchal <jiri.prchal@aksignal.cz> wrote:
> >>
> >>>
> >>>
> >>> On 11.6.2015 15:53, Alan Stern wrote:
> >>>> On Thu, 11 Jun 2015, Ji?? Prchal wrote:
> >>>>
> >>>>> Hi all,
> >>>>> I discovered some bug when I change kernel from 3.18.13 to 3.18.14. I have board with usb hub CY7C65632 on it.
> >>>>> In .13 it works fine but in .14 it repeats this message:
> >>>>> [   19.170000] usb 2-3: new full-speed USB device number 56 using at91_ohci
> >>>>> and devices connected to usb through hub doesn't appear at all.
> >>>>
> >>>>> Any idea?
> >>>>
> >>>> Try using git bisect to find the commit which caused this problem to
> >>>> start.
> >>>
> >>> This is result:
> >>> Bisecting: 0 revisions left to test after this (roughly 0 steps)
> >>> [ae74ea64ccdb8b99ee2618b58020263d5b1d9b22] clk: at91: usb: propagate rate modification to the parent clk
> >>
> >>
> >> Actually when bisecting you found a bug that has been fixed before
> >> 3.18.14 was released (see this commit [1]).
> >> This being said, the prototype mismatch fix does not seem to fix all
> >> the mismatches (seems the ->determine_rate() has been changed in 3.19
> >> too, and the prototype mismatch patch was a backport of a 3.19 fix).
> >>
> >> Anyway, you'll find below a patch supposed to fix the remaining bug.
> >
> > I forgot to disable the line wrapper in my email client, here is the
> > same patch without the wrapped lines:
> 
> Aplied to 3.18.14 and it helped!


Thanks for testing, I'll send this patch to Sacha and the stable ML.

Best Regards,

Boris

-- 
Boris Brezillon, Free Electrons
Embedded Linux and Kernel engineering
http://free-electrons.com
