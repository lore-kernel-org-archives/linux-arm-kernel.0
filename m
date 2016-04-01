From: will.deacon@arm.com (Will Deacon)
Date: Fri, 1 Apr 2016 16:15:23 +0100
Subject: [GIT PULL] arm64: fixes for -rc2
Message-ID: <20160401151521.GA3991@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Linus,

Here are three arm64 patches for -rc2. One of them fixes a nasty code
patching problem for big-endian systems, whilst the other two address
some issues remaining after the merge window. Specifically, cleaning up
after the KVM PMU work and sweeping up some defconfig updates that were
missed, which includes squashing a Kconfig warning from duplicate
definitions of MMC_BLOCK_MINORS.

We're debugging a couple of other issues at the moment, but the wheels
don't appear to have fallen off yet.

Please pull.

Will

--->8

The following changes since commit f55532a0c0b8bb6148f4e07853b876ef73bc69ca:

  Linux 4.6-rc1 (2016-03-26 16:03:24 -0700)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/arm64/linux.git tags/arm64-fixes

for you to fetch changes up to 431597bb95560c975221c0394c442723d7a21f2d:

  arm64: defconfig: updates for 4.6 (2016-03-29 16:56:00 +0100)

----------------------------------------------------------------
arm64 fixes:

- Fix oops when patching in alternative sequences on big-endian CPUs
- Reconcile asm/perf_event.h after merge window fallout with KVM ARM
- Defconfig updates

----------------------------------------------------------------
James Morse (1):
      arm64: opcodes.h: Add arm big-endian config options before including arm header

Shannon Zhao (1):
      arm64: perf: Move PMU register related defines to asm/perf_event.h

Will Deacon (1):
      arm64: defconfig: updates for 4.6

 arch/arm64/configs/defconfig            | 28 +++++++++----
 arch/arm64/include/asm/kvm_host.h       |  1 -
 arch/arm64/include/asm/kvm_hyp.h        |  1 -
 arch/arm64/include/asm/kvm_perf_event.h | 68 -------------------------------
 arch/arm64/include/asm/opcodes.h        |  4 ++
 arch/arm64/include/asm/perf_event.h     | 47 +++++++++++++++++++++
 arch/arm64/kernel/perf_event.c          | 72 +++++++++------------------------
 7 files changed, 90 insertions(+), 131 deletions(-)
 delete mode 100644 arch/arm64/include/asm/kvm_perf_event.h
