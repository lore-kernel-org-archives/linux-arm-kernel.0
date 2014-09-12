From: linus.walleij@linaro.org (Linus Walleij)
Date: Fri, 12 Sep 2014 09:36:04 +0200
Subject: [PATCH 0/4] PL08x device tree support
Message-ID: <1410507364-32299-1-git-send-email-linus.walleij@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patch set has been sitting on my harddisk for some time, and
now that I saw Roland Stigge posting similar stuff I guess it is time
to get it out the door.

Roland: please look at this and see if it will be appropriate for the
LPC32xx as well, or if major changes are needed.

A major concern has been the muxed signals found on some platforms.
I leave the door open for adding signal muxes in front of any DMA
engine, but hope that this and the platforms that need it can be
handled separately from the fixed one-channel-per-signal assignment
found on the simpler platforms.

Linus Walleij (4):
  dma: pl08x: support fixed signal assignment
  dmaengine: device tree bindings for PL08x
  dmaengine: support device tree channel assignment
  ARM: nomadik: add DMA support

 .../devicetree/bindings/dma/arm-pl08x.txt          | 182 +++++++++++++
 arch/arm/boot/dts/ste-nomadik-stn8815.dtsi         | 296 +++++++++++++++++++++
 drivers/dma/amba-pl08x.c                           | 256 +++++++++++++++++-
 3 files changed, 731 insertions(+), 3 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/dma/arm-pl08x.txt

-- 
1.9.3
