From: romain.perier@gmail.com (Romain Perier)
Date: Mon, 19 Jan 2015 18:08:05 +0000
Subject: [PATCH v1 0/4] net: stmmac: dwmac-rk: Fix phy regulator issues
Message-ID: <1421690889-11901-1-git-send-email-romain.perier@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This series fixes few issues in dwmac-rk:

1. Voltage settings was hardcoded into the driver for the phy regulator.
   The driver now uses the default voltage settings found in the devicetree, which are
   applied throught the regulator framework.
2. The regulator name used to power on or power off the phy was put in the devicetree
   variable "phy_regulator", which is not standard and added a lot of code for nothing.
   The driver now uses the devicetree property "phy-supply" and the corresponding functions
   to manipulate this regulator.

The corresponding devicetree files are also updated. As, dwmac-rk was recently
pushed in the development tree, I don't care about devicetree backward compatibility
issues.

Romain Perier (4):
  net: stmmac: dwmac-rk: Don't set the regulator voltage for phy from
    the driver
  ARM: dts: Add regulator voltage settings for vcc_phy in
    rk3288-evb.dtsi
  net: stmmac: dwmac-rk: Use standard devicetree property for phy
    regulator
  ARM: dts: Convert gmac to phy-supply in rk3288-evb-rk808.dts

 arch/arm/boot/dts/rk3288-evb-rk808.dts         |  2 +-
 arch/arm/boot/dts/rk3288-evb.dtsi              |  2 +
 drivers/net/ethernet/stmicro/stmmac/dwmac-rk.c | 62 ++++++++------------------
 3 files changed, 22 insertions(+), 44 deletions(-)

-- 
1.9.1
