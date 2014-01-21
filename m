From: dan.carpenter@oracle.com (Dan Carpenter)
Date: Tue, 21 Jan 2014 09:52:16 +0300
Subject: [patch] ARM: mvebu: checking for IS_ERR() instead of NULL
Message-ID: <20140121065216.GA31535@elgon.mountain>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

of_iomap() returns NULL on error, it doesn't return error pointers.

Signed-off-by: Dan Carpenter <dan.carpenter@oracle.com>

diff --git a/arch/arm/mach-mvebu/mvebu-soc-id.c b/arch/arm/mach-mvebu/mvebu-soc-id.c
index fe4fc1cbdfaf..b4cfbd62709d 100644
--- a/arch/arm/mach-mvebu/mvebu-soc-id.c
+++ b/arch/arm/mach-mvebu/mvebu-soc-id.c
@@ -88,7 +88,7 @@ static int __init mvebu_soc_id_init(void)
 	}
 
 	pci_base = of_iomap(child, 0);
-	if (IS_ERR(pci_base)) {
+	if (!pci_base) {
 		pr_err("cannot map registers\n");
 		ret = -ENOMEM;
 		goto res_ioremap;
