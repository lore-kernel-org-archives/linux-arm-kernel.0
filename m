From: woogyom.kim@gmail.com (Milo Kim)
Date: Fri, 28 Oct 2016 15:54:08 +0900
Subject: [PATCH v2 0/4] Support H3 SPI controller
Message-ID: <20161028065412.23008-1-woogyom.kim@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Allwinner H3 SPI controller has same architecture as A31.
So most configuration is identical except one thing - FIFO capacity.

                         A31    H3
------------------------------------
Number of controllers     4      2
Number of FIFO depth     128    64
Transfer bits             8      8

Register maps are sharable, so sun6i SPI driver is reusable with
device configuration.

Tested on Nano Pi M1 and SPI slave device is TI LP8860.

v2:
  Include DTS patches
  Use of_device_get_match_data() helper to get device specific data
  Fix build warning of 64bit CPU architecture
    (warning: cast from pointer to integer of different size
     [-Wpointer-to-int-cast])

Milo Kim (4):
  ARM: dts: sun8i: Add SPI pinctrl node in H3
  ARM: dts: sun8i: Add SPI controller node in H3
  spi: sun6i: Add binding for Allwinner H3 SPI controller
  spi: sun6i: Support Allwinner H3 SPI controller

 .../devicetree/bindings/spi/spi-sun6i.txt          | 25 +++++++++++-
 arch/arm/boot/dts/sun8i-h3.dtsi                    | 46 ++++++++++++++++++++++
 drivers/spi/spi-sun6i.c                            | 18 ++++++---
 3 files changed, 82 insertions(+), 7 deletions(-)

-- 
2.9.3
