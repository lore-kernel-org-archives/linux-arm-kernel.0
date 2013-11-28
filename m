From: b.brezillon@overkiz.com (Boris BREZILLON)
Date: Thu, 28 Nov 2013 15:49:31 +0100
Subject: [PATCH v4 0/6] ARM: at91: use new at91 clks for samad3 SoCs
Message-ID: <1385650171-8756-1-git-send-email-b.brezillon@overkiz.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello,

This patch series moves sama5d3 SoCs and boards to the new at91 clk framework
(based on common clk framework).

Best Regards,

Boris

Changes since v3:
 - fix prog clks declaration

Changes since v2:
 - rework dt bindings:
   * replace "atmel,clk-id" property by the standard "reg" property
   * reference system, peripheral and programmable clks using the direct
     clk node instead of the parent node plus a clk id
 - add usb_clk to usb ehci controller node

Changes since v1:
 - remove references to peripheral id macros
 - remove old clk definitions after moving to new clk framework

Boris BREZILLON (6):
  ARM: at91: prepare sama5 dt boards transition to common clk
  ARM: at91: prepare common clk transition for sama5d3 SoC
  ARM: at91/dt: define sama5d3 clocks
  ARM: at91/dt: define sama5d3xek's main clk frequency
  ARM: at91: move sama5d3 SoC to common clk
  ARM: at91/dt: remove old clk material

 arch/arm/boot/dts/sama5d3.dtsi      |  379 ++++++++++++++++++++++++++++++++++-
 arch/arm/boot/dts/sama5d3_can.dtsi  |   20 ++
 arch/arm/boot/dts/sama5d3_emac.dtsi |   11 +
 arch/arm/boot/dts/sama5d3_gmac.dtsi |   11 +
 arch/arm/boot/dts/sama5d3_lcd.dtsi  |   17 ++
 arch/arm/boot/dts/sama5d3_mci2.dtsi |   12 ++
 arch/arm/boot/dts/sama5d3_tcb1.dtsi |   12 ++
 arch/arm/boot/dts/sama5d3_uart.dtsi |   21 ++
 arch/arm/boot/dts/sama5d3xcm.dtsi   |   17 +-
 arch/arm/mach-at91/Kconfig          |    1 -
 arch/arm/mach-at91/board-dt-sama5.c |   10 +-
 arch/arm/mach-at91/sama5d3.c        |  342 -------------------------------
 12 files changed, 497 insertions(+), 356 deletions(-)

-- 
1.7.9.5
