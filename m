From: icenowy@aosc.io (Icenowy Zheng)
Date: Wed,  5 Apr 2017 22:30:32 +0800
Subject: [PATCH 0/2] pmu0 MMIO region for A64 USB PHY
Message-ID: <20170405143034.8868-1-icenowy@aosc.io>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The USB PHY of A64 contains a "pmu0" MMIO region, which contains some control
registers for the EHCI0/OHCI0 pair on A64 SoC.

This pair is not used currently in 4.11, but when enabling it in 4.12, the
MMIO region is needed.

In order to prevent device tree compatibility breakage, add this region in
4.11.

Icenowy Zheng (2):
  dt: bindings: add pmu0 regs for USB PHYs on Allwinner H3/V3s/A64
  arm64: allwinner: a64: add pmu0 regs for USB PHY

 Documentation/devicetree/bindings/phy/sun4i-usb-phy.txt | 1 +
 arch/arm64/boot/dts/allwinner/sun50i-a64.dtsi           | 2 ++
 2 files changed, 3 insertions(+)

-- 
2.12.2
