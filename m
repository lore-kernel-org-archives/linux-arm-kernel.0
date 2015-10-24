From: f.fainelli@gmail.com (Florian Fainelli)
Date: Sat, 24 Oct 2015 13:36:20 -0700
Subject: [GIT PULL 2/2] Broadcom drivers changes for 4.4 (try 2)
Message-ID: <1445718981-13552-1-git-send-email-f.fainelli@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The following changes since commit 6ff33f3902c3b1c5d0db6b1e2c70b6d76fba357f:

  Linux 4.3-rc1 (2015-09-12 16:35:56 -0700)

are available in the git repository at:

  https://github.com/Broadcom/stblinux tags/arm/soc/for-4.4/rpi-drivers

for you to fetch changes up to 16134b3bc317c571e953d18196acf0a92afda5ff:

  ARM: bcm2835: add mutual inclusion protection (2015-10-24 13:15:58 -0700)

----------------------------------------------------------------
This pull request contains the Raspberry Pi firmware driver, for communicating
with the VPU which has exclusive control of some of the peripherals.

Eric adds the actual firmware driver and Alexander fixes the header file which
was missing include guards.

----------------------------------------------------------------
Alexander Aring (1):
      ARM: bcm2835: add mutual inclusion protection

Eric Anholt (1):
      ARM: bcm2835: Add the Raspberry Pi firmware driver

 drivers/firmware/Kconfig                   |   7 +
 drivers/firmware/Makefile                  |   1 +
 drivers/firmware/raspberrypi.c             | 260 +++++++++++++++++++++++++++++
 include/soc/bcm2835/raspberrypi-firmware.h | 120 +++++++++++++
 4 files changed, 388 insertions(+)
 create mode 100644 drivers/firmware/raspberrypi.c
 create mode 100644 include/soc/bcm2835/raspberrypi-firmware.h
