From: will.deacon@arm.com (Will Deacon)
Date: Wed, 2 Oct 2013 19:13:47 +0100
Subject: [PATCH v4 00/17] 64-bit friendly generic sched_clock()
In-Reply-To: <524C5FD2.5050406@linaro.org>
References: <1374189690-10810-1-git-send-email-sboyd@codeaurora.org>
 <51E88170.3080505@linaro.org>
 <20131002174700.GF30298@mudshark.cambridge.arm.com>
 <524C5FD2.5050406@linaro.org>
Message-ID: <20131002181347.GJ30298@mudshark.cambridge.arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Oct 02, 2013 at 07:02:58PM +0100, John Stultz wrote:
> On 10/02/2013 10:47 AM, Will Deacon wrote:
> > On Fri, Jul 19, 2013 at 12:59:44AM +0100, John Stultz wrote:
> >> On 07/18/2013 04:21 PM, Stephen Boyd wrote:
> >>> This patchset adds support for 64 bit counters in the generic
> >>> sched_clock code and converts drivers over to use it. Based
> >>> on v3.11-rc1.
> >>>
> >>> Changes since v3:
> >>>   * Move to use seqcount to fix issues with 64-bit cyc counters
> >>>   * Move to hrtimer to fix underflow/overflow errors in wraparound
> >>>     calculation
> >>>   * Use of 1 hour in clocks_calc_mult_shift
> >>>   * Converted over drivers in drivers/clocksource
> >> I've not been able to take a deep review yet, but this looks pretty much 
> >> like what we discussed last week, so I'm happy with it so far. Has this 
> >> gotten much testing (on both 32 and 64bit systems?)
> >>
> >> One detail: Most of this is likely to go in via tip/timers/core, but the 
> >> 5/17 "arch_timer: Move to generic sched_clock" will need some 
> >> synchronization with Catalin to make sure its ok to go in via tip. Not 
> >> sure what other arm64 changes are pending that would depend or collide 
> >> with that change.
> > I wouldn't expect anything more than a trivial Kconfig clash with the arm64
> > tree, if that.
> 
> So I also have a branch with these changes based on a branch with only
> the prereqs that are already merged, so I can provide a pull request
> that can go in via the aarch64 tree and won't collide with tip. Would
> that be preferrable?

I think it's simpler for us if you just take the lot via your tree, unless
you have any objections.

Cheers,

Will
