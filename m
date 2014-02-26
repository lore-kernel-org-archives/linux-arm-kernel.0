From: sboyd@codeaurora.org (Stephen Boyd)
Date: Wed, 26 Feb 2014 10:59:25 -0800
Subject: [PATCH v4 7/8] mfd: pm8921: Loosen Kconfig dependency
In-Reply-To: <1393441166-32692-1-git-send-email-sboyd@codeaurora.org>
References: <1393441166-32692-1-git-send-email-sboyd@codeaurora.org>
Message-ID: <1393441166-32692-8-git-send-email-sboyd@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Allow this driver to be compiled on all ARM builds as it doesn't
rely on anything within arm/mach-msm.

Signed-off-by: Stephen Boyd <sboyd@codeaurora.org>
---
 drivers/mfd/Kconfig | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/mfd/Kconfig b/drivers/mfd/Kconfig
index be98d88acfb8..42d592a2e392 100644
--- a/drivers/mfd/Kconfig
+++ b/drivers/mfd/Kconfig
@@ -473,7 +473,7 @@ config MFD_PM8XXX
 
 config MFD_PM8921_CORE
 	tristate "Qualcomm PM8921 PMIC chip"
-	depends on (ARCH_MSM || HEXAGON)
+	depends on (ARM || HEXAGON)
 	select IRQ_DOMAIN
 	select MFD_CORE
 	select MFD_PM8XXX
-- 
The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum,
hosted by The Linux Foundation
