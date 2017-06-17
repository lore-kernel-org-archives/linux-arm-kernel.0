From: icenowy@aosc.io (Icenowy Zheng)
Date: Sat, 17 Jun 2017 22:07:33 +0800
Subject: [PATCH 0/4] net-next: stmmac: dwmac-sun8i: add support for V3s
Message-ID: <20170617140737.41951-1-icenowy@aosc.io>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Allwinner V3s features an EMAC like the on in H3, but without external MII
interfaces, so being not able really to use RMII/RGMII.

And it has a different default value of syscon (0x38000 instead of 0x58000
on H3), which shows a problem that the EMAC clock freq should be 24MHz.
(Both H3 and V3s SoCs doesn't have extra xtal input for EPHY, and the
main xtal is 24MHz. The default value of H3 is set to 24MHz, but the V3s
default value is set to 25MHz).

First two patches are device tree binding patches, the third forces
the frequency to 24MHz and the fourth really add the V3s support.

Icenowy Zheng (4):
  dt-bindings: net-next: Add DT bindings documentation for Allwinner V3s
    EMAC
  dt-bindings: syscon: Add DT bindings documentation for Allwinner V3s
    syscon
  net-next: stmmac: dwmac-sun8i: force EPHY clock freq to 24MHz
  net-next: stmmac: dwmac-sun8i: add support for V3s EMAC

 Documentation/devicetree/bindings/misc/allwinner,syscon.txt |  1 +
 Documentation/devicetree/bindings/net/dwmac-sun8i.txt       | 10 ++++++++--
 drivers/net/ethernet/stmicro/stmmac/dwmac-sun8i.c           | 12 ++++++++++++
 drivers/net/ethernet/stmicro/stmmac/stmmac_platform.c       |  1 +
 4 files changed, 22 insertions(+), 2 deletions(-)

-- 
2.13.0
