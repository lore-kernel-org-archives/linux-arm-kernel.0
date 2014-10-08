From: arnd@arndb.de (Arnd Bergmann)
Date: Wed, 08 Oct 2014 22:36:15 +0200
Subject: [GIT PULL 7/7] ARM64: SoC changes for 3.18
In-Reply-To: <1922034.HH2lvbiFi0@wuerfel>
References: <1922034.HH2lvbiFi0@wuerfel>
Message-ID: <2440106.3HoFFHSvh9@wuerfel>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The following changes since commit 7d1311b93e58ed55f3a31cc8f94c4b8fe988a2b9:

  Linux 3.17-rc1 (2014-08-16 10:40:26 -0600)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/arm/arm-soc.git tags/arm64-for-linus

for you to fetch changes up to 18ef9fefd3ef73279cd144bdb24cfd2683ff0492:

  arm64, defconfig: Enable Cavium Thunder SoC in defconfig (2014-10-02 17:38:55 +0200)

----------------------------------------------------------------
ARM64: SoC changes for 3.18

Starting with 3.18, we are merging SoC-specific changes for arm64 through
the arm-soc tree, like we have been doing for arm32.

This time, there is only one set of changes, adding support for the
Cavium "Thunder" Soc family. Since the changes are relatively small,
this includes Kconfig, defconfig and DT changes.

If all goes well, we will never require adding actual C source code
for platform support in arm64, given that the architecture is more
clearly defined and we have moved out a lot of the platform specifics
into device drivers for arm32 already.

----------------------------------------------------------------
Radha Mohan Chintakuntla (3):
      arm64, thunder: Add initial dts for Cavium Thunder SoC
      arm64, thunder: Document devicetree bindings for Cavium Thunder SoC
      arm64, thunder: Add Kconfig option for Cavium Thunder SoC Family

Robert Richter (1):
      arm64, defconfig: Enable Cavium Thunder SoC in defconfig

 .../devicetree/bindings/arm/cavium-thunder.txt     |  10 +
 Documentation/devicetree/bindings/arm/cpus.txt     |   1 +
 arch/arm64/Kconfig                                 |   5 +
 arch/arm64/boot/dts/Makefile                       |   1 +
 arch/arm64/boot/dts/thunder-88xx.dts               |  67 ++++
 arch/arm64/boot/dts/thunder-88xx.dtsi              | 401 +++++++++++++++++++++
 arch/arm64/configs/defconfig                       |   1 +
 7 files changed, 486 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/arm/cavium-thunder.txt
 create mode 100644 arch/arm64/boot/dts/thunder-88xx.dts
 create mode 100644 arch/arm64/boot/dts/thunder-88xx.dtsi
