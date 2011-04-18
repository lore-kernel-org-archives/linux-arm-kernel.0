From: broonie@opensource.wolfsonmicro.com (Mark Brown)
Date: Tue, 19 Apr 2011 00:55:11 +0100
Subject: Status of arch/arm in linux-next
In-Reply-To: <alpine.LFD.2.00.1104182315180.2744@localhost6.localdomain6>
References: <BANLkTi=3+yQU_URj0Tao_MP7v=O7cO_ftg@mail.gmail.com>
	<20110415155642.GO1611@n2100.arm.linux.org.uk>
	<BANLkTi=iqcwq+kEaDEWGrCAutZUAPPXFyw@mail.gmail.com>
	<20110416082802.GS1611@n2100.arm.linux.org.uk>
	<20110416165725.GA25811@opensource.wolfsonmicro.com>
	<20110418081050.GG12272@atomide.com>
	<20110418135704.GB1765@opensource.wolfsonmicro.com>
	<20110418171857.GC25671@n2100.arm.linux.org.uk>
	<20110418202301.GA13808@opensource.wolfsonmicro.com>
	<alpine.LFD.2.00.1104182315180.2744@localhost6.localdomain6>
Message-ID: <20110418235508.GA15216@opensource.wolfsonmicro.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Apr 18, 2011 at 11:40:15PM +0200, Thomas Gleixner wrote:
> On Mon, 18 Apr 2011, Mark Brown wrote:

> > Yeah, I saw that.  Quite frankly it's astonishing - I must apologise, I
> > had thought you were most likely misinterpreting what he was saying.

> Sigh.

I find it hard to read it as saying anything other than that new code is
unwelcome and any substantial diffstat needs to be negative.  This is
pretty much what Russell has been saying (if a bit less hard line).

> > To make matters worse unless people just give up the longer we keep the
> > tree shut down the larger the merge will be when it does reopen.

> I tend to disagree. It's not rocket science to cleanup stuff just
> along the way. I did the (not yet perfect) conversion of about 20 irq
> chips on saturday just to see how far I get with that abstract
> chip. And it simply got rid of >1200 LOC with some more potential
> reduction already detected.

That's not terribly helpful to people trying to contribute anything
other than refactoring of existing code - the message that's been given
is that anything which adds new support (platforms, machines, whatever)
is not even worth looking at.  For people working on code that's already
in mainline they can refactor and that's fine for them.  If that's not
the case then people are just being told the code is not welcome until
some non-specific amount of cleanup work has been done to existing code.

This is not really constructive from the contributor side as it doesn't
offer any direct or clear route to addressing the problem that's
blocking their code, there's no improvement that can be made to code
that would make it worth considering.  What we're telling people to do
is work on random improvements to more or less tangentially related
code.  This doesn't seem entirely reasonable and is going to be
especially offputting for new contributors (like the people trying to
submit new platforms, many of them will be new to mainline work) as it's
a pretty big jump to start working on less familiar code when you're
still trying to find your feet and worried about stepping on people's
toes or breaking things, not to mention justifying your time to
management.

> So when we come up with such generic abstractions then it's not
> a too big burden for a maintainer to care about his 1 or 2 irq chips
> and some other small cleanups here and there.

Of course, it's obvious that as we add abstractions we'll be able to
make improvements.  Saying to people that they should use existing
abstractions (recently added or otherwise) or even that they should
factor out bits of their code so that others can use them is exactly the
approach I'd hope we'd be taking here.  That would be clear, relevant
review which gives people something direct they can work towards.

> Linus does not expect that ARM code shrinks 80% in the next cycle, but
> he wants to see that people take him seriously and actually cut down
> code in a diffstat visible way.

The issue for me is that we're doing that not by raising the bar on new
contributions and demonstrating that there's work going into factoring
stuff out but rather by shutting down entirely to pretty much anything
other than refactoring so that we force a negative diffstat.

It'd be much better if we could do something like what Grant suggested
earlier in the thread, splitting out the refactoring work (which you'd
hope will have a nice looking diffstat) from the run of the mill stuff
so that the cleanup is highlighted, especially when we combine this
approach with the more stringent review that pretty much everyone is
bought in to.  That seems more sustainable for the long term, and much
more helpful for ongoing development.
