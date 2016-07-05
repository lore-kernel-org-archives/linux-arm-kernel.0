From: yendapally.reddy@broadcom.com (Yendapally Reddy Dhananjaya Reddy)
Date: Tue,  5 Jul 2016 02:00:23 -0400
Subject: [PATCH v5 0/3] pwm support for Broadcom iProc SoC's
Message-ID: <1467698426-27600-1-git-send-email-yendapally.reddy@broadcom.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patchset contains the pwm support for the Broadcom's iProc SoC's.

The first patch provides the documentation details and the
second patch contains the controller support details. The third patch
contains the enable method for Northstar Plus SoC.

This patch series has been tested on NSP bcm958625HR board.
The pwm is not enabled for this board as the pins are open and not used.

This patch series is based on v4.7.0-rc1 and is available from github
repo: https://github.com/Broadcom/cygnus-linux.git
branch: iproc-pwm-v5

Changes since v4
Supported apply() callback instead of config()/set_polarity()
/enable()/disable()? as suggested by Brian

Changes since v3
Addressed comments from Scott to include COMPILE_TEST

Changes since v2
Rebased on v4.7.0-rc1

Changes since v1
Addressed the review comments from Thierry
 1. Use separate driver for iProc SoC's.
 2. Added Robs ack to the Documentation patch

Yendapally Reddy Dhananjaya Reddy (3):
  Documentation: dt: Add Broadcom iproc pwm controller binding
  pwm: iproc: Add support for Broadcom iproc pwm controller
  ARM: dts: NSP: Add PWM Support to DT

 .../devicetree/bindings/pwm/brcm,iproc-pwm.txt     |  21 ++
 arch/arm/boot/dts/bcm-nsp.dtsi                     |   8 +
 drivers/pwm/Kconfig                                |  10 +
 drivers/pwm/Makefile                               |   1 +
 drivers/pwm/pwm-bcm-iproc.c                        | 268 +++++++++++++++++++++
 5 files changed, 308 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/pwm/brcm,iproc-pwm.txt
 create mode 100644 drivers/pwm/pwm-bcm-iproc.c

-- 
2.1.0
