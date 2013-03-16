From: lokeshvutla@ti.com (Lokesh Vutla)
Date: Sat, 16 Mar 2013 11:46:40 +0530
Subject: [PATCH V2 0/8] memory: emif: miscellaneous bug fixes for EMIF driver
Message-ID: <1363414608-7448-1-git-send-email-lokeshvutla@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This series resolves a few minor issues for EMIF driver.

Tested all patches on OMAP4430-sdp.
Patch : "memory: emif: setup LP settings on freq update"
is tested on a local tree, since freq update cannot be
tested on mainline.

Ambresh K (1):
  memory: emif: setup LP settings on freq update

Grygorii Strashko (1):
  memory: emif: errata i743: Prohibit usage of Power-Down mode

Lokesh Vutla (2):
  memory: emif: Fix the lpmode timeout calculation
  memory: emif: Load the correct custom config values from dt

Nishanth Menon (3):
  memory: emif: handle overflow for timing for LP mode
  memory: emif: Handle devices which are not rated for >85C
  memory: emif: use restart if power_off not present when out of spec

Oleksandr Dmytryshyn (1):
  memory: emif: Fix the incorrect 'size' parameter in memcpy

 drivers/memory/emif.c                   |  129 +++++++++++++++++++++++++++----
 include/linux/platform_data/emif_plat.h |    1 +
 2 files changed, 114 insertions(+), 16 deletions(-)

-- 
1.7.9.5
