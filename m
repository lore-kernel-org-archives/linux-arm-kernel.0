From: broonie@opensource.wolfsonmicro.com (Mark Brown)
Date: Thu, 14 Apr 2011 14:56:59 +0100
Subject: [PATCH] ARM: S3C64XX: Initial support for Wolfson/Simtec
	Cragganmore/Banff
In-Reply-To: <20110414101431.GC1611@n2100.arm.linux.org.uk>
References: <1302533295-27917-1-git-send-email-broonie@opensource.wolfsonmicro.com>
	<01bd01cbfa2e$1afae140$50f0a3c0$%kim@samsung.com>
	<20110414012406.GA3789@opensource.wolfsonmicro.com>
	<20110414101431.GC1611@n2100.arm.linux.org.uk>
Message-ID: <20110414135659.GB7890@opensource.wolfsonmicro.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Apr 14, 2011 at 11:14:31AM +0100, Russell King - ARM Linux wrote:

> People (eg, Ingo) have been saying that the core ARM code is in good
> shape and is not a problem.

I know, I read and participated in the thread.

> If you look at what Linus complained about, it was the platform stuff.
> It's the platform stuff which has got out of control, and we have common
> themes duplicated under different SoC classes.

This is very true.

> It's not the core ARM code which needs consolidating.  It is the platform
> stuff which needs attention.

Indeed; however, that's the tree you manage so it seemed natural that
this was the tree you were applying the rule to and you have already
refused to take some core ARM code enhancements as a result of this
policy and obviously there was the thread today with the clk API.

> What scares me at the moment is that looking at the diffstat in linux-next,
> it looks to me like its business as usual for arch/arm, and we're heading
> again for another 60k line insertions for the next merge window.

Hrm, looking at the stats currently I'm seeing only 5000 net insertions
currently.  But still, code size increases.

> additions to arch/arm.  There is no way that I can sort this out on my
> own - the problem is _far_ too big for any one individual to attack
> unless we permantly freeze arch/arm for the next few years against
> new additions.

> At the moment, the only outcome I can see is that Linus is going to have
> another rant at the next merge window, and that will be game over for ARM
> in mainline.

You're only seeing two extremes here, and I don't see that Linus having
another rant is going to immediately result in ARM being thrown out of
mainline.  Reading the thread there seemed to be a general understanding
that addressing this is a big project and we're not going to resolve
anything immediately.

I think we can work on improving the situation in mainline without
completely stalling new development, and I think that will help get
manpower to work on the refactoring and consolidation that we need.
If we can point at work that's progressing in the right direction that
should be OK - there will probably be grumbling still, but there's
engagement.

For example, if we identify specific areas for focus, especially those
where we have realistic consolodations either in place or easy to
implement (like the GPIOs with the memory mapped GPIOs, or the clock API
if we get the common clock code merged), and push back hard on new code
in those areas I think we've got a good chance of getting progress where
we're focusing.  A clear "you need to do this thing instead" has (in my
exeperience) a reasonable shot at getting people to do whatever the
other thing is, and even a "this needs to be done in a better way but
I'm not sure what" can work.  This sort of approach to gradual
improvement in the framework and consolodation of common code has been
working fairly well for us in the audio drivers.

A total refusal to accept any new code until there have been some
non-specific general improvements in the architecture doesn't drive
contributions in that way - it's just a flat no, it doesn't give people
a route they can follow to make it possible to get whatever it is
they're trying to do done in mainline.  If there's no possibility of
getting the end result included the motivation to work on mainline
infrastructure (be that intrinsic motivation or making a case to
managers that some time needs to be allocated) is damaged.

> We need more people taking Linus' concern seriously.

I think we need to offer people constructive routes to doing so.  We
need to set the bar on mainline contributions higher, but we also need
to avoid setting the bar so high that we drive people away from mainline
entirely.

I'm very concerned that if we stop accepting any new code at all for ARM
into mainline then I think we're likely to cause serious damage to ARM
support in mainline anyway - it'll drive the development effort for new
silicon and boards out of mainline and back into vendor trees, right at
a time when we're making headway in getting people working in mainline.
