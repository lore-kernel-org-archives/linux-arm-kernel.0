From: mark.rutland@arm.com (Mark Rutland)
Date: Tue, 19 Jul 2016 12:22:41 +0100
Subject: Is THREAD_INFO_IN_TASK appropriate for -mm for 4.8?
In-Reply-To: <CALCETrUf_7=Tr4JrDj+3UPT5kUT1MsRtypvfqkOg_MVHAJu=PA@mail.gmail.com>
References: <CALCETrUf_7=Tr4JrDj+3UPT5kUT1MsRtypvfqkOg_MVHAJu=PA@mail.gmail.com>
Message-ID: <20160719112223.GA20476@leverpostej>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Jul 18, 2016 at 04:47:39PM -0700, Andy Lutomirski wrote:
> Hi all-
> 
> There are four core patches needed for the THREAD_INFO_IN_TASK thing,
> and they apply cleanly to -mm now.  The x86 patch to flip the feature
> on does not apply cleanly anywhere because it depends on changes in
> -tip *and* in -mm.  I'd like to get all of this as well as the rest of
> the vmap-stacks stuff in by 4.9, but I'm wondering if it might make
> sense to get the core THREAD_INFO_IN_TASK stuff into -mm for 4.8
> instead.
> 
> Pros:
>  - It reduces the amount of core code that -tip will have to carry until 4.9.
>  - It may benefit other architectures.  Christian Borntraeger
> expressed an interest in enabling the feature for s390, but it'll be
> awkward for him until the core bit landed.  Similarly, arm64 seems to
> be interested.

This would probably be useful for arm64.

There's still a reasonable amount to figure out (e.g. [1,2]), so from my
PoV this is a nice-to-have, but there's no pressure.

Thanks,
Mark.

[1] https://lkml.org/lkml/2016/7/11/193
[2] https://lkml.org/lkml/2016/7/11/483
