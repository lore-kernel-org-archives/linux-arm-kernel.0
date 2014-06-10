From: ch.naveen@samsung.com (Naveen Krishna Chatradhi)
Date: Tue, 10 Jun 2014 14:30:56 +0530
Subject: [PATCH 0/3] spi: s3c64xx: use "cs-gpios" in spi node instead of
 "cs-gpio"
Message-ID: <1402390859-28287-1-git-send-email-ch.naveen@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Currently, spi-s3c64xx.c needs "cs-gpio" chip select GPIO to be
defined under "controller-data" node under each slave node.

&spi_x {
	cs-gpios <>;
	...
	slave_node {

		controller-data {
			cs-gpio = <>;
			...
		};
		...
	};
	...
};

Where as, SPI core and many other drivers uses "cs-gpios" for
from device tree node.

Hence, make changes in spi-s3c64xx.c driver to make use of
"cs-gpios" from SPI node(parent) instead of "cs-gpio" defined in
slaves "controller-data"(child) node.

Also, fixes a compilation warning and corrects the DTS nodes for
Exynos4210 based SMDKv310, Exynos4412 based Trats2, Exynos5250 based
SMDK5250 boards.

Naveen Krishna Chatradhi (3):
based on for-next branch of spi.git
  spi: s3c64xx: use "cs-gpios" from spi node instead of "cs-gpio"
  spi: s3c64xx: remove a compilation warning with an assignment

based on for-next branch of linuxsamsung.git
  ARM: DTS: move "cs-gpio" from "controller-data" to under spi node

 arch/arm/boot/dts/exynos4210-smdkv310.dts |    2 +-
 arch/arm/boot/dts/exynos4412-trats2.dts   |    2 +-
 arch/arm/boot/dts/exynos5250-smdk5250.dts |    2 +-
 drivers/spi/spi-s3c64xx.c                 |   56 ++++++++++++++++++-----------
 4 files changed, 38 insertions(+), 24 deletions(-)

-- 
1.7.9.5
