From: mark.rutland@arm.com (Mark Rutland)
Date: Fri, 7 Jun 2013 18:39:02 +0100
Subject: [GIT PULL] arm: arch_timer cleanups and niceties for 3.11
Message-ID: <20130607173902.GJ23311@e106331-lin.cambridge.arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Russell,

Please pull these arch_timer cleanups I've been holding onto for a while.
They're the same as my last posting [1], but have been rebased to v3.10-rc3.

Thanks,
Mark.

[1] http://lists.infradead.org/pipermail/linux-arm-kernel/2013-May/170602.html

---->8----

The following changes since commit e4aa937ec75df0eea0bee03bffa3303ad36c986b:

  Linux 3.10-rc3 (2013-05-26 16:00:47 -0700)

are available in the git repository at:

  git://linux-arm.org/linux-mr.git for-rmk/arch-timer-cleanups

for you to fetch changes up to 3f71be237ce37e0131973ebfa33b326bc51d743e:

  ARM: arch_timer: stop virtual timer when booted in HYP mode (2013-06-07 10:20:29 +0100)

----------------------------------------------------------------
Marc Zyngier (2):
      ARM: hyp: initialize CNTVOFF to zero
      ARM: arch_timer: stop virtual timer when booted in HYP mode

Mark Rutland (3):
      ARM: KVM: arch_timers: zero CNTVOFF upon return to host
      clocksource: arch_timer: use virtual counters
      arm: fix up ARM_ARCH_TIMER selects

 arch/arm/include/asm/arch_timer.h    |  9 ---------
 arch/arm/kernel/hyp-stub.S           |  7 +++++++
 arch/arm/kvm/interrupts_head.S       |  4 ++++
 arch/arm/mach-exynos/Kconfig         |  2 +-
 arch/arm/mach-shmobile/Kconfig       |  4 ++--
 arch/arm/mach-tegra/Kconfig          |  2 +-
 arch/arm/mach-virt/Kconfig           |  2 +-
 arch/arm64/include/asm/arch_timer.h  | 10 ----------
 drivers/clocksource/arm_arch_timer.c | 23 +++++------------------
 include/clocksource/arm_arch_timer.h |  2 +-
 10 files changed, 22 insertions(+), 43 deletions(-)
