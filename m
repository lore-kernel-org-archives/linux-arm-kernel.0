From: tharvey@gateworks.com (Tim Harvey)
Date: Thu, 13 Mar 2014 10:40:03 -0700
Subject: [PATCH 0/2] ARM: IMX: fix ability to use pcie interrupt-map
Message-ID: <1394732405-2260-1-git-send-email-tharvey@gateworks.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The #address-cells of the arm-cortext-a9 gic in the imx pcie host controller
node is invalid which breaks the ability to user interrupt-map for legacy
pci interrupts.

Tim Harvey (2):
  ARM: DT: fix gic interrupt controller documentation
  ARM: dts: imx: fix invalid #address-cells value

 Documentation/devicetree/bindings/arm/gic.txt | 2 +-
 arch/arm/boot/dts/imx6qdl.dtsi                | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

-- 
1.8.3.2
