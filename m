From: slemieux.tyco@gmail.com (slemieux.tyco at gmail.com)
Date: Thu, 14 Apr 2016 08:20:34 -0400
Subject: [PATCH 0/3] arm: dts: lpc32xx: update ssp / spi nodes
Message-ID: <1460636437-21764-1-git-send-email-slemieux.tyco@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Sylvain Lemieux <slemieux@tycoint.com>

This patchset change the following:
1) adds clock properties to spi peripheral devices,
   clock ids are taken from dt-bindings/clock/lpc32xx-clock.h

2) disable, by default, the SSP0/SPI1 and SSP1/SPI2 shared pinout;
   shared pin should be enable in board specific dts, as needed.

3) enable SSP0 used by PHY3250.

Sylvain Lemieux (3):
  arm: dts: lpc32xx: add clock properties to spi nodes
  arm: dts: lpc32xx: disabled ssp0/spi1 & ssp1/spi2 by default
  arm: dts: phy3250: enable ssp0

 arch/arm/boot/dts/lpc32xx.dtsi | 16 ++++++++++++++
 arch/arm/boot/dts/phy3250.dts  |  1 +
 2 files changed, 15 insertions(+)

-- 
1.8.3.1
