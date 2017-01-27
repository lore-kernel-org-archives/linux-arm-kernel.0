From: thierry.reding@gmail.com (Thierry Reding)
Date: Fri, 27 Jan 2017 10:21:20 +0100
Subject: [GIT PULL 3/4] ARM: tegra: Device tree changes for v4.11-rc1
In-Reply-To: <20170127092121.21570-1-thierry.reding@gmail.com>
References: <20170127092121.21570-1-thierry.reding@gmail.com>
Message-ID: <20170127092121.21570-3-thierry.reding@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi ARM SoC maintainers,

The following changes since commit 0c744ea4f77d72b3dcebb7a8f2684633ec79be88:

  Linux 4.10-rc2 (2017-01-01 14:31:53 -0800)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/tegra/linux.git tags/tegra-for-4.11-arm-dt

for you to fetch changes up to 393a33c74554be3c30233907e3aa0f84603fee31:

  ARM: tegra: nyan-blaze: Proper pinmux for TPM I2C (2017-01-25 12:07:21 +0100)

Thanks,
Thierry

----------------------------------------------------------------
ARM: tegra: Device tree changes for v4.11-rc1

This contains a set of patches that add hardware compatibility for newer
revisions of the Toradex Apalis TK1. Also included is a fix to the PAZ00
that stabilizes panel initialization on boot as well as a patch to add
card detection for the ?SD card slot on TrimSlice.

To round things off there are a couple of fixes and changes to the Nyan
device tree files to fix the battery charger, add compatibility with new
revisions of Nyan Blaze and Nyan Big, as well as properly support the
TPM.

----------------------------------------------------------------
Jerome Coste (1):
      ARM: tegra: nyan-blaze: Proper pinmux for TPM I2C

Marc Dietrich (1):
      ARM: tegra: paz00: Mark panel regulator as enabled on boot

Marcel Ziswiler (5):
      ARM: tegra: apalis-tk1: Pull-up temperature alert
      ARM: tegra: apalis-tk1: Optional DisplayPort hot-plug detect
      ARM: tegra: apalis-tk1: Adjust pin muxing for v1.1 HW
      ARM: tegra: apalis-tk1: Fix SD card detect on v1.1 HW
      ARM: tegra: apalis-tk1: Update compatibility comment

Paul Kocialkowski (5):
      ARM: tegra: nyan: Use proper IRQ type definitions
      ARM: tegra: nyan: Use external control for bq24735 charger
      ARM: tegra: nyan-big: Include compatible revisions for proper detection
      ARM: tegra: nyan-blaze: Include compatible revisions for proper detection
      ARM: tegra: nyan-big: Proper pinmux for TPM I2C

Rask Ingemann Lambertsen (1):
      ARM: dts: tegra: Fix missing card detection in Trimslice ?SD card slot

 arch/arm/boot/dts/tegra124-apalis-eval.dts | 10 +----
 arch/arm/boot/dts/tegra124-apalis.dtsi     | 61 +++++++++++++-----------------
 arch/arm/boot/dts/tegra124-nyan-big.dts    | 26 +++++++------
 arch/arm/boot/dts/tegra124-nyan-blaze.dts  | 28 ++++++++------
 arch/arm/boot/dts/tegra124-nyan.dtsi       |  5 ++-
 arch/arm/boot/dts/tegra20-paz00.dts        |  1 +
 arch/arm/boot/dts/tegra20-trimslice.dts    |  1 +
 7 files changed, 66 insertions(+), 66 deletions(-)
