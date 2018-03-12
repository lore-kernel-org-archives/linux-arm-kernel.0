From: jeffy.chen@rock-chips.com (Jeffy Chen)
Date: Mon, 12 Mar 2018 17:51:42 +0800
Subject: [PATCH v5 4/4] ARM: rockchip: Set name of regmap_config
In-Reply-To: <20180312095142.30854-1-jeffy.chen@rock-chips.com>
References: <20180312095142.30854-1-jeffy.chen@rock-chips.com>
Message-ID: <20180312095142.30854-5-jeffy.chen@rock-chips.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

We are now allowing to register debugfs without a valid device, and not
having a valid name will end up using "dummy*" to create debugfs dir.

Signed-off-by: Jeffy Chen <jeffy.chen@rock-chips.com>
---

Changes in v5: None
Changes in v4: None
Changes in v3: None

 arch/arm/mach-rockchip/platsmp.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm/mach-rockchip/platsmp.c b/arch/arm/mach-rockchip/platsmp.c
index ecec340ca345..51984a40b097 100644
--- a/arch/arm/mach-rockchip/platsmp.c
+++ b/arch/arm/mach-rockchip/platsmp.c
@@ -208,6 +208,7 @@ static int __init rockchip_smp_prepare_sram(struct device_node *node)
 }
 
 static const struct regmap_config rockchip_pmu_regmap_config = {
+	.name = "rockchip-pmu",
 	.reg_bits = 32,
 	.val_bits = 32,
 	.reg_stride = 4,
-- 
2.11.0
