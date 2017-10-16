From: linus.walleij@linaro.org (Linus Walleij)
Date: Mon, 16 Oct 2017 21:41:01 +0200
Subject: [PATCH 0/5 v2] watchdog: consolidate FTWDT010 derivatives
Message-ID: <20171016194106.3995-1-linus.walleij@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This cuts off the consolidation of MOXA ART and Aspeed for
the time being, simply renaming the Gemini version into
"ftwdt010" so we can work from that point.

I have sent patches updating the MOXA ART and Aspeed device
trees but they may not go into v4.15 so taking it a bit
easy.

This is a good first step.

Linus Walleij (5):
  watchdog: gemini/ftwdt010: rename DT bindings
  watchdog: gemini/ftwdt010: rename driver and symbols
  watchdog: ftwdt010: Make interrupt optional
  watchdog: ftwdt010: Add clock support
  watchdog: ftwdt010: Add restart support

 .../bindings/watchdog/cortina,gemini-watchdog.txt  |  17 --
 ...ina,gemin-watchdog.txt => faraday,ftwdt010.txt} |  11 +-
 drivers/watchdog/Kconfig                           |  15 +-
 drivers/watchdog/Makefile                          |   2 +-
 drivers/watchdog/ftwdt010_wdt.c                    | 315 +++++++++++++++++++++
 drivers/watchdog/gemini_wdt.c                      | 229 ---------------
 6 files changed, 333 insertions(+), 256 deletions(-)
 delete mode 100644 Documentation/devicetree/bindings/watchdog/cortina,gemini-watchdog.txt
 rename Documentation/devicetree/bindings/watchdog/{cortina,gemin-watchdog.txt => faraday,ftwdt010.txt} (55%)
 create mode 100644 drivers/watchdog/ftwdt010_wdt.c
 delete mode 100644 drivers/watchdog/gemini_wdt.c

-- 
2.13.6
