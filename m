From: abdun.nihaal@gmail.com (Abdun Nihaal)
Date: Sun,  3 Jun 2018 21:29:58 +0530
Subject: [PATCH 1/7] staging: mt7621-pci: Remove space after open parenthesis
In-Reply-To: <cover.1528040188.git.abdun.nihaal@gmail.com>
References: <cover.1528040188.git.abdun.nihaal@gmail.com>
Message-ID: <e1ebc6d90b6a35239dd477a91bb64699461c87f7.1528040188.git.abdun.nihaal@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This fixes the following checkpatch error:

ERROR: space prohibited after that open parenthesis '('

Signed-off-by: Abdun Nihaal <abdun.nihaal@gmail.com>
---
 drivers/staging/mt7621-pci/pci-mt7621.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/staging/mt7621-pci/pci-mt7621.c b/drivers/staging/mt7621-pci/pci-mt7621.c
index 1fa41eb8a87f..44f1a592a7a5 100644
--- a/drivers/staging/mt7621-pci/pci-mt7621.c
+++ b/drivers/staging/mt7621-pci/pci-mt7621.c
@@ -221,7 +221,7 @@ static int config_access(unsigned char access_type, struct pci_bus *bus,
 		MV_WRITE(data_reg, *data);
 		break;
 	case PCI_ACCESS_READ_1:
-		MV_READ_8( data_reg+(where&0x3), data);
+		MV_READ_8(data_reg+(where&0x3), data);
 		break;
 	case PCI_ACCESS_READ_2:
 		MV_READ_16(data_reg+(where&0x3), data);
@@ -663,7 +663,7 @@ static int mt7621_pci_probe(struct platform_device *pdev)
 
 	mdelay(500);
 #if defined (CONFIG_PCIE_PORT0)
-	if(( RALINK_PCI0_STATUS & 0x1) == 0)
+	if((RALINK_PCI0_STATUS & 0x1) == 0)
 	{
 		printk("PCIE0 no card, disable it(RST&CLK)\n");
 		ASSERT_SYSRST_PCIE(RALINK_PCIE0_RST);
@@ -675,7 +675,7 @@ static int mt7621_pci_probe(struct platform_device *pdev)
 	}
 #endif
 #if defined (CONFIG_PCIE_PORT1)
-	if(( RALINK_PCI1_STATUS & 0x1) == 0)
+	if((RALINK_PCI1_STATUS & 0x1) == 0)
 	{
 		printk("PCIE1 no card, disable it(RST&CLK)\n");
 		ASSERT_SYSRST_PCIE(RALINK_PCIE1_RST);
@@ -687,7 +687,7 @@ static int mt7621_pci_probe(struct platform_device *pdev)
 	}
 #endif
 #if defined (CONFIG_PCIE_PORT2)
-	if (( RALINK_PCI2_STATUS & 0x1) == 0) {
+	if ((RALINK_PCI2_STATUS & 0x1) == 0) {
 		printk("PCIE2 no card, disable it(RST&CLK)\n");
 		ASSERT_SYSRST_PCIE(RALINK_PCIE2_RST);
 		RALINK_CLKCFG1 = (RALINK_CLKCFG1 & ~RALINK_PCIE2_CLK_EN);
-- 
2.17.0
