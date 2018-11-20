From: fabrice.gasnier@st.com (Fabrice Gasnier)
Date: Tue, 20 Nov 2018 11:12:29 +0100
Subject: [PATCH 0/3] iio: stm32-adc: add PM support
Message-ID: <1542708752-26163-1-git-send-email-fabrice.gasnier@st.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patch series adds support for power management to stm32-adc iio driver.
It slighlty reworks regulator and clock handling, to move them in dedicated
routines. Then these routines can be called from probe/remove and PM callbacks.
It also takes care of running ADC when going to low power mode.

Fabrice Gasnier (3):
  iio: adc: stm32-adc: move self-calibration to prepare routine
  iio: adc: stm32-adc: add power management support
  iio: adc: stm32-adc: switch off running adc when going to low power

 drivers/iio/adc/stm32-adc-core.c | 182 +++++++++++++++--------
 drivers/iio/adc/stm32-adc.c      | 303 ++++++++++++++++++++++++++++-----------
 2 files changed, 343 insertions(+), 142 deletions(-)

-- 
1.9.1
