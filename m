From: alexandre.belloni@free-electrons.com (Alexandre Belloni)
Date: Mon, 24 Mar 2014 22:30:46 +0100
Subject: [ARM ATTEND] Following discussions
In-Reply-To: <CAL_Jsq+EiRhEaq3wDSjB-zCUsYD1oEi4iCFehUpyMT6YKk8TNQ@mail.gmail.com>
References: <20140324160615.GC3351@piout.net>
 <CAL_Jsq+EiRhEaq3wDSjB-zCUsYD1oEi4iCFehUpyMT6YKk8TNQ@mail.gmail.com>
Message-ID: <20140324213045.GD3351@piout.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 24/03/2014 at 13:03:18 -0500, Rob Herring wrote :
> On Mon, Mar 24, 2014 at 11:06 AM, Alexandre Belloni
> <alexandre.belloni@free-electrons.com> wrote:
> > Hi,
> >
> > As I have been working on the i.mx28, Marvell Berlin and AT91 linux
> > support, I'm interested in attending the ARM summit to follow the
> > current status and learn about the current best practices.
> >
> > I've also been doing a lot of cleanup and I would like to discuss how to
> > go about cleaning the style issues in the Device Trees like lists
> > without elements bracketed individually, magic values used instead of
> > macros and the likes.
> 
> The first step would be getting agreement that either of those are
> really considered style issues. IMO, use of defines is purely
> optional. For DT's that are pretty much static, there is little point
> in going back and changing them now. Changing ALL numbers in dts files
> to defines is not the direction either. Generally, numbers that come
> from the h/w (addresses, irq numbers, etc.) should not be defines.
> Things which are more just DT convention like irq trigger values or
> clock numbers can be defines. The question to ask is does it improve
> readability or just add another level of lookup when you need to know
> the actual value.
> 

That's exactly the point of my question. Mark Rutland recently made
comment on some newly submitted device trees that were basically
structured like previous device trees. A lot of copy pasting is involved
when writing those. Another example would be how many device tree have a
"clocks" container node encompassing the clock subnodes that is useless,
non-standard and not guaranteed to probe ?
How many nodes have an unit-address without a reg ? Worse, without a
parent with #address-cells and #size-cells ?

My guess is that if you want people to stop spreading that kind of
issues, at some point in time it will be necessary to remove those from
the current DTs, unless we get that promised DT validator.

Until then, you can't expect people to read and understand the ePAPR
instead of simply reading/copying existing DTs. The code is still the
documentation in the kernel.

I truly believe that your time is valuable and has to be spent reviewing
new bindings instead of repeating over and over again the same do's and
don't.

-- 
Alexandre Belloni, Free Electrons
Embedded Linux, Kernel and Android engineering
http://free-electrons.com
