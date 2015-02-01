From: maxime.ripard@free-electrons.com (Maxime Ripard)
Date: Sun,  1 Feb 2015 14:49:44 +0100
Subject: [PATCH 00/30] ARM: dt: sunxi: DT cleanups
Message-ID: <1422798614-3581-1-git-send-email-maxime.ripard@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

This set does a set of cleanups that were either long awaited (sun5i
DTSI merge) or have been asked recently (conversion to label based
syntax for DTS).

Maxime

Maxime Ripard (30):
  ARM: sun5i: Add a DTSI common to A10s and A13
  ARM: sun5i: a13: Move to the common sun5i DTSI
  ARM: sun5i: a10s: Move to the common sun5i DTSI
  ARM: sun4i: a1000: Convert to DT label based syntax
  ARM: sun4i: ba10 tvbox: Convert to DT label based syntax
  ARM: sun4i: cubieboard: Convert to DT label based syntax
  ARM: sun4i: hackberry: Convert to DT label based syntax
  ARM: sun4i: inet97fv2: Convert to DT label based syntax
  ARM: sun4i: mini xplus: Convert to DT label based syntax
  ARM: sun4i: olinuxino lime: Convert to DT label based syntax
  ARM: sun4i: pcduino: Convert to DT label based syntax
  ARM: sun5i: a10s: olinuxino micro: Convert to DT label based syntax
  ARM: sun5i: a10s: r7 tv dongle: Convert to DT label based syntax
  ARM: sun5i: a13: hsg h702: Convert to DT label based syntax
  ARM: sun5i: a13: olinuxino micro: Convert to DT label based syntax
  ARM: sun5i: a13: olinuxino: Convert to DT label based syntax
  ARM: sun6i: app4 evb1: Convert to DT label based syntax
  ARM: sun6i: colombus: Convert to DT label based syntax
  ARM: sun6i: m9: Convert to DT label based syntax
  ARM: sun7i: bananapi: Convert to DT label based syntax
  ARM: sun7i: cubieboard2: Convert to DT label based syntax
  ARM: sun7i: cubietruck: Convert to DT label based syntax
  ARM: sun7i: hummingbird: Convert to DT label based syntax
  ARM: sun7i: i12 tvbox: Convert to DT label based syntax
  ARM: sun7i: m3: Convert to DT label based syntax
  ARM: sun7i: olinuxino lime: Convert to DT label based syntax
  ARM: sun7i: olinuxino lime2: Convert to DT label based syntax
  ARM: sun7i: olinuxino micro: Convert to DT label based syntax
  ARM: sun7i: pcduino3: Convert to DT label based syntax
  ARM: sun8i: ippo q8h v5: Convert to DT label based syntax

 arch/arm/boot/dts/sun4i-a10-a1000.dts            | 200 ++++----
 arch/arm/boot/dts/sun4i-a10-ba10-tvbox.dts       | 168 ++++---
 arch/arm/boot/dts/sun4i-a10-cubieboard.dts       | 214 +++++----
 arch/arm/boot/dts/sun4i-a10-hackberry.dts        | 187 ++++----
 arch/arm/boot/dts/sun4i-a10-inet97fv2.dts        | 104 ++--
 arch/arm/boot/dts/sun4i-a10-mini-xplus.dts       | 140 +++---
 arch/arm/boot/dts/sun4i-a10-olinuxino-lime.dts   | 188 ++++----
 arch/arm/boot/dts/sun4i-a10-pcduino.dts          | 177 ++++---
 arch/arm/boot/dts/sun5i-a10s-olinuxino-micro.dts | 315 ++++++------
 arch/arm/boot/dts/sun5i-a10s-r7-tv-dongle.dts    | 132 +++--
 arch/arm/boot/dts/sun5i-a10s.dtsi                | 582 ++---------------------
 arch/arm/boot/dts/sun5i-a13-hsg-h702.dts         | 136 +++---
 arch/arm/boot/dts/sun5i-a13-olinuxino-micro.dts  | 148 +++---
 arch/arm/boot/dts/sun5i-a13-olinuxino.dts        | 236 +++++----
 arch/arm/boot/dts/sun5i-a13.dtsi                 | 554 ++-------------------
 arch/arm/boot/dts/sun5i.dtsi                     | 560 ++++++++++++++++++++++
 arch/arm/boot/dts/sun6i-a31-app4-evb1.dts        |  52 +-
 arch/arm/boot/dts/sun6i-a31-colombus.dts         | 120 +++--
 arch/arm/boot/dts/sun6i-a31-m9.dts               | 148 +++---
 arch/arm/boot/dts/sun7i-a20-bananapi.dts         | 262 +++++-----
 arch/arm/boot/dts/sun7i-a20-cubieboard2.dts      | 198 ++++----
 arch/arm/boot/dts/sun7i-a20-cubietruck.dts       | 316 ++++++------
 arch/arm/boot/dts/sun7i-a20-hummingbird.dts      | 384 ++++++++-------
 arch/arm/boot/dts/sun7i-a20-i12-tvbox.dts        | 252 +++++-----
 arch/arm/boot/dts/sun7i-a20-m3.dts               | 178 ++++---
 arch/arm/boot/dts/sun7i-a20-olinuxino-lime.dts   | 186 ++++----
 arch/arm/boot/dts/sun7i-a20-olinuxino-lime2.dts  | 288 ++++++-----
 arch/arm/boot/dts/sun7i-a20-olinuxino-micro.dts  | 364 +++++++-------
 arch/arm/boot/dts/sun7i-a20-pcduino3.dts         | 210 ++++----
 arch/arm/boot/dts/sun8i-a23-ippo-q8h-v5.dts      | 110 +++--
 30 files changed, 3316 insertions(+), 3793 deletions(-)
 create mode 100644 arch/arm/boot/dts/sun5i.dtsi

-- 
2.2.2
