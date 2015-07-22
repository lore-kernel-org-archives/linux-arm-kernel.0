From: maxime.coquelin@st.com (Maxime Coquelin)
Date: Wed, 22 Jul 2015 19:22:52 +0200
Subject: [GIT PULL] STi DT changes for v4.3, round 1
Message-ID: <55AFD16C.7020006@st.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Olof, Arnd and Kevin,

Please consider this first round of STi DT updates for v4.3:

The following changes since commit d770e558e21961ad6cfdf0ff7df0eb5d7d4f0754:

   Linux 4.2-rc1 (2015-07-05 11:01:52 -0700)

are available in the git repository at:

   https://git.kernel.org/pub/scm/linux/kernel/git/mcoquelin/sti.git 
tags/sti-dt-for-v4.3-1

for you to fetch changes up to 794445095791aa4f92dfd802f08b541167d63ecc:

   ARM: DT: STiH410: Add bdisp dt nodes (2015-07-22 15:05:31 +0200)

----------------------------------------------------------------
STi DT update for v4.3, round 1.

Highlights:
-----------
  - Add pinctrl configurations for transport stream channels
  - Add cpu-release-addr properties to STiH407 and STiH418
  - Add PWM regulator support so STIH407 family
  - Add BDISP node to STiH407

----------------------------------------------------------------
Fabien Dessenne (1):
       ARM: DT: STiH410: Add bdisp dt nodes

Gabriel Fernandez (1):
       ARM: STi: DT: Rename st_pll3200c32_407_c0_x into st_pll3200c32_cx_x

Lee Jones (2):
       ARM: STi: STiH407: Move PWM nodes STiH407 => STiH407-family
       ARM: STi: STiH407: Add PWM Regulator node

Peter Griffin (11):
       ARM: STi: DT: Add STiH407 family tsin0 pinctrl configuration
       ARM: STi: DT: Add STiH407 family tsin1 pinctrl configuration
       ARM: STi: DT: Add STiH407 family tsin2 pinctrl configuration
       ARM: STi: DT: Add STiH407 family tsin3 pinctrl configuration
       ARM: STi: DT: Add STiH407 family tsin4 pinctrl configuration
       ARM: STi: DT: Add STiH407 family tsin5 pinctrl configuration
       ARM: STi: DT: Add STiH407 family tsout0 pinctrl configuration
       ARM: STi: DT: Add STiH407 family tsout1 pinctrl configuration
       ARM: STi: DT: Add STiH407 family mtsin0 pinctrl configuration
       ARM: STi: DT: STiH407: Add cpu-release-addr dt property.
       ARM: STi: DT: STiH418: Add cpu-release-addr dt property.

  .../devicetree/bindings/clock/st/st,clkgen-pll.txt |   4 +-
  arch/arm/boot/dts/stih407-clock.dtsi               |   4 +-
  arch/arm/boot/dts/stih407-family.dtsi              |  45 +++++
  arch/arm/boot/dts/stih407-pinctrl.dtsi             | 200 
+++++++++++++++++++++
  arch/arm/boot/dts/stih407.dtsi                     |  28 ---
  arch/arm/boot/dts/stih410-clock.dtsi               |   4 +-
  arch/arm/boot/dts/stih410.dtsi                     |  12 ++
  arch/arm/boot/dts/stih418-clock.dtsi               |   4 +-
  arch/arm/boot/dts/stih418.dtsi                     |   4 +
  9 files changed, 269 insertions(+), 36 deletions(-)
