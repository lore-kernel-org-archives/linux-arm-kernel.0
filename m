From: fabrice.gasnier@st.com (Fabrice Gasnier)
Date: Fri, 26 Jan 2018 16:11:31 +0100
Subject: [PATCH v2 0/8] Add support for PWM input capture on STM32
Message-ID: <1516979499-3665-1-git-send-email-fabrice.gasnier@st.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This series adds support for capture to stm32-pwm driver.
Capture is based on DMAs.
- First two patches are precursor patches
- Subsequent two patches add support for requesting DMAs to MFD core
- Next three patches add support for capture to stm32-pwm driver
- This has been tested on stm32429i-eval board.

---
Changes in v2:
- Abstract DMA handling from child driver: move it to MFD core
- Rework pwm capture routines to adopt this change
- Comment on optional dma support, beautify DMAs probe

Fabrice Gasnier (8):
  pwm: stm32: fix, remove unused struct device
  pwm: stm32: protect common prescaler for all channels
  dt-bindings: mfd: stm32-timers: add support for dmas
  mfd: stm32-timers: add support for dmas
  pwm: stm32: add capture support
  pwm: stm32: improve capture by tuning counter prescaler
  pwm: stm32: use input prescaler to improve period capture
  ARM: dts: stm32: Enable pwm3 input capture on stm32f429i-eval

 .../devicetree/bindings/mfd/stm32-timers.txt       |  20 ++
 arch/arm/boot/dts/stm32429i-eval.dts               |   3 +
 drivers/mfd/stm32-timers.c                         | 215 +++++++++++++++-
 drivers/pwm/pwm-stm32.c                            | 276 ++++++++++++++++++++-
 include/linux/mfd/stm32-timers.h                   |  39 +++
 5 files changed, 547 insertions(+), 6 deletions(-)

-- 
1.9.1
