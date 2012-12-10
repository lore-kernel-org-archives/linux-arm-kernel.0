From: lokeshvutla@ti.com (Lokesh Vutla)
Date: Mon, 10 Dec 2012 12:39:09 +0530
Subject: [PATCH 0/9] memory: emif: miscellaneous bug fixes for EMIF driver
Message-ID: <1355123358-5273-1-git-send-email-lokeshvutla@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This series resolves a few minor issues for EMIF driver.

Tested all the patches on OMAP4-sdp, OMAP5-sevm.
Patch : "memory: emif: setup LP settings on freq update"
is tested on a local tree, since freq update cannot be
tested on mainline.

Ambresh K (1):
  memory: emif: use default custom config parameter.

Lokesh Vutla (1):
  memory: emif: Correct the lpmode timeout calculation

Nishanth Menon (5):
  memory: emif: setup LP settings on freq update
  memory: emif: handle overflow for timing for LP mode
  memory: emif: Handle devices which are not rated for >85C
  memory: emif: use restart if power_off not present when out of spec
  memory: emif: disable phy_fast_dll_lock

Oleksandr Dmytryshyn (1):
  memory: emif: fix timings initialization issue

Severine Glock (1):
  memory: emif: debugfs: Remove MR4= string print

 drivers/memory/emif.c                   |   92 +++++++++++++++++++++++++------
 drivers/memory/emif.h                   |    2 +-
 include/linux/platform_data/emif_plat.h |    1 +
 3 files changed, 78 insertions(+), 17 deletions(-)

-- 
1.7.9.5
