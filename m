From: thierry.reding@gmail.com (Thierry Reding)
Date: Mon, 30 Mar 2015 12:12:13 +0200
Subject: [GIT PULL 2/2] ARM: tegra: Device tree changes for v4.1-rc1
In-Reply-To: <1427710333-13472-1-git-send-email-thierry.reding@gmail.com>
References: <1427710333-13472-1-git-send-email-thierry.reding@gmail.com>
Message-ID: <1427710333-13472-2-git-send-email-thierry.reding@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi ARM SoC maintainers,

The following changes since commit c517d838eb7d07bbe9507871fab3931deccff539:

  Linux 4.0-rc1 (2015-02-22 18:21:14 -0800)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/tegra/linux.git tags/tegra-for-4.1-dt

for you to fetch changes up to 03650bd2010b117c5c16a75278b0d01def8e9376:

  ARM: tegra: Add EMC timings to Nyan Blaze device tree (2015-03-30 11:43:39 +0200)

----------------------------------------------------------------
ARM: tegra: Device tree changes for v4.1-rc1

A bunch of changes to improve support on the Nyan Big (Acer Chromebook
13). These enable the trackpad and make the WiFi card work. Changes to
the userspace-exposed name of the soundcard are required for a better
audio experience.

Support for Nyan Blaze (HP Chromebook 14) is added. It is very similar
to Nyan Big and therefore can enjoys many of the above improvements.

Since the EMC driver can now be used to scale the frequency at which
external memory is clocked, corresponding EMC frequency tables are added
for Jetson TK1 and the Nyan boards.

The Jetson TK1, Beaver and Nyan boards now also use generated pinmux
data, which makes it easier to keep it in sync with the data provided by
syseng.

----------------------------------------------------------------
Lucas Stach (1):
      ARM: tegra: Use generated pinmux for Beaver board

Mikko Perttunen (2):
      ARM: tegra: Add EMC to Tegra124 device tree
      ARM: tegra: Add EMC timings to Jetson TK1 device tree

Stephen Warren (1):
      ARM: tegra: Import latest Jetson TK1 pinmux

Tomeu Vizoso (13):
      ARM: tegra: Change model of sound card in Nyan Big
      ARM: tegra: Move generic parts out of the nyan-big DT
      ARM: tegra: Add DTS for the nyan-blaze board
      ARM: tegra: Add node for trackpad in Nyan boards
      ARM: tegra: Use pwrseq-simple for the wifi in Nyan
      ARM: tegra: Use generated pinmux data for Nyan Big
      ARM: tegra: nyan: Set maximum frequency for SPI flash
      ARM: tegra: nyan: Add gpio-restart node
      ARM: tegra: nyan: The WiFi card is kept powered during suspend
      of: Add binding for NVIDIA Tegra ACTMON node
      ARM: tegra: Add Tegra124 ACTMON support
      ARM: tegra: Add EMC timings to Nyan Big device tree
      ARM: tegra: Add EMC timings to Nyan Blaze device tree

 .../bindings/arm/tegra/nvidia,tegra30-actmon.txt   |   32 +
 arch/arm/boot/dts/Makefile                         |    1 +
 arch/arm/boot/dts/tegra124-jetson-tk1-emc.dtsi     | 2421 ++++++++++++++++++++
 arch/arm/boot/dts/tegra124-jetson-tk1.dts          |  559 +++--
 arch/arm/boot/dts/tegra124-nyan-big-emc.dtsi       | 2023 ++++++++++++++++
 arch/arm/boot/dts/tegra124-nyan-big.dts            | 2121 +++++++++--------
 arch/arm/boot/dts/tegra124-nyan-blaze-emc.dtsi     | 2049 +++++++++++++++++
 arch/arm/boot/dts/tegra124-nyan-blaze.dts          | 1334 +++++++++++
 arch/arm/boot/dts/tegra124-nyan.dtsi               |  695 ++++++
 arch/arm/boot/dts/tegra124.dtsi                    |   19 +
 arch/arm/boot/dts/tegra30-beaver.dts               | 1653 ++++++++++++-
 11 files changed, 11607 insertions(+), 1300 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/arm/tegra/nvidia,tegra30-actmon.txt
 create mode 100644 arch/arm/boot/dts/tegra124-jetson-tk1-emc.dtsi
 create mode 100644 arch/arm/boot/dts/tegra124-nyan-big-emc.dtsi
 create mode 100644 arch/arm/boot/dts/tegra124-nyan-blaze-emc.dtsi
 create mode 100644 arch/arm/boot/dts/tegra124-nyan-blaze.dts
 create mode 100644 arch/arm/boot/dts/tegra124-nyan.dtsi
