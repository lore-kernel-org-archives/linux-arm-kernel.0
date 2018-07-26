From: arun.parameswaran@broadcom.com (Arun Parameswaran)
Date: Thu, 26 Jul 2018 11:36:17 -0700
Subject: [PATCH 0/7] Add clock config and pm support to bcm iProc mdio mux
Message-ID: <1532630184-29450-1-git-send-email-arun.parameswaran@broadcom.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,
The patchset is based on David Miller's "net" repo.

The patchset extends the Broadcom iProc mdio mux to add support for
suspend/resume and the ability to configure the internal clock
divider.

The base address of the mdio-mux-bcm-iproc is modified to point to the
start of the mdio block's address space, to be able to access all the
mdio's registers. The missing registers are required to configure the
internal clock divider registers in some of the Broadcom SoC's.

Thanks
Arun

Arun Parameswaran (7):
  dt-bindings: net: Fix Broadcom iProc mdio mux driver base address
  net: phy: Fix the register offsets in Broadcom iProc mdio mux driver
  arm64: dts: Fix the base address of the Broadcom iProc mdio mux
  dt-bindings: net: Add clock handle to Broadcom iProc mdio mux
  net: phy: Add support to configure clock in Broadcom iProc mdio mux
  net: phy: Add pm support to Broadcom iProc mdio mux driver
  net: phy: Add pm support for scan ctrl register to bcm mdio mux

 .../bindings/net/brcm,mdio-mux-iproc.txt           |  7 +-
 arch/arm64/boot/dts/broadcom/northstar2/ns2.dtsi   |  4 +-
 .../arm64/boot/dts/broadcom/stingray/stingray.dtsi |  4 +-
 drivers/net/phy/mdio-mux-bcm-iproc.c               | 89 ++++++++++++++++++++--
 4 files changed, 92 insertions(+), 12 deletions(-)

-- 
1.9.1
