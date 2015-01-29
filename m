From: danindrey@mail.ru (Andrey Danin)
Date: Thu, 29 Jan 2015 10:20:19 +0300
Subject: [PATCH 0/3] arm: tegra: implement NVEC driver using tegra i2c.
Message-ID: <1422516022-27161-1-git-send-email-danindrey@mail.ru>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

NVEC driver contains code to manage tegra i2c controller in slave mode.
I2C slave support was implemented in linux kernel. The goal of this
patch serie is to implement I2C slave mode in tegra drived and rework
NVEC driver to use it.

Patches are based on i2c for-next.

Patch 1 imeplents slave mode for tegra I2C controller. This patch
was checked on tegra 2 device (Toshiba AC100) only. Please review
carefully.

Patch 2 reworks NVEC driver itself. I kept code close to original.

Patch 3 fixes device tree and documentation.


Thanks in advance

Andrey Danin (3):
  i2c: tegra: implement slave mode
  staging/nvec: reimplement on top of tegra i2c driver
  dt: paz00: define nvec as child of i2c bus

 .../devicetree/bindings/nvec/nvidia,nvec.txt       |  19 +-
 arch/arm/boot/dts/tegra20-paz00.dts                |  22 +-
 drivers/i2c/busses/i2c-tegra.c                     | 131 +++++++
 drivers/staging/nvec/nvec.c                        | 379 +++++++--------------
 drivers/staging/nvec/nvec.h                        |  17 +-
 5 files changed, 264 insertions(+), 304 deletions(-)

-- 
1.9.1
