From: swarren@wwwdotorg.org (Stephen Warren)
Date: Wed, 30 Jan 2013 14:42:38 -0700
Subject: [GIT PULL 7/8] ARM: tegra: device tree updates
In-Reply-To: <1359582159-28816-1-git-send-email-swarren@wwwdotorg.org>
References: <1359582159-28816-1-git-send-email-swarren@wwwdotorg.org>
Message-ID: <1359582159-28816-7-git-send-email-swarren@wwwdotorg.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Numerous updates to the various Tegra device trees are made:

* Addition of NVIDIA Beaver (Tegra30) and Toradex Colibri T20 and Iris
  carrier boards.
* Enablement of the HDMI connector on most boards.
* Enablement of the keyboard controller on a few boards.
* Addition of the AC'97 controller to Tegra20.
* Addition of a GPIO poweroff node for TrimSlice.
* Changes to support the new "high speed UART" (DMA-capable) driver for
  Tegra serial ports, and enablement for Cardhu's UART C.
* A few cleanups, such as compatible flag fixes, node renames, node
  ordering fixes, commonizing properties into SoC .dtsi files, etc..

This pull request is based on (most of) the previous pull request with
tag tegra-for-3.9-soc-t114.

----------------------------------------------------------------

The following changes since commit 5c541b884c09559723f426af2391ab07a4ca10e0:

  ARM: tegra: Add initial support for Tegra114 SoC.

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/swarren/linux-tegra.git tegra-for-3.9-dt

for you to fetch changes up to 3fbf07d80b40f73c304624179381f9038bd03b74:

  ARM: dt: tegra30: Rename "smmu" to "iommu"

----------------------------------------------------------------

Bryan Wu (3):
      ARM: DT: tegra: Unify the description of Tegra20 boards
      ARM: DT: tegra: Add board level compatible properties
      ARM: DT: tegra: Add Tegra30 Beaver board support

Hiroshi Doyu (2):
      ARM: dt: tegra20: Rename "gart" to "iommu"
      ARM: dt: tegra30: Rename "smmu" to "iommu"

Laxman Dewangan (7):
      ARM: tegra30: tegra30 gpio is not compatible with tegra20 gpio
      ARM: tegra: dts: add aliases and DMA requestor for serial controller
      ARM: tegra: add DT entry for KBC controller
      ARM: tegra: seaboard: enable keyboard in DT
      ARM: tegra: cardhu: register UARTC
      ARM: tegra: whistler: enable keyboard in DT
      ARM: tegra: harmony: enable keyboard in DT

Lucas Stach (4):
      ASoC: tegra: add ac97 host controller to device tree
      ARM: tegra: move serial clock-frequency attr into the Tegra20 dtsi
      ARM: tegra: Add Colibri T20 512MB COM device tree
      ARM: tegra: Add Toradex Iris carrier board DT with T20 512MB COM

Stephen Warren (6):
      ARM: tegra: trimslice: add gpio-poweroff node to DT
      ARM: tegra: seaboard: enable HDMI port
      ARM: tegra: ventana: enable HDMI port
      ARM: tegra: paz00: enable HDMI port
      ARM: tegra: swap cache-/interrupt-ctrlr nodes in DT
      ARM: tegra: move serial clock-frequency attr into the Tegra30 dtsi

 Documentation/devicetree/bindings/arm/tegra.txt |   32 +-
 arch/arm/boot/dts/Makefile                      |    2 +
 arch/arm/boot/dts/tegra20-colibri-512.dtsi      |  491 ++++++++++++++++++
 arch/arm/boot/dts/tegra20-harmony.dts           |  120 ++++-
 arch/arm/boot/dts/tegra20-iris-512.dts          |   89 ++++
 arch/arm/boot/dts/tegra20-paz00.dts             |   22 +-
 arch/arm/boot/dts/tegra20-seaboard.dts          |  158 +++++-
 arch/arm/boot/dts/tegra20-tamonten.dtsi         |    1 -
 arch/arm/boot/dts/tegra20-trimslice.dts         |   11 +-
 arch/arm/boot/dts/tegra20-ventana.dts           |   23 +-
 arch/arm/boot/dts/tegra20-whistler.dts          |   15 +-
 arch/arm/boot/dts/tegra20.dtsi                  |   72 ++-
 arch/arm/boot/dts/tegra30-beaver.dts            |  373 +++++++++++++
 arch/arm/boot/dts/tegra30-cardhu.dtsi           |   15 +-
 arch/arm/boot/dts/tegra30.dtsi                  |   66 ++-
 15 files changed, 1430 insertions(+), 60 deletions(-)
 create mode 100644 arch/arm/boot/dts/tegra20-colibri-512.dtsi
 create mode 100644 arch/arm/boot/dts/tegra20-iris-512.dts
 create mode 100644 arch/arm/boot/dts/tegra30-beaver.dts
