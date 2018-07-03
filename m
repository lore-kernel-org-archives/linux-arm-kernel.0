From: eric@anholt.net (Eric Anholt)
Date: Tue,  3 Jul 2018 13:05:09 -0700
Subject: [GIT PULL 2/4] bcm2835-drivers-next-2018-07-03
In-Reply-To: <20180703200511.2725-1-eric@anholt.net>
References: <20180703200511.2725-1-eric@anholt.net>
Message-ID: <20180703200511.2725-2-eric@anholt.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The following changes since commit ce397d215ccd07b8ae3f71db689aedb85d56ab40:

  Linux 4.18-rc1 (2018-06-17 08:04:49 +0900)

are available in the Git repository at:

  git://github.com/anholt/linux tags/bcm2835-drivers-next-2018-07-03

for you to fetch changes up to 5bfdc1097654eb31bcf2d10421ed769ef3b161c6:

  firmware: raspberrypi: Remove VLA usage (2018-07-03 12:56:12 -0700)

----------------------------------------------------------------
This pull request brings in the new HWMON driver for getting
under-voltage detection from the Raspberry Pi firmware, and a change
from Kees to remove another instance of VLA stack usage.

----------------------------------------------------------------
Kees Cook (1):
      firmware: raspberrypi: Remove VLA usage

Stefan Wahren (3):
      ARM: bcm2835: Add GET_THROTTLED firmware property
      hwmon: Add support for RPi voltage sensor
      firmware: raspberrypi: Register hwmon driver

 Documentation/hwmon/raspberrypi-hwmon      |  22 ++++
 drivers/firmware/raspberrypi.c             |  29 ++++-
 drivers/hwmon/Kconfig                      |  10 ++
 drivers/hwmon/Makefile                     |   1 +
 drivers/hwmon/raspberrypi-hwmon.c          | 166 +++++++++++++++++++++++++++++
 include/soc/bcm2835/raspberrypi-firmware.h |   1 +
 6 files changed, 227 insertions(+), 2 deletions(-)
 create mode 100644 Documentation/hwmon/raspberrypi-hwmon
 create mode 100644 drivers/hwmon/raspberrypi-hwmon.c
