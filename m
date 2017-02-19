From: martin.blumenstingl@googlemail.com (Martin Blumenstingl)
Date: Sun, 19 Feb 2017 23:23:24 +0100
Subject: [PATCH 0/1] ARM64: defconfig: add support for PWM LEDs
Message-ID: <20170219222325.7085-1-martin.blumenstingl@googlemail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Some ARM64 boards (such as the Khadas VIM and many other Amlogic based
devices) have one of the LEDs connected through a PWM controller. This
allows dimming the LED.

The ARM64 defconfig does not support the leds-pwm driver yet. Enabling
that also means that we have to enable the default-on LED trigger.
leds-gpio has a (trigger specific) "default-state" property which can
be used to set the default state, while with leds-pwm this has to be
configured using the default-on trigger.

Martin Blumenstingl (1):
  ARM64: defconfig: enable the leds-pwm driver and default-on trigger

 arch/arm64/configs/defconfig | 2 ++
 1 file changed, 2 insertions(+)

-- 
2.11.1
