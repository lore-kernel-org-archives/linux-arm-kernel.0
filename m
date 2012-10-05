From: lee.jones@linaro.org (Lee Jones)
Date: Fri,  5 Oct 2012 16:31:36 +0100
Subject: [PATCH 00/10] Platform data clean-up and UIB device enablement
Message-ID: <1349451107-8009-1-git-send-email-lee.jones@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

In this patch-set we move all Device Tree start-up code from the u8500
board file and into the more persistent db8500 cpu file. This will aid
future endeavours to remove platform code completely from Mainline. We
also enable some of the devices found on the STUIB (User Interface
board), which attaches to some of ST-Ericsson's reference platforms.

 .../devicetree/bindings/input/stmpe-keypad.txt     |   39 +++++
 Documentation/devicetree/bindings/mfd/stmpe.txt    |   25 ++++
 arch/arm/boot/dts/stuib.dtsi                       |   40 ++++++
 drivers/input/keyboard/stmpe-keypad.c              |   67 +++++++--
 drivers/mfd/stmpe.c                                |  152 +++++++++++++-------
 drivers/of/of_i2c.c                                |    3 +
 include/linux/mfd/stmpe.h                          |    2 +
 7 files changed, 271 insertions(+), 57 deletions(-)
