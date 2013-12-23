From: taras.kondratiuk@linaro.org (Taras Kondratiuk)
Date: Mon, 23 Dec 2013 18:19:34 +0200
Subject: [PATCH 0/5] ARM: kprobes: big endian support
Message-ID: <1387815579-15677-1-git-send-email-taras.kondratiuk@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Reworked initial Ben's series for big endian support [1].
Dropped patches that are not directly related to kprobes.
Current set of patches is enough to have functional BE kprobes.
All kprobes-tests pass in any LE/BE and ARM/Thumb combination.

Based on v3.13-rc5.

[1] http://www.spinics.net/lists/arm-kernel/msg285210.html

Ben Dooks (4):
  ARM: kprobes: fix instruction fetch order with <asm/opcodes.h>
  ARM: kprobes-test: use <asm/opcodes.h> for instruction accesses
  ARM: kprobes-test: use <asm/opcodes.h> for ARM instruction building
  ARM: kprobes-test: use <asm/opcodes.h> for Thumb instruction building

Taras Kondratiuk (1):
  ARM: kprobes-test: Workaround GAS .align bug

 arch/arm/kernel/kprobes-common.c     |   19 +-
 arch/arm/kernel/kprobes-test-arm.c   |  595 +++++++++++++++++-----------------
 arch/arm/kernel/kprobes-test-thumb.c |  447 ++++++++++++-------------
 arch/arm/kernel/kprobes-test.c       |   14 +-
 arch/arm/kernel/kprobes-test.h       |    2 +-
 arch/arm/kernel/kprobes-thumb.c      |   20 +-
 arch/arm/kernel/kprobes.c            |    9 +-
 7 files changed, 558 insertions(+), 548 deletions(-)

-- 
1.7.9.5
