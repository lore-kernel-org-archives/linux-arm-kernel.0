From: yendapally.reddy@broadcom.com (Yendapally Reddy Dhananjaya Reddy)
Date: Tue, 29 Mar 2016 10:22:27 -0400
Subject: [PATCH RESEND 0/3] pwm support for Broadcom iProc SoC's
Message-ID: <1459261350-23851-1-git-send-email-yendapally.reddy@broadcom.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patchset contains the pwm support for the Broadcom's iProc SoC's.

The first patch provides the documentation details and the
second patch contains the controller support details. The third patch
contains the enable method for Northstar Plus SoC.

This patch series has been tested on NSP bcm958625HR board with oscilloscope.
The pwm is not enabled for this board as the pins are open and not used.

This patch series is based on v4.6.0-rc1 and is available from github
repo: https://github.com/Broadcom/cygnus-linux.git
branch: iproc-pwm-v1

This patch series was originally sent on 03/01/16.
See https://lkml.org/lkml/2016/3/1/487

Yendapally Reddy Dhananjaya Reddy (3):
  Documentation: dt: Add Broadcom iproc pwm controller binding
  pwm: kona: Add support for Broadcom iproc pwm controller
  ARM: dts: NSP: Add PWM Support to DT

 .../devicetree/bindings/pwm/brcm,kona-pwm.txt      |   2 +-
 arch/arm/boot/dts/bcm-nsp.dtsi                     |   8 +
 drivers/pwm/Kconfig                                |   6 +-
 drivers/pwm/pwm-bcm-kona.c                         | 183 ++++++++++++++++++---
 4 files changed, 172 insertions(+), 27 deletions(-)

-- 
2.1.0
