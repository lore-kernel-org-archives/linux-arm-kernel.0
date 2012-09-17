From: anilkumar@ti.com (AnilKumar Ch)
Date: Mon, 17 Sep 2012 12:53:18 +0530
Subject: [PATCH v3 0/4] lis3: lis3lv02d_i2c: Add device tree support
Message-ID: <1347866602-2088-1-git-send-email-anilkumar@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Adds device tree support to lis3lv02d_i2c driver. Along with this
DT init is moved from core driver to individual drivers, with the
current implementation some pdata is missing in lis3lv02d_i2c driver.

Also adds platform data for lis331dlh driver to am335x-EVM. These
patches were tested on AM335x-EVM.

Changes from v2:
	- Added documentation details specific to lis3lv02d_i2c
	  driver with example node
	- Modified DTS node representation in .dts file
	- Removed "-i2c" string from compatible name

Changes from v1:
	- Moved lis3lv02d_init_dt to individual drivers with
	  some code clean-up.
	- Added lis331dlh compatible entry for lis331dlh parts

AnilKumar Ch (4):
  lis3: lis3lv02d: remove lis3lv02d driver DT init
  lis3: lis3lv02d_spi: Add lis3lv02d device tree init
  lis3: lis3lv02d_i2c: Add lis3lv02d device tree init
  ARM: dts: AM33XX: Add lis331dlh device tree data to am335x-evm

 Documentation/devicetree/bindings/misc/lis302.txt |   36 +++++++++++++++++++
 arch/arm/boot/dts/am335x-evm.dts                  |   39 +++++++++++++++++++++
 drivers/misc/lis3lv02d/lis3lv02d.c                |    8 ++---
 drivers/misc/lis3lv02d/lis3lv02d.h                |    1 +
 drivers/misc/lis3lv02d/lis3lv02d_i2c.c            |   18 ++++++++++
 drivers/misc/lis3lv02d/lis3lv02d_spi.c            |    8 +++--
 6 files changed, 101 insertions(+), 9 deletions(-)

-- 
1.7.9.5
