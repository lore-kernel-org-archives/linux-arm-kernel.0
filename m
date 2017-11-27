From: f.fainelli@gmail.com (Florian Fainelli)
Date: Mon, 27 Nov 2017 12:08:17 -0800
Subject: [GIT PULL 1/1] Broadcom devicetree fixes for 4.15
Message-ID: <20171127200817.32647-1-f.fainelli@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The following changes since commit 4fbd8d194f06c8a3fd2af1ce560ddb31f7ec8323:

  Linux 4.15-rc1 (2017-11-26 16:01:47 -0800)

are available in the git repository at:

  http://github.com/Broadcom/stblinux.git tags/arm-soc/for-4.15/devicetree-fixes-1

for you to fetch changes up to babd8a3e31fbb0abb4c37ee3548974732080b996:

  Merge tag 'bcm2835-dt-next-fixes-2017-11-15' into devicetree/fixes (2017-11-27 11:28:23 -0800)

----------------------------------------------------------------
This pull request contains Broadcom ARM-based SoCs Device Tree fixes for 4.15,
please pull the following:

- Stefan provides a fix for the BCM2835 (Raspberry Pi) to fix warnings about
  missing "#phy-cells" properties

- Florian provides two fixes for Nortsthar Plus, one that uses the correct
  interrupt specifiers for the timer/watchdog and one that disables SATA
  on BCM9582**HR boards since that leads to unidentified hangs right now

----------------------------------------------------------------
Florian Fainelli (3):
      ARM: dts: NSP: Disable AHCI controller for HR NSP boards
      ARM: dts: NSP: Fix PPI interrupt types
      Merge tag 'bcm2835-dt-next-fixes-2017-11-15' into devicetree/fixes

Stefan Wahren (1):
      ARM: dts: bcm283x: Fix DTC warnings about missing phy-cells

 arch/arm/boot/dts/bcm-nsp.dtsi    | 4 ++--
 arch/arm/boot/dts/bcm283x.dtsi    | 1 +
 arch/arm/boot/dts/bcm958623hr.dts | 4 ----
 arch/arm/boot/dts/bcm958625hr.dts | 4 ----
 4 files changed, 3 insertions(+), 10 deletions(-)
