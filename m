From: hayashi.kunihiko@socionext.com (Kunihiko Hayashi)
Date: Fri,  9 Nov 2018 10:42:03 +0900
Subject: [PATCH 0/4] reset: uniphier: Rename from USB3 reset to glue reset and
 add AHCI reset support
Message-ID: <1541727727-10821-1-git-send-email-hayashi.kunihiko@socionext.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This series renames the reset control of core reset included in USB3 glue
layer with in the glue layer for generic peripherals to allow other devices
to use it.

And this series adds support for the core reset included in AHCI glue layer.

Kunihiko Hayashi (4):
  dt-bindings: reset: uniphier: Replace the expression of USB3 with
    generic peripherals
  reset: uniphier-usb3: Rename to reset-uniphier-glue
  dt-bindings: reset: uniphier: Add AHCI core reset description
  reset: uniphier-glue: Add AHCI reset control support in glue layer

 .../devicetree/bindings/reset/uniphier-reset.txt   |  25 +--
 drivers/reset/Kconfig                              |  10 +-
 drivers/reset/Makefile                             |   2 +-
 drivers/reset/reset-uniphier-glue.c                | 183 +++++++++++++++++++++
 drivers/reset/reset-uniphier-usb3.c                | 171 -------------------
 5 files changed, 203 insertions(+), 188 deletions(-)
 create mode 100644 drivers/reset/reset-uniphier-glue.c
 delete mode 100644 drivers/reset/reset-uniphier-usb3.c

-- 
2.7.4
