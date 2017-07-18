From: fabrice.gasnier@st.com (Fabrice Gasnier)
Date: Tue, 18 Jul 2017 14:35:29 +0200
Subject: [PATCH 0/3] Allow to tune sampling time on STM32 ADC
Message-ID: <1500381332-17086-1-git-send-email-fabrice.gasnier@st.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

STM32 ADC allows each channel to be sampled with a different sampling
time. This series fixes common clock rate and adds optional device
tree property, so minimum sampling time can be tuned. This is done via
device tree as it's tightly coupled with hardware (analog source).

Fabrice Gasnier (3):
  iio: adc: stm32: fix common clock rate
  dt-bindings: iio: adc: stm32: add optional min-sample-time
  iio: adc: stm32: add optional min-sample-time

 .../devicetree/bindings/iio/adc/st,stm32-adc.txt   |   5 +
 drivers/iio/adc/stm32-adc-core.c                   |  10 +-
 drivers/iio/adc/stm32-adc.c                        | 134 ++++++++++++++++++++-
 3 files changed, 140 insertions(+), 9 deletions(-)

-- 
1.9.1
