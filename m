From: maxime.ripard@free-electrons.com (Maxime Ripard)
Date: Sun,  5 Feb 2017 19:49:36 +0100
Subject: [PATCH 0/9] ARM: sun5i: Cleanup and reorganisation of the DTSI
Message-ID: <cover.8519ab0b2252458a322bea5955d191e63f67100b.1486320544.git-series.maxime.ripard@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

Most of the sun5i DTSI have grown organically, some nodes being added to
SoC DTSI because they were not properly tested, some because old datasheet
were wrong, and some times because we were not even sure whether it could
be shared at all, or how to share it.

Now that we have much more details, we can use that opportunity to
refactor all our DTSI so that we reduce greatly the duplication, especially
with the GR8 DTSI.

Let me know what you think,
Maxime

Maxime Ripard (9):
  ARM: sun5i: A10s: Switch the EMAC pins indices
  ARM: sun5i: a10s: switch simple framebuffer indices
  ARM: sunxi: Rename pwm0_pins to match our usual pattern
  ARM: sun5i: Add UART2 pin group
  ARM: sun5i: Rename UART3 flow control pins
  ARM: sun5i: a13: Merge common controllers into the common DTSI
  ARM: sun5i: a10s: Merge common controllers into the common DTSI
  ARM: sun5i: r8: Merge common controllers into the common DTSI
  ARM: sun5i: gr8: Use common sun5i DTSI

 arch/arm/boot/dts/sun5i-a10s-olinuxino-micro.dts       |   4 +-
 arch/arm/boot/dts/sun5i-a10s-wobo-i5.dts               |   2 +-
 arch/arm/boot/dts/sun5i-a10s.dtsi                      |  76 +-
 arch/arm/boot/dts/sun5i-a13-empire-electronix-d709.dts |   2 +-
 arch/arm/boot/dts/sun5i-a13.dtsi                       | 139 +--
 arch/arm/boot/dts/sun5i-gr8-chip-pro.dts               |   2 +-
 arch/arm/boot/dts/sun5i-gr8-evb.dts                    |   2 +-
 arch/arm/boot/dts/sun5i-gr8.dtsi                       | 617 +----------
 arch/arm/boot/dts/sun5i-r8-chip.dts                    |   2 +-
 arch/arm/boot/dts/sun5i-r8.dtsi                        |  40 +-
 arch/arm/boot/dts/sun5i.dtsi                           | 292 ++++-
 arch/arm/boot/dts/sun8i-a23-a33.dtsi                   |   2 +-
 arch/arm/boot/dts/sunxi-reference-design-tablet.dtsi   |   2 +-
 13 files changed, 327 insertions(+), 855 deletions(-)

base-commit: 2a6e628efb37432a83bb42b00e3c403b1d8873dd
-- 
git-series 0.8.11
