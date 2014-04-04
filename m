From: s.trumtrar@pengutronix.de (Steffen Trumtrar)
Date: Fri,  4 Apr 2014 18:31:24 +0200
Subject: [PATCH 0/3] reset: add socfpga reset-controller
Message-ID: <1396629087-23727-1-git-send-email-s.trumtrar@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi!

This series converts the current rst-mgr entry in the socfpga.dtsi to
a driver that registers with the reset-controller framework.

1/3 adds the driver,
2/3 updates the binding to reflect this
3/3 updates the socfpga.dtsi and adds the DT-header file

Regards,
Steffen

Steffen Trumtrar (3):
  reset: add driver for socfpga
  Documentation: dt: socfpga: add reset-cells property
  ARM: socfpga: dts: add reset-controller

 .../bindings/arm/altera/socfpga-reset.txt          |   2 +
 arch/arm/boot/dts/socfpga.dtsi                     |   8 +-
 drivers/reset/Makefile                             |   1 +
 drivers/reset/reset-socfpga.c                      | 149 +++++++++++++++++++++
 include/dt-bindings/reset/altr,rst-mgr.h           |  90 +++++++++++++
 5 files changed, 249 insertions(+), 1 deletion(-)
 create mode 100644 drivers/reset/reset-socfpga.c
 create mode 100644 include/dt-bindings/reset/altr,rst-mgr.h

-- 
1.9.1
