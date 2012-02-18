From: haojian.zhuang@gmail.com (Haojian Zhuang)
Date: Sat, 18 Feb 2012 18:04:51 +0800
Subject: [GIT PULL] [v3.3] fixes for arch-pxa in arm
Message-ID: <CAN1soZwcL-ELxwW5MB7zNQOrr0YPpo6pXp40D7uEaKH6Li0haw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Arnd,

Here's the fixes for 3.3.

The following changes since commit c38e23456278e967f094b08247ffc3711b1029b2:

  i387: fix sense of sanity check (2012-02-15 08:05:18 -0800)

are available in the git repository at:
  git://github.com/hzhuang1/linux.git fixes

Axel Lin (2):
      ARM: pxa: fix error handling in pxa2xx_drv_pcmcia_probe
      pxa/hx4700: add platform device and I2C info for AK4641 codec

Danny Kukawka (3):
      ARM: pxa: fix including linux/gpio.h twice
      arch/arm/mach-mmp/: some files include some headers twice
      arch/arm/mach-pxa/: included linux/gpio.h twice

Haojian Zhuang (2):
      ARM: pxa: fix wrong parsing gpio event on spitz
      ARM: pxa: fix mixed declarations and code in sharpsl_pm

 arch/arm/mach-mmp/aspenite.c   |    1 -
 arch/arm/mach-mmp/pxa168.c     |    1 -
 arch/arm/mach-mmp/tavorevb.c   |    1 -
 arch/arm/mach-pxa/hx4700.c     |   25 +++++++++++++++++++++++++
 arch/arm/mach-pxa/pxa25x.c     |    1 -
 arch/arm/mach-pxa/pxa27x.c     |    1 -
 arch/arm/mach-pxa/saarb.c      |    1 -
 arch/arm/mach-pxa/sharpsl_pm.c |    3 +--
 arch/arm/mach-pxa/spitz_pm.c   |    5 ++---
 drivers/pcmcia/pxa2xx_base.c   |   12 +++---------
 10 files changed, 31 insertions(+), 20 deletions(-)
