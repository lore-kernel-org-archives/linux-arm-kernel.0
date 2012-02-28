From: haojian.zhuang@gmail.com (Haojian Zhuang)
Date: Tue, 28 Feb 2012 12:15:19 +0800
Subject: [GIT PULL][v3.4] pull request of rtc-sa1100 branch in pxa git tree
Message-ID: <CAN1soZyJGbFVVaXEbsXk=kansWsXjnFZ9m=_yWoNFLWiZwMjXw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Arnd,

Please help to pull rtc-sa1100 changes.

The following changes since commit 6b21d18ed50c7d145220b0724ea7f2613abf0f95:

  Linux 3.3-rc5 (2012-02-25 12:18:16 -0800)

are available in the git repository at:
  git://github.com/hzhuang1/linux.git rtc-sa1100

Haojian Zhuang (6):
      rtc: sa1100: remove periodic code
      rtc: sa1100: remove verification code of alarm
      rtc: sa1100: declare irq in resource
      ARM: pxa: add rtc dummy clock
      rtc: sa1100: enable clk support
      ARM: mmp: enable rtc in pxa910

Jett.Zhou (1):
      ARM: sa1100: clean up clock support

 arch/arm/Kconfig                           |    2 +-
 arch/arm/mach-mmp/include/mach/pxa910.h    |    1 +
 arch/arm/mach-mmp/include/mach/regs-apbc.h |    1 +
 arch/arm/mach-mmp/include/mach/regs-rtc.h  |   23 ++++
 arch/arm/mach-mmp/pxa910.c                 |   27 ++++
 arch/arm/mach-mmp/ttc_dkb.c                |    1 +
 arch/arm/mach-pxa/devices.c                |   28 ++++-
 arch/arm/mach-pxa/pxa25x.c                 |    1 +
 arch/arm/mach-pxa/pxa27x.c                 |    1 +
 arch/arm/mach-pxa/pxa3xx.c                 |    1 +
 arch/arm/mach-pxa/pxa95x.c                 |    1 +
 arch/arm/mach-sa1100/clock.c               |   82 +++++++-----
 arch/arm/mach-sa1100/generic.c             |    8 +
 drivers/rtc/Kconfig                        |    4 +-
 drivers/rtc/rtc-sa1100.c                   |  198 ++++++++++++++--------------
 15 files changed, 234 insertions(+), 145 deletions(-)
 create mode 100644 arch/arm/mach-mmp/include/mach/regs-rtc.h
