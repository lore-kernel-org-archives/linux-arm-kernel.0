From: f.fainelli@gmail.com (Florian Fainelli)
Date: Mon, 16 Apr 2018 15:30:35 -0700
Subject: [GIT PULL 1/1] Broadcom drivers fixes for 4.17
Message-ID: <20180416223035.578-1-f.fainelli@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The following changes since commit 60cc43fc888428bb2f18f08997432d426a243338:

  Linux 4.17-rc1 (2018-04-15 18:24:20 -0700)

are available in the git repository at:

  https://github.com/Broadcom/stblinux.git tags/arm-soc/for-4.17/drivers-fixes

for you to fetch changes up to 144345a4a8c3b497a3f60d3af9d6071a37660186:

  soc: bcm2835: Make !RASPBERRYPI_FIRMWARE dummies return failure (2018-04-16 15:15:23 -0700)

----------------------------------------------------------------
This pull request contains Broadcom SoCs drivers fixes, please pull the
following:

- Geert makes the Raspberry Pi firmwware return -ENOSYS (similar to
  other subsystems) when CONFIG_RASPBERRYPI_FIRMWARE is off.

- Florian fixes an incorrect annotation in the Raspberry Pi power domain
  driver, spotted by sparse

----------------------------------------------------------------
Florian Fainelli (1):
      soc: bcm: raspberrypi-power: Fix use of __packed

Geert Uytterhoeven (1):
      soc: bcm2835: Make !RASPBERRYPI_FIRMWARE dummies return failure

 drivers/soc/bcm/raspberrypi-power.c        | 2 +-
 include/soc/bcm2835/raspberrypi-firmware.h | 4 ++--
 2 files changed, 3 insertions(+), 3 deletions(-)
