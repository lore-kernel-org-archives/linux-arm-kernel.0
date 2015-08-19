From: mpa@pengutronix.de (Markus Pargmann)
Date: Wed, 19 Aug 2015 12:18:29 +0200
Subject: [PATCH 0/3] gpiolib: Initializing GPIOs using DT property gpio-initval
Message-ID: <1439979512-3894-1-git-send-email-mpa@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

This series adds a gpio-initval property to the devicetree. It provides a way
to initialize GPIOs to a defined value.

The previous patch was '[PATCH v2] gpio: Allow hogged gpios to be requested'
which would have allowed to request hogged GPIOs. Linus suggested a separate DT
property as hogged gpios should not be requested.

There are 3 patches. The first two simplify the function gpiod_hog. The third
reuses the gpiod_hog()_code for a new gpiod_initialize() and adds the parsing
of the DT.

This series is based on the series
"[PATCH v3 0/9] gpiolib: Add GPIO name support".

Best regards,

Markus


Markus Pargmann (3):
  gpio: Use __gpiod_request directly
  gpiolib: gpiod_hog remove separate name argument
  gpiolib: Add GPIO initialization

 Documentation/devicetree/bindings/gpio/gpio.txt | 29 ++++++----
 drivers/gpio/gpiolib-of.c                       | 11 +++-
 drivers/gpio/gpiolib.c                          | 74 +++++++++++++++++--------
 drivers/gpio/gpiolib.h                          |  6 +-
 4 files changed, 83 insertions(+), 37 deletions(-)

-- 
2.4.6
