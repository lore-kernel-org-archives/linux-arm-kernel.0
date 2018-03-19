From: brgl@bgdev.pl (Bartosz Golaszewski)
Date: Mon, 19 Mar 2018 16:33:10 +0100
Subject: [PATCH v2 0/4] ARM: davinci: remove the mach-specific aemif driver -
 part 1
Message-ID: <20180319153314.26120-1-brgl@bgdev.pl>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Bartosz Golaszewski <bgolaszewski@baylibre.com>

This is the first part of changes required to remove duplicate aemif
support from mach-davinci.

I actually noticed that one of my previous changes from 2017 broke nand
in legacy mode - the clock lookup no longer works. This series addresses
it as well.

First patch just uses a static string for the ti-aemif driver name.

The second adds support for board files to the aemif driver.

Last two add nand support to da850-lcdk in legacy mode and make
da850-evm use the platform driver instead of the mach-specific one.

If these patches get accepted, I'll prepere a follow-up moving all
other boards to the new platform driver.

This series applies on top of v8 of David Lechner's CCF series.

v1 -> v2:
- drop the first two patches, which are no longer needed with David's
  psc driver

Bartosz Golaszewski (4):
  memory: aemif: don't rely on kbuild for driver's name
  memory: aemif: add support for board files
  ARM: davinci: add aemif & nand support to da850-lcdk in legacy mode
  ARM: davinci: use aemif platform driver in legacy mode for da850-evm

 arch/arm/mach-davinci/board-da850-evm.c     |  93 +++++++++++---------
 arch/arm/mach-davinci/board-omapl138-hawk.c | 132 ++++++++++++++++++++++++++++
 drivers/memory/ti-aemif.c                   |  59 ++++++++-----
 include/linux/platform_data/ti-aemif.h      |   9 ++
 4 files changed, 230 insertions(+), 63 deletions(-)

-- 
2.16.1
