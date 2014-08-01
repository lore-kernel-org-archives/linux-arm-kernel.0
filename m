From: peter.ujfalusi@ti.com (Peter Ujfalusi)
Date: Fri, 1 Aug 2014 09:13:24 +0300
Subject: [PATCH v2 0/6] ARM: DT/davinci: Audio for da850-evm in DT boot
Message-ID: <1406873610-5037-1-git-send-email-peter.ujfalusi@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

Changes since v1:
- fixed the address missmatch for tlv320aic3106 codec (@1b -> 18)
- The edma patches has been taken by Vinod, they should be in linux-next soon.

The following series will enable audio via simple card on the board when booted
with DT.

For edma one patch is needed to have working dma:
http://marc.info/?l=linux-omap&m=140680159327749&w=2

Regards,
Peter
---
Peter Ujfalusi (6):
  ARM: davinci: da8xx-dt: add OF_DEV_AUXDATA entry for mcasp0
  ARM: DTS: da850: Add node for edma0
  ARM: DTS: da850: Add node for McASP
  ARM: DTS: da850-evm: Enable McASP via DT boot
  ARM: DTS: da850-evm: Add node for tlv320aic3106 codec
  ARM: DTS: da850-evm: Enable audio via simple-card

 arch/arm/boot/dts/da850-evm.dts  | 72 ++++++++++++++++++++++++++++++++++++++++
 arch/arm/boot/dts/da850.dtsi     | 19 +++++++++++
 arch/arm/mach-davinci/da8xx-dt.c |  1 +
 3 files changed, 92 insertions(+)

-- 
2.0.2
