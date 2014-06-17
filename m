From: mpa@pengutronix.de (Markus Pargmann)
Date: Tue, 17 Jun 2014 11:06:28 +0200
Subject: [PATCH 0/7] ARM: dts: ssi device node updates
Message-ID: <1402995995-15098-1-git-send-email-mpa@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This series cleans up some old or unnecessary properties from the dts files.

Patch 1 removes an enabled ssi unit that is not used.

Patch 2 adds ssi DMA properties based on the previous definiton of
fsl,ssi-dma-events for imx50.

Patches 3 and 4 remove the old non-generic fsl,ssi-dma-events property. The
generic dmas property is still present and used.

Patch 5,6 and 7 remove the fsl,mode properties for ssi units that are
connected with sgtl5000 cards. The sgtl5000 already configures the connection
between codec and CPU DAI correctly, so we don't need fsl,mode here.

Regards,

Markus


Markus Pargmann (7):
  ARM: dts: imx6: ventana, Remove unused ssi2
  ARM: dts: imx50, add ssi dma properties
  ARM: dts: imx5*, remove fsl,ssi-dma-events
  arm: dts: imx6qdl, remove fsl,ssi-dma-events
  ARM: dts: imx2*, remove ssi fsl,mode for sgtl5000 cards
  ARM: dts: imx5*, remove ssi fsl,mode for sgtl5000 cards
  ARM: dts: imx6*, remove ssi fsl,mode for sgtl5000 cards

 arch/arm/boot/dts/imx25-pdk.dts           | 1 -
 arch/arm/boot/dts/imx50.dtsi              | 8 ++++++--
 arch/arm/boot/dts/imx51-babbage.dts       | 1 -
 arch/arm/boot/dts/imx51.dtsi              | 3 ---
 arch/arm/boot/dts/imx53-m53evk.dts        | 1 -
 arch/arm/boot/dts/imx53-mba53.dts         | 1 -
 arch/arm/boot/dts/imx53-qsb-common.dtsi   | 1 -
 arch/arm/boot/dts/imx53-tx53.dtsi         | 1 -
 arch/arm/boot/dts/imx53-voipac-bsb.dts    | 1 -
 arch/arm/boot/dts/imx53.dtsi              | 3 ---
 arch/arm/boot/dts/imx6dl-riotboard.dts    | 1 -
 arch/arm/boot/dts/imx6q-gw5400-a.dts      | 1 -
 arch/arm/boot/dts/imx6qdl-gw52xx.dtsi     | 1 -
 arch/arm/boot/dts/imx6qdl-gw53xx.dtsi     | 1 -
 arch/arm/boot/dts/imx6qdl-gw54xx.dtsi     | 6 ------
 arch/arm/boot/dts/imx6qdl-nitrogen6x.dtsi | 1 -
 arch/arm/boot/dts/imx6qdl-sabrelite.dtsi  | 1 -
 arch/arm/boot/dts/imx6qdl-sabresd.dtsi    | 1 -
 arch/arm/boot/dts/imx6qdl-wandboard.dtsi  | 1 -
 arch/arm/boot/dts/imx6qdl.dtsi            | 3 ---
 20 files changed, 6 insertions(+), 32 deletions(-)

-- 
2.0.0
