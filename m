From: dianders@chromium.org (Doug Anderson)
Date: Tue, 12 Aug 2014 16:21:12 -0700
Subject: [PATCH v4 0/2] Add eMMC and SD card support for rk3288-evb
Message-ID: <1407885674-16469-1-git-send-email-dianders@chromium.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This series adds basic eMMC and SD card support for the rk3288-evb
board based on Addy's dw_mmc patch.

Note that we don't have regulators specified yet (no regulator driver
for rk808-based board).  We also don't yet support UHS modes or MMC
DDR50 (which require regulator support plus dw_mmc driver support for
tuning).  Those features can come later.

Changes in v4:
- Add status="disabled".
- Squash patch #1 and #4 since Jaehoon's patch landed.
- Squashed patches #2 and #3 since Jaehoon's patch landed.

Changes in v3:
- Removed DDR50 mode since it needs tuning, which isn't there yet.

Changes in v2:
- Refer to the new title of Jaehoon's patch
- New patchwork link for Addy's patch
- Squashed in the DDR50 mode since Addy spun his patch.

Doug Anderson (2):
  ARM: dts: Add emmc and sdmmc to the rk3288 device tree
  ARM: dts: Enable emmc and sdmmc on the rk3288-evb boards

 arch/arm/boot/dts/rk3288-evb.dtsi | 24 ++++++++++++++++++++++++
 arch/arm/boot/dts/rk3288.dtsi     | 20 ++++++++++++++++++++
 2 files changed, 44 insertions(+)

-- 
2.1.0.rc2.206.gedb03e5
