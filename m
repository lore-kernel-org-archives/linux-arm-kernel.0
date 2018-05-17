From: daniel@zonque.org (Daniel Mack)
Date: Thu, 17 May 2018 11:05:49 +0200
Subject: [PATCH v2 0/3] input: touchscreen: edt-ft5x06: make wakeup source
 behavior configurable
Message-ID: <20180517090552.5704-1-daniel@zonque.org>
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

v1 ? v2:
	* simply drop device_init_wakeup() as the I2C core does handles
	  the wakeup-source property already (1/3)
	* add a delay after reset deassertion at resume time (2/3)
	* no changes in the DTS patch (3/3)


Daniel Mack (3):
  input: touchscreen: edt-ft5x06: don't make device a wakeup source by
    default
  input: touchscreen: edt-ft5x06: assert reset during suspend
  ARM: dts: imx28/imx53: enable edt-ft5x06 wakeup source

 .../bindings/input/touchscreen/edt-ft5x06.txt      |  3 +++
 arch/arm/boot/dts/imx28-tx28.dts                   |  1 +
 arch/arm/boot/dts/imx53-tx53-x03x.dts              |  1 +
 drivers/input/touchscreen/edt-ft5x06.c             | 27 +++++++++++++++++-----
 4 files changed, 26 insertions(+), 6 deletions(-)

-- 
2.14.3
