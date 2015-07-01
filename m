From: richardcochran@gmail.com (Richard Cochran)
Date: Wed,  1 Jul 2015 21:34:01 +0200
Subject: [PATCH 0/2] gpio: dwapb: allow sane gpio numbering
Message-ID: <cover.1435777856.git.rcochran@linutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The dwapb driver always uses dynamic (pseudo-random) gpio numbers
selected in blocks *descending* from the arch's maximum gpio value.
Maybe this was meant for some theoretical hot pluggable gpio
controller, but normal SoC devices have their gpio numbering set in
stone.

This series extends the driver to accept a base number from the device
tree and add the correct base numbers into the dts for the Altera
socfpga.


Richard Cochran (2):
  gpio: dwapb: Use human understandable gpio numbering.
  arm: dts: socfpga: Provide the gpio numbers in the controller nodes.

 Documentation/devicetree/bindings/gpio/snps-dwapb-gpio.txt | 2 ++
 arch/arm/boot/dts/socfpga.dtsi                             | 3 +++
 drivers/gpio/gpio-dwapb.c                                  | 8 +++++++-
 3 files changed, 12 insertions(+), 1 deletion(-)

-- 
2.1.4
