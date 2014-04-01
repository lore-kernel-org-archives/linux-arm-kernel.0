From: taras.kondratiuk@linaro.org (Taras Kondratiuk)
Date: Tue, 01 Apr 2014 17:13:21 +0300
Subject: [GIT PULL v2] ARM: probes: big-endian support
Message-ID: <533AC981.6070101@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Russell,

Please pull fixes for ARM kprobes/uprobes big-endian support.

It is reworked initial Ben's series for big endian support [1].
Dropped patches that are not directly related to probes and rebased
series on top of Dave Long's ARM uprobes series. Current set of
patches is enough to have functional BE kprobes and uprobes.

One ARM kprobe test fails on Cortex-A15 boards (TC2 and Keystone2 EVM),
while it passes on Pandaboard. The issue is not related to this series
and already present since v3.13-rc7.

v1..v2: Rebased series on top of Dave Long's ARM uprobes series.
        Now this series fixes both BE kprobes and BE uprobes.

Tested on Pandaboard ES and TI Keystone2 EVM.

pull req v1: http://www.spinics.net/lists/arm-kernel/msg300227.html
[1] http://www.spinics.net/lists/arm-kernel/msg285210.html

--->8

The following changes since commit c7edc9e326d53ca5ef9bed82de0740c6b107d55b:

  ARM: add uprobes support (2014-03-18 16:39:40 -0400)

are available in the git repository at:

  git://git.linaro.org/people/taras.kondratiuk/linux.git tags/for_russell/arm-be-probes

for you to fetch changes up to 41b5368f31f86a1c2be2bb16a1cf18d23f1223d4:

  ARM: kprobes-test: Workaround GAS .align bug (2014-04-01 16:48:27 +0300)

----------------------------------------------------------------
Ben Dooks (4):
      ARM: probes: fix instruction fetch order with <asm/opcodes.h>
      ARM: kprobes-test: use <asm/opcodes.h> for instruction accesses
      ARM: kprobes-test: use <asm/opcodes.h> for ARM instruction building
      ARM: kprobes-test: use <asm/opcodes.h> for Thumb instruction building

Taras Kondratiuk (1):
      ARM: kprobes-test: Workaround GAS .align bug

 arch/arm/kernel/kprobes-common.c     |    4 +-
 arch/arm/kernel/kprobes-test-arm.c   |  603 +++++++++++++++++-----------------
 arch/arm/kernel/kprobes-test-thumb.c |  447 ++++++++++++-------------
 arch/arm/kernel/kprobes-test.c       |   13 +-
 arch/arm/kernel/kprobes-test.h       |    2 +-
 arch/arm/kernel/kprobes-thumb.c      |   20 +-
 arch/arm/kernel/kprobes.c            |    9 +-
 arch/arm/kernel/probes.c             |   15 +-
 8 files changed, 562 insertions(+), 551 deletions(-)

-- 
Taras Kondratiuk
