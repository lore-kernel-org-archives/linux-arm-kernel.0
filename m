From: b51503@freescale.com (Bai Ping)
Date: Tue, 15 Dec 2015 14:07:48 +0800
Subject: [PATCH v2 0/5] Add support for imx6qp
Message-ID: <1450159673-27314-1-git-send-email-b51503@freescale.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patchset add basic support for i.MX6Quad Plus SOC.

change for v2:
 -- address commnet from Fabio Estevam, split the dts
    into three patch:
	dts for imx6qp soc; dts for imx6qp-sabresd
	and dts for imx6qp-sabreauto
 -- fix a typo in commit, the chip name should be i.MX6Quad Plus 

Bai Ping (5):
  ARM: dts: imx: Add basic dts support for imx6qp SOC
  ARM: dts: imx: Add basic dts support for imx6qp-sabresd
  ARM: dts: imx: Add basic dts support for imx6qp-sabreauto
  clk: imx: Add clock support for imx6qp
  ARM: imx: Add msl code support for imx6qp

 arch/arm/boot/dts/Makefile                |   2 +
 arch/arm/boot/dts/imx6q.dtsi              |   2 +-
 arch/arm/boot/dts/imx6qdl-sabresd.dtsi    |   1 +
 arch/arm/boot/dts/imx6qp-sabreauto.dts    |  67 +++++++++++++
 arch/arm/boot/dts/imx6qp-sabresd.dts      |  59 +++++++++++
 arch/arm/boot/dts/imx6qp.dtsi             | 157 ++++++++++++++++++++++++++++++
 arch/arm/mach-imx/anatop.c                |   5 +-
 arch/arm/mach-imx/mach-imx6q.c            |   8 +-
 drivers/clk/imx/clk-imx6q.c               | 132 ++++++++++++++++++++-----
 include/dt-bindings/clock/imx6qdl-clock.h |  16 ++-
 10 files changed, 417 insertions(+), 32 deletions(-)
 create mode 100644 arch/arm/boot/dts/imx6qp-sabreauto.dts
 create mode 100644 arch/arm/boot/dts/imx6qp-sabresd.dts
 create mode 100644 arch/arm/boot/dts/imx6qp.dtsi

-- 
1.9.1
