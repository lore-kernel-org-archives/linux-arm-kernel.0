From: martin.blumenstingl@googlemail.com (Martin Blumenstingl)
Date: Sun, 11 Jun 2017 12:03:40 +0200
Subject: [PATCH 0/3] Meson (32-bit) multi_v7_defconfig updates
Message-ID: <20170611100343.25868-1-martin.blumenstingl@googlemail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This enables the following drivers which are supported on Meson8 and
Meson8b (as well as Meson8m2):
- Meson USB2 PHY driver (USB controller support is provided by dwc2,
  which is already enabled)
- Meson PWM driver (used to dim LEDs and generate the 32.768 kHz LPO
  clock for the SDIO wifi modules)
- the generic PWM clock driver (for the 32.768 kHz LPO clock for the
  SDIO wifi modules)


I am not sure if these patches will go through Kevin's Amlogic tree
or through some other tree. However, these should be independent from
anything else, so it's just a matter of preference through which tree
they go.


Martin Blumenstingl (3):
  ARM: multi_v7_defconfig: enable the Amlogic Meson USB2 PHY driver
  ARM: multi_v7_defconfig: enable the Meson PWM controller
  ARM: multi_v7_defconfig: enable the PWM clock driver

 arch/arm/configs/multi_v7_defconfig | 3 +++
 1 file changed, 3 insertions(+)

-- 
2.13.1
