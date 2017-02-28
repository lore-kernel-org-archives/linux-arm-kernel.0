From: bgolaszewski@baylibre.com (Bartosz Golaszewski)
Date: Tue, 28 Feb 2017 17:01:54 +0100
Subject: [PATCH v4 0/6] ARM: davinci: vpif capture & display support
Message-ID: <1488297720-4558-1-git-send-email-bgolaszewski@baylibre.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This series adds pdata quirks and other changes required to make vpif
work on the da850-evm board.

v1 -> v2:
- added patch 1/5 - don't bail-out from pdata_quirks_check() after
  applying a single quirk
- changed the comment above the new fixed regulator to make it more
  descriptive
- removed unnecessary #ifdefs from pdata-quirks.c

v2 -> v3:
- added patch 6/6: add enable GPIOs to pdata-quirks - this is needed
  because vpif gets its resources from pdata-quirks instead of the
  device tree

v3 -> v4:
- removed patch 6/6 - it may take some more time to determine the
  correct solution for enable-gpios, so I decided to respin the
  series without it and send it later as a follow-up
- split the pdata-quirks patch for vpif capture into two separate
  patches: one adding the OF_DEV_AUXDATA() and one adding the actual
  quirks
- split the vpif capture registration into two functions to avoid
  redundant ifs

Bartosz Golaszewski (3):
  ARM: davinci: da8xx: allow having multiple pdata-quirks
  ARM: da850-evm: add a fixed regulator for the UI board IO expander
  ARM: davinci: add pdata-quirks for da850-evm vpif display

Kevin Hilman (3):
  ARM: davinci: board-da850-evm: add I2C ID for VPIF
  ARM: davinci: da8xx: add OF_DEV_AUXDATA() for vpif
  ARM: davinci: da8xx: add pdata-quirks for VPIF capture

 arch/arm/mach-davinci/board-da850-evm.c |   4 +
 arch/arm/mach-davinci/da8xx-dt.c        |   1 +
 arch/arm/mach-davinci/pdata-quirks.c    | 178 +++++++++++++++++++++++++++++++-
 3 files changed, 182 insertions(+), 1 deletion(-)

-- 
2.9.3
