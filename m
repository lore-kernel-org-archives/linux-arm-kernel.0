From: taras.kondratiuk@linaro.org (Taras Kondratiuk)
Date: Mon, 13 Jan 2014 14:09:40 +0200
Subject: [GIT PULL] ARM: kprobes: big-endian support
Message-ID: <52D3D784.2000600@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Russell,

Please pull fixes for ARM Kprobes big-endian support.

It is reworked initial Ben's series for big endian support [1].
Dropped patches that are not directly related to kprobes.
Current set of patches is enough to have functional BE kprobes.

One ARM kprobe test fails on Cortex-A15 boards (TC2 and Keystone2 EVM),
while it passes on Pandaboard. The issue is not related to this series
and already present in v3.13-rc7.

[1] http://www.spinics.net/lists/arm-kernel/msg285210.html

-- 
Taras Kondratiuk

--->8

The following changes since commit 7e22e91102c6b9df7c4ae2168910e19d2bb14cd6:

  Linux 3.13-rc8 (2014-01-12 17:04:18 +0700)

are available in the git repository at:

  git://git.linaro.org/people/taras.kondratiuk/linux.git tags/for_russell/arm-be-kprobes

for you to fetch changes up to 1c2d814c019b63bf0778fc2d2fd54c6e44f1ab5d:

  ARM: kprobes-test: Workaround GAS .align bug (2014-01-13 13:58:52 +0200)

----------------------------------------------------------------
Ben Dooks (4):
      ARM: kprobes: fix instruction fetch order with <asm/opcodes.h>
      ARM: kprobes-test: use <asm/opcodes.h> for instruction accesses
      ARM: kprobes-test: use <asm/opcodes.h> for ARM instruction building
      ARM: kprobes-test: use <asm/opcodes.h> for Thumb instruction building

Taras Kondratiuk (1):
      ARM: kprobes-test: Workaround GAS .align bug

 arch/arm/kernel/kprobes-common.c     |   19 +-
 arch/arm/kernel/kprobes-test-arm.c   |  603 +++++++++++++++++-----------------
 arch/arm/kernel/kprobes-test-thumb.c |  447 ++++++++++++-------------
 arch/arm/kernel/kprobes-test.c       |   13 +-
 arch/arm/kernel/kprobes-test.h       |    2 +-
 arch/arm/kernel/kprobes-thumb.c      |   20 +-
 arch/arm/kernel/kprobes.c            |    9 +-
 7 files changed, 562 insertions(+), 551 deletions(-)
