From: jay.xu@rock-chips.com (jianqun.xu)
Date: Thu, 18 Feb 2016 19:16:31 +0800
Subject: [PATCH v3 2/4] spi: rockchip: add bindings for rk3399 spi
In-Reply-To: <1455794193-4497-1-git-send-email-jay.xu@rock-chips.com>
References: <1455794193-4497-1-git-send-email-jay.xu@rock-chips.com>
Message-ID: <1455794193-4497-3-git-send-email-jay.xu@rock-chips.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Xu Jianqun <jay.xu@rock-chips.com>

Add devicetree bindings for Rockchip rk3399 spi which found on
Rockchip rk3399 SoCs.

Signed-off-by: Jianqun Xu <jay.xu@rock-chips.com>
Signed-off-by: Heiko Stuebner <heiko@sntech.de>
---
changes in v3:
- add compatible for rk3399 spi (Mark, Heiko)

 Documentation/devicetree/bindings/spi/spi-rockchip.txt | 1 +
 drivers/spi/spi-rockchip.c                             | 1 +
 2 files changed, 2 insertions(+)

diff --git a/Documentation/devicetree/bindings/spi/spi-rockchip.txt b/Documentation/devicetree/bindings/spi/spi-rockchip.txt
index 0c491bd..1b14d69 100644
--- a/Documentation/devicetree/bindings/spi/spi-rockchip.txt
+++ b/Documentation/devicetree/bindings/spi/spi-rockchip.txt
@@ -9,6 +9,7 @@ Required Properties:
     "rockchip,rk3066-spi" for rk3066.
     "rockchip,rk3188-spi", "rockchip,rk3066-spi" for rk3188.
     "rockchip,rk3288-spi", "rockchip,rk3066-spi" for rk3288.
+    "rockchip,rk3399-spi", "rockchip,rk3066-spi" for rk3399.
 - reg: physical base address of the controller and length of memory mapped
        region.
 - interrupts: The interrupt number to the cpu. The interrupt specifier format
diff --git a/drivers/spi/spi-rockchip.c b/drivers/spi/spi-rockchip.c
index 79a8bc4..345fefd 100644
--- a/drivers/spi/spi-rockchip.c
+++ b/drivers/spi/spi-rockchip.c
@@ -868,6 +868,7 @@ static const struct of_device_id rockchip_spi_dt_match[] = {
 	{ .compatible = "rockchip,rk3066-spi", },
 	{ .compatible = "rockchip,rk3188-spi", },
 	{ .compatible = "rockchip,rk3288-spi", },
+	{ .compatible = "rockchip,rk3399-spi", },
 	{ },
 };
 MODULE_DEVICE_TABLE(of, rockchip_spi_dt_match);
-- 
1.9.1
