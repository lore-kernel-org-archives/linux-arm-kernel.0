From: marc.zyngier@arm.com (Marc Zyngier)
Date: Wed, 18 Jan 2017 10:53:29 +0000
Subject: [PATCH 0/2] ARM: DTS: Fix broken GICv2 register maps
Message-ID: <1484736811-24002-1-git-send-email-marc.zyngier@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

For a GICv2 (which happens to be virtualization capable), the
architecture mandates the following regions:

	     GICD: 4kB
	     GICC: 8kB
	     GICH: 8kB
	     GICV: 8kB

Unfortunately, I made a mistake in one of the examples contained in
the DT binding document, and everyone duplicated that same mistake all
over the map.

This small series fixes the DT binding, and hopefully updates all the
offending DTs to be compliant with the architecture.

Marc Zyngier (2):
  dt-bindings: arm,gic: Fix binding example for a virt-capable GIC
  ARM: DTS: Fix register map for virt-capable GIC

 Documentation/devicetree/bindings/interrupt-controller/arm,gic.txt | 4 ++--
 arch/arm/boot/dts/alpine.dtsi                                      | 2 +-
 arch/arm/boot/dts/axm55xx.dtsi                                     | 2 +-
 arch/arm/boot/dts/dra7.dtsi                                        | 2 +-
 arch/arm/boot/dts/ecx-2000.dts                                     | 2 +-
 arch/arm/boot/dts/exynos3250.dtsi                                  | 2 +-
 arch/arm/boot/dts/exynos5.dtsi                                     | 2 +-
 arch/arm/boot/dts/exynos5260.dtsi                                  | 2 +-
 arch/arm/boot/dts/exynos5440.dtsi                                  | 2 +-
 arch/arm/boot/dts/imx6ul.dtsi                                      | 4 ++--
 arch/arm/boot/dts/keystone-k2g.dtsi                                | 2 +-
 arch/arm/boot/dts/keystone.dtsi                                    | 2 +-
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
 38 files changed, 42 insertions(+), 42 deletions(-)

-- 
2.1.4
