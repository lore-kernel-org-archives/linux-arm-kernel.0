From: icenowy@aosc.io (Icenowy Zheng)
Date: Wed,  4 Oct 2017 00:59:42 +0800
Subject: [PATCH v3 0/2] Allwinner XR819 SDIO Wi-Fi DT binding and OPi Zero
 XR819 IRQ
Message-ID: <20171003165944.13056-1-icenowy@aosc.io>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The Allwinner XR819 SDIO Wi-Fi chip supports an out-of-band interrupt line,
and the in-band interrupt is also supported.

However the current out-of-tree driver uses the out-of-band interrupt by
default.

This patchset adds the device tree binding for the chip as well as the
out-of-band interrupt, then adds the interrupt to the device tree of
Orange Pi Zero.

Icenowy Zheng (1):
  dt-bindings: add device tree binding for Allwinner XR819 SDIO Wi-Fi

Sergey Matyukevich (1):
  ARM: sun8i: h2+: specify wifi interrupts for Orange Pi Zero

 .../bindings/net/wireless/allwinner,xr819.txt      | 38 ++++++++++++++++++++++
 arch/arm/boot/dts/sun8i-h2-plus-orangepi-zero.dts  |  3 ++
 2 files changed, 41 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/net/wireless/allwinner,xr819.txt

-- 
2.13.5
