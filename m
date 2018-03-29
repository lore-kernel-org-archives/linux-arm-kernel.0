From: wens@csie.org (Chen-Yu Tsai)
Date: Thu, 29 Mar 2018 12:31:12 +0800
Subject: [PATCH 0/3] mfd: axp20x: driver cleanup
Message-ID: <20180329043115.7132-1-wens@csie.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Lee,

Here are some cleanup patches for the axp20x mfd driver.

Patch 1 const-ifies all the struct mfd_cell and struct resource
instances found throughout the driver. Not sure why they weren't
set to const before.

Patch 2 replaces all the openly declared interrupt resources with
nice to read one-line DEFINE_RES_IRQ macros.

Patch 3 corrects the prefix for four of the AXP806 interrupt enums.
"POK" was incorrectly expanded to "PWROK".

These are all simple cleanups. No functionality is changed.

Regards
ChenYu

Chen-Yu Tsai (3):
  mfd: axp20x: Const-ify struct mfd_cell and struct resource
  mfd: axp20x: Use DEFINE_RES_IRQ to declare resources for mfd_cells
  mfd: axp20x: Correct AXP806 POK interrupt prefix

 drivers/mfd/axp20x.c       | 239 +++++++++++----------------------------------
 include/linux/mfd/axp20x.h |  10 +-
 2 files changed, 61 insertions(+), 188 deletions(-)

-- 
2.16.3
