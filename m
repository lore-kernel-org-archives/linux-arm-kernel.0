From: wxt@rock-chips.com (Caesar Wang)
Date: Thu, 19 May 2016 23:47:03 +0800
Subject: [PATCH 2/3] spi/rockchip: add the rk3036/rk3228/rk3368 to match for
 driver
In-Reply-To: <1463672824-15367-1-git-send-email-wxt@rock-chips.com>
References: <1463672824-15367-1-git-send-email-wxt@rock-chips.com>
Message-ID: <1463672824-15367-2-git-send-email-wxt@rock-chips.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

In gerenal, the "rockchip,rockchip-spi" string will match the dts
that's great in spi driver. After all the most of rockchip SoCs ar
same spi controller.

Then, we should keep the old style to match the dts various.

Signed-off-by: Caesar Wang <wxt@rock-chips.com>
Cc: Mark Brown <broonie@kernel.org>
Cc: Heiko Stuebner <heiko@sntech.de>
Cc: linux-rockchip at lists.infradead.org
---

 drivers/spi/spi-rockchip.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/spi/spi-rockchip.c b/drivers/spi/spi-rockchip.c
index 6c6c001..dd08b68 100644
--- a/drivers/spi/spi-rockchip.c
+++ b/drivers/spi/spi-rockchip.c
@@ -893,9 +893,12 @@ static const struct dev_pm_ops rockchip_spi_pm = {
 };
 
 static const struct of_device_id rockchip_spi_dt_match[] = {
+	{ .compatible = "rockchip,rk3036-spi", },
 	{ .compatible = "rockchip,rk3066-spi", },
 	{ .compatible = "rockchip,rk3188-spi", },
+	{ .compatible = "rockchip,rk3228-spi", },
 	{ .compatible = "rockchip,rk3288-spi", },
+	{ .compatible = "rockchip,rk3368-spi", },
 	{ .compatible = "rockchip,rk3399-spi", },
 	{ },
 };
-- 
2.7.4
