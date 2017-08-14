From: andy.yan@rock-chips.com (Andy Yan)
Date: Mon, 14 Aug 2017 16:34:22 +0800
Subject: [PATCH v4 1/8] spi: rockchip: add compatible string for rv1108 spi
In-Reply-To: <1502699477-8063-1-git-send-email-andy.yan@rock-chips.com>
References: <1502699477-8063-1-git-send-email-andy.yan@rock-chips.com>
Message-ID: <1502699662-8181-1-git-send-email-andy.yan@rock-chips.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The spi on rv1108 is the same as other rockchip based
socs, add compatible string for it.

Signed-off-by: Andy Yan <andy.yan@rock-chips.com>
Acked-by: Rob Herring <robh@kernel.org>

---

Changes in v4: None
Changes in v3: None
Changes in v2: None

 Documentation/devicetree/bindings/spi/spi-rockchip.txt | 1 +
 drivers/spi/spi-rockchip.c                             | 1 +
 2 files changed, 2 insertions(+)

diff --git a/Documentation/devicetree/bindings/spi/spi-rockchip.txt b/Documentation/devicetree/bindings/spi/spi-rockchip.txt
index 83da493..6e3ffac 100644
--- a/Documentation/devicetree/bindings/spi/spi-rockchip.txt
+++ b/Documentation/devicetree/bindings/spi/spi-rockchip.txt
@@ -6,6 +6,7 @@ and display controllers using the SPI communication interface.
 Required Properties:
 
 - compatible: should be one of the following.
+    "rockchip,rv1108-spi" for rv1108 SoCs.
     "rockchip,rk3036-spi" for rk3036 SoCS.
     "rockchip,rk3066-spi" for rk3066 SoCs.
     "rockchip,rk3188-spi" for rk3188 SoCs.
diff --git a/drivers/spi/spi-rockchip.c b/drivers/spi/spi-rockchip.c
index 0b4a52b..27b4db2 100644
--- a/drivers/spi/spi-rockchip.c
+++ b/drivers/spi/spi-rockchip.c
@@ -919,6 +919,7 @@ static const struct dev_pm_ops rockchip_spi_pm = {
 };
 
 static const struct of_device_id rockchip_spi_dt_match[] = {
+	{ .compatible = "rockchip,rv1108-spi", },
 	{ .compatible = "rockchip,rk3036-spi", },
 	{ .compatible = "rockchip,rk3066-spi", },
 	{ .compatible = "rockchip,rk3188-spi", },
-- 
2.7.4
