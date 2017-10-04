From: alexandre.torgue@st.com (Alexandre Torgue)
Date: Wed, 4 Oct 2017 16:08:10 +0200
Subject: [GIT PULL] STM32 DT fixes for v4.14
Message-ID: <ec743780-6c16-ada9-3e0a-335758c989df@st.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Arnd, Kevin and Olof,

Please consider this round of STM32 DT fixes for v4.14:

The following changes since commit 2bd6bf03f4c1c59381d62c61d03f6cc3fe71f66e:

   Linux 4.14-rc1 (2017-09-16 15:47:51 -0700)

are available in the git repository at:

   git://git.kernel.org/pub/scm/linux/kernel/git/atorgue/stm32.git 
tags/stm32-dt-fixes-for-v4.14

for you to fetch changes up to 2aaae13a9db7897a007c5d7bb46cacfb37dffacd:

   ARM: dts: stm32: use right pinctrl compatible for stm32f469 
(2017-10-04 15:34:48 +0200)

----------------------------------------------------------------
STM32 fixes for v4.14:
---------------------

-Fix STMPE1600 bindings for stm32429i-eval board
-Use right compatible for stm32f469 pinctrl. It implies to use
pinctrl dedicated files for F4 SoCs.

----------------------------------------------------------------
Alexandre Torgue (2):
       ARM: dts: stm32: Fix STMPE1600 binding on stm32429i-eval board
       ARM: dts: stm32: use right pinctrl compatible for stm32f469

  arch/arm/boot/dts/stm32429i-eval.dts     |   5 +-
  arch/arm/boot/dts/stm32f4-pinctrl.dtsi   | 343 
+++++++++++++++++++++++++++++++
  arch/arm/boot/dts/stm32f429-disco.dts    |   1 +
  arch/arm/boot/dts/stm32f429-pinctrl.dtsi |  95 +++++++++
  arch/arm/boot/dts/stm32f429.dtsi         | 297 --------------------------
  arch/arm/boot/dts/stm32f469-disco.dts    |   1 +
  arch/arm/boot/dts/stm32f469-pinctrl.dtsi |  96 +++++++++
  7 files changed, 538 insertions(+), 300 deletions(-)
  create mode 100644 arch/arm/boot/dts/stm32f4-pinctrl.dtsi
  create mode 100644 arch/arm/boot/dts/stm32f429-pinctrl.dtsi
  create mode 100644 arch/arm/boot/dts/stm32f469-pinctrl.dtsi
