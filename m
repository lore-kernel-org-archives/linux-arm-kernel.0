From: sebastian.hesselbarth@gmail.com (Sebastian Hesselbarth)
Date: Wed, 20 May 2015 18:50:26 +0200
Subject: [GIT PULL v2] ARM: berlin: Simple-MFD rework for v4.2 (round 1)
In-Reply-To: <1432140626-6109-1-git-send-email-sebastian.hesselbarth@gmail.com>
References: <1432140626-6109-1-git-send-email-sebastian.hesselbarth@gmail.com>
Message-ID: <1432140626-6109-2-git-send-email-sebastian.hesselbarth@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Arnd, Kevin, Olof,

this is a PR for the Berlin System/Chip controller simple-mfd rework
which is now bisect compatible and rebased on top of arm-soc's
drivers/simple-mfd tag. Compared to the corresponding patch set, I
also added the ADC node patch for berlin2q which also depends on
simple-mfd.

Please pull.

Thanks,
  Sebastian

The following changes since commit 48f1a9a4e268dec7c7f3e79339cfb85699c48eb0:

  arm64: add LEDs and some trigger support to defconfig (2015-05-11 08:55:04 +0200)

are available in the git repository at:

  git://git.infradead.org/users/hesselba/linux-berlin.git tags/berlin-simple-mfd-4.2-1

for you to fetch changes up to 5be2361160cdbbfcc580b82a440218c115c15504:

  ARM: berlin: add an ADC node for the BG2Q (2015-05-18 18:10:16 +0200)

----------------------------------------------------------------
Berlin simple-mfd for v4.2
- based on arm-soc drivers/simple-mfd branch
- rework of chip/system ctrl nodes to simple-mfd probing for
  clk, pinctrl, and reset
- add adc node

----------------------------------------------------------------
Antoine Tenart (15):
      ARM: berlin: select MFD_SYSCON by default
      ARM: berlin: prepare simple-mfd/syscon conversion of sys/chip ctrl nodes
      reset: berlin: convert to a platform driver
      ARM: berlin: move reset to simple-mfd nodes
      reset: berlin: drop arch_initcall initialization
      pinctrl: berlin: prepare to use regmap provided by syscon
      ARM: berlin: move pinctrl to simple-mfd nodes
      pinctrl: berlin: drop SoC stub provided regmap
      clk: berlin: prepare simple-mfd conversion
      ARM: berlin: move BG2 clock node
      ARM: berlin: move BG2CD clock node
      ARM: berlin: move BG2Q clock node
      clk: berlin: drop direct of_iomap of nodes reg property
      ARM: berlin: remove useless chip and system ctrl compatibles
      ARM: berlin: add an ADC node for the BG2Q

 arch/arm/boot/dts/berlin2.dtsi        |  90 ++++++++++++++-----------
 arch/arm/boot/dts/berlin2cd.dtsi      |  66 ++++++++++++-------
 arch/arm/boot/dts/berlin2q.dtsi       | 120 ++++++++++++++++++++--------------
 arch/arm/mach-berlin/Kconfig          |   1 +
 drivers/clk/berlin/bg2.c              |   7 +-
 drivers/clk/berlin/bg2q.c             |   7 +-
 drivers/pinctrl/berlin/berlin-bg2.c   |  26 +-------
 drivers/pinctrl/berlin/berlin-bg2cd.c |  26 +-------
 drivers/pinctrl/berlin/berlin-bg2q.c  |  26 +-------
 drivers/pinctrl/berlin/berlin.c       |   9 ++-
 drivers/reset/reset-berlin.c          |  74 ++++++++-------------
 11 files changed, 212 insertions(+), 240 deletions(-)
