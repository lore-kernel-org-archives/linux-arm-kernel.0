From: daniel@zonque.org (Daniel Mack)
Date: Wed, 16 May 2018 14:28:26 +0200
Subject: [PATCH 0/3] input: touchscreen: edt-ft5x06: make wakeup source
 behavior configurable
Message-ID: <20180516122829.23694-1-daniel@zonque.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

I have a platform that features an edt-ft5x06 touch panel and that
doesn't want to wake on touch screen activity.

Here's a trivial series of patches that make the edt-ft5x06 driver only
act as wakeup source when requested through device properties or DTS.

The third patch changes the default in two DTS files that use this
driver.

I guess the first two patches should go through the input tree, while
the third can be picked by the IMX people. There are no compile-time
dependencies, so the order doesn't matter.


Thanks,
Daniel


Daniel Mack (3):
  input: touchscreen: edt-ft5x06: make wakeup source behavior
    configurable
  input: touchscreen: edt-ft5x06: assert reset during suspend
  ARM: dts: imx28/imx53: enable edt-ft5x06 wakeup source

 .../devicetree/bindings/input/touchscreen/edt-ft5x06.txt         | 3 +++
 arch/arm/boot/dts/imx28-tx28.dts                                 | 1 +
 arch/arm/boot/dts/imx53-tx53-x03x.dts                            | 1 +
 drivers/input/touchscreen/edt-ft5x06.c                           | 9 ++++++++-
 4 files changed, 13 insertions(+), 1 deletion(-)

-- 
2.14.3
