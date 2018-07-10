From: hayashi.kunihiko@socionext.com (Kunihiko Hayashi)
Date: Tue, 10 Jul 2018 10:14:15 +0900
Subject: [PATCH v2 0/2]  reset: uniphier: add USB3 core reset support
Message-ID: <1531185257-16444-1-git-send-email-hayashi.kunihiko@socionext.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This series add new USB3 core reset control support for UniPhier SoCs.
This reset line belongs to USB3 glue layer.

Changes since v1:
- dt-bindings: fix a typo, not "clock-names" but "reset-names"
- dt-bindings: add description of glue layer
- reuse soc_data for pxs2, ld20 and pxs3
- put reset_simple_data into uniphier_usb3_reset_priv
- replace clk operations with clk_bulk
- move nclks and nrsts to soc_data
- rewrite a header with C++ comment style
- change the subject 'USB3 controller reset' to 'USB3 core reset'

Kunihiko Hayashi (2):
  dt-bindings: reset: uniphier: add USB3 core reset support
  reset: uniphier: add USB3 core reset control

 .../devicetree/bindings/reset/uniphier-reset.txt   |  56 +++++++
 drivers/reset/Kconfig                              |  10 ++
 drivers/reset/Makefile                             |   1 +
 drivers/reset/reset-uniphier-usb3.c                | 171 +++++++++++++++++++++
 4 files changed, 238 insertions(+)
 create mode 100644 drivers/reset/reset-uniphier-usb3.c

-- 
2.7.4
