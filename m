From: bgolaszewski@baylibre.com (Bartosz Golaszewski)
Date: Wed,  4 Jan 2017 11:36:05 +0100
Subject: [PATCH 0/2] ARM: davinci: improve the nand clock lookup
Message-ID: <1483526167-24209-1-git-send-email-bgolaszewski@baylibre.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Sekhar,

this is a follow-up to the series fixing the da850 clocks.

Instead of having a half-measure of leaving out the dev_id from the
clock lookup table, make the aemif driver capable of accessing it
over platform data.

Tested with da850-lcdk.

Bartosz Golaszewski (2):
  memory: aemif: allow passing device lookup table as platform data
  ARM: da850: add the nand dev_id to the clock lookup table

 arch/arm/mach-davinci/da850.c          | 10 +---------
 arch/arm/mach-davinci/da8xx-dt.c       | 12 +++++++++++-
 drivers/memory/ti-aemif.c              |  8 +++++++-
 include/linux/platform_data/ti-aemif.h | 23 +++++++++++++++++++++++
 4 files changed, 42 insertions(+), 11 deletions(-)
 create mode 100644 include/linux/platform_data/ti-aemif.h

-- 
2.9.3
