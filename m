From: ykk@rock-chips.com (Yakir Yang)
Date: Mon, 14 Mar 2016 11:09:15 +0800
Subject: [PATCH 1/2] i2c: rk3x: add support for rk3228
Message-ID: <1457924955-29996-1-git-send-email-ykk@rock-chips.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Enable the I2C core for this SoC.

Signed-off-by: Yakir Yang <ykk@rock-chips.com>
---
 Documentation/devicetree/bindings/i2c/i2c-rk3x.txt | 4 ++--
 drivers/i2c/busses/i2c-rk3x.c                      | 1 +
 2 files changed, 3 insertions(+), 2 deletions(-)

diff --git a/Documentation/devicetree/bindings/i2c/i2c-rk3x.txt b/Documentation/devicetree/bindings/i2c/i2c-rk3x.txt
index f0d71bc..0b4a85f 100644
--- a/Documentation/devicetree/bindings/i2c/i2c-rk3x.txt
+++ b/Documentation/devicetree/bindings/i2c/i2c-rk3x.txt
@@ -6,8 +6,8 @@ RK3xxx SoCs.
 Required properties :
 
  - reg : Offset and length of the register set for the device
- - compatible : should be "rockchip,rk3066-i2c", "rockchip,rk3188-i2c" or
-		"rockchip,rk3288-i2c".
+ - compatible : should be "rockchip,rk3066-i2c", "rockchip,rk3188-i2c",
+		"rockchip,rk3228-i2c" or "rockchip,rk3288-i2c".
  - interrupts : interrupt number
  - clocks : parent clock
 
diff --git a/drivers/i2c/busses/i2c-rk3x.c b/drivers/i2c/busses/i2c-rk3x.c
index 9096d17..3dcc5f3 100644
--- a/drivers/i2c/busses/i2c-rk3x.c
+++ b/drivers/i2c/busses/i2c-rk3x.c
@@ -855,6 +855,7 @@ static struct rk3x_i2c_soc_data soc_data[3] = {
 static const struct of_device_id rk3x_i2c_match[] = {
 	{ .compatible = "rockchip,rk3066-i2c", .data = (void *)&soc_data[0] },
 	{ .compatible = "rockchip,rk3188-i2c", .data = (void *)&soc_data[1] },
+	{ .compatible = "rockchip,rk3228-i2c", .data = (void *)&soc_data[2] },
 	{ .compatible = "rockchip,rk3288-i2c", .data = (void *)&soc_data[2] },
 	{},
 };
-- 
1.9.1
