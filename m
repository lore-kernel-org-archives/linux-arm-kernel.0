From: dianders@chromium.org (Doug Anderson)
Date: Thu, 31 Jul 2014 09:13:16 -0700
Subject: [PATCH v2 0/4] Add eMMC and SD card support for rk3288-evb
Message-ID: <1406823200-20911-1-git-send-email-dianders@chromium.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This series adds basic eMMC and SD card support for the rk3288-evb
board based on Addy's posted dw_mmc patch from:
  https://patchwork.kernel.org/patch/4653631/

The series is a little tricky because:
* Jaehoon has some outstanding patches to remove the slot node.  Since
  those haven't landed yet, I've posted my original patch with the
  slot node and then some future patches that can land with Jaehoon's
  patches.

So just to be explicit:
- Patch #1 and #2 can land after Addy's patch lands.
- Patch #3 and #4 can land after Jaehoon's patch lands, though there's
  no huge hurry since Jaehoon's patch supports the old mode (it just
  prints a warning).

Note that we don't have regulators specified yet (no regulator driver
for rk808-based board).  We also don't yet support UHS modes (which
require regulator support plus dw_mmc driver support for tuning).
Those features can come later.

Changes in v2:
- New patchwork link for Addy's patch
- Squashed in the DDR50 mode since Addy spun his patch.
- Refer to the new title of Jaehoon's patch

Doug Anderson (4):
  ARM: dts: Add emmc and sdmmc to the rk3288 device tree
  ARM: dts: Enable emmc and sdmmc on the rk3288-evb boards
  ARM: dts: Take the mmc slot node out of rk3288-evb
  ARM: dts: mmc slot node gone on rk3288 => no more address / size cells

 arch/arm/boot/dts/rk3288-evb.dtsi | 25 +++++++++++++++++++++++++
 arch/arm/boot/dts/rk3288.dtsi     | 18 ++++++++++++++++++
 2 files changed, 43 insertions(+)

-- 
2.0.0.526.g5318336
