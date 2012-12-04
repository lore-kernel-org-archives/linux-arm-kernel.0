From: manabian@gmail.com (Joachim Eastwood)
Date: Tue,  4 Dec 2012 19:10:55 +0100
Subject: [PATCH 0/4] AT91RM9200 MMC, SSC and EMAC bindings
Message-ID: <1354644659-31385-1-git-send-email-manabian@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

These patches create bindings for MMC, SSC and EMAC in the AT91RM9200 devicetree. Patches are based on the pinctrl tree (at91 branch) since that's where the rest of the RM9200 devicetree patches is located.

Patch 1 is a short fix for the RM9200 pins. Forgot to change the pins when I copied the bindings from another SoC.

Patch 2 creates bindings for MMC on RM9200. I have not been able to test the bindings since my board doesn't have MMC.

Patch 3 creates SSC bindings. Clock additions are also needed but these will coming through the ASoC tree. SSC bindings seem to work. I haven't been able to test actual audio though.

Patch 4 creates EMAC bindings. These are tested and are working.


I also have bindings for I2c and SPI on RM9200. I'll send patches when Atmel SPI support hits next.


Joachim Eastwood (4):
  ARM: at91: fix gpios on i2c-gpio for RM9200 DT
  ARM: at91: add MMC bindings to RM9200 DT
  ARM: at91: add SSC bindings to RM9200 DT
  ARM: at91: add EMAC bindings to RM9200 DT

 arch/arm/boot/dts/at91rm9200.dtsi  | 162 ++++++++++++++++++++++++++++++++++++-
 arch/arm/boot/dts/at91rm9200ek.dts |   5 ++
 arch/arm/mach-at91/at91rm9200.c    |   2 +
 3 files changed, 167 insertions(+), 2 deletions(-)

-- 
1.8.0
