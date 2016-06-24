From: tony.felice@timesys.com (Anthony Felice)
Date: Fri, 24 Jun 2016 15:44:42 -0400
Subject: [PATCH 0/4] Enable display and touchscreen for Vybrid Tower
Message-ID: <1466797486-31558-1-git-send-email-tony.felice@timesys.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patchset enables the TWR-LCD-RGB display and the CRTouch-based touchscreen
on the Vybrid Tower platform. Both display and touchscreen have been tested and
verified working with this patchset on a Rev J Vybrid Tower system.

Anthony Felice (4):
  ARM: dts: vf610-twr: Enable display controller
  input: touchscreen: crtouch_ts: Add driver
  ARM: dts: vf610-twr: Add crtouch node and pinmux
  ARM: imx_v6_v7_defconfig: enable useful configurations for Vybrid

 .../bindings/input/touchscreen/crtouch_ts.txt      |  14 ++
 arch/arm/boot/dts/vf610-twr.dts                    |  62 +++++
 arch/arm/configs/imx_v6_v7_defconfig               |   6 +-
 drivers/input/touchscreen/Kconfig                  |  10 +
 drivers/input/touchscreen/Makefile                 |   1 +
 drivers/input/touchscreen/crtouch_ts.c             | 279 +++++++++++++++++++++
 6 files changed, 368 insertions(+), 4 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/input/touchscreen/crtouch_ts.txt
 create mode 100644 drivers/input/touchscreen/crtouch_ts.c

-- 
2.7.4
