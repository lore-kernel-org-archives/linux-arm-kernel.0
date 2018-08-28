From: wens@csie.org (Chen-Yu Tsai)
Date: Tue, 28 Aug 2018 18:01:29 +0800
Subject: [PATCH 0/3] arm64: dts: allwinner: a64: pinmux cleanups
Message-ID: <20180828100132.12975-1-wens@csie.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

This series does some cleanup of the Allwinner A64 pinmux groups.

The first addresses a limitation on the A64 where we have the eMMC's
DS in always muxed in. The DS pin is shared with SPI0's MISO, thereby
preventing SPI0 from being used. In this patch we split out the DS
pin into a separate group for boards that actually utilize it to
select on their own.

The other two patches just rename pinmux group node names and labels
from <func>_pins_<[a-z]> to <func>_<pingroup/pin names>_pins. The latter
is the style we adopted later on, and is easier to know which pins they
correspond to, i.e. easier to review.

Please have a look.

While I want to do some more cleanup, I realized that the label and/or
node names might be used by distro (Armbian comes to mind) or personal
device tree overlay files. Do we need to have these remain fixed? Do
we or can we provide a fallback? (Is that even possible?)

Regards
ChenYu

Chen-Yu Tsai (3):
  arm64: dts: allwinner: a64: Split out data strobe pin from mmc2 pinmux
  arm64: dts: allwinner: a64: Rename uart0_pins_a label to uart0_pb_pins
  arm64: dts: allwinner: a64: Rename r_i2c_pins_a label to
    r_i2c_pl89_pins

 .../boot/dts/allwinner/sun50i-a64-amarula-relic.dts |  2 +-
 .../boot/dts/allwinner/sun50i-a64-bananapi-m64.dts  |  4 ++--
 .../boot/dts/allwinner/sun50i-a64-nanopi-a64.dts    |  2 +-
 .../boot/dts/allwinner/sun50i-a64-olinuxino.dts     |  2 +-
 .../boot/dts/allwinner/sun50i-a64-orangepi-win.dts  |  2 +-
 arch/arm64/boot/dts/allwinner/sun50i-a64-pine64.dts |  2 +-
 .../boot/dts/allwinner/sun50i-a64-pinebook.dts      |  6 +++---
 .../dts/allwinner/sun50i-a64-sopine-baseboard.dts   |  2 +-
 .../arm64/boot/dts/allwinner/sun50i-a64-teres-i.dts |  2 +-
 arch/arm64/boot/dts/allwinner/sun50i-a64.dtsi       | 13 ++++++++++---
 10 files changed, 22 insertions(+), 15 deletions(-)

-- 
2.18.0
