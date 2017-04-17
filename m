From: hoegeun.kwon@samsung.com (Hoegeun Kwon)
Date: Mon, 17 Apr 2017 15:02:11 +0900
Subject: [PATCH v2 0/3] Add support for the S6E3HF2 panel on TM2e board
References: <CGME20170417060217epcas1p167d86ba0e12d461efbab67b0014fa1d2@epcas1p1.samsung.com>
Message-ID: <1492408934-22096-1-git-send-email-hoegeun.kwon@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi all,

First, thanks for Andrzej review.

The purpose of this patch is add support for s6e3hf2 AMOLED panel on
the TM2e board. The panel has 1600x2560 resolution in 5.65" physical
panel in the TM2e device.

The s6e3hf2 panel(5.65") is simliar to the previous s6e3ha2 panel(5.7"),
but resolution and some command message are different. So it can be
distinguished as a compatiblitiy string.

Best regards,
Hoegeun

Changes for V2:
- Add new compatible string to "samsung,s6e3ha2.txt binding with comments.
- Fix the panel name from s6e3ha2-e to s6e3hf2

Hoegeun Kwon (3):
  dt-bindings: Add support for samsung s6e3hf2 panel
  drm/panel: s6e3ha2: Add support for s6e3hf2 panel on TM2e board
  arm64: dts: exynos: Add support for s6e3hf2 panel device on TM2e board

 .../bindings/display/panel/samsung,s6e3ha2.txt     |  5 +-
 arch/arm64/boot/dts/exynos/exynos5433-tm2e.dts     | 12 ++++
 drivers/gpu/drm/panel/panel-samsung-s6e3ha2.c      | 64 +++++++++++++++++++---
 3 files changed, 73 insertions(+), 8 deletions(-)

-- 
1.9.1
