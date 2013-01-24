From: rachna@ti.com (Patil, Rachna)
Date: Thu, 24 Jan 2013 09:15:04 +0530
Subject: [PATCH v4 0/8] MFD: ti_am335x_tscadc: DT support and TSC features
 addition
Message-ID: <1358999112-31192-1-git-send-email-rachna@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: "Patil, Rachna" <rachna@ti.com>

This patch set is a cumulative set of [1] and [2] sent earlier.

Note that there are no code changes in either of the patch set,
only rebased on top of Linus's v3.8-rc3 tag to make sure that
all the patches apply without any conflicts.

This patch set has been tested on AM335x EVM.

[1] http://www.spinics.net/lists/linux-input/msg23060.html
[2] http://www.spinics.net/lists/linux-input/msg23090.html

Changes in v4:
	Subnodes and their properties documentation added.
	Non-standard properties prefixed with vendor name.

Changes in v3:
	No code change.

Changes in v2:
	Patch "input: ti_am335x_tsc: Add variance filter"
	from v1 has been dropped.
	Add MFD device DT node in AM335x EVM.

Patil, Rachna (8):
  input: ti_am335x_tsc: Step enable bits made configurable
  input: ti_am335x_tsc: Order of TSC wires, made configurable
  input: touchscreen: ti_tsc: remove unwanted fifo flush
  MFD: ti_am335x_tscadc: add device tree binding information
  MFD: ti_am335x_tscadc: Add DT support
  input: ti_am335x_tsc: Add DT support
  IIO: ti_am335x_adc: Add DT support
  arm/dts: AM335x-evm: Add TSC/ADC MFD device support

 .../devicetree/bindings/mfd/ti_am335x_tscadc.txt   |   52 ++++
 arch/arm/boot/dts/am335x-evm.dts                   |   13 +
 arch/arm/boot/dts/am33xx.dtsi                      |    8 +
 drivers/iio/adc/ti_am335x_adc.c                    |   26 +-
 drivers/input/touchscreen/ti_am335x_tsc.c          |  266 +++++++++++++++++---
 drivers/mfd/ti_am335x_tscadc.c                     |   28 ++-
 include/linux/input/ti_am335x_tsc.h                |   12 +
 include/linux/mfd/ti_am335x_tscadc.h               |   11 +-
 8 files changed, 364 insertions(+), 52 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/mfd/ti_am335x_tscadc.txt

-- 
1.7.9.5
