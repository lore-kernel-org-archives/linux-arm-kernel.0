From: olof@lixom.net (Olof Johansson)
Date: Sat, 21 Jul 2018 14:13:49 -0700
Subject: [GIT PULL] ARM: SoC fixes
Message-ID: <20180721211349.f43vzd67fm6b5jim@localhost>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Linus,

The following changes since commit 13e66ceea1600f1061181acc2d4e0fac1a7d0333:

  Merge tag 'omap-for-v4.18/fixes-rc4-signed' of git://git.kernel.org/pub/scm/linux/kernel/git/tmlind/linux-omap into fixes (2018-07-14 15:14:02 -0700)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/arm/arm-soc.git tags/armsoc-fixes

for you to fetch changes up to 5858610f0dd76151c4e12420fd11801d23737663:

  Merge tag 'imx-fixes-4.18-4' of git://git.kernel.org/pub/scm/linux/kernel/git/shawnguo/linux into fixes (2018-07-20 14:22:11 -0700)

----------------------------------------------------------------
ARM: SoC fixes for 4.18-rc

 - Fix interrupt type on ethernet switch for i.MX-based RDU2
 - GPC on i.MX exposed too large a register window which resulted in
   userspace being able to crash the machine.
 - Fixup of bad merge resolution moving GPIO DT nodes under pinctrl
   on droid4.

----------------------------------------------------------------
Anson Huang (1):
      soc: imx: gpc: restrict register range for regmap access

Olof Johansson (3):
      Merge tag 'omap-for-v4.18/fixes-rc5-signed' of git://git.kernel.org/.../tmlind/linux-omap into fixes
      Merge tag 'imx-fixes-4.18-3' of git://git.kernel.org/.../shawnguo/linux into fixes
      Merge tag 'imx-fixes-4.18-4' of git://git.kernel.org/.../shawnguo/linux into fixes

Pavel Machek (1):
      ARM: dts: omap4-droid4: fix dts w.r.t. pwm

Uwe Kleine-K?nig (1):
      ARM: dts: imx6: RDU2: fix irq type for mv88e6xxx switch

 arch/arm/boot/dts/imx6qdl-zii-rdu2.dtsi  |  2 +-
 arch/arm/boot/dts/omap4-droid4-xt894.dts |  9 +++------
 drivers/soc/imx/gpc.c                    | 21 +++++++++++++++++++++
 3 files changed, 25 insertions(+), 7 deletions(-)
