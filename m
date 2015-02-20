From: peter.ujfalusi@ti.com (Peter Ujfalusi)
Date: Fri, 20 Feb 2015 15:42:01 +0200
Subject: [PATCH 0/5] ARM: DTS: OMAP/DRA7: dma property name correction
Message-ID: <1424439726-31994-1-git-send-email-peter.ujfalusi@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

While working on the DMA crossbar support for DRA7 typo of devices I have
noticed that the dma-channels and dma-requests properties of sdma wrongly
has # at the beginning.
According to the documentation, it should not have:
Documentation/devicetree/bindings/dma/dma.txt

Since these properties are not in use at the moment, but it is going to be needed
for the crossbar driver it is better to fix it right now so we do not need to
patch .dtsi and .c files at the same time later.

Tony: I would really appreciate if this could go in within the current merge
window.

Thanks,
Peter

Peter Ujfalusi (5):
  ARM: DTS: omap2: Correct the dma controller's property names
  ARM: DTS: omap3: Correct the dma controller's property names
  ARM: DTS: omap4: Correct the dma controller's property names
  ARM: DTS: omap5: Correct the dma controller's property names
  ARM: DTS: dra7: Correct the dma controller's property names

 arch/arm/boot/dts/dra7.dtsi  | 4 ++--
 arch/arm/boot/dts/omap2.dtsi | 4 ++--
 arch/arm/boot/dts/omap3.dtsi | 4 ++--
 arch/arm/boot/dts/omap4.dtsi | 4 ++--
 arch/arm/boot/dts/omap5.dtsi | 4 ++--
 5 files changed, 10 insertions(+), 10 deletions(-)

-- 
2.3.0
