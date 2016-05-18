From: yendapally.reddy@broadcom.com (Yendapally Reddy Dhananjaya Reddy)
Date: Wed, 18 May 2016 02:53:58 -0400
Subject: [PATCH INTERNAL v2 0/3] pwm support for Broadcom iProc SoC's
Message-ID: <1463554441-47982-1-git-send-email-yendapally.reddy@broadcom.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patchset contains the pwm support for the Broadcom's iProc SoC's.

The first patch provides the documentation details and the
second patch contains the controller support details. The third patch
contains the enable method for Northstar Plus SoC.

This patch series has been tested on NSP bcm958625HR board.
The pwm is not enabled for this board as the pins are open and not used.

This patch series is based on v4.6.0-rc1 and is available from github
repo: https://github.com/Broadcom/cygnus-linux.git
branch: iproc-pwm-v2

Changes since v1

Addressed the review comments from Thierry
 1. Use separate driver for iProc SoC's.

Yendapally Reddy Dhananjaya Reddy (3):
  Documentation: dt: Add Broadcom iproc pwm controller binding
  pwm: iproc: Add support for Broadcom iproc pwm controller
  ARM: dts: NSP: Add PWM Support to DT

 .../devicetree/bindings/pwm/brcm,iproc-pwm.txt     |  21 ++
 arch/arm/boot/dts/bcm-nsp.dtsi                     |   8 +
 drivers/pwm/Kconfig                                |  10 +
 drivers/pwm/Makefile                               |   1 +
 drivers/pwm/pwm-bcm-iproc.c                        | 320 +++++++++++++++++++++
 5 files changed, 360 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/pwm/brcm,iproc-pwm.txt
 create mode 100644 drivers/pwm/pwm-bcm-iproc.c

-- 
2.1.0
