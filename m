From: arnd@arndb.de (Arnd Bergmann)
Date: Mon, 25 Mar 2013 13:32:13 +0000
Subject: [GIT PULL] arm-soc: bug fixes for 3.9-rc4
Message-ID: <201303251332.13859.arnd@arndb.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The following changes since commit a937536b868b8369b98967929045f1df54234323:

  Linux 3.9-rc3 (2013-03-17 15:59:32 -0700)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/arm/arm-soc.git tags/fixes

for you to fetch changes up to c69d72aec52eb5234f433259ac5dcc3b68f1480d:

  MAINTAINERS: update email address for Kevin Hilman (2013-03-22 21:57:15 +0100)

----------------------------------------------------------------
Four patches for arm-soc this week:
- Kevin Hilman is no longer reachable under his previous email address.
  He submitted the patch earlier, but nobody felt responsible to pick
  it up.

- One Tegra fix for an incorect register address in device tree.

- IMX multiplatform support exposes a configuration option that
  leads to unbootable kernels on all other machines and that needs
  to depend on that platform.

- A nontrivial bug fix for the setup of the mxs video output.

----------------------------------------------------------------
Arnd Bergmann (2):
      Merge tag 'mxs-fixes-3.9-3' of git://git.linaro.org/people/shawnguo/linux-2.6 into fixes
      Merge tag 'imx-fixes-3.9-3' of git://git.linaro.org/people/shawnguo/linux-2.6 into fixes

Kevin Hilman (1):
      MAINTAINERS: update email address for Kevin Hilman

Laxman Dewangan (1):
      ARM: tegra: fix register address of slink controller

Marek Vasut (1):
      ARM: video: mxs: Fix mxsfb misconfiguring VDCTRL0

Shawn Guo (1):
      ARM: imx: add dependency check for DEBUG_IMX_UART_PORT

 MAINTAINERS                    |  6 +++---
 arch/arm/Kconfig.debug         |  1 +
 arch/arm/boot/dts/tegra20.dtsi |  2 +-
 arch/arm/boot/dts/tegra30.dtsi |  2 +-
 arch/arm/mach-mxs/mach-mxs.c   | 24 ++++++++++++------------
 drivers/video/mxsfb.c          |  7 +++++--
 include/linux/mxsfb.h          |  7 +++++--
 7 files changed, 28 insertions(+), 21 deletions(-)
