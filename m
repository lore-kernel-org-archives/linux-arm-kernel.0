From: manu@freebsd.org (Emmanuel Vadot)
Date: Mon, 13 Jun 2016 22:37:03 +0200
Subject: [PATCH 0/3] Allwinner MMC Fifo register
Message-ID: <1465850226-37420-1-git-send-email-manu@freebsd.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi everyone,

The mmc fifo register in A31 and later is at address 0x200 (0x100 for A10 and A20).
Therefore the compatible string shouldn't be the same.

Emmanuel Vadot (3):
  Change compatible string to "allwinner,sun6i-a31-mmc" for A31, A23-A33
    and H3.
  Add "allwinner,sun6i-a31-mmc" compatible string in the Documentation.
  Add "allwinner,sun6i-a31-mmc" support in the driver.

 Documentation/devicetree/bindings/mmc/sunxi-mmc.txt | 3 ++-
 arch/arm/boot/dts/sun6i-a31.dtsi                    | 8 ++++----
 arch/arm/boot/dts/sun8i-a23-a33.dtsi                | 6 +++---
 arch/arm/boot/dts/sun8i-h3.dtsi                     | 6 +++---
 drivers/mmc/host/sunxi-mmc.c                        | 1 +
 5 files changed, 13 insertions(+), 11 deletions(-)

-- 
2.8.1
