From: danindrey@mail.ru (Andrey Danin)
Date: Mon, 30 Mar 2015 23:00:11 +0300
Subject: [PATCH v2 0/4]  arm: tegra: implement NVEC driver using tegra i2c.
Message-ID: <1427745615-5428-1-git-send-email-danindrey@mail.ru>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

NVEC driver contains code to manage tegra i2c controller in slave mode.
I2C slave support was implemented in linux kernel. The goal of this
patch serie is to implement I2C slave mode in tegra drived and rework
NVEC driver to use it.

Patches are based on i2c for-next.

Changes for v2:
- rebased on top of new i2c slave framework.
- old code is removed in separate patch
- documentation patch is integrated to main nvec patch


Thanks in advance

Andrey Danin (4):
  i2c: tegra: implement slave mode
  staging/nvec: reimplement on top of tegra i2c driver
  staging/nvec: remove old code
  dt: paz00: define nvec as child of i2c bus

 .../devicetree/bindings/nvec/nvidia,nvec.txt       |  21 +-
 arch/arm/boot/dts/tegra20-paz00.dts                |  22 +-
 drivers/i2c/busses/Kconfig                         |   1 +
 drivers/i2c/busses/i2c-tegra.c                     | 119 ++++++
 drivers/staging/nvec/nvec.c                        | 411 +++++++--------------
 drivers/staging/nvec/nvec.h                        |  10 -
 6 files changed, 269 insertions(+), 315 deletions(-)

-- 
1.9.1
