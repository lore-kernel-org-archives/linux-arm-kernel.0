From: shawnguo@kernel.org (Shawn Guo)
Date: Mon,  1 Oct 2018 15:20:00 +0800
Subject: [GIT PULL 2/5] i.MX SoC changes for 4.20
In-Reply-To: <20181001072003.16238-1-shawnguo@kernel.org>
References: <20181001072003.16238-1-shawnguo@kernel.org>
Message-ID: <20181001072003.16238-2-shawnguo@kernel.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The following changes since commit 57361846b52bc686112da6ca5368d11210796804:

  Linux 4.19-rc2 (2018-09-02 14:37:30 -0700)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/shawnguo/linux.git tags/imx-soc-4.20

for you to fetch changes up to c90dec00cc84942614bc41f75dc24a87b6d5763b:

  ARM: imx: add i.mx6ulz msl support (2018-09-30 15:31:40 +0800)

----------------------------------------------------------------
i.MX SoC update for 4.20:
 - Add ipg clock support in MMDC driver for registers access, so that
   we will be safe even if the clock is not turned on by firmware.
 - Register pm_power_off handler to provide power off support for iMX6
   based boards with external PMIC.
 - Add platform code support for i.MX 6ULZ SoC which is a derivative of
   i.MX6ULL with some modules removed.

----------------------------------------------------------------
Anson Huang (2):
      ARM: imx: add mmdc ipg clock operation for mmdc
      ARM: imx: add i.mx6ulz msl support

Oleksij Rempel (1):
      ARM: imx6: register pm_power_off handler if "fsl,pmic-stby-poweroff" is set

 arch/arm/mach-imx/anatop.c  | 20 ++++++++++++++++++++
 arch/arm/mach-imx/cpu.c     |  3 +++
 arch/arm/mach-imx/mmdc.c    | 14 ++++++++++++++
 arch/arm/mach-imx/mxc.h     |  7 +++++++
 arch/arm/mach-imx/pm-imx6.c | 29 +++++++++++++++++++++++++++--
 5 files changed, 71 insertions(+), 2 deletions(-)
