From: wens@csie.org (Chen-Yu Tsai)
Date: Tue, 19 Aug 2014 00:51:49 +0800
Subject: [PATCH v2 0/2] ARM: sun8i: Enable pinctrl, i2c and mmc
Message-ID: <1408380711-26308-1-git-send-email-wens@csie.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Maxime,

This is v2 of the remaining sun8i series. I've dropped the patches you
merged. The remaining patches have been rebased onto sunxi-next.

This series enables all the controllers on sun8i that we already have
drivers for, excluding SPI as the tablet I have does not use it and
I cannot test it. If there's a way to test it without external connections
or devices please let me know.

The commit logs pretty much explain themselves. Note that PLL6 is not
implemented yet. I've some patches for the clocks that I will send later.


Cheers
ChenYu


Changes since v1:

  - Removed clock-frequency from i2c controller nodes, as they match
    the default value.
  - Dropped patches that were merged in v1.
  - Rebased onto sunxi-next.


Chen-Yu Tsai (2):
  ARM: dts: sun8i: Add i2c controller nodes
  ARM: dts: sun8i: Enable i2c controllers on ippo-q8h-v5

 arch/arm/boot/dts/sun8i-a23-ippo-q8h-v5.dts | 19 +++++++++++++++++
 arch/arm/boot/dts/sun8i-a23.dtsi            | 33 +++++++++++++++++++++++++++++
 2 files changed, 52 insertions(+)

-- 
2.1.0
