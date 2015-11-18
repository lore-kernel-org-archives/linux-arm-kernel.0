From: vz@mleia.com (Vladimir Zapolskiy)
Date: Wed, 18 Nov 2015 18:21:40 +0200
Subject: [GIT PULL] LPC32xx DTS changes for v4.4
Message-ID: <1447863700-15681-1-git-send-email-vz@mleia.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi arm-soc team,

Please consider pulling these DTS changes for the NXP LPC32xx
platform and related boards.

The following changes since commit 8005c49d9aea74d382f474ce11afbbc7d7130bec:

  Linux 4.4-rc1 (2015-11-15 17:00:27 -0800)

are available in the git repository at:

  https://github.com/vzapolskiy/linux.git lpc32xx-dts

for you to fetch changes up to aa29efb445f11506daca0db934331f144b38ddc4:

  arm: dts: lpc32xx: move USB controller subdevices into own device node (2015-11-18 18:01:27 +0200)

----------------------------------------------------------------
Main changes in the series:
- Added description of the second PWM controller device
- Added External Memory Controller device tree node (Primecell PL175)
- Added device tree nodes for standard timer controllers
- USB controllers are grouped
- Various minor clean-ups needed for further development of LPC32xx

----------------------------------------------------------------
Vladimir Zapolskiy (8):
      arm: dts: lpc32xx: change include syntax to be C preprocessor friendly
      arm: dts: lpc32xx: add labels to all defined peripheral nodes
      arm: dts: lpc32xx: add reg property to cpu device node
      arm: dts: lpc32xx: add device node for the second pwm controller
      arm: dts: ea3250/phy3250: specify phys memory offset for lpc32xx boards
      arm: dts: lpc32xx: add external memory controller device node
      arm: dts: lpc32xx: add device nodes for standard timers
      arm: dts: lpc32xx: move USB controller subdevices into own device node

 arch/arm/boot/dts/ea3250.dts   |  41 +++++-------
 arch/arm/boot/dts/lpc32xx.dtsi | 142 ++++++++++++++++++++++++++++++-----------
 arch/arm/boot/dts/phy3250.dts  |  41 +++++-------
 3 files changed, 139 insertions(+), 85 deletions(-)
