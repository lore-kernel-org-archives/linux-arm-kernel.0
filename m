From: wens@csie.org (Chen-Yu Tsai)
Date: Thu,  2 Feb 2017 00:25:45 +0800
Subject: [PATCH 0/2] pinctrl: sunxi: Merge A31s pinctrl driver with A31
Message-ID: <20170201162547.24232-1-wens@csie.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi everyone,

This series merges support for the A31s' pin controller into the A31
driver, using the new sunxi variants support code. The A31s is a trimmed
down version of the A31, with some hardware blocks removed, and some
pin functions or pins removed. Thus it is easy to support the A31s
using the A31 driver by marking the extra pins/functions as A31 only.

Patch 1 does exactly this.

Patch 2 removes the original A31s driver, which is now redundant.

I opted not to rename sun6i-a31 to sun6i in various places.


Regards
ChenYu


Chen-Yu Tsai (2):
  pinctrl: sunxi: Support A31/A31s with pinctrl variants
  pinctrl: sunxi: Remove redundant A31s pinctrl driver

 drivers/pinctrl/sunxi/Kconfig              |   4 -
 drivers/pinctrl/sunxi/Makefile             |   1 -
 drivers/pinctrl/sunxi/pinctrl-sun6i-a31.c  | 184 ++++---
 drivers/pinctrl/sunxi/pinctrl-sun6i-a31s.c | 809 -----------------------------
 drivers/pinctrl/sunxi/pinctrl-sunxi.h      |   2 +
 5 files changed, 121 insertions(+), 879 deletions(-)
 delete mode 100644 drivers/pinctrl/sunxi/pinctrl-sun6i-a31s.c

-- 
2.11.0
