From: wens@csie.org (Chen-Yu Tsai)
Date: Thu, 19 Mar 2015 10:39:31 +0800
Subject: [PATCH 0/2] ARM: dts: sunxi: Fix cpufreq instabilities
Message-ID: <1426732773-7179-1-git-send-email-wens@csie.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Maxime,

Here are 2 dts fixes for sunxi cpufreq support, aimed at 4.0.

The first patch limits the Olimex A10-Lime to 960MHz, as a few people
reported on IRC that it was unstable at 1008MHz.

The second patch removes the overclocking settings from sun5i/sun7i
dts, so all the boards will be stable, regardless of whether regulators
were added or not.

I would like to revisit this after the new OPP bindings are merged
and support added to cpufreq-dt.


Regards
ChenYu


Chen-Yu Tsai (2):
  ARM: dts: sun4i: a10-lime: Override and remove 1008MHz OPP setting
  ARM: dts: sunxi: Remove overclocked/overvoltaged OPP

 arch/arm/boot/dts/sun4i-a10-olinuxino-lime.dts | 14 ++++++++++++++
 arch/arm/boot/dts/sun5i-a13.dtsi               |  3 +--
 arch/arm/boot/dts/sun7i-a20.dtsi               |  3 +--
 3 files changed, 16 insertions(+), 4 deletions(-)

-- 
2.1.4
