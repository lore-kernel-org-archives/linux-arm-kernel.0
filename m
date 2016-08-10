From: patrice.chotard@st.com (patrice.chotard at st.com)
Date: Wed, 10 Aug 2016 15:12:57 +0200
Subject: [PATCH 0/4] STi: Allow to use gpio specifier's second parameter
Message-ID: <1470834781-23232-1-git-send-email-patrice.chotard@st.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Patrice Chotard <patrice.chotard@st.com>

Currently, on STi platforms, only first parameter of gpio specifier 
is used. It's not possible to indicate is a GPIO is active high or 
low, although second gpio specifier parameter is already present in 
some STi dts files.

This patchset update ST specific pinctrl driver and update/clean
boards dts files.

Only last dts's SoC generation (STiH407/410/418) are updated.

STiH415/416 are intentionnally not updated as STMicrolectronics stops
to supporting these SoCs. A patch series is under internal review
and will be send soon to drop all STiH415/416 kernel code.

Patrice Chotard (4):
  pinctrl: st: Use second parameter to gpio specifier
  ARM: dts: STiH407-pinctrl: Update gpio-cells to 2
  ARM: dts: STiH418-B2199: Update gpio specifier
  ARM: dts: STiH41x-b2020: Update gpio specifier

 .../devicetree/bindings/pinctrl/pinctrl-st.txt     |  8 +++-
 arch/arm/boot/dts/stih407-pinctrl.dtsi             | 52 +++++++++++-----------
 arch/arm/boot/dts/stih418-b2199.dts                |  7 ++-
 arch/arm/boot/dts/stih41x-b2020.dtsi               |  6 +--
 drivers/pinctrl/pinctrl-st.c                       | 17 -------
 5 files changed, 38 insertions(+), 52 deletions(-)

-- 
1.9.1
