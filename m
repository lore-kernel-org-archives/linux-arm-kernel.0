From: andre.przywara@arm.com (Andre Przywara)
Date: Sat, 25 Nov 2017 12:02:00 +0000
Subject: [PATCH 2/2] pinctrl: sunxi: Disable strict mode for H5 driver
In-Reply-To: <20171125120200.23294-1-andre.przywara@arm.com>
References: <20171125120200.23294-1-andre.przywara@arm.com>
Message-ID: <20171125120200.23294-3-andre.przywara@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

All of the H5 boards in the kernel reference the MMC0 CD pin twice in
their DT, so strict mode will make the MMC driver fail to load.
To keep existing DTs working, disable strict mode in the H5 driver.

Signed-off-by: Andre Przywara <andre.przywara@arm.com>
Reported-by: Chris Obbard <obbardc@gmail.com>
---
 drivers/pinctrl/sunxi/pinctrl-sun50i-h5.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/drivers/pinctrl/sunxi/pinctrl-sun50i-h5.c b/drivers/pinctrl/sunxi/pinctrl-sun50i-h5.c
index 97b48336f84a..a78d7b922ef4 100644
--- a/drivers/pinctrl/sunxi/pinctrl-sun50i-h5.c
+++ b/drivers/pinctrl/sunxi/pinctrl-sun50i-h5.c
@@ -535,14 +535,16 @@ static const struct sunxi_pinctrl_desc sun50i_h5_pinctrl_data_broken = {
 	.pins = sun50i_h5_pins,
 	.npins = ARRAY_SIZE(sun50i_h5_pins),
 	.irq_banks = 2,
-	.irq_read_needs_mux = true
+	.irq_read_needs_mux = true,
+	.disable_strict_mode = true,
 };
 
 static const struct sunxi_pinctrl_desc sun50i_h5_pinctrl_data = {
 	.pins = sun50i_h5_pins,
 	.npins = ARRAY_SIZE(sun50i_h5_pins),
 	.irq_banks = 3,
-	.irq_read_needs_mux = true
+	.irq_read_needs_mux = true,
+	.disable_strict_mode = true,
 };
 
 static int sun50i_h5_pinctrl_probe(struct platform_device *pdev)
-- 
2.14.1
