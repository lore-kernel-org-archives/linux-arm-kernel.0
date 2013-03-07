From: maxime.ripard@free-electrons.com (Maxime Ripard)
Date: Thu,  7 Mar 2013 23:14:14 +0100
Subject: [PATCHv2 0/6] Extend UART support for Allwinner SoCs
Message-ID: <1362694460-1919-1-git-send-email-maxime.ripard@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

This patchset reworks a bit the UART support that is found in the DT
for Allwinner SoCs, which was quite limited until now.

It first switches to using the clocks property, then rework a bit the
DTSI to have only the UART available in the A10 and the A13 (the A10
has 8 UARTs, while A13 has only the uart1 and uart3).

Thanks,
Maxime

Changes since v1:
  - Add Emilio patch to add support for clock phandle to 8250_dw
  - Change uart3 definition to use the clocks property as well

Emilio L?pez (1):
  serial: 8250_dw: add support for clocks property when using
    DeviceTree

Maxime Ripard (5):
  ARM: sunxi: dt: Use clocks property instead of clock-frequency for
    the UARTs
  ARM: sunxi: dt: Move uart0 to sun4i-a10.dtsi
  ARM: sunxi: dt: Add uart3 dt node
  ARM: sunxi: dt: Add A10 UARTs to the dtsi.
  ARM: sunxi: hackberry: Add UART muxing

 arch/arm/boot/dts/sun4i-a10-hackberry.dts |    2 +
 arch/arm/boot/dts/sun4i-a10.dtsi          |   61 +++++++++++++++++++++++++++++
 arch/arm/boot/dts/sunxi.dtsi              |   16 ++++----
 drivers/tty/serial/8250/8250_dw.c         |   32 ++++++++++-----
 4 files changed, 93 insertions(+), 18 deletions(-)

-- 
1.7.10.4
