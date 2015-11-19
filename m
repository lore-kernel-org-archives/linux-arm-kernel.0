From: heiko@sntech.de (Heiko Stuebner)
Date: Thu, 19 Nov 2015 22:22:25 +0100
Subject: [PATCH v3 4/8] phy: rockchip-usb: add compatible values for rk3066a
 and rk3188
In-Reply-To: <1447968149-10979-1-git-send-email-heiko@sntech.de>
References: <1447968149-10979-1-git-send-email-heiko@sntech.de>
Message-ID: <1447968149-10979-5-git-send-email-heiko@sntech.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

We need custom handling for these two socs in the driver shortly,
so add the necessary compatible values to binding and driver.

Signed-off-by: Heiko Stuebner <heiko@sntech.de>
---
 Documentation/devicetree/bindings/phy/rockchip-usb-phy.txt | 5 ++++-
 drivers/phy/phy-rockchip-usb.c                             | 2 ++
 2 files changed, 6 insertions(+), 1 deletion(-)

diff --git a/Documentation/devicetree/bindings/phy/rockchip-usb-phy.txt b/Documentation/devicetree/bindings/phy/rockchip-usb-phy.txt
index 826454a..9b37242 100644
--- a/Documentation/devicetree/bindings/phy/rockchip-usb-phy.txt
+++ b/Documentation/devicetree/bindings/phy/rockchip-usb-phy.txt
@@ -1,7 +1,10 @@
 ROCKCHIP USB2 PHY
 
 Required properties:
- - compatible: rockchip,rk3288-usb-phy
+ - compatible: matching the soc type, one of
+     "rockchip,rk3066a-usb-phy"
+     "rockchip,rk3188-usb-phy"
+     "rockchip,rk3288-usb-phy"
  - rockchip,grf : phandle to the syscon managing the "general
    register files"
  - #address-cells: should be 1
diff --git a/drivers/phy/phy-rockchip-usb.c b/drivers/phy/phy-rockchip-usb.c
index ff3ac33..16cd533 100644
--- a/drivers/phy/phy-rockchip-usb.c
+++ b/drivers/phy/phy-rockchip-usb.c
@@ -176,6 +176,8 @@ static int rockchip_usb_phy_probe(struct platform_device *pdev)
 }
 
 static const struct of_device_id rockchip_usb_phy_dt_ids[] = {
+	{ .compatible = "rockchip,rk3066a-usb-phy" },
+	{ .compatible = "rockchip,rk3188-usb-phy" },
 	{ .compatible = "rockchip,rk3288-usb-phy" },
 	{}
 };
-- 
2.6.2
