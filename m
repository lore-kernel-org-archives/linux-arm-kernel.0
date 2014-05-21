From: lee.jones@linaro.org (Lee Jones)
Date: Wed, 21 May 2014 10:48:52 +0100
Subject: [GIT PULL] mfd: Second IB for Mark (regulator)
In-Reply-To: <1398295293-11033-1-git-send-email-mporter@linaro.org>
References: <1398295293-11033-1-git-send-email-mporter@linaro.org>
Message-ID: <20140521094852.GH6679@lee--X1>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The following changes since commit a798c10faf62a505d24e5f6213fbaf904a39623f:

  Linux 3.15-rc2 (2014-04-20 11:08:50 -0700)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/lee/mfd.git tags/mfd-regulator-v3.16-1

for you to fetch changes up to c6466950e917890be3050171f6745ccb9d91d35f:

  regulator: bcm590xx: Add support for regulators on secondary I2C slave (2014-05-21 10:40:16 +0100)

----------------------------------------------------------------
Immutable branch between MFD and Regulator due for v3.16 merge-window.

----------------------------------------------------------------
Doug Anderson (2):
      mfd: tps65090: Don't tell child devices we have an IRQ if we don't
      mfd: tps65090: Stop caching most registers

Matt Porter (3):
      mfd: bcm590xx: Update binding with additional BCM59056 regulators
      mfd: bcm590xx: Add support for secondary I2C slave address
      regulator: bcm590xx: Add support for regulators on secondary I2C slave

 Documentation/devicetree/bindings/mfd/bcm590xx.txt |  4 +-
 drivers/mfd/bcm590xx.c                             | 60 ++++++++++----
 drivers/mfd/tps65090.c                             | 41 ++++++----
 drivers/power/tps65090-charger.c                   | 11 ---
 drivers/regulator/bcm590xx-regulator.c             | 92 +++++++++++++++++++---
 include/linux/mfd/bcm590xx.h                       |  9 ++-
 include/linux/mfd/tps65090.h                       | 14 ++++
 7 files changed, 176 insertions(+), 55 deletions(-)

-- 
Lee Jones
Linaro STMicroelectronics Landing Team Lead
Linaro.org ? Open source software for ARM SoCs
Follow Linaro: Facebook | Twitter | Blog
