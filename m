From: srinivas.kandagatla@st.com (srinivas.kandagatla at st.com)
Date: Mon, 3 Feb 2014 11:59:47 +0000
Subject: [PATCH v1 0/3] net: stmmac: Add STi GMAC ethernet
Message-ID: <1391428787-27143-1-git-send-email-srinivas.kandagatla@st.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Srinivas Kandagatla <srinivas.kandagatla@st.com>

Hi All,

This patch series adds Ethernet support to STi series SOCs STiH415 and STiH416.
STi SOC series integrates dwmac IP from synopsis, however there is a hardware
glue on top of this standard IP, this glue needs to configured before the
actual dwmac can be used.  Also the glue logic needs re-configuring when the
link speed changes, This is because the clk source can change as the link
speed.

This patch just adds STi specific callbacks into of_data for configuring the
glue layer.

I have rebased my original patches (http://lkml.org/lkml/2013/11/12/243)
to latest stmmac which updates callbacks to suit glue drivers like this.

These patches are tested on b2000 and B2020 with STiH415 and STiH416.

Thanks,
srini

Srinivas Kandagatla (3):
  net: stmmac:sti: Add STi SOC glue driver.
  ARM: STi: Add STiH415 ethernet support.
  ARM: STi: Add STiH416 ethernet support.

 .../devicetree/bindings/net/sti-dwmac.txt          |   58 ++++
 arch/arm/boot/dts/stih415-clock.dtsi               |   14 +
 arch/arm/boot/dts/stih415-pinctrl.dtsi             |  121 +++++++
 arch/arm/boot/dts/stih415.dtsi                     |   48 +++
 arch/arm/boot/dts/stih416-clock.dtsi               |   14 +
 arch/arm/boot/dts/stih416-pinctrl.dtsi             |  109 +++++++
 arch/arm/boot/dts/stih416.dtsi                     |   44 +++
 arch/arm/boot/dts/stih41x-b2000.dtsi               |   22 ++
 arch/arm/boot/dts/stih41x-b2020.dtsi               |   26 ++
 drivers/net/ethernet/stmicro/stmmac/Kconfig        |   11 +
 drivers/net/ethernet/stmicro/stmmac/Makefile       |    1 +
 drivers/net/ethernet/stmicro/stmmac/dwmac-sti.c    |  331 ++++++++++++++++++++
 drivers/net/ethernet/stmicro/stmmac/stmmac.h       |    3 +
 .../net/ethernet/stmicro/stmmac/stmmac_platform.c  |    5 +
 14 files changed, 807 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/net/sti-dwmac.txt
 create mode 100644 drivers/net/ethernet/stmicro/stmmac/dwmac-sti.c

-- 
1.7.9.5
