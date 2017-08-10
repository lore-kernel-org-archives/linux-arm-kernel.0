From: clabbe.montjoie@gmail.com (Corentin Labbe)
Date: Thu, 10 Aug 2017 10:51:26 +0200
Subject: [PATCH 0/3] net: stmmac: Detect PHY location with phy-is-integrated
Message-ID: <20170810085129.20463-1-clabbe.montjoie@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello

The current way to find if the phy is internal is to compare DT phy-mode
and emac_variant/internal_phy.
But it will negate a possible future SoC where an external PHY use the
same phy mode than the internal one.

This patchs series adds a new way to find if the PHY is internal, via
the phy-is-integrated DT property.

The first and third patch should go via the net tree.
the second via the sunxi tree.

Thanks
Regards

Corentin Labbe (3):
  Documentation: bindings: Add documentation for phy-is-integrated
  ARM: sun8i: sunxi-h3-h5: add phy-is-integrated property to internal
    PHY
  net: stmmac: dwmac-sun8i: choose internal PHY via phy-is-integrated

 Documentation/devicetree/bindings/net/phy.txt     |  4 ++++
 arch/arm/boot/dts/sunxi-h3-h5.dtsi                |  1 +
 drivers/net/ethernet/stmicro/stmmac/dwmac-sun8i.c | 16 ++++++++--------
 3 files changed, 13 insertions(+), 8 deletions(-)

-- 
2.13.0
