From: p.zabel@pengutronix.de (Philipp Zabel)
Date: Wed, 20 Aug 2014 10:42:58 +0200
Subject: [RFC PATCH 0/6] Change vendor prefix for Intersil Corporation
Message-ID: <1408524184-31928-1-git-send-email-p.zabel@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

currently there is a wild mixture of isl, isil, and intersil
compatibles in the kernel. I figure at this point it is still
possible to change this to use "isil" everywhere without too
much pain, but it might be preferred to keep the already
documented "isl" prefix, even though it doesn't follow the
convention to use the NASDAQ symbol where available.

The current users of the "isil" prefix are the following drivers
and device trees, so we could just as well change those instead:
	arch/arm/boot/dts/tegra20-seaboard.dts
	arch/arm/boot/dts/tegra20-ventana.dts
	arch/arm/boot/dts/tegra30-cardhu.dtsi
	arch/powerpc/boot/dts/p1022rdk.dts
	drivers/staging/iio/light/isl29018.c
	drivers/staging/iio/light/isl29028.c

regards
Philipp

Philipp Zabel (6):
  of: Change vendor prefix for Intersil Corporation to isil
  Documentation: Add isl1208 and isl12022 to trivial-devices list
  ARM: mvebu: Change vendor prefix for Intersil Corporation to isil
  powerpc/85xx: Change vendor prefix for Intersil Corporation to isil
  rtc: rtc-isl12022: Change vendor prefix for Intersil Corporation to
    isil
  rtc: rtc-isl12057: Change vendor prefix for Intersil Corporation to
    isil

 Documentation/devicetree/bindings/i2c/trivial-devices.txt | 4 +++-
 Documentation/devicetree/bindings/vendor-prefixes.txt     | 2 +-
 arch/arm/boot/dts/armada-370-netgear-rn102.dts            | 2 +-
 arch/arm/boot/dts/armada-370-netgear-rn104.dts            | 2 +-
 arch/arm/boot/dts/armada-xp-netgear-rn2120.dts            | 2 +-
 arch/powerpc/boot/dts/ppa8548.dts                         | 2 +-
 drivers/rtc/rtc-isl12022.c                                | 3 ++-
 drivers/rtc/rtc-isl12057.c                                | 3 ++-
 8 files changed, 12 insertions(+), 8 deletions(-)

-- 
2.1.0.rc1
