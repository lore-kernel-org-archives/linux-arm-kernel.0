From: linux@baker-net.org.uk (Adam Baker)
Date: Sat,  5 Mar 2016 15:34:54 +0000
Subject: [PATCH v4 0/3] driver for the hardware monitoring chip in the Zyxel
 NSA320
Message-ID: <1457192097-32538-1-git-send-email-linux@baker-net.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

 Documentation/devicetree/bindings/hwmon/nsa320-mcu.txt |  21 +++++
 Documentation/hwmon/nsa320                             |  53 +++++++++++
 arch/arm/boot/dts/kirkwood-nsa320.dts                  |  13 ++-
 drivers/hwmon/Kconfig                                  |  15 +++
 drivers/hwmon/Makefile                                 |   1 +
 drivers/hwmon/nsa320-hwmon.c                           | 216 ++++++++++++++++++++++++++++++++++++++++++++
 6 files changed, 317 insertions(+), 2 deletions(-)

Changes since v3
Use s32 as the return value from nsa320_hwmon_update

Changes since v2
Update patch 2/3 based on further review from Guenter Roeck, patches
1/3 and 3/3 are unchanged except for adding Rob's Ack to 1/3

Changes since v1
Update to reflect review comments from Guenter Roeck,
mainly changing it to be nsa320, not nsa3xx but also making it
return an errno on failure and various other tidy ups.
