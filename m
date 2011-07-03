From: shawn.guo@linaro.org (Shawn Guo)
Date: Sun,  3 Jul 2011 15:55:58 +0800
Subject: [PATCH 0/2] Add device tree probe support for tty/serial/imx
Message-ID: <1309679760-22796-1-git-send-email-shawn.guo@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The first patch removes the use of cpu_is_mx1().  It has no dependency
on other patches, and can be merged right away after review gets done.
I assume it will go through Sascha's tree with Alan's ack, since it
touches quite some arch codes.  Please let me know if it's not the case.

The second patch adds device tree probe, and depends on the patch
below.

  http://article.gmane.org/gmane.linux.drivers.devicetree/6128

Grant, how does the above patch look to you?  I have been seeing
a number of drivers depending on it when migrating to device tree.
It will be good if we can git it settled soon.

Shawn Guo (2):
      serial/imx: get rid of the uses of cpu_is_mx1()
      serial/imx: add device tree probe support

 .../bindings/tty/serial/fsl-imx-uart.txt           |   19 +++
 arch/arm/mach-imx/clock-imx1.c                     |    6 +-
 arch/arm/plat-mxc/devices/platform-imx-uart.c      |    2 +-
 drivers/tty/serial/imx.c                           |  131 +++++++++++++++++--
 4 files changed, 140 insertions(+), 18 deletions(-)
