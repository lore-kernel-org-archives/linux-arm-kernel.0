From: wens@csie.org (Chen-Yu Tsai)
Date: Sun, 18 Oct 2015 01:27:08 +0800
Subject: [PATCH v6 0/2] ARM: sunxi: Add Reduced Serial Bus (RSB) controller
 support
Message-ID: <1445102830-21774-1-git-send-email-wens@csie.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi everyone,

This is v6 of the Allwinner Reduced Serial Bus driver. This version puts
the driver under drivers/bus instead of drivers/soc/sunxi. There are no
changes to the binding or the driver itself.

The series is based on v4.3-rc1.

Changes since v5:

 .../bindings/{soc/sunxi/rsb.txt => bus/sunxi-rsb.txt}         |  0
 drivers/bus/Kconfig                                           | 11 +++++++++++
 drivers/bus/Makefile                                          |  1 +
 drivers/{soc/sunxi/sunxi_rsb.c => bus/sunxi-rsb.c}            |  2 +-
 drivers/soc/sunxi/Kconfig                                     | 10 ----------
 drivers/soc/sunxi/Makefile                                    |  1 -
 include/linux/{soc/sunxi/sunxi_rsb.h => sunxi-rsb.h}          |  0
 7 files changed, 13 insertions(+), 12 deletions(-)

The Kconfig entry has been updated with a proper entry description, making
it selectable. Both the entry and help text have been edited to make it
clear this is an Allwinner specific driver. A dependency on ARCH_SUNXI is
also added.


Regards
ChenYu

Chen-Yu Tsai (2):
  bus: sunxi-rsb: Add Allwinner Reduced Serial Bus (RSB) controller
    bindings
  bus: sunxi-rsb: Add driver for Allwinner Reduced Serial Bus

 .../devicetree/bindings/bus/sunxi-rsb.txt          |  47 ++
 drivers/bus/Kconfig                                |  11 +
 drivers/bus/Makefile                               |   1 +
 drivers/bus/sunxi-rsb.c                            | 783 +++++++++++++++++++++
 include/linux/sunxi-rsb.h                          | 105 +++
 5 files changed, 947 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/bus/sunxi-rsb.txt
 create mode 100644 drivers/bus/sunxi-rsb.c
 create mode 100644 include/linux/sunxi-rsb.h

-- 
2.6.1
