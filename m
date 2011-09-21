From: tixy@yxit.co.uk (Tixy)
Date: Wed, 21 Sep 2011 08:32:38 +0100
Subject: [GIT PULL] ARM: kprobes: Add test code to kernel tree
Message-ID: <1316590358.2682.7.camel@computer2>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Russell

Would you please pull these patches for the next merge window? They are
pretty much an essential tool for anyone debugging or extending the
kprobes instruction simulation code and are a good regression test for
kprobes on ARM.

Thanks

-- 
Jon Medhurst (usually know as Tixy)


The following changes since commit b6fd41e29dea9c6753b1843a77e50433e6123bcb:

  Linux 3.1-rc6 (2011-09-12 14:02:02 -0700)

are available in the git repository at:
  git://git.yxit.co.uk/linux kprobes-test

Jon Medhurst (10):
      ARM: kprobes: Add config option for selecting the ARM kprobes tests
      ARM: kprobes: Add basic API tests
      ARM: kprobes: Framework for instruction set test cases
      ARM: kprobes: Add Thumb instruction simulation test cases
      ARM: kprobes: Add ARM instruction simulation test cases
      ARM: kprobes: Add exports for test code
      ARM: kprobes: Add decoding table self-consistency tests
      ARM: kprobes: Add decoding table test coverage analysis
      ARM: kprobes: Add some benchmarking to test module
      ARM: kprobes: Add introductory comment to test code

 arch/arm/Kconfig.debug               |    6 +
 arch/arm/kernel/Makefile             |    7 +
 arch/arm/kernel/kprobes-arm.c        |    4 +
 arch/arm/kernel/kprobes-test-arm.c   | 1323 +++++++++++++++++++++++++
 arch/arm/kernel/kprobes-test-thumb.c | 1187 +++++++++++++++++++++++
 arch/arm/kernel/kprobes-test.c       | 1748 ++++++++++++++++++++++++++++++++++
 arch/arm/kernel/kprobes-test.h       |  392 ++++++++
 arch/arm/kernel/kprobes-thumb.c      |    7 +
 arch/arm/kernel/kprobes.h            |    8 +
 9 files changed, 4682 insertions(+), 0 deletions(-)
 create mode 100644 arch/arm/kernel/kprobes-test-arm.c
 create mode 100644 arch/arm/kernel/kprobes-test-thumb.c
 create mode 100644 arch/arm/kernel/kprobes-test.c
 create mode 100644 arch/arm/kernel/kprobes-test.h
