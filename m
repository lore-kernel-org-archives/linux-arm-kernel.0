From: wens@csie.org (Chen-Yu Tsai)
Date: Tue,  2 Jun 2015 18:04:00 +0800
Subject: [PATCH 0/3] ARM: dts: sun8i-a33: Support for Sinlinx SinA33 dev board
Message-ID: <1433239443-738-1-git-send-email-wens@csie.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Maxime,

This series enables support for the Sinlinx SinA33 dev board. This
is a core/daughter board SDK kit from Chinese vendor Sinlinx. The
core board itself does not have any special connectivity, so I
didn't split them into 2 files.

The series is based on Vishnu/Hans' A33 series (v2). As the last
(dts) patch was not merged yet, there might be a conflict in
dts/Makefile.

Patch 1 adds a pinmux setting for uart0 on PB pins. This is new on
A33, and is much better than using R_UART for console on A23, as
we can also see messages from BROM/boot0 when developing, and also
use the same earlyprintk settings as other sunxi platforms.

Patch 2 adds a pinmux setting for 8 bit eMMC on mmc2.
mmc2 also has a reset pin, though I'm not sure if our mmc driver
actually uses it. Not using it seems to work anyway.

Patch 3 adds the dts file for the SinA33 dev board. Just the basic
set of features are enabled: UART console, MMC, LRADC.

Chen-Yu Tsai (3):
  ARM: dts: sun8i: Add pinmux setting for 8bit mmc2
  ARM: dts: sun8i-a33: Add pinmux setting for uart0 on PB pins
  ARM: dts: sun8i-a33: Add dts for Sinlinx SinA33 development board.

 arch/arm/boot/dts/Makefile                         |   3 +-
 arch/arm/boot/dts/sun8i-a23-a33.dtsi               |  10 ++
 ...sun8i-a33.dtsi => sun8i-a33-sinlinx-sina33.dts} | 106 ++++++++++++++-------
 arch/arm/boot/dts/sun8i-a33.dtsi                   |   8 ++
 4 files changed, 93 insertions(+), 34 deletions(-)
 copy arch/arm/boot/dts/{sun8i-a33.dtsi => sun8i-a33-sinlinx-sina33.dts} (56%)

-- 
2.1.4
