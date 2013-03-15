From: maxime.ripard@free-electrons.com (Maxime Ripard)
Date: Fri, 15 Mar 2013 21:06:22 +0100
Subject: [PATCHv3 0/6] Extend UART support for Allwinner SoCs
Message-ID: <1363377988-4966-1-git-send-email-maxime.ripard@free-electrons.com>
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

Changes from v2:
  - Reworked Emilio's patch according to Heikki Krogerus' review to enable the
    use of the clock framework even when not using the dt

Emilio L?pez (1):
  serial: 8250_dw: add support for clk api

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
 drivers/tty/serial/8250/8250_dw.c         |   33 +++++++++++-----
 4 files changed, 95 insertions(+), 17 deletions(-)

-- 
1.7.10.4
