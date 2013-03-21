From: lee.jones@linaro.org (Lee Jones)
Date: Thu, 21 Mar 2013 15:59:14 +0000
Subject: [PATCH 17/46] ARM: ux500: regulators: List the MMIO camera as a
 consumer of VAUX1
In-Reply-To: <1363881583-15234-1-git-send-email-lee.jones@linaro.org>
References: <1363881583-15234-1-git-send-email-lee.jones@linaro.org>
Message-ID: <1363881583-15234-18-git-send-email-lee.jones@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The MMIO camera uses the VAUX1 as it's voltage supply.

Signed-off-by: Lee Jones <lee.jones@linaro.org>
---
 arch/arm/mach-ux500/board-mop500-regulators.c |    2 ++
 1 file changed, 2 insertions(+)

diff --git a/arch/arm/mach-ux500/board-mop500-regulators.c b/arch/arm/mach-ux500/board-mop500-regulators.c
index 3d63c8d..b08c8c8 100644
--- a/arch/arm/mach-ux500/board-mop500-regulators.c
+++ b/arch/arm/mach-ux500/board-mop500-regulators.c
@@ -81,6 +81,8 @@ static struct regulator_consumer_supply ab8500_vaux1_consumers[] = {
 	REGULATOR_SUPPLY("vdd", "2-005c"),
 	/* Cypress TrueTouch Touchscreen device */
 	REGULATOR_SUPPLY("vcpin", "spi8.0"),
+	/* Camera device */
+	REGULATOR_SUPPLY("vaux12v5", "mmio_camera"),
 };
 
 static struct regulator_consumer_supply ab8500_vaux2_consumers[] = {
-- 
1.7.10.4
