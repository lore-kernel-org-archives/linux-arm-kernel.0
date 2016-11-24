From: wens@csie.org (Chen-Yu Tsai)
Date: Thu, 24 Nov 2016 14:43:37 +0800
Subject: [PATCH 0/2] ARM: dts: sun6i: Disable display pipeline by default
Message-ID: <20161124064339.12615-1-wens@csie.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

While we now support the internal display pipeline found on sun6i, it
is possible that we are unable to enable the display for some boards,
due to a lack of drivers for the panels or bridges found on them. If
the display pipeline is enabled, the driver will try to enable, and
possibly screw up the simple framebuffer U-boot had configured.

This series disables the display pipeline by default, and re-enables
it for the A31 Hummingbird, which already had its display pipeline
enabled.

The series can go in after 4.10-rc1, as a fix, but should not be delayed
till the next release.

Regards
ChenYu

Chen-Yu Tsai (2):
  ARM: dts: sun6i: Disable display pipeline by default
  ARM: dts: sun6i: hummingbird: Enable display engine again

 arch/arm/boot/dts/sun6i-a31-hummingbird.dts | 4 ++++
 arch/arm/boot/dts/sun6i-a31.dtsi            | 1 +
 2 files changed, 5 insertions(+)

-- 
2.10.2
