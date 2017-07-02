From: clabbe.montjoie@gmail.com (Corentin Labbe)
Date: Sun,  2 Jul 2017 14:31:53 +0200
Subject: [PATCH 0/6] net: stmmac: revert "support future possible different
 internal phy mode"
Message-ID: <20170702123159.6939-1-clabbe.montjoie@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello

The current way to find if the phy is internal is to compare DT phy-mode
and emac_variant/internal_phy.
But it will negate a possible future SoC where an external PHY use the
same phy mode than the internal one.

My first idea was to use phy-mode = "internal" but since internal phy-mode
is reserved for non-xMII protocol we cannot use it with dwmac-sun8i

I will send an additionnal patch for documenting more phy-mode = "internal"

Corentin Labbe (6):
  arm: sun8i: nanopi-neo: revert use internal phy-mode
  arm: sun8i: orangepi-2: revert "use internal phy-mode"
  arm: sun8i: orangepi-one: revert "use internal phy-mode"
  arm: sun8i: orangepi-zero: revert "use internal phy-mode"
  arm: sun8i: orangepipc: revert "use internal phy-mode"
  net: stmmac: revert "support future possible different internal phy
    mode"

 arch/arm/boot/dts/sun8i-h2-plus-orangepi-zero.dts |  2 +-
 arch/arm/boot/dts/sun8i-h3-nanopi-neo.dts         |  2 +-
 arch/arm/boot/dts/sun8i-h3-orangepi-2.dts         |  2 +-
 arch/arm/boot/dts/sun8i-h3-orangepi-one.dts       |  2 +-
 arch/arm/boot/dts/sun8i-h3-orangepi-pc.dts        |  2 +-
 drivers/net/ethernet/stmicro/stmmac/dwmac-sun8i.c | 10 +++-------
 6 files changed, 8 insertions(+), 12 deletions(-)

-- 
2.13.0
