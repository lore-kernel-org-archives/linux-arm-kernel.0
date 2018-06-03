From: abdun.nihaal@gmail.com (Abdun Nihaal)
Date: Sun,  3 Jun 2018 21:30:04 +0530
Subject: [PATCH 7/7] staging: mt7621-pci: fix coding style error
In-Reply-To: <cover.1528040188.git.abdun.nihaal@gmail.com>
References: <cover.1528040188.git.abdun.nihaal@gmail.com>
Message-ID: <dd5a61ff6074778d813183464fd65020098978c1.1528040188.git.abdun.nihaal@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This fixes the following checkpatch error:

ERROR: that open brace { should be on the previous line

Signed-off-by: Abdun Nihaal <abdun.nihaal@gmail.com>
---
 drivers/staging/mt7621-pci/pci-mt7621.c | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/drivers/staging/mt7621-pci/pci-mt7621.c b/drivers/staging/mt7621-pci/pci-mt7621.c
index 510aa633589a..96cae1e1838b 100644
--- a/drivers/staging/mt7621-pci/pci-mt7621.c
+++ b/drivers/staging/mt7621-pci/pci-mt7621.c
@@ -663,8 +663,7 @@ static int mt7621_pci_probe(struct platform_device *pdev)
 
 	mdelay(500);
 #if defined (CONFIG_PCIE_PORT0)
-	if ((RALINK_PCI0_STATUS & 0x1) == 0)
-	{
+	if ((RALINK_PCI0_STATUS & 0x1) == 0) {
 		printk("PCIE0 no card, disable it(RST&CLK)\n");
 		ASSERT_SYSRST_PCIE(RALINK_PCIE0_RST);
 		RALINK_CLKCFG1 = (RALINK_CLKCFG1 & ~RALINK_PCIE0_CLK_EN);
@@ -675,8 +674,7 @@ static int mt7621_pci_probe(struct platform_device *pdev)
 	}
 #endif
 #if defined (CONFIG_PCIE_PORT1)
-	if ((RALINK_PCI1_STATUS & 0x1) == 0)
-	{
+	if ((RALINK_PCI1_STATUS & 0x1) == 0) {
 		printk("PCIE1 no card, disable it(RST&CLK)\n");
 		ASSERT_SYSRST_PCIE(RALINK_PCIE1_RST);
 		RALINK_CLKCFG1 = (RALINK_CLKCFG1 & ~RALINK_PCIE1_CLK_EN);
-- 
2.17.0
