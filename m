From: taras.kondratiuk@linaro.org (Taras Kondratiuk)
Date: Fri, 10 Jan 2014 19:58:21 +0200
Subject: [PATCH v2 0/5] ARM: kprobes: big endian support
Message-ID: <1389376706-30051-1-git-send-email-taras.kondratiuk@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Reworked initial Ben's series for big endian support [1].
Dropped patches that are not directly related to kprobes.
Current set of patches is enough to have functional BE kprobes.

One ARM kprobe test fails on Cortex-A15 boards (TC2 and Keystone2 EVM),
while it passes on Pandaboard. The issue is not related to this series
and already present in v3.13-rc7. I'll try to look into it later.

v1..v2: Fixed coprocessor instruction building for ARM tests in the patch 
        "ARM: kprobes-test: use <asm/opcodes.h> for ARM instruction building"

Based on v3.13-rc7.

[1] http://www.spinics.net/lists/arm-kernel/msg285210.html

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

-- 
1.7.9.5
