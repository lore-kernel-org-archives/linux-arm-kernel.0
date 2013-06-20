From: lorenzo.pieralisi@arm.com (Lorenzo Pieralisi)
Date: Thu, 20 Jun 2013 16:37:31 +0100
Subject: [GIT PULL RESEND] ARM: MPIDR linearization
Message-ID: <20130620153731.GB10110@e102568-lin.cambridge.arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Russell,

please pull this patch series that implements MPIDR linearization through a
simple hashing algorithm and updates current cpu_{suspend}/{resume} code to
use the newly created hash structures to retrieve context pointers.
It represents a stepping stone for the implementation of power management code
on forthcoming multi-cluster ARM systems.

It has been tested on TC2 (dual cluster A15xA7 system), iMX6q, OMAP4 and
Tegra, with processors hitting low-power states requiring warm-boot resume
through the cpu_resume code path.

It is rebased against your devel-stable, I fixed conflicts with code already
queued there.

Please let me know if you have any objection.

Thank you very much indeed,
Lorenzo

The following changes since commit fd8957a96d535a992067b2c206672323a885454a:

  Merge branch 'for-rmk/arch-timer-cleanups' of git://linux-arm.org/linux-mr into devel-stable (2013-06-18 20:12:56 +0100)

are available in the git repository at:


  git://linux-arm.org/linux-2.6-lp.git mpidr-updates-for-rmk

for you to fetch changes up to 7604537bbb5720376e8c9e6bc74a8e6305e3094d:

  ARM: kernel: implement stack pointer save array through MPIDR hashing (2013-06-20 11:24:11 +0100)

----------------------------------------------------------------
Lorenzo Pieralisi (2):
      ARM: kernel: build MPIDR hash function data structure
      ARM: kernel: implement stack pointer save array through MPIDR hashing

 arch/arm/include/asm/smp_plat.h | 18 ++++++++
 arch/arm/include/asm/suspend.h  |  5 +++
 arch/arm/kernel/asm-offsets.c   |  6 +++
 arch/arm/kernel/setup.c         | 67 ++++++++++++++++++++++++++++
 arch/arm/kernel/sleep.S         | 97 +++++++++++++++++++++++++++++++++--------
 arch/arm/kernel/suspend.c       | 20 +++++++++
 6 files changed, 195 insertions(+), 18 deletions(-)
