From: marc.zyngier@arm.com (Marc Zyngier)
Date: Mon, 30 Jan 2017 08:53:09 +0000
Subject: [PULL v2] ARM: DTS: Fix broken GICv2 register maps
Message-ID: <1485766389-30811-1-git-send-email-marc.zyngier@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

ARM-soc folks,

Please find below the pull request for a DT fix affecting a large
number of 32bit platforms, which has been acked by a number of
platform maintainers.

* From v1: Dropped the controvertial cortex-a15-gic->arm,gic-400
  change in the example, at Rob's request.

The following changes since commit 49def1853334396f948dcb4cedb9347abb318df5:

  Linux 4.10-rc4 (2017-01-15 16:21:59 -0800)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/maz/arm-platforms.git irq/gic-v2-dt

for you to fetch changes up to 84fcda8e194838ddbc06843e54a9ca9371ec4b82:

  ARM: DTS: Fix register map for virt-capable GIC (2017-01-30 08:45:25 +0000)

----------------------------------------------------------------
Marc Zyngier (2):
      dt-bindings: arm,gic: Fix binding example for a virt-capable GIC
      ARM: DTS: Fix register map for virt-capable GIC

 Documentation/devicetree/bindings/interrupt-controller/arm,gic.txt | 2 +-
 arch/arm/boot/dts/alpine.dtsi                                      | 2 +-
 arch/arm/boot/dts/axm55xx.dtsi                                     | 2 +-
 arch/arm/boot/dts/dra7.dtsi                                        | 2 +-
 arch/arm/boot/dts/ecx-2000.dts                                     | 2 +-
 arch/arm/boot/dts/exynos3250.dtsi                                  | 2 +-
 arch/arm/boot/dts/exynos5.dtsi                                     | 4 ++--
 arch/arm/boot/dts/exynos5260.dtsi                                  | 2 +-
 arch/arm/boot/dts/exynos5440.dtsi                                  | 2 +-
 arch/arm/boot/dts/imx6ul.dtsi                                      | 4 ++--
 arch/arm/boot/dts/keystone-k2g.dtsi                                | 4 ++--
 arch/arm/boot/dts/keystone.dtsi                                    | 4 ++--
 arch/arm/boot/dts/ls1021a.dtsi                                     | 4 ++--
 arch/arm/boot/dts/mt2701.dtsi                                      | 2 +-
 arch/arm/boot/dts/mt6580.dtsi                                      | 2 +-
 arch/arm/boot/dts/mt6589.dtsi                                      | 2 +-
 arch/arm/boot/dts/mt7623.dtsi                                      | 2 +-
 arch/arm/boot/dts/mt8127.dtsi                                      | 2 +-
 arch/arm/boot/dts/mt8135.dtsi                                      | 2 +-
 arch/arm/boot/dts/omap5.dtsi                                       | 2 +-
 arch/arm/boot/dts/r8a73a4.dtsi                                     | 2 +-
 arch/arm/boot/dts/r8a7743.dtsi                                     | 2 +-
 arch/arm/boot/dts/r8a7745.dtsi                                     | 2 +-
 arch/arm/boot/dts/r8a7790.dtsi                                     | 2 +-
 arch/arm/boot/dts/r8a7791.dtsi                                     | 2 +-
 arch/arm/boot/dts/r8a7792.dtsi                                     | 2 +-
 arch/arm/boot/dts/r8a7793.dtsi                                     | 2 +-
 arch/arm/boot/dts/r8a7794.dtsi                                     | 2 +-
 arch/arm/boot/dts/rk1108.dtsi                                      | 2 +-
 arch/arm/boot/dts/rk3036.dtsi                                      | 2 +-
 arch/arm/boot/dts/rk322x.dtsi                                      | 2 +-
 arch/arm/boot/dts/rk3288.dtsi                                      | 2 +-
 arch/arm/boot/dts/sun6i-a31.dtsi                                   | 2 +-
 arch/arm/boot/dts/sun7i-a20.dtsi                                   | 4 ++--
 arch/arm/boot/dts/sun8i-a23-a33.dtsi                               | 2 +-
 arch/arm/boot/dts/sun8i-a83t.dtsi                                  | 2 +-
 arch/arm/boot/dts/sun8i-h3.dtsi                                    | 2 +-
 arch/arm/boot/dts/sun9i-a80.dtsi                                   | 2 +-
 38 files changed, 44 insertions(+), 44 deletions(-)
