From: alexandre.belloni@bootlin.com (Alexandre Belloni)
Date: Thu,  7 Jun 2018 10:41:03 +0200
Subject: [PATCH 0/4] Fix suspend resume on at91sam9261 and at91sam9263
Message-ID: <20180607084107.4461-1-alexandre.belloni@bootlin.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

USB clock detection may not work properly on at91sam9261 and at91sam9263
because they currently use the same bit mask as at91rm9200 instead of
the one for at91sam9260.

Take the opportunity to also change the PMC compatible strings for all
the other SoCs in preparation for the new clock bindings.

Alexandre Belloni (4):
  dt-bindings: arm: remove PMC bindings
  dt-bindings: clk: at91: Document all the PMC compatibles
  ARM: at91: fix USB clock detection handling
  ARM: dts: fix PMC compatible

 .../devicetree/bindings/arm/atmel-pmc.txt          | 14 --------------
 .../devicetree/bindings/clock/at91-clock.txt       |  9 ++++-----
 arch/arm/boot/dts/at91sam9261.dtsi                 |  2 +-
 arch/arm/boot/dts/at91sam9263.dtsi                 |  2 +-
 arch/arm/boot/dts/at91sam9rl.dtsi                  |  2 +-
 arch/arm/boot/dts/sama5d4.dtsi                     |  2 +-
 arch/arm/mach-at91/pm.c                            |  5 +++++
 7 files changed, 13 insertions(+), 23 deletions(-)
 delete mode 100644 Documentation/devicetree/bindings/arm/atmel-pmc.txt

-- 
2.17.1
