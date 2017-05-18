From: shawnguo@kernel.org (Shawn Guo)
Date: Thu, 18 May 2017 22:56:41 +0800
Subject: [GIT PULL] i.MX fixes for 4.12
Message-ID: <20170518145638.GA26102@dragon>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The following changes since commit 2ea659a9ef488125eb46da6eb571de5eae5c43f6:

  Linux 4.12-rc1 (2017-05-13 13:19:49 -0700)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/shawnguo/linux.git tags/imx-fixes-4.12

for you to fetch changes up to e23c7f7d57831fdae444be9d507e67716ab601d4:

  soc: imx: add PM dependency for IMX7_PM_DOMAINS (2017-05-15 09:33:22 +0800)

----------------------------------------------------------------
i.MX fixes for 4.12:
 - A fix on GPCv2 power domain driver Kconfig which causes a build
   failure when CONFIG_PM is not set.
 - Pull down PMIC IRQ pin for imx53-qsrb board to prevent spurious
   PMIC interrupts from happening.
 - Remove board level OPP override for imx6sx-sdb to fix a boot crash
   seen on Rev.C boards.

----------------------------------------------------------------
Arnd Bergmann (1):
      soc: imx: add PM dependency for IMX7_PM_DOMAINS

Fabio Estevam (1):
      ARM: dts: imx53-qsrb: Pulldown PMIC IRQ pin

Leonard Crestez (1):
      ARM: dts: imx6sx-sdb: Remove OPP override

 arch/arm/boot/dts/imx53-qsrb.dts |  2 +-
 arch/arm/boot/dts/imx6sx-sdb.dts | 17 -----------------
 drivers/soc/imx/Kconfig          |  3 ++-
 3 files changed, 3 insertions(+), 19 deletions(-)
