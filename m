From: shijie8@gmail.com (Huang Shijie)
Date: Sun,  1 Jul 2012 23:24:33 -0400
Subject: [PATCH v2 0/3] add gpmi support for imx6q
Message-ID: <1341199476-7446-1-git-send-email-shijie8@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patch set adds the gpmi-nand support for imx6q.

I prefer to add the clocks in the gpmi-nand driver.
Yes, it will change the gpmi nand driver, but we have to do so.
The reason is :
  We will support the ONFI nand in mx6q in the future. If the ONFI nand is
  set to Sync mode, we have to __change__ the clocks explicitly.

Test this patch set on imx6q-arm2 board.

v1 --> v2:
	[1] add dev_id for the gpmi-nand's clocks.
	[2] set the default values for these clocks.

Huang Shijie (3):
  ARM: imx6q: add clocks for gpmi-nand
  ARM: imx6q: add DT node for gpmi nand
  mtd: gpmi: change the code for clocks

 arch/arm/boot/dts/imx6q-arm2.dts       |    6 ++
 arch/arm/boot/dts/imx6q.dtsi           |   36 ++++++++++++++
 arch/arm/mach-imx/clk-imx6q.c          |    8 +++-
 drivers/mtd/nand/gpmi-nand/gpmi-lib.c  |   43 ++++++++++++++---
 drivers/mtd/nand/gpmi-nand/gpmi-nand.c |   82 ++++++++++++++++++++++++++++----
 drivers/mtd/nand/gpmi-nand/gpmi-nand.h |    3 +-
 6 files changed, 159 insertions(+), 19 deletions(-)

-- 
1.7.4.4
