From: plagnioj@jcrosoft.com (Jean-Christophe PLAGNIOL-VILLARD)
Date: Wed, 19 Dec 2012 19:32:36 +0100
Subject: [PATCH 0/3] IIO: AT91: add lowres, sleep and sample&hold time
 missing support
Message-ID: <20121219183236.GP23971@game.jcrosoft.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

	The current adc driver is missing some key feature support
	 - select high/low resolution support
	 - sleep mode
	 - Sample and Hold Time

	 This patch seris fix it
	 Without it the current driver is not usable in most of the case

Jean-Christophe PLAGNIOL-VILLARD (2):
      ARM: AT91: IIO: add sleep mode support
      ARM: AT91: IIO: fix missing Sample and Hold time

Ludovic Desroches (1):
      ARM: AT91: IIO: add low and high res support for adc

 Documentation/devicetree/bindings/arm/atmel-adc.txt |   13 ++++++++++++
 arch/arm/boot/dts/at91sam9260.dtsi                  |    3 +++
 arch/arm/boot/dts/at91sam9g45.dtsi                  |    3 +++
 arch/arm/boot/dts/at91sam9x5.dtsi                   |    3 +++
 drivers/iio/adc/at91_adc.c                          |   90 ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++-----
 5 files changed, 107 insertions(+), 5 deletions(-)

Best Regards,
J.
