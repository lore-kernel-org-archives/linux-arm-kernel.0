From: wsa@the-dreams.de (Wolfram Sang)
Date: Thu, 16 May 2013 13:15:57 +0200
Subject: [PATCH 29/33] arch/arm/mach-tegra: don't check resource with
 devm_ioremap_resource
In-Reply-To: <1368702961-4325-1-git-send-email-wsa@the-dreams.de>
References: <1368702961-4325-1-git-send-email-wsa@the-dreams.de>
Message-ID: <1368702961-4325-30-git-send-email-wsa@the-dreams.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

devm_ioremap_resource does sanity checks on the given resource. No need to
duplicate this in the driver.

Signed-off-by: Wolfram Sang <wsa@the-dreams.de>
---
 arch/arm/mach-tegra/tegra2_emc.c |    5 -----
 1 file changed, 5 deletions(-)

diff --git a/arch/arm/mach-tegra/tegra2_emc.c b/arch/arm/mach-tegra/tegra2_emc.c
index 9e8bdfa..31e69a0 100644
--- a/arch/arm/mach-tegra/tegra2_emc.c
+++ b/arch/arm/mach-tegra/tegra2_emc.c
@@ -307,11 +307,6 @@ static int tegra_emc_probe(struct platform_device *pdev)
 	}
 
 	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
-	if (!res) {
-		dev_err(&pdev->dev, "missing register base\n");
-		return -ENOMEM;
-	}
-
 	emc_regbase = devm_ioremap_resource(&pdev->dev, res);
 	if (IS_ERR(emc_regbase))
 		return PTR_ERR(emc_regbase);
-- 
1.7.10.4
