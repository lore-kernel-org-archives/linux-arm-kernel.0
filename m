From: peter.chen@nxp.com (Peter Chen)
Date: Mon, 14 Nov 2016 15:04:19 +0800
Subject: [PATCH v3 0/3] imx: add imx6ull support
Message-ID: <1479107062-15365-1-git-send-email-peter.chen@nxp.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Shawn,

In this series, it adds support for imx6ull SoC which is a derived SoC
from imx6ul, and imx6ull is pin-to-pin compatible with imx6ul, the
basic functions are tested at imx6ull 14x14 evk, and imx6ul 14x14 evk
is tested too to avoid regression.

Changes for v3:
- Keep imx6ul-14x14-evk.dts unchanging, and let imx6ull-14x14-evk.dts
  include it. [Patch 1/3]

Changes for v2:
- Keep imx6ul.dtsi unchanging, and using GPL/X11 dual license
  for new dts file. [Patch 1/3]
- Using IMX6ULL prefix for both imx6ull dedicated pin and clock name.
  [Patch 1/3, 3/3]
- Delete useless changes for patch 2/3.
- Delete blank line for patch 3/3.
- Using assigned-clocks for imx6ull 14x14 evk. [Patch 1/3, 3/3]

Bai Ping (1):
  clk: imx: clk-imx6ul: add clk support for imx6ull

Peter Chen (2):
  ARM: imx6ull: add imx6ull support
  ARM: imx: mach-imx6ul: add imx6ull support

 arch/arm/boot/dts/Makefile               |  3 +-
 arch/arm/boot/dts/imx6ull-14x14-evk.dts  | 52 +++++++++++++++++++++++
 arch/arm/boot/dts/imx6ull-pinfunc.h      | 56 +++++++++++++++++++++++++
 arch/arm/boot/dts/imx6ull.dtsi           | 43 +++++++++++++++++++
 arch/arm/mach-imx/mach-imx6ul.c          |  1 +
 drivers/clk/imx/clk-imx6ul.c             | 72 +++++++++++++++++++++++++++-----
 include/dt-bindings/clock/imx6ul-clock.h | 15 ++++++-
 7 files changed, 229 insertions(+), 13 deletions(-)
 create mode 100644 arch/arm/boot/dts/imx6ull-14x14-evk.dts
 create mode 100644 arch/arm/boot/dts/imx6ull-pinfunc.h
 create mode 100644 arch/arm/boot/dts/imx6ull.dtsi

-- 
2.7.4
