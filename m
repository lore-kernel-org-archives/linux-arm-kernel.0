From: lee.jones@linaro.org (Lee Jones)
Date: Fri, 12 Feb 2016 09:00:33 +0000
Subject: [GIT PULL] Immutable branch between MFD and Regulator
In-Reply-To: <1455242567-17880-1-git-send-email-wens@csie.org>
References: <1455242567-17880-1-git-send-email-wens@csie.org>
Message-ID: <20160212090033.GN20693@x1>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Enjoy!

The following changes since commit 36f90b0a2ddd60823fe193a85e60ff1906c2a9b3:

  Linux 4.5-rc2 (2016-01-31 18:12:16 -0800)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/lee/mfd.git tags/ib-mfd-regulator-v4.6

for you to fetch changes up to 04e0981c67e6a7ba8aacac731d925f4ff21b67fb:

  regulator: axp20x: Support new AXP223 PMIC (2016-02-12 08:55:34 +0000)

----------------------------------------------------------------
Immutable branch between MFD and Regulator

----------------------------------------------------------------
Chen-Yu Tsai (8):
      mfd: axp20x: Add AXP223 to list of supported PMICs in DT bindings
      mfd: axp20x: Remove second struct device * parameter for axp20x_match_device()
      mfd: axp20x: Use dev->driver->of_match_table in axp20x_match_device()
      mfd: axp20x: Add missing copyright notice
      mfd: axp20x: Split the driver into core and i2c bits
      mfd: axp20x: Whitespace, open parenthesis alignment code style fixes
      mfd: axp20x: Add support for RSB based AXP223 PMIC
      regulator: axp20x: Support new AXP223 PMIC

 Documentation/devicetree/bindings/mfd/axp20x.txt |   7 +-
 drivers/mfd/Kconfig                              |  25 ++++--
 drivers/mfd/Makefile                             |   2 +
 drivers/mfd/axp20x-i2c.c                         | 104 ++++++++++++++++++++++
 drivers/mfd/axp20x-rsb.c                         |  80 +++++++++++++++++
 drivers/mfd/axp20x.c                             | 105 ++++++-----------------
 drivers/regulator/axp20x-regulator.c             |   3 +
 include/linux/mfd/axp20x.h                       |  34 +++++++-
 8 files changed, 271 insertions(+), 89 deletions(-)
 create mode 100644 drivers/mfd/axp20x-i2c.c
 create mode 100644 drivers/mfd/axp20x-rsb.c

-- 
Lee Jones
Linaro STMicroelectronics Landing Team Lead
Linaro.org ? Open source software for ARM SoCs
Follow Linaro: Facebook | Twitter | Blog
