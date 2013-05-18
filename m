From: linux@prisktech.co.nz (Tony Prisk)
Date: Sat, 18 May 2013 21:15:10 +1200
Subject: [PATCH 0/4] FB updates for 3.11
Message-ID: <1368868514-18975-1-git-send-email-linux@prisktech.co.nz>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Patch #1 - Move register defines inside the driver and drop the header.
Patch #2 - Convert the register defines to use the vendor preferred names.
Patch #3 - Add a device clock to wm8505fb. Without it, only the uboot
initialized resolution is supported.
Patch #4 - Add support for the VGA output found on the APC8750 board.

Tony Prisk (4):
  fb: vt8500: Move register defines inside driver
  fb: vt8500: Convert to use vendor register names
  fb: vt8500: Require a device clock for wm8505fb driver
  fb: vt8500: Add VGA output support to wm8505fb driver.

 .../devicetree/bindings/video/wm,wm8505-fb.txt     |    9 +-
 drivers/video/wm8505fb.c                           |  195 ++++++++++++--
 drivers/video/wm8505fb_regs.h                      |   76 ------
 drivers/video/wmt_ge_rops.c                        |  280 +++++++++++++++-----
 4 files changed, 394 insertions(+), 166 deletions(-)
 delete mode 100644 drivers/video/wm8505fb_regs.h

-- 
1.7.9.5
