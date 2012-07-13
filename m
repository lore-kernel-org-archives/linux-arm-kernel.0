From: vipulkumar.samar@st.com (Vipul Kumar Samar)
Date: Fri, 13 Jul 2012 14:53:47 +0530
Subject: [PATCH V2 0/7] ARM: SPEAr13xx: Minor fixes and updation
Message-ID: <cover.1342171151.git.vipulkumar.samar@st.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

-v2:
-Fix check retrun value from clk_set_rate and clk_set_parent.
-Fix sys_clk mask value.
-Additional patch for overwrite platform data passed from auxdata_lookup

-v1:
-Fix interrupt bindings for ethernet, i2c,.
-Fix clk enable register for uart1 and i2c1.
-Fix register con_id for ethernet.
-Update sys_clk parent.
-Pass ethernet platform data from auxdata lookup.
-Add local timer clock.

Vipul Kumar Samar (7):
  ARM: SPEAr13xx: Fix Interrupt bindings
  clk: SPEAr1340: Fix clk enable register for uart1 and i2c1.
  clk: SPEAr13xx: Add localtimer (twd) clock support
  Clk : SPEAr13xx: Register con_id for Ethernet phy clks
  Clk: SPEAr1340: Update sys clock parent array
  ARM: SPEAr13xx: Add auxdata for Ethernet controller.
  net: stmmac: Overwrite platform data if passed from auxdata

 arch/arm/boot/dts/spear13xx.dtsi                   |   11 +-
 arch/arm/mach-spear13xx/include/mach/generic.h     |    2 +
 arch/arm/mach-spear13xx/include/mach/spear.h       |    1 +
 arch/arm/mach-spear13xx/spear1340.c                |   32 ++++++
 arch/arm/mach-spear13xx/spear13xx.c                |  104 ++++++++++++++++++++
 drivers/clk/spear/spear1310_clock.c                |   14 ++-
 drivers/clk/spear/spear1340_clock.c                |   14 ++-
 .../net/ethernet/stmicro/stmmac/stmmac_platform.c  |    5 +-
 8 files changed, 166 insertions(+), 17 deletions(-)

-- 
1.7.2.2
