From: will.deacon@arm.com (Will Deacon)
Date: Fri, 26 Feb 2016 16:48:52 +0000
Subject: [PATCH 00/13] arm-cci: PMU driver updates for 4.6
In-Reply-To: <CAOesGMhYP8tQXVYX70_U2EYnvOdTtE2xgDi77dKRkJsyjypgDw@mail.gmail.com>
References: <1456224595-3282-1-git-send-email-suzuki.poulose@arm.com>
 <20160223114003.GF3966@arm.com> <56CC64E7.3040407@arm.com>
 <20160224165814.GA10126@localhost> <20160224171218.GC12471@arm.com>
 <CAOesGMhYP8tQXVYX70_U2EYnvOdTtE2xgDi77dKRkJsyjypgDw@mail.gmail.com>
Message-ID: <20160226164851.GI29125@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Feb 24, 2016 at 10:46:09AM -0800, Olof Johansson wrote:
> On Wed, Feb 24, 2016 at 9:12 AM, Will Deacon <will.deacon@arm.com> wrote:
> > On Wed, Feb 24, 2016 at 08:58:14AM -0800, Olof Johansson wrote:
> >> On Tue, Feb 23, 2016 at 01:55:51PM +0000, Suzuki K. Poulose wrote:
> >> > On 23/02/16 11:40, Will Deacon wrote:
> >> > >On Tue, Feb 23, 2016 at 10:49:42AM +0000, Suzuki K Poulose wrote:
> >> > >>Here are some fixes and updates for arm-cci pmu driver targeting v4.6,
> >> > >>applies on top of v4.5-rc5.
> >> > >>
> >> > >>Highlights include :
> >> > >>  - Support for CoreLink CCI-550 PMU
> >> > >>  - Reliable writes to PMU Counter registers for CCI-500/550.
> >> > >>
> >> > >>All the patches have been Acked. Please let me know how this
> >> > >>can be merged.
> >> >
> >> > >>
> >> > >>  Documentation/devicetree/bindings/arm/cci.txt |    2 +
> >> > >>  drivers/bus/Kconfig                           |   10 +-
> >> > >>  drivers/bus/arm-cci.c                         |  612 +++++++++++++++++--------
> >> > >>  3 files changed, 427 insertions(+), 197 deletions(-)
> >> > >
> >> > >How do you plan to merge this? I can take it all onto a branch for
> >> > >arm-soc, or I can include it on my perf/updates branch, or ...?
> >> >
> >> > Arnd, Olof,
> >> >
> >> > What do you think would be the best route ?
> >>
> >> Traditionally we've been picking these up in arm-soc in our drivers branch.
> >>
> >> Will, unless you want them in your tree for some reason that's what I'll do
> >> here as well.
> >
> > Just that I already have some CPU PMU patches that I planned to send, so
> > I could bundle these in with those if necessary. I have no preference
> > either way though, as long as they get queued someplace.
> 
> Ok, I'm alright with you queueing these if that makes it easier. Feel
> free to add:
> 
> Acked-by: Olof Johansson <olof@lixom.net>

Thanks, Olof. I'll queue them shortly.

> Only concern is if we cause confusion on where people should send
> these patches down the road, but there aren't that many authors of
> them so it's not a huge problem.

Yup. It's pretty much a handful of @arm.com people.

> > At some point, those drivers should be largely moved from drivers/bus/
> > to drivers/perf/, but that's a separate issue.
> 
> And with a maintainer on that, that'd resolve the "where do I send
> this" issue. The maintainer, of course, needs to know where to feed
> things next, but that's easier to solve.

I'm down for the arm-pmu.c, so I'm happy to own the interconnect PMUs
too, but I'll need to sit down and extract the drivers first.

Will
