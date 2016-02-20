From: f.fainelli@gmail.com (Florian Fainelli)
Date: Sat, 20 Feb 2016 11:46:23 -0800
Subject: [GIT PULL 4/8] Broadcom devicetree-arm64 changes for 4.6
In-Reply-To: <1455997587-17564-1-git-send-email-f.fainelli@gmail.com>
References: <1455997587-17564-1-git-send-email-f.fainelli@gmail.com>
Message-ID: <1455997587-17564-4-git-send-email-f.fainelli@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

  Linux 4.5-rc1 (2016-01-24 13:06:47 -0800)

are available in the git repository at:

  http://github.com/Broadcom/stblinux.git tags/arm-soc/for-4.6/devicetree-arm64

for you to fetch changes up to f008decc4797979bc1d3b8efd18bd5df1e53e9f0:

  dt-bindings: Add documentation for Broadcom Vulcan (2016-02-20 10:42:51 -0800)

----------------------------------------------------------------
This pull request contains Broadcom ARM64-based SoCs device tree changes:

- Anup adds additional nodes to the Broadcom Northstart 2 Device Trees: SDHCI
  (iProc-compatible), ARM SP804 timers, ARM SP805 watchdog

- Anup also adds a binding documentation for the ARM SP805 watchdog since there
  was not one in tree before

- Ray adds PCIE root complex nodes to the Northstar 2 Device Tree nodes, using
  the iProc-compatible binding

- Jayachandran C. adds binding documentation for the Broadcom Vulcan processors and
  reference platforms

----------------------------------------------------------------
Anup Patel (4):
      arm64: dts: Add SDHCI DT node for NS2
      arm64: dts: Add ARM SP804 timer DT nodes for NS2
      dt-bindings: watchdog: Add ARM SP805 DT bindings
      arm64: dts: Add ARM SP805 watchdog DT node for NS2

Jayachandran C (1):
      dt-bindings: Add documentation for Broadcom Vulcan

Ray Jui (1):
      arm64: dts: Add PCIe0 and PCIe4 DT nodes for NS2

 .../bindings/arm/bcm/brcm,vulcan-soc.txt           |  10 ++
 Documentation/devicetree/bindings/arm/cpus.txt     |   1 +
 .../devicetree/bindings/watchdog/arm,sp805.txt     |  17 +++
 arch/arm64/boot/dts/broadcom/ns2-svk.dts           |  12 ++
 arch/arm64/boot/dts/broadcom/ns2.dtsi              | 140 +++++++++++++++++++++
 5 files changed, 180 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/arm/bcm/brcm,vulcan-soc.txt
 create mode 100644 Documentation/devicetree/bindings/watchdog/arm,sp805.txt
