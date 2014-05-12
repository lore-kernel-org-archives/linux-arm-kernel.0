From: 21cnbao@gmail.com (Barry Song)
Date: Mon, 12 May 2014 21:59:20 +0800
Subject: [GIT PULL]]ARM: sirf: machine update for 3.16
Message-ID: <CAGsJ_4yqTkKu+93Fo_D6NaZMyz4T6_EmKz4gZfyeQCi_uF-3dg@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Arnd, Olof, Kevin,

The following changes since commit d1db0eea852497762cab43b905b879dfcd3b8987:

  Linux 3.15-rc3 (2014-04-27 19:29:27 -0700)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/baohua/linux.git
tags/sirf-soc-for-3.16

for you to fetch changes up to 23d7c66a8b096362d38418521f20af76443696b9:

  clocksource: marco: fix the affinity set for local timer of CPU1
(2014-05-12 21:43:49 +0800)

----------------------------------------------------------------
ARM: sirf: machine update for 3.16

most of them fix some minor checkpatch issues according to key customers'
requirement.
and this patchset also cleanups the clk of clocksource: move to get clk
by dts properity and move to irq_force_affinity for the irq affinity set
of CPU1 local timer.

----------------------------------------------------------------
Bin Shi (2):
      clocksource: prima2: fix some minor checkpatch issues
      irqchip: sirf: fix one minor checkpatch issue

Xianglong Du (1):
      ARM: prima2: rstc: fix some minor checkpatch issues

Zhiwu Song (2):
      clocksource:sirf: remove the hardcode for the clk of timers
      clocksource: marco: fix the affinity set for local timer of CPU1

 arch/arm/boot/dts/atlas6.dtsi      |    1 +
 arch/arm/boot/dts/prima2.dtsi      |    1 +
 arch/arm/mach-prima2/rstc.c        |   34 +++++++++++++++-----------
 drivers/clocksource/timer-marco.c  |   10 +++-----
 drivers/clocksource/timer-prima2.c |   47 ++++++++++++++++++++++--------------
 drivers/irqchip/irq-sirfsoc.c      |    3 ++-
 6 files changed, 57 insertions(+), 39 deletions(-)


-barry
