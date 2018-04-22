From: martin.blumenstingl@googlemail.com (Martin Blumenstingl)
Date: Sun, 22 Apr 2018 12:38:03 +0200
Subject: [PATCH 0/2] Amlogic 32-bit multi_v7_defconfig updates
Message-ID: <20180422103805.1324-1-martin.blumenstingl@googlemail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Some boards come with a PMU (system power controller, such as the Ricoh
RN5T618). These need CONFIG_I2C_MESON built-in so the regulators can be
set up during boot.

Also enable CONFIG_PWM_MESON (as module) because some boards use it to
dim the LED and/or generate the 32.768 kHz clock for the SDIO wifi chip.

@Kevin: I assume that you'll take this through your tree, so no immediate
action from the arm-soc maintainers needed, right?


Martin Blumenstingl (2):
  arm: multi_v7_defconfig: enable the Amlogic Meson I2C driver
  ARM: multi_v7_defconfig: enable the Meson PWM controller

 arch/arm/configs/multi_v7_defconfig | 2 ++
 1 file changed, 2 insertions(+)

-- 
2.17.0
