From: o.rempel@pengutronix.de (Oleksij Rempel)
Date: Thu, 18 Oct 2018 13:26:12 +0200
Subject: [PATCH v1 0/3] i2c: imx: DMA related fixes 
Message-ID: <20181018112615.29362-1-o.rempel@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Current i2c-imx module prints DMA warnings which in many cases are
false positive and just confuse testers:
1. DMA is not available on chips before i.MX50
2. DMA for i2c is muxed with some other peripheral, and can be used only
for one of devices at same time. So, obvious choice it to use it with
SDHC instead of i2c.

Oleksij Rempel (3):
  ARM: dts: imx6sll: fix typo for fsl,imx6sll-i2c node
  i2c: imx: probe dma only only on i.MX50 and later.
  i2c: imx: don't print error if DMA is not configured

 arch/arm/boot/dts/imx6sll.dtsi |  2 +-
 drivers/i2c/busses/i2c-imx.c   | 89 +++++++++++++++++++++++++++-------
 2 files changed, 73 insertions(+), 18 deletions(-)

-- 
2.19.0
