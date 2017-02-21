From: bgolaszewski@baylibre.com (Bartosz Golaszewski)
Date: Tue, 21 Feb 2017 16:49:27 +0100
Subject: [PATCH v2 0/5] ARM: davinci: vpif capture & display support
Message-ID: <1487692172-11772-1-git-send-email-bgolaszewski@baylibre.com>
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

Bartosz Golaszewski (3):
  ARM: davinci: da8xx: allow having multiple pdata-quirks
  ARM: da850-evm: add a fixed regulator for the UI board IO expander
  ARM: davinci: add pdata-quirks for da850-evm vpif display

Kevin Hilman (2):
  ARM: davinci: board-da850-evm: add I2C ID for VPIF
  ARM: davinci: da8xx: add pdata-quirks for VPIF capture

 arch/arm/mach-davinci/board-da850-evm.c |   4 +
 arch/arm/mach-davinci/da8xx-dt.c        |   1 +
 arch/arm/mach-davinci/pdata-quirks.c    | 171 +++++++++++++++++++++++++++++++-
 3 files changed, 175 insertions(+), 1 deletion(-)

-- 
2.9.3
