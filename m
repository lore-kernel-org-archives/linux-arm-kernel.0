From: will.deacon@arm.com (Will Deacon)
Date: Thu, 24 Apr 2014 11:18:20 +0100
Subject: [PATCH v6 2/6] ARM: allow user access to arch timer virtual
 counter
In-Reply-To: <5357FB2F.8060002@mentor.com>
References: <cover.1398213562.git.nathan_lynch@mentor.com>
 <10ed3f4cfce13a80a9a3070934fc0e31619a1242.1398213562.git.nathan_lynch@mentor.com>
 <20140423173244.GL5649@arm.com> <5357FB2F.8060002@mentor.com>
Message-ID: <20140424101820.GB19564@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Apr 23, 2014 at 06:41:03PM +0100, Nathan Lynch wrote:
> On 04/23/2014 12:32 PM, Will Deacon wrote:
> > On Wed, Apr 23, 2014 at 01:48:53AM +0100, Nathan Lynch wrote:
> >> As ARM64 does.  This is a necessary prerequisite for implementing
> >> gettimeofday and clock_gettime in a vdso.
> > 
> > Doesn't this change make arch_counter_set_user_access identical for arm and
> > arm64? In which case, we could move it into the driver itself.
> 
> True; I had considered this but wasn't sure how it could be staged.
> 
> Would a single patch updating arch/arm64, arch/arm, and
> drivers/clocksource/arm_arch_timer.c be okay?

I'd probably modify arm_arch_timer.c to have it's own implementation, then
have follow-up patches removing the arch-private definitions. You could
probably deal with arch_timer_evtstrm_enable at the same time.

Will
