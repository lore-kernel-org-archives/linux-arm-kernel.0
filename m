From: ivan.khoronzhuk@ti.com (Ivan Khoronzhuk)
Date: Wed, 11 Dec 2013 20:00:27 +0200
Subject: [PATCH 0/3] Introduce clocksource driver for Keystone platform
Message-ID: <1386784830-15863-1-git-send-email-ivan.khoronzhuk@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Add a backup timer64 based clockevent driver for keystone arch.
This driver uses timer in 64-bit general purpose mode as clock event
device.

Ivan Khoronzhuk (3):
  clocksource: timer-keystone: introduce clocksource driver for
    Keystone
  clocksource: keystone: add bindings for keystone timer
  arm: dts: keystone: add keystone timer entry

 .../bindings/timer/ti,keystone-timer.txt           |   29 +++
 arch/arm/boot/dts/keystone-clocks.dtsi             |   10 +
 arch/arm/boot/dts/keystone.dtsi                    |    7 +
 drivers/clocksource/Makefile                       |    1 +
 drivers/clocksource/timer-keystone.c               |  223 ++++++++++++++++++++
 5 files changed, 270 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/timer/ti,keystone-timer.txt
 create mode 100644 drivers/clocksource/timer-keystone.c

-- 
1.7.9.5
