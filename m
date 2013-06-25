From: t.figa@samsung.com (Tomasz Figa)
Date: Tue, 25 Jun 2013 17:38:22 +0200
Subject: [PATCH 0/4] Add support for Samsung HSOTG on DT-enabled platforms
Message-ID: <1372174706-5459-1-git-send-email-t.figa@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This series enables platforms booting with Device Tree to use the Samsung
HSOTG IP. Since USB PHY support has been already added, it's just a matter
of adding an OF match table to the driver and respective device tree nodes
to dts files.

[On Samsung Trats board based on Exynos 4210]
Tested-by: Tomasz Figa <t.figa@samsung.com>

Tomasz Figa (4):
  usb: gadget: s3c-hsotg: Allow driver instantiation using device tree
  ARM: dts: exynos4: Add node for hsotg
  ARM: dts: exynos4: Add nodes for USB PHY block
  ARM: dts: exynos4210-trats: Enable USB gadget functionality

 .../devicetree/bindings/usb/samsung-hsotg.txt      | 40 ++++++++++++++++++++++
 arch/arm/boot/dts/exynos4.dtsi                     |  9 +++++
 arch/arm/boot/dts/exynos4210-trats.dts             | 10 ++++++
 arch/arm/boot/dts/exynos4210.dtsi                  | 15 ++++++++
 arch/arm/boot/dts/exynos4x12.dtsi                  | 15 ++++++++
 drivers/usb/gadget/s3c-hsotg.c                     | 10 ++++++
 6 files changed, 99 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/usb/samsung-hsotg.txt

-- 
1.8.2.1
