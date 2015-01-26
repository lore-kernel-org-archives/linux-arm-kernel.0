From: maxime.ripard@free-electrons.com (Maxime Ripard)
Date: Mon, 26 Jan 2015 15:56:02 +0100
Subject: [PATCH v2 0/2] ARM: mvebu: a385-db-ap: Enable the NAND controller
Message-ID: <1422284164-16867-1-git-send-email-maxime.ripard@free-electrons.com>
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

Changes from v1:
  - Added a timeout to the busy waiting loop for RDDREQ

Maxime Ripard (2):
  mtd: nand: pxa3xx: Fix PIO FIFO draining
  ARM: mvebu: a385-db-ap: Enable the NAND

 arch/arm/boot/dts/armada-385-db-ap.dts | 13 ++++++++++
 drivers/mtd/nand/pxa3xx_nand.c         | 45 +++++++++++++++++++++++++++++-----
 2 files changed, 52 insertions(+), 6 deletions(-)

-- 
2.2.2
