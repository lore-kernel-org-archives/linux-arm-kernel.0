From: will.deacon@arm.com (Will Deacon)
Date: Thu, 20 Nov 2014 10:56:14 +0000
Subject: [GIT PULL] ARM: perf: updates for 3.19
In-Reply-To: <20141114191637.GA9291@arm.com>
References: <20141114191637.GA9291@arm.com>
Message-ID: <20141120105614.GD19126@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Nov 14, 2014 at 07:16:37PM +0000, Will Deacon wrote:
> Hi Arnd, Olof, Russell,
> 
> Please can you pull the following ARM perf updates into arm-soc?
> 
> I usually send these via rmk's tree, but there's a bunch of CCI PMU
> rework in here which is then relied upon by other patches in the series,
> so it would be easiest to keep it all together.
> 
> These have been in -next for a few weeks, so please let me know when
> you've pulled and I'll drop my branch from there.

Ping? Anything else you need from me to get this into arm-soc?

Will

> --->8
> 
> The following changes since commit cac7f2429872d3733dc3f9915857b1691da2eb2f:
> 
>   Linux 3.18-rc2 (2014-10-26 16:48:41 -0700)
> 
> are available in the git repository at:
> 
>   git://git.kernel.org/pub/scm/linux/kernel/git/will/linux.git tags/arm-perf-3.19
> 
> for you to fetch changes up to af66abfe2ec8bd82211e9e4f036a64c902ff4cdb:
> 
>   arm: perf: fold hotplug notifier into arm_pmu (2014-10-30 12:17:01 +0000)
> 
> ----------------------------------------------------------------
> This patch series takes us slightly further on the road to big.LITTLE
> support in perf. The main change enabling this is moving the CCI PMU
> driver away from the arm-pmu abstraction, allowing the arch code to
> focus specifically on support for CPU PMUs.
> 
> ----------------------------------------------------------------
> Mark Rutland (10):
>       bus: cci: move away from arm_pmu framework
>       arm: perf: factor out callchain code
>       arm: perf: add missing pr_info newlines
>       arm: perf: make PMU probing data-driven
>       arm: perf: use IDR types for CPU PMUs
>       arm: perf: limit size of accounting data
>       arm: perf: kill get_hw_events()
>       arm: perf: fold percpu_pmu into pmu_hw_events
>       arm: perf: dynamically allocate cpu hardware data
>       arm: perf: fold hotplug notifier into arm_pmu
> 
> Will Deacon (1):
>       ARM: perf: use pr_* instead of printk
> 
> chai wen (1):
>       ARM: perf: remove useless return and check of idx in counter handling
> 
>  arch/arm/include/asm/perf_event.h   |   2 +-
>  arch/arm/include/asm/pmu.h          |  36 ++-
>  arch/arm/kernel/Makefile            |   2 +-
>  arch/arm/kernel/perf_callchain.c    | 136 +++++++++
>  arch/arm/kernel/perf_event.c        | 162 ++---------
>  arch/arm/kernel/perf_event_cpu.c    | 181 ++++++------
>  arch/arm/kernel/perf_event_v6.c     |  12 +-
>  arch/arm/kernel/perf_event_v7.c     |  72 +++--
>  arch/arm/kernel/perf_event_xscale.c |  20 +-
>  drivers/bus/arm-cci.c               | 552 +++++++++++++++++++++++++++++-------
>  10 files changed, 772 insertions(+), 403 deletions(-)
>  create mode 100644 arch/arm/kernel/perf_callchain.c
