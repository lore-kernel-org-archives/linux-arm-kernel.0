From: dianders@chromium.org (Doug Anderson)
Date: Tue, 29 Jul 2014 13:31:51 -0700
Subject: [PATCH 0/5] Add eMMC and SD card support for rk3288-evb
Message-ID: <1406665916-23396-1-git-send-email-dianders@chromium.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This series adds basic eMMC and SD card support for the rk3288-evb
board based on Addy's posted dw_mmc patch from:
  https://patchwork.kernel.org/patch/4520631/

The series is a little tricky because:
* Addy's patch has a bug w/ DDR50 (see my response there), so I've
  posted the original support without DDR50 and then a fix (that could
  be squashed) enabling DDR50.
* Jaehoon has some outstanding patches to remove the slot node.  Since
  those haven't landed yet, I've posted my original patch with the
  slot node and then some future patches that can land with Jaehoon's
  patches.

Note that we don't have regulators specified yet (no regulator driver
for rk808-based board).  We also don't yet support UHS modes (which
require regulator support plus dw_mmc driver support for tuning).
Those features can come later.


Doug Anderson (5):
  ARM: dts: Add emmc and sdmmc to the rk3288 device tree
  ARM: dts: Enable emmc and sdmmc on the rk3288-evb boards
  ARM: dts: Enable DDR50 mode on the eMMC
  ARM: dts: Take the mmc slot node out of rk3288-evb
  ARM: dts: mmc slot node gone on rk3288 => no more address / size cells

 arch/arm/boot/dts/rk3288-evb.dtsi | 25 +++++++++++++++++++++++++
 arch/arm/boot/dts/rk3288.dtsi     | 18 ++++++++++++++++++
 2 files changed, 43 insertions(+)

-- 
2.0.0.526.g5318336
