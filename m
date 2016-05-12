From: david.wu@rock-chips.com (David Wu)
Date: Thu, 12 May 2016 15:57:59 +0800
Subject: [PATCH v9 6/8] dt-bindings: i2c: rk3x: add support for rk3399
In-Reply-To: <1463039586-8134-1-git-send-email-david.wu@rock-chips.com>
References: <1463039586-8134-1-git-send-email-david.wu@rock-chips.com>
Message-ID: <1463039879-8318-1-git-send-email-david.wu@rock-chips.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The bus clock and function clock are separated at rk3399,
and others use one clock as the bus clock and function clock.

Signed-off-by: David Wu <david.wu@rock-chips.com>
Reviewed-by: Douglas Anderson <dianders@chromium.org>
Reviewed-by: Heiko Stuebner <heiko@sntech.de>
---
Change in v9:
- remove unnecessary "REQUIRED".

Change in v8:
- remove error description.

 Documentation/devicetree/bindings/i2c/i2c-rk3x.txt | 16 +++++++++++++---
 1 file changed, 13 insertions(+), 3 deletions(-)

diff --git a/Documentation/devicetree/bindings/i2c/i2c-rk3x.txt b/Documentation/devicetree/bindings/i2c/i2c-rk3x.txt
index 0b4a85f..bbc5a1e 100644
--- a/Documentation/devicetree/bindings/i2c/i2c-rk3x.txt
+++ b/Documentation/devicetree/bindings/i2c/i2c-rk3x.txt
@@ -6,10 +6,20 @@ RK3xxx SoCs.
 Required properties :
 
  - reg : Offset and length of the register set for the device
- - compatible : should be "rockchip,rk3066-i2c", "rockchip,rk3188-i2c",
-		"rockchip,rk3228-i2c" or "rockchip,rk3288-i2c".
+ - compatible: should be one of the following:
+   - "rockchip,rk3066-i2c": for rk3066
+   - "rockchip,rk3188-i2c": for rk3188
+   - "rockchip,rk3228-i2c": for rk3228
+   - "rockchip,rk3288-i2c": for rk3288
+   - "rockchip,rk3399-i2c": for rk3399
  - interrupts : interrupt number
- - clocks : parent clock
+ - clocks: See ../clock/clock-bindings.txt
+   - For older hardware (rk3066, rk3188, rk3228, rk3288):
+     - There is one clock that's used both to derive the functional clock
+       for the device and as the bus clock.
+   - For newer hardware (rk3399): specified by name
+     - "i2c": This is used to derive the functional clock.
+     - "pclk": This is the bus clock.
 
 Required on RK3066, RK3188 :
 
-- 
1.9.1
