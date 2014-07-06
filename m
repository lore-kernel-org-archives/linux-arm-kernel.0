From: himangi774@gmail.com (Himangi Saraogi)
Date: Sun, 6 Jul 2014 23:16:09 +0530
Subject: [PATCH 0/5] Introduce a managed function for gpio_request_array
Message-ID: <cover.1404665589.git.himangi774@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patchset intoduces a new managed interface devm_gpio_request_array,
adds it in the documentation and its declaration in the gpio.h include
file. Some cases of gpio_request_array are changed to
devm_gpio_request_array.

Himangi Saraogi (5):
  gpiolib: devres: Introduce the function devm_request_gpio_array
  ASoC: wm1250-ev1: Use devm_gpio_request_array
  ASoC: pxa: Use devm_gpio_request_array
  ASoC: pxa: e800_wm9712: Introduce the use of devm_gpio_request_array
  ASoC: pxa/hx4700: Introduce the use of devm_gpio_request_array

 Documentation/driver-model/devres.txt |  1 +
 drivers/gpio/devres.c                 | 21 +++++++++++++++++++++
 include/linux/gpio.h                  |  2 ++
 sound/soc/codecs/wm1250-ev1.c         | 24 +++++-------------------
 sound/soc/pxa/e740_wm9705.c           |  9 +++------
 sound/soc/pxa/e800_wm9712.c           |  9 +++------
 sound/soc/pxa/hx4700.c                | 12 +++---------
 7 files changed, 38 insertions(+), 40 deletions(-)

-- 
1.9.1
