From: mpa@pengutronix.de (Markus Pargmann)
Date: Sun, 30 Aug 2015 09:44:43 +0200
Subject: [PATCH v2 0/3] gpiolib: Initializing GPIOs using DT property
 gpio-initval
Message-ID: <1440920686-6892-1-git-send-email-mpa@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

This is basically a resend with the devicetree mailinglist added to CC.

This series adds a gpio-initval property to the devicetree. It provides a way
to initialize GPIOs to a defined value.

There are 3 patches. The first two simplify the function gpiod_hog. The third
reuses the gpiod_hog()_code for a new gpiod_initialize() and adds the parsing
of the DT.

This series is based on the series
"[PATCH v3 0/9] gpiolib: Add GPIO name support".

Best regards,

Markus


Changes in v2:
 - Fixed Signed-off-by/author


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
2.5.0
