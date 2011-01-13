From: eric.y.miao@gmail.com (Eric Miao)
Date: Thu, 13 Jan 2011 15:15:21 -0600
Subject: [GIT PULL] pxa: fixes for 2.6.38-rc
Message-ID: <AANLkTim_zbLbN-WD9Fhg+Bgin2QR6ODuNw5ru2R+3hLJ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Russell,

The following changes since commit aebf2fc9dc974270b4b25a83816c7051c73f07c8:

  it8152: add IT8152_LAST_IRQ definition to fix build error
(2011-01-02 23:21:14 +0800)

are available in the git repository at:
  git://git.kernel.org/pub/scm/linux/kernel/git/ycmiao/pxa-linux-2.6.git devel

Eric Miao (1):
      ARM: pxa: fix recursive calls in pxa_low_gpio_chip

Marek Vasut (4):
      ARM: pxa: fix warning in zeus.c
      ARM: pxa: remove unused variable in clock-pxa3xx.c
      ARM: pxa: use cpu_has_ipr() consistently in irq.c
      ARM: pxa: fix suspend/resume array index miscalculation

Pavel Machek (1):
      ARM: sa1111: fix typo in sa1111_retrigger_lowirq()

Philip Rakity (2):
      ARM: mmp: MMP2 drive strength FAST using wrong value
      ARM: mmp: PXA910 drive strength FAST using wrong value

 arch/arm/common/sa1111.c                    |    2 +-
 arch/arm/mach-mmp/include/mach/mfp-mmp2.h   |    2 +-
 arch/arm/mach-mmp/include/mach/mfp-pxa910.h |    2 +-
 arch/arm/mach-pxa/clock-pxa3xx.c            |    1 -
 arch/arm/mach-pxa/irq.c                     |   49 ++++++++++-----------------
 arch/arm/mach-pxa/zeus.c                    |    4 +-
 6 files changed, 23 insertions(+), 37 deletions(-)
