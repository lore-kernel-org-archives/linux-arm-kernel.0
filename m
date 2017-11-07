From: yixun.lan@amlogic.com (Yixun Lan)
Date: Tue, 7 Nov 2017 13:36:46 +0800
Subject: [PATCH v3 0/4] fix the clock setting for SAR ADC
Message-ID: <20171107053646.31087-1-yixun.lan@amlogic.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

patch [1/4]:
  Fix wrong SARADC/SANA clock gate bit in Meson-GXBB/GXL,
the published datasheet also has wrong description about this.

patch [2-4/4]:
  Drop the "sana" clock from SAR ADC module,

  From the hardware perspective, the SAR ADC module doesn't
require "sana" clock to wrok. This should apply to all SoC,
including meson6,8, GXBB, GXL..

Note: the whole patchset series has been tested at GXL-P212 board,
we haven't got any meson6,8 board to test, so I would appreciate
if someone (Martin?) could help to confirm it works there.
 
Changes since v2 at [2] :
  - explicitly point out 'sana' clock is not required for saradc, and drop them
  - update comments, as the published datasheet is wrong
 
Changes since v1 at [1] :
  - correct SAR ADC/SANA clock gate bit

[1] http://lists.infradead.org/pipermail/linux-amlogic/2017-November/005221.html
[2] http://lists.infradead.org/pipermail/linux-amlogic/2017-November/005242.html


Xingyu Chen (3):
  iio: adc: meson-saradc: remove irrelevant clock "sana"
  dt-bindings: iio: adc: update the doc for SAR ADC
  ARM64: dts: meson: drop "sana" clock from SAR ADC

Yixun Lan (1):
  clk: meson: gxbb: fix wrong clock for SARADC/SANA

 .../bindings/iio/adc/amlogic,meson-saradc.txt        |  1 -
 arch/arm/boot/dts/meson8.dtsi                        |  5 ++---
 arch/arm/boot/dts/meson8b.dtsi                       |  5 ++---
 arch/arm64/boot/dts/amlogic/meson-gxbb.dtsi          |  3 +--
 arch/arm64/boot/dts/amlogic/meson-gxl.dtsi           |  3 +--
 drivers/clk/meson/gxbb.c                             |  4 ++--
 drivers/iio/adc/meson_saradc.c                       | 20 --------------------
 7 files changed, 8 insertions(+), 33 deletions(-)

-- 
2.14.1
