From: clabbe.montjoie@gmail.com (Corentin Labbe)
Date: Fri, 28 Jul 2017 11:28:15 +0200
Subject: [PATCH 0/3] net-next: stmmac: support future possible different
 internal phy mode
Message-ID: <20170728092818.23419-1-clabbe.montjoie@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello

The current way to find if the phy is internal is to compare DT phy-mode
and emac_variant/internal_phy.
But it will negate a possible future SoC where an external PHY use the
same phy mode than the internal one.

This patchs series adds a new way to find if the PHY is internal, via its
compatible.

Corentin Labbe (3):
  dt-bindings: net: add compatible for internal sun8i-h3/sun8i-v3s PHYs
  ARM: sunxi: h3/h5: Add sun8i-h3-ephy compatible
  net-next: stmmac: dwmac-sun8i: choose internal PHY via compatible

 Documentation/devicetree/bindings/net/dwmac-sun8i.txt |  4 ++--
 arch/arm/boot/dts/sunxi-h3-h5.dtsi                    |  3 ++-
 drivers/net/ethernet/stmicro/stmmac/dwmac-sun8i.c     | 16 ++++++++++------
 3 files changed, 14 insertions(+), 9 deletions(-)

-- 
2.13.0
