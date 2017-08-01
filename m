From: icenowy@aosc.io (Icenowy Zheng)
Date: Tue,  1 Aug 2017 22:54:16 +0800
Subject: [PATCH] pinctrl: sunxi: fix V3s pinctrl driver IRQ bank base
Message-ID: <20170801145416.61854-1-icenowy@aosc.io>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The V3s pin controller doesn't have the bank 0 (starts at address
0x200), which is like A33. However, this is not workarounded when
developing the driver, which makes IRQ not working.

Fix the IRQ bank base.

Fixes: 56d9e4a76039 ("pinctrl: sunxi: add driver for V3s SoC")
Cc: stable at vger.kernel.org
Signed-off-by: Icenowy Zheng <icenowy@aosc.io>
---
 drivers/pinctrl/sunxi/pinctrl-sun8i-v3s.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/pinctrl/sunxi/pinctrl-sun8i-v3s.c b/drivers/pinctrl/sunxi/pinctrl-sun8i-v3s.c
index c86d3c42a905..496ba34e1f5f 100644
--- a/drivers/pinctrl/sunxi/pinctrl-sun8i-v3s.c
+++ b/drivers/pinctrl/sunxi/pinctrl-sun8i-v3s.c
@@ -297,6 +297,7 @@ static const struct sunxi_pinctrl_desc sun8i_v3s_pinctrl_data = {
 	.pins = sun8i_v3s_pins,
 	.npins = ARRAY_SIZE(sun8i_v3s_pins),
 	.irq_banks = 2,
+	.irq_bank_base = 1,
 	.irq_read_needs_mux = true
 };
 
-- 
2.13.0
