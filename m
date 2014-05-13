From: robherring2@gmail.com (Rob Herring)
Date: Mon, 12 May 2014 19:29:46 -0500
Subject: [PATCH 0/7] OF init section function prototype fixes
Message-ID: <1399940993-1773-1-git-send-email-robherring2@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Rob Herring <robh@kernel.org>

This series fixes the function prototypes of various OF initiaiization 
callback functions. I found these when adding type checking. I intend to 
merge this thru the DT tree with the series that adds the type 
checking[1].

Rob

[1] https://lkml.org/lkml/2014/5/8/667

Rob Herring (7):
  ARM: imx: fix function type for CLK_OF_DECLARE
  clk: rockchip: fix function type for CLK_OF_DECLARE
  clk: sunxi: avoid double DT matching
  clk: sunxi: fix function type for CLK_OF_DECLARE
  irqchip: s3c24xx: fix function type for IRQCHIP_OF_DECLARE
  irqchip: mxs: fix function type for IRQCHIP_OF_DECLARE
  clk: ti: add missing semi-colon on CLK_OF_DECLARE

 arch/arm/mach-imx/clk-imx35.c       | 4 +---
 drivers/clk/rockchip/clk-rockchip.c | 3 +--
 drivers/clk/sunxi/clk-sunxi.c       | 5 ++---
 drivers/clk/ti/gate.c               | 2 +-
 drivers/irqchip/irq-mxs.c           | 4 ++--
 drivers/irqchip/irq-s3c24xx.c       | 6 ++----
 6 files changed, 9 insertions(+), 15 deletions(-)

-- 
1.9.1
