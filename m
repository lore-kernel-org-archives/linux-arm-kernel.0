From: krzk@kernel.org (Krzysztof Kozlowski)
Date: Tue, 24 Apr 2018 22:32:31 +0200
Subject: [RFC 02/10] ata: ahci-platform: Remove support for Exynos5440
In-Reply-To: <20180424203239.21885-1-krzk@kernel.org>
References: <20180424203239.21885-1-krzk@kernel.org>
Message-ID: <20180424203239.21885-3-krzk@kernel.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The Exynos5440 is not actively developed, there are no development
boards available and probably there are no real products with it.
Remove wide-tree support for Exynos5440.

Signed-off-by: Krzysztof Kozlowski <krzk@kernel.org>
---
 Documentation/devicetree/bindings/ata/ahci-platform.txt | 1 -
 drivers/ata/ahci_platform.c                             | 1 -
 2 files changed, 2 deletions(-)

diff --git a/Documentation/devicetree/bindings/ata/ahci-platform.txt b/Documentation/devicetree/bindings/ata/ahci-platform.txt
index c760ecb81381..663766685818 100644
--- a/Documentation/devicetree/bindings/ata/ahci-platform.txt
+++ b/Documentation/devicetree/bindings/ata/ahci-platform.txt
@@ -17,7 +17,6 @@ Required properties:
   - "marvell,armada-380-ahci"
   - "marvell,armada-3700-ahci"
   - "snps,dwc-ahci"
-  - "snps,exynos5440-ahci"
   - "snps,spear-ahci"
   - "generic-ahci"
 - interrupts        : <interrupt mapping for SATA IRQ>
diff --git a/drivers/ata/ahci_platform.c b/drivers/ata/ahci_platform.c
index 99f9a895a459..564570ea3e27 100644
--- a/drivers/ata/ahci_platform.c
+++ b/drivers/ata/ahci_platform.c
@@ -75,7 +75,6 @@ static const struct of_device_id ahci_of_match[] = {
 	{ .compatible = "generic-ahci", },
 	/* Keep the following compatibles for device tree compatibility */
 	{ .compatible = "snps,spear-ahci", },
-	{ .compatible = "snps,exynos5440-ahci", },
 	{ .compatible = "ibm,476gtr-ahci", },
 	{ .compatible = "snps,dwc-ahci", },
 	{ .compatible = "hisilicon,hisi-ahci", },
-- 
2.14.1
