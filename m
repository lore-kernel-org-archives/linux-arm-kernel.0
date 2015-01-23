From: maxime.ripard@free-electrons.com (Maxime Ripard)
Date: Fri, 23 Jan 2015 16:41:41 +0100
Subject: [PATCH 0/2] ARM: mvebu: a385-db-ap: Enable the NAND controller
Message-ID: <1422027703-3763-1-git-send-email-maxime.ripard@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

This patch serie enable the NAND support on the Armada 385 Access
Point DB.

In the process, some timeouts were found when we were accessing a
freshly erased NAND page, which turned out to be an issue when
draining the read FIFO where we were not following the datasheet.

This has been fixed with the first patch, with stable CC'd. The second
patch just enables the NAND controller in the DT.

Thanks,
Maxime

Maxime Ripard (2):
  mtd: nand: pxa3xx: Fix PIO FIFO draining
  ARM: mvebu: a385-db-ap: Enable the NAND

 arch/arm/boot/dts/armada-385-db-ap.dts | 13 ++++++++++++
 drivers/mtd/nand/pxa3xx_nand.c         | 36 ++++++++++++++++++++++++++++------
 2 files changed, 43 insertions(+), 6 deletions(-)

-- 
2.2.2
