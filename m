From: david.lanzendoerfer@o2s.ch (David =?utf-8?q?Lanzend=C3=B6rfer?=)
Date: Wed, 05 Feb 2014 14:53:31 +0100
Subject: [PATCH v3 0/7] ARM: sunxi: Add driver for SD/MMC hosts found on
 allwinner sunxi SOCs
Message-ID: <20140205134741.3027.50207.stgit@dizzy-6.o2s.ch>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello
The following patchset adds support for the SD/MMC host found in the Allwinner SoCs.
It contains all the necessary modifications for clock environment and also the device
tree script modification which add it to all the boards using it.
The clock environment function needed for phase offset configuration has
been proposed and implemented by Emilio.
A lot of work and cleanup has been done by Hans de Goede. Special thanks to him!
This patchset is the third attempt to send this driver upstream.
It addresses special remarks about coding style and API usage and incorporates proposed
corrections into the previous commits.
It also includes the patch of Emilios, I forgot to include last time.

best regards
David

---

David Lanzend?rfer (4):
      ARM: sunxi: Add driver for SD/MMC hosts found on Allwinner sunxi SoCs
      ARM: dts: sun7i: Add support for mmc
      ARM: dts: sun4i: Add support for mmc
      ARM: dts: sun5i: Add support for mmc

Emilio L?pez (2):
      clk: sunxi: factors: automatic reparenting support
      clk: sunxi: Implement MMC phase control

Hans de Goede (1):
      ARM: sunxi: clk: export clk_sunxi_mmc_phase_control


 arch/arm/boot/dts/sun4i-a10-a1000.dts            |    8 
 arch/arm/boot/dts/sun4i-a10-cubieboard.dts       |    8 
 arch/arm/boot/dts/sun4i-a10.dtsi                 |   54 +
 arch/arm/boot/dts/sun5i-a10s-olinuxino-micro.dts |   30 +
 arch/arm/boot/dts/sun5i-a10s.dtsi                |   44 +
 arch/arm/boot/dts/sun5i-a13-olinuxino-micro.dts  |   15 
 arch/arm/boot/dts/sun5i-a13-olinuxino.dts        |   15 
 arch/arm/boot/dts/sun5i-a13.dtsi                 |   37 +
 arch/arm/boot/dts/sun7i-a20-cubieboard2.dts      |    8 
 arch/arm/boot/dts/sun7i-a20-cubietruck.dts       |    8 
 arch/arm/boot/dts/sun7i-a20-olinuxino-micro.dts  |   23 +
 arch/arm/boot/dts/sun7i-a20.dtsi                 |   61 ++
 drivers/clk/sunxi/clk-factors.c                  |   36 +
 drivers/clk/sunxi/clk-sunxi.c                    |   35 +
 drivers/mmc/host/Kconfig                         |    7 
 drivers/mmc/host/Makefile                        |    2 
 drivers/mmc/host/sunxi-mci.c                     |  859 ++++++++++++++++++++++
 drivers/mmc/host/sunxi-mci.h                     |  239 ++++++
 include/linux/clk/sunxi.h                        |   22 +
 19 files changed, 1511 insertions(+)
 create mode 100644 drivers/mmc/host/sunxi-mci.c
 create mode 100644 drivers/mmc/host/sunxi-mci.h
 create mode 100644 include/linux/clk/sunxi.h

-- 
Signature
