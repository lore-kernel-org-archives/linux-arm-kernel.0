From: narmstrong@baylibre.com (Neil Armstrong)
Date: Fri,  9 Sep 2016 15:19:52 +0200
Subject: [PATCH 0/3] reset: Add support for OX820 SoC
Message-ID: <20160909131955.27334-1-narmstrong@baylibre.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patchset adds support for the reset controller in the Oxford
Semiconductor OX820 SoC, big brother of the OX810SE.

Since this driver uses a regmap access, it's important to tag each
compatible SoC since the regmap offset could differ in later SoCs.

This patchet also moves the reset indices to a clean DT include file.

Neil Armstrong (3):
  reset: oxnas: Add OX820 support
  dt-bindings: reset: oxnas: Add include file with reset indexes
  dt-bindings: reset: oxnas: Update for OX820

 .../devicetree/bindings/reset/oxnas,reset.txt      | 39 ++--------------
 drivers/reset/reset-oxnas.c                        |  1 +
 include/dt-bindings/reset/oxsemi,ox810se.h         | 53 ++++++++++++++++++++++
 include/dt-bindings/reset/oxsemi,ox820.h           | 53 ++++++++++++++++++++++
 4 files changed, 110 insertions(+), 36 deletions(-)
 create mode 100644 include/dt-bindings/reset/oxsemi,ox810se.h
 create mode 100644 include/dt-bindings/reset/oxsemi,ox820.h

-- 
2.7.0
