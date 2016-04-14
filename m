From: jszhang@marvell.com (Jisheng Zhang)
Date: Thu, 14 Apr 2016 20:53:30 +0800
Subject: [PATCH 0/4] i2c: designware: runtime pm fix and improve
Message-ID: <1460638414-5987-1-git-send-email-jszhang@marvell.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This series tries to fix one hang issue during probe found on arm
platform, and unbalanced clk enable prepare issue. Then applies similar
change as commit 36d48fb5766a ("i2c: designware-platdrv: enable
RuntimePM before registering to the core"), lastly remove the runtime
suspend prevention in i2c_dw_probe().


Jisheng Zhang (4):
  i2c: designware-platdrv: Fix runtime PM initialization
  i2c: designware-platdrv: fix unbalanced clk enable and prepare
  i2c: designware-pcidrv: enable RuntimePM before registering to the
    core
  i2c: designware: remove runtime suspend prevention during registration

 drivers/i2c/busses/i2c-designware-core.c    |  8 --------
 drivers/i2c/busses/i2c-designware-pcidrv.c  | 11 +++++++----
 drivers/i2c/busses/i2c-designware-platdrv.c | 16 +++++++++++++++-
 3 files changed, 22 insertions(+), 13 deletions(-)

-- 
2.8.0.rc3
