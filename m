From: narmstrong@baylibre.com (Neil Armstrong)
Date: Wed,  5 Oct 2016 17:27:07 +0200
Subject: [RESEND PATCH v2 0/3] 
Message-ID: <20161005152710.2898-1-narmstrong@baylibre.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This is a resend of v2 with the actual changes on patch number 3.

This patchset adds support for the reset controller in the Oxford
Semiconductor OX820 SoC, big brother of the OX810SE.

Since this driver uses a regmap access, it's important to tag each
compatible SoC since the regmap offset could differ in later SoCs.

This patchet also moves the reset indices to a clean DT include file.


Changes since v1 at: http://lkml.kernel.org/r/20160909131955.27334-1-narmstrong at baylibre.com
 - Reformat bindings
 - Add reference to include files in bindings

Neil Armstrong (3):
  reset: oxnas: Add OX820 support
  dt-bindings: reset: oxnas: Add include file with reset indexes
  dt-bindings: reset: oxnas: Update for OX820

 .../devicetree/bindings/reset/oxnas,reset.txt      | 44 ++++--------------
 drivers/reset/reset-oxnas.c                        |  1 +
 include/dt-bindings/reset/oxsemi,ox810se.h         | 53 ++++++++++++++++++++++
 include/dt-bindings/reset/oxsemi,ox820.h           | 53 ++++++++++++++++++++++
 4 files changed, 116 insertions(+), 35 deletions(-)
 create mode 100644 include/dt-bindings/reset/oxsemi,ox810se.h
 create mode 100644 include/dt-bindings/reset/oxsemi,ox820.h

-- 
2.7.0
