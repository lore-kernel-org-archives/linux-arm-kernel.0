From: haojian.zhuang@gmail.com (Haojian Zhuang)
Date: Mon, 27 Feb 2012 11:18:28 +0800
Subject: [GIT PULL] [for 3.4] git pull request for arch-pxa
Message-ID: <CAN1soZzkih_N9eB6+9F3j0QDbbhQ0wLMP2TkVoqMQ7UijEYCew@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Arnd,

Please help to pull these patches for v3.4.

The following changes since commit c38e23456278e967f094b08247ffc3711b1029b2:

  i387: fix sense of sanity check (2012-02-15 08:05:18 -0800)

are available in the git repository at:
  git://github.com/hzhuang1/linux.git for-next

Haojian Zhuang (7):
      rtc: sa1100: remove periodic code
      rtc: sa1100: remove verification code of alarm
      rtc: sa1100: declare irq in resource
      ARM: pxa: add rtc dummy clock
      rtc: sa1100: enable clk support
      ARM: mmp: enable rtc in pxa910
      ARM: mmp: append irq name of gpio device

Jett.Zhou (1):
      ARM: sa1100: clean up clock support

Paul Parsons (4):
      pxa/hx4700: Correct StrataFlash block size discovery
      pxa/hx4700: Add ASIC3 LED support
      pxa/hx4700: Fix PXA_GPIO_IRQ_BASE/IRQ_NUM values
      pxa/hx4700: Fix basic suspend/resume

 arch/arm/Kconfig                           |    3 +-
 arch/arm/mach-mmp/include/mach/pxa910.h    |    1 +
 arch/arm/mach-mmp/include/mach/regs-apbc.h |    1 +
 arch/arm/mach-mmp/include/mach/regs-rtc.h  |   23 ++++
 arch/arm/mach-mmp/mmp2.c                   |    1 +
 arch/arm/mach-mmp/pxa168.c                 |    1 +
 arch/arm/mach-mmp/pxa910.c                 |   28 ++++
 arch/arm/mach-mmp/ttc_dkb.c                |    1 +
 arch/arm/mach-pxa/devices.c                |   28 ++++-
 arch/arm/mach-pxa/hx4700.c                 |   40 +++++-
 arch/arm/mach-pxa/pxa25x.c                 |    1 +
 arch/arm/mach-pxa/pxa27x.c                 |    1 +
 arch/arm/mach-pxa/pxa3xx.c                 |    1 +
 arch/arm/mach-pxa/pxa95x.c                 |    1 +
 arch/arm/mach-sa1100/clock.c               |   82 +++++++-----
 arch/arm/mach-sa1100/generic.c             |    8 +
 drivers/rtc/Kconfig                        |    4 +-
 drivers/rtc/rtc-sa1100.c                   |  198 ++++++++++++++--------------
 18 files changed, 271 insertions(+), 152 deletions(-)
 create mode 100644 arch/arm/mach-mmp/include/mach/regs-rtc.h
