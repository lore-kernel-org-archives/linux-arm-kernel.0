From: will.deacon@arm.com (Will Deacon)
Date: Tue, 22 Nov 2011 18:16:39 +0000
Subject: [GIT PULL] ARM perf fixes for 3.2
In-Reply-To: <20111121174500.GJ20611@mudshark.cambridge.arm.com>
References: <20111121174500.GJ20611@mudshark.cambridge.arm.com>
Message-ID: <20111122181638.GA15377@mudshark.cambridge.arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Russell,

On Mon, Nov 21, 2011 at 05:45:00PM +0000, Will Deacon wrote:
> Please pull these perf fixes for 3.2. Without them, modules trying to use
> the PMU will not compile (I accidently dropped an EXPORT_SYMBOL) and, more
> seriously, perf can be made to dereference NULL if the user tries to
> schedule an event group.
> 
> Thanks to Tixy and Pawel for reporting the issues.
> 
> Cheers,
> 
> Will

I've added an additional fix to this branch that was reported through
Linaro. If you've already pulled, I can pop it in the patch system. If not,
then here's the updated pull request:


The following changes since commit cfcfc9eca2bcbd26a8e206baeb005b055dbf8e37:

  Linux 3.2-rc2 (2011-11-15 15:02:59 -0200)

are available in the git repository at:
  git://git.kernel.org/pub/scm/linux/kernel/git/will/linux.git for-rmk

Will Deacon (4):
      ARM: PMU: re-export release_pmu symbol to modules
      ARM: PMU: remove pmu_init declaration
      ARM: perf: initialise used_mask for fake PMU during validation
      ARM: perf: check that we have a platform device when reserving PMU

 arch/arm/include/asm/pmu.h   |   10 ----------
 arch/arm/kernel/perf_event.c |   11 ++++++++++-
 arch/arm/kernel/pmu.c        |    1 +
 3 files changed, 11 insertions(+), 11 deletions(-)


Thanks,

Will
