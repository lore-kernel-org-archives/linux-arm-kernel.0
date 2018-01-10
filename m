From: patrice.chotard@st.com (patrice.chotard at st.com)
Date: Wed, 10 Jan 2018 09:21:00 +0100
Subject: [PATCH 0/7] ARM: dts: STi: Fix DT dtc warnings 
Message-ID: <1515572469-19276-1-git-send-email-patrice.chotard@st.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Patrice Chotard <patrice.chotard@st.com>

This series fixes all dtc warnings related to STi platforms dt files.
It has been triggered by Rob Herring [1]

[1] https://www.spinics.net/lists/devicetree/msg206209.html

For most of implicated node, a simple move outside the soc node
solves the warnings.

Patrice Chotard (7):
  ARM: dts: STi: fix bindings notation
  ARM: dts: STi: Add gpio polarity for "hdmi,hpd-gpio" property
  ARM: dts: STi: Move clocks without reg outside soc
  ARM: dts: STi: Move leds node outside soc node
  ARM: dts: STi: Move usb2_picophyX nodes without reg out of soc
  ARM: dts: STi: Move sound related nodes without reg out of soc
  ARM: dts: STi: Add fake reg property for sti-display-subsystem

 arch/arm/boot/dts/stih407-b2120.dts    |   2 +-
 arch/arm/boot/dts/stih407-clock.dtsi   | 108 ++++++++++++++--------------
 arch/arm/boot/dts/stih407-family.dtsi  |  22 +++---
 arch/arm/boot/dts/stih407-pinctrl.dtsi |  10 +--
 arch/arm/boot/dts/stih407.dtsi         |   7 +-
 arch/arm/boot/dts/stih410-b2120.dts    |  20 +++---
 arch/arm/boot/dts/stih410-b2260.dts    | 101 +++++++++++++-------------
 arch/arm/boot/dts/stih410-clock.dtsi   | 105 +++++++++++++--------------
 arch/arm/boot/dts/stih410-pinctrl.dtsi |   2 +-
 arch/arm/boot/dts/stih410.dtsi         |  46 ++++++------
 arch/arm/boot/dts/stih418-b2199.dts    |  30 ++++----
 arch/arm/boot/dts/stih418-clock.dtsi   | 109 ++++++++++++++--------------
 arch/arm/boot/dts/stih418.dtsi         |  34 ++++-----
 arch/arm/boot/dts/stihxxx-b2120.dtsi   | 128 ++++++++++++++++-----------------
 14 files changed, 362 insertions(+), 362 deletions(-)

-- 
1.9.1
