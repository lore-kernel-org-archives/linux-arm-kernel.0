From: linux@baker-net.org.uk (Adam Baker)
Date: Mon, 15 Feb 2016 23:25:01 +0000
Subject: [PATCH v2] A driver for the hardware monitoring chip in the Zyxel
 NSA320
Message-ID: <1455578705-10531-1-git-send-email-linux@baker-net.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patch series adds a driver to support the hardware monitoring MCU
that is present in the Zyxel NSA320. It is believed that this is
identical to the one used in the NSA325 and some variants of the NSA310.

 Documentation/devicetree/bindings/hwmon/nsa320-mcu.txt |  21 ++++++++
 arch/arm/boot/dts/kirkwood-nsa320.dts                  |  13 ++++-
 drivers/hwmon/Kconfig                                  |  15 ++++++
 drivers/hwmon/Makefile                                 |   1 +
 drivers/hwmon/nsa320-hwmon.c                           | 215 +++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
 5 files changed, 263 insertions(+), 2 deletions(-)


Changes since v1
Update to reflect review comments from Guenter Roeck,
mainly changing it to be nsa320, not nsa3xx but also making it
return an errno on failure and various other tidy ups.

I'm not sure what protocol is with regard to adding tags to a patch
when updating it, in v1

patch 1 received
Acked-by: Rob Herring <robh@kernel.org>

patch 2 was reviewed by Guenter Roeck but does the reviewed by tag
only get added if he agrees with the changes?

Sebastian Hesselbarth reviewed an early draft before it was posted
publicly.
