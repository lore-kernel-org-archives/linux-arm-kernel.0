From: maxime.ripard@free-electrons.com (Maxime Ripard)
Date: Wed,  6 Mar 2013 16:29:22 +0100
Subject: [PATCH 0/5] Extend UART support for Allwinner SoCs
Message-ID: <1362583767-13862-1-git-send-email-maxime.ripard@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

This patchset reworks a bit the UART support that is found in the DT
for Allwinner SoCs, which was quite limited until now.

It first switches to using the clocks property, then rework a bit the
DTSI to have only the UART available in the A10 and the A13 (the A10
has 8 UARTs, while A13 has only the uart1 and uart3).

Maxime Ripard (5):
  ARM: sunxi: dt: Use clocks property instead of clock-frequency for
    the UARTs
  ARM: sunxi: dt: Move uart0 to sun4i-a10.dtsi
  ARM: sunxi: dt: Add uart3 dt node
  ARM: sunxi: dt: Add A10 UARTs to the dtsi.
  ARM: sunxi: hackberry: Add UART muxing

 arch/arm/boot/dts/sun4i-a10-hackberry.dts |    2 +
 arch/arm/boot/dts/sun4i-a10.dtsi          |   61 +++++++++++++++++++++++++++++
 arch/arm/boot/dts/sunxi.dtsi              |   14 +++----
 3 files changed, 70 insertions(+), 7 deletions(-)

-- 
1.7.10.4
