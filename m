From: hoegeun.kwon@samsung.com (Hoegeun Kwon)
Date: Thu, 15 Jun 2017 19:03:26 +0900
Subject: [PATCH v2 0/4] Add support for the s6e63j0x03 panel on Rinato board
References: <CGME20170615100341epcas5p18affc41c65c13d0daac005290cf1d249@epcas5p1.samsung.com>
Message-ID: <1497521010-8429-1-git-send-email-hoegeun.kwon@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi all,

The purpose of this patch is add support for s6e63j0x03 AMOLED panel
on the rinato board(Samsung Galaxy Gear 2).

Changes for V2:
- Added the interface info in binding document.
- Added Reviewed-by: Andrzej Hajda <a.hajda@samsung.com> (1/3 patch).
- Added Acked-by: Rob Herring <robh@kernel.org> (1/3 patch).
- Fixed the tristate of config from video mode to command mode.
- Fixed the reset gpios from active high to low from rinato dts.
- Fixed a lot of things in panel driver, reflect Andrzej's review.

Best regards,
Hoegeun

Hoegeun Kwon (4):
  dt-bindings: Add support for samsung s6e63j0x03 panel binding
  drm/panel: Add support for s6e63j0x03 panel driver
  ARM: dts: exynos: Fix the active of reset gpios from rinato dts
  ARM: dts: exynos: Remove the display-timing and delay from rinato dts

 .../bindings/display/panel/samsung,s6e63j0x03.txt  |  24 ++
 arch/arm/boot/dts/exynos3250-rinato.dts            |  24 +-
 drivers/gpu/drm/panel/Kconfig                      |   7 +
 drivers/gpu/drm/panel/Makefile                     |   1 +
 drivers/gpu/drm/panel/panel-samsung-s6e63j0x03.c   | 476 +++++++++++++++++++++
 5 files changed, 509 insertions(+), 23 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/display/panel/samsung,s6e63j0x03.txt
 create mode 100644 drivers/gpu/drm/panel/panel-samsung-s6e63j0x03.c

-- 
1.9.1
