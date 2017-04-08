From: krzk@kernel.org (Krzysztof Kozlowski)
Date: Sat,  8 Apr 2017 16:10:02 +0200
Subject: [GIT PULL 3/5] ARM: dts: exynos: DTS for v4.12
In-Reply-To: <20170408141004.386-1-krzk@kernel.org>
References: <20170408141004.386-1-krzk@kernel.org>
Message-ID: <20170408141004.386-4-krzk@kernel.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

I provided some of the patches as sub-tags to other maintainers who
needed it.


Best regards,
Krzysztof


Cc: Hans Verkuil <hans.verkuil@cisco.com>

The following changes since commit c1ae3cfa0e89fa1a7ecc4c99031f5e9ae99d9201:

  Linux 4.11-rc1 (2017-03-05 12:59:56 -0800)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/krzk/linux.git tags/samsung-dt-4.12

for you to fetch changes up to a1146328ec47141007a6ec076e1cbfc80f31887f:

  Merge tag 'samsung-dt-hdmi-cec-4.12' into next/dt (2017-03-31 00:27:18 +0300)

----------------------------------------------------------------
Samsung DeviceTree ARM update for v4.12:
1. Enhancements to PCIe nodes on Exynos5440.
2. Fix thermal values on some of Exynos5420 boards like Odroid XU3.
3. Add proper clock frequency properties to DSI nodes.
4. Fix watchdog reset on Exynos4412.
5. Fix watchdog infinite interrupt in soft mode on Exynos4210,
   Exynos5440, S3C64xx and S5Pv210.
6. Enable watchdog on Exynos4 and S3C SoCs.

----------------------------------------------------------------
Hans Verkuil (1):
      ARM: dts: exynos: add HDMI controller phandle to exynos4.dtsi

Hoegeun Kwon (1):
      ARM: dts: exynos: Add the burst and esc clock frequency properties to DSI node

Jaehoon Chung (1):
      ARM: dts: exynos: Add phy-pcie node for pcie to Exynos5440

Krzysztof Kozlowski (8):
      ARM: dts: exynos: Do not ignore real-world fuse values for thermal zone 0 on Exynos5420
      ARM: dts: exynos: Fix watchdog reset on Exynos4412
      ARM: dts: s3c64xx: Enable watchdog on all S3C64xx boards
      ARM: dts: exynos: Enable watchdog on all Exynos4 boards
      ARM: dts: exynos: Fix infinite interrupt in soft mode on Exynos4210 and Exynos5440
      ARM: dts: s3c64xx: Fix infinite interrupt in soft mode
      ARM: dts: s5pv210: Fix infinite interrupt in soft mode
      Merge tag 'samsung-dt-hdmi-cec-4.12' into next/dt

 arch/arm/boot/dts/exynos3250-rinato.dts           |  2 ++
 arch/arm/boot/dts/exynos4.dtsi                    | 10 +------
 arch/arm/boot/dts/exynos4210-origen.dts           |  4 ---
 arch/arm/boot/dts/exynos4210-trats.dts            |  2 ++
 arch/arm/boot/dts/exynos4210.dtsi                 |  8 ++++++
 arch/arm/boot/dts/exynos4412-itop-scp-core.dtsi   |  4 ---
 arch/arm/boot/dts/exynos4412-odroid-common.dtsi   |  4 ---
 arch/arm/boot/dts/exynos4412-origen.dts           |  4 ---
 arch/arm/boot/dts/exynos4412-trats2.dts           |  2 ++
 arch/arm/boot/dts/exynos4412.dtsi                 |  9 +++++++
 arch/arm/boot/dts/exynos5420-tmu-sensor-conf.dtsi | 25 ++++++++++++++++++
 arch/arm/boot/dts/exynos5420.dtsi                 | 10 +++----
 arch/arm/boot/dts/exynos5440.dtsi                 | 32 +++++++++++++++--------
 arch/arm/boot/dts/s3c64xx.dtsi                    |  3 +--
 arch/arm/boot/dts/s5pv210.dtsi                    |  2 +-
 15 files changed, 77 insertions(+), 44 deletions(-)
 create mode 100644 arch/arm/boot/dts/exynos5420-tmu-sensor-conf.dtsi
