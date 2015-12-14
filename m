From: ulrich.hecht+renesas@gmail.com (Ulrich Hecht)
Date: Mon, 14 Dec 2015 16:42:32 +0100
Subject: [PATCH 0/6] SATA for r8a7795, Salvator-X
Message-ID: <1450107758-2544-1-git-send-email-ulrich.hecht+renesas@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi!

This is an adaptation of the patch set from the BSP, adjusted to the new PFC
and MSTP clock models.  Applied on top of renesas-drivers, this works great
for me.

CU
Uli


Kouei Abe (3):
  arm64: dts: r8a7795: Add SATA controller node
  arm64: dts: salvator-x: Enable SATA controller
  arm64: defconfig: Add Renesas R-Car SATA driver for R-Car Gen3 SoCs

Takeshi Kihara (1):
  pinctrl: sh-pfc: r8a7795: Add SATA support

Ulrich Hecht (2):
  clk: shmobile: r8a7795: Add SATA0 clock
  pinctrl: sh-pfc: r8a7795: add SATA0 pin conf to DT

 arch/arm64/boot/dts/renesas/r8a7795-salvator-x.dts | 11 ++++++++++
 arch/arm64/boot/dts/renesas/r8a7795.dtsi           |  8 ++++++++
 arch/arm64/configs/defconfig                       |  1 +
 drivers/clk/shmobile/r8a7795-cpg-mssr.c            |  1 +
 drivers/pinctrl/sh-pfc/pfc-r8a7795.c               | 24 ++++++++++++++++++++++
 5 files changed, 45 insertions(+)

-- 
2.6.3
