From: olof@lixom.net (Olof Johansson)
Date: Thu, 20 Sep 2012 17:16:33 -0700
Subject: [GIT PULL] ARM: SoC fixes for 3.6-rc
Message-ID: <CAOesGMi8VYoptLeGQj7qZWUOyovX8P+409R64QHfH7=vGvCDgw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Linus,


The following changes since commit 5698bd757d55b1bb87edd1a9744ab09c142abfc2:

  Linux 3.6-rc6 (2012-09-16 14:58:51 -0700)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/arm/arm-soc.git
tags/fixes-for-linus

for you to fetch changes up to 23f3f0613f6172ef1f0cbb0e971adf29f1c1fe5e:

  Merge tag 'imx-fixes' of git://git.pengutronix.de/git/imx/linux-2.6
into fixes (2012-09-18 10:16:44 -0700)

----------------------------------------------------------------

arm-soc: bug fixes for v3.6-rc

A couple of samsung clock locking fixes, at91 device tree gpio
configuration fix and a couple more for shmobile and i.MX.

All small targeted fixes.

----------------------------------------------------------------
Fabio Estevam (1):
      ARM: imx: armadillo5x0: Fix illegal register access

Jean-Christophe PLAGNIOL-VILLARD (1):
      ARM: at91: fix missing #interrupt-cells on gpio-controller

Mandeep Singh Baines (1):
      ARM: SAMSUNG: use spin_lock_irqsave() in clk_set_parent

Olof Johansson (4):
      Merge branch 'v3.6-samsung-fixes-3' of
git://git.kernel.org/.../kgene/linux-samsung into fixes
      Merge branch 'fixes' of git://git.kernel.org/.../horms/renesas into fixes
      Merge tag 'at91-fixes' of git://github.com/at91linux/linux-at91 into fixes
      Merge tag 'imx-fixes' of
git://git.pengutronix.de/git/imx/linux-2.6 into fixes

Sascha Hauer (1):
      ARM i.MX25: Make timer irq work again

Tetsuyuki Kobayashi (1):
      ARM: shmobile: kzm9g: bugfix: correct mmcif interrupt settings

Tushar Behera (1):
      ARM: SAMSUNG: Use spin_lock_{irqsave,irqrestore} in clk_set_rate

 arch/arm/boot/dts/at91sam9260.dtsi    |  3 +++
 arch/arm/boot/dts/at91sam9263.dtsi    |  5 +++++
 arch/arm/boot/dts/at91sam9g45.dtsi    |  5 +++++
 arch/arm/boot/dts/at91sam9n12.dtsi    |  4 ++++
 arch/arm/boot/dts/at91sam9x5.dtsi     |  4 ++++
 arch/arm/mach-imx/clk-imx25.c         |  2 +-
 arch/arm/mach-imx/mach-armadillo5x0.c |  3 ++-
 arch/arm/mach-shmobile/board-kzm9g.c  |  4 ++--
 arch/arm/plat-mxc/include/mach/mx25.h |  1 +
 arch/arm/plat-samsung/clock.c         | 10 ++++++----
 10 files changed, 33 insertions(+), 8 deletions(-)
