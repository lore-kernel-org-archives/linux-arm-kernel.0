From: linux@baker-net.org.uk (Adam Baker)
Date: Sun, 28 Feb 2016 22:30:11 +0000
Subject: [PATCH v3 0/3] driver for the hardware monitoring chip in the Zyxel
 NSA320
Message-ID: <1456698614-15176-1-git-send-email-linux@baker-net.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patch series adds a driver to support the hardware monitoring MCU
that is present in the Zyxel NSA320. It is believed that this is
identical to the one used in the NSA325 and some variants of the NSA310.

 Documentation/devicetree/bindings/hwmon/nsa320-mcu.txt |  21 +++
 Documentation/hwmon/nsa320                             |  53 +++++++
 arch/arm/boot/dts/kirkwood-nsa320.dts                  |  13 +-
 drivers/hwmon/Kconfig                                  |  15 ++
 drivers/hwmon/Makefile                                 |   1 +
 drivers/hwmon/nsa320-hwmon.c                           | 215 ++++++++++++++++++++++++++++
 6 files changed, 316 insertions(+), 2 deletions(-)

---
Changes since v1
Update to reflect linux at roeck-us.netreview comments from Guenter Roeck,
mainly changing it to be nsa320, not nsa3xx but also making it
return an errno on failure and various other tidy ups.

Changes since v2
Update patch 2/3 based on further review from Guenter Roeck, patches
1/3 and 3/3 are unchanged except for adding Rob's Ack to 1/3
