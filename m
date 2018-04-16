From: fabrice.gasnier@st.com (Fabrice Gasnier)
Date: Mon, 16 Apr 2018 18:19:15 +0200
Subject: [PATCH v4 0/6] Add support for PWM input capture on STM32
Message-ID: <1523895561-4073-1-git-send-email-fabrice.gasnier@st.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This series adds support for capture to stm32-pwm driver.
Capture is based on DMAs.
- First two patches add support for requesting DMAs to MFD core
- Next three patches add support for capture to stm32-pwm driver
- This has been tested on stm32429i-eval board.

---
Changes in v4:
- Lee's comments on patch 2 (mfd: stm32-timers: add support for dmas)
  Add kerneldoc header, better format comments.

Changes in v3:
- Dropped 2 precusor patches applied by Thierry in pwm tree:
  "pwm: stm32: fix, remove unused struct device"
  "pwm: stm32: protect common prescaler for all channels"
- Note: this series applies on top on pwm tree
- Implements Lee's comments on MFD part: rework stm32_timers_dma struct,
  exported routine prototype now use generic device struct, more
  various comments (see patch 2 changelog).

Resend v2:
- Add collected Acks

Changes in v2:
- Abstract DMA handling from child driver: move it to MFD core
- Rework pwm capture routines to adopt this change
- Comment on optional dma support, beautify DMAs probe

Fabrice Gasnier (6):
  dt-bindings: mfd: stm32-timers: add support for dmas
  mfd: stm32-timers: add support for dmas
  pwm: stm32: add capture support
  pwm: stm32: improve capture by tuning counter prescaler
  pwm: stm32: use input prescaler to improve period capture
  ARM: dts: stm32: Enable pwm3 input capture on stm32f429i-eval

 .../devicetree/bindings/mfd/stm32-timers.txt       |  20 ++
 arch/arm/boot/dts/stm32429i-eval.dts               |   3 +
 drivers/mfd/stm32-timers.c                         | 227 +++++++++++++++++-
 drivers/pwm/pwm-stm32.c                            | 257 +++++++++++++++++++++
 include/linux/mfd/stm32-timers.h                   |  44 ++++
 5 files changed, 549 insertions(+), 2 deletions(-)

-- 
1.9.1
