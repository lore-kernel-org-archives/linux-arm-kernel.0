From: swarren@wwwdotorg.org (Stephen Warren)
Date: Fri, 16 May 2014 12:25:45 -0600
Subject: [GIT PULL 2/3] ARM: tegra: device tree changes for 3.16
In-Reply-To: <1400264746-13106-1-git-send-email-swarren@wwwdotorg.org>
References: <1400264746-13106-1-git-send-email-swarren@wwwdotorg.org>
Message-ID: <1400264746-13106-2-git-send-email-swarren@wwwdotorg.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The bulk of Tegra changes for 3.16 are to device trees. Highlights are:

- New board support for:
  - Jetson TK1.
  - SHIELD.
  - Tegra Note 7.
  - Colibri T30 module.
- HDMI support on Venice2.
- SD card write-protect GPIOs added to some boards.
- Numerous regulator cleanups.

----------------------------------------------------------------

The following changes since commit c9eaa447e77efe77b7fa4c953bd62de8297fd6c5:

  Linux 3.15-rc1

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/tegra/linux.git tegra-for-3.16-dt

for you to fetch changes up to 446e9c63161519902a251c3670d2fbb455146475:

  ARM: tegra: initial add of Colibri T30

----------------------------------------------------------------

Alexandre Courbot (2):
      ARM: tegra: add Tegra Note 7 device tree
      ARM: tegra: add device tree for SHIELD

Andrew Bresticker (1):
      ARM: tegra: fix Venice2 SD card VQMMC supply

Stefan Agner (1):
      ARM: tegra: initial add of Colibri T30

Stephen Warren (8):
      ARM: tegra: add Jetson TK1 device tree
      ARM: tegra: define Jetson TK1 regulators
      ARM: tegra: fix Jetson TK1 SD card supply
      ARM: tegra: make Venice's +3.3V_RUN regulator always on
      ARM: tegra: use correct audio CODEC on Jetson TK1
      ARM: tegra: add SD wp-gpios to Jetson TK1 DT
      ARM: tegra: add SD wp-gpios to Dalmore DT
      ARM: tegra: add SD wp-gpios to Venice2 DT

Thierry Reding (7):
      ARM: tegra: Add Tegra124 HDMI support
      ARM: tegra: venice2 - Enable HDMI
      ARM: tegra: jetson-tk1 - Enable HDMI support
      ARM: tegra: harmony - Add +5V HDMI supply
      ARM: tegra: beaver - Add +5V HDMI supply
      ARM: tegra: dalmore - Add +5V HDMI supply
      ARM: tegra: dalmore - Add DSI power supply

 arch/arm/boot/dts/Makefile                    |    4 +
 arch/arm/boot/dts/tegra114-dalmore.dts        |   21 +-
 arch/arm/boot/dts/tegra114-roth.dts           | 1113 ++++++++++++
 arch/arm/boot/dts/tegra114-tn7.dts            |  348 ++++
 arch/arm/boot/dts/tegra124-jetson-tk1.dts     | 1827 ++++++++++++++++++++
 arch/arm/boot/dts/tegra124-venice2.dts        |   42 +-
 arch/arm/boot/dts/tegra124.dtsi               |   12 +
 arch/arm/boot/dts/tegra20-harmony.dts         |   12 +
 arch/arm/boot/dts/tegra30-beaver.dts          |   12 +
 arch/arm/boot/dts/tegra30-colibri-eval-v3.dts |  205 +++
 arch/arm/boot/dts/tegra30-colibri.dtsi        |  377 ++++
 11 files changed, 3965 insertions(+), 8 deletions(-)
 create mode 100644 arch/arm/boot/dts/tegra114-roth.dts
 create mode 100644 arch/arm/boot/dts/tegra114-tn7.dts
 create mode 100644 arch/arm/boot/dts/tegra124-jetson-tk1.dts
 create mode 100644 arch/arm/boot/dts/tegra30-colibri-eval-v3.dts
 create mode 100644 arch/arm/boot/dts/tegra30-colibri.dtsi
