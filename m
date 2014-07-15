From: wens@csie.org (Chen-Yu Tsai)
Date: Wed, 16 Jul 2014 01:15:42 +0800
Subject: [PATCH v2 0/5] ARM: dts: sun6i: Add support for GMAC
Message-ID: <1405444547-21870-1-git-send-email-wens@csie.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Maxime,

This is v2 of the A31 GMAC support series. The GMAC is the same as in
the A20, except it has an extra reset control. The GMAC clock module is
mostly the same as in the A20, without the extra dividers, which I left
out intentionally from the clock driver.

The register offsets and interrupts were copied from A31 SDK in Rhombus
Tech's repository. The pin muxes were from the EVB fex file.

I've tested this on my A31 Hummingbird under 100M and 1000M.

Patch 5 adds support for the A31 Hummingbird. It is based on your work,
so it has your name on it. I cleaned up the format and descriptions,
got rid of missing devices, and added usb and the external rtc. 


Changes since v1:

- Dropped Colombus board patch, as it needs AXP221 regulator support.
- Added reset-name to GMAC node.
- Added A31 Hummingbird support.


Cheers,
ChenYu

Chen-Yu Tsai (4):
  ARM: dts: sun6i: Add pin muxing options for GMAC
  ARM: dts: sun6i: Add GMAC clock node to the A31 dtsi
  ARM: dts: sun6i: Add A31 GMAC gigabit ethernet controller node
  ARM: dts: sun6i: Add ethernet alias for GMAC

Maxime Ripard (1):
  ARM: dts: sun6i: Add Merrii A31 Hummingbird support

 arch/arm/boot/dts/Makefile                  |   1 +
 arch/arm/boot/dts/sun6i-a31-hummingbird.dts | 119 ++++++++++++++++++++++++++++
 arch/arm/boot/dts/sun6i-a31.dtsi            |  88 ++++++++++++++++++++
 3 files changed, 208 insertions(+)
 create mode 100644 arch/arm/boot/dts/sun6i-a31-hummingbird.dts

-- 
2.0.1
