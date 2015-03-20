From: wens@csie.org (Chen-Yu Tsai)
Date: Fri, 20 Mar 2015 14:49:18 +0800
Subject: [PATCH v2 0/2] ARM: dts: sunxi: Fix cpufreq instabilities
Message-ID: <1426834160-10409-1-git-send-email-wens@csie.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Maxime,

Here's v2 of the sunxi cpufreq dts fixes, aimed at 4.0.

The first patch limits the Olimex A10-Lime to 912MHz, as a few people
reported on IRC that it was unstable at 1008MHz.

The second patch removes the overclocking settings from sun[457]i dts,
so all the boards will be stable, regardless of whether regulators
were added or not.

I would like to revisit this after the new OPP bindings are merged
and support added to cpufreq-dt.


Changes since v1:

  - Added sun4i dts fixes
  - Corrected A10-Lime settings to match sun4i


Regards
ChenYu


Chen-Yu Tsai (2):
  ARM: dts: sun4i: a10-lime: Override and remove 1008MHz OPP setting
  ARM: dts: sunxi: Remove overclocked/overvoltaged OPP

 arch/arm/boot/dts/sun4i-a10-olinuxino-lime.dts | 11 +++++++++++
 arch/arm/boot/dts/sun4i-a10.dtsi               |  3 +--
 arch/arm/boot/dts/sun5i-a13.dtsi               |  3 +--
 arch/arm/boot/dts/sun7i-a20.dtsi               |  3 +--
 4 files changed, 14 insertions(+), 6 deletions(-)

-- 
2.1.4
