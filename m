From: aleksey.makarov@caviumnetworks.com (Aleksey Makarov)
Date: Wed, 29 Jul 2015 16:49:45 +0300
Subject: [PATCH net 10/11] net: thunderx: Add PCI driver shutdown routine
In-Reply-To: <1438177787-20940-1-git-send-email-aleksey.makarov@caviumnetworks.com>
References: <1438177787-20940-1-git-send-email-aleksey.makarov@caviumnetworks.com>
Message-ID: <1438177787-20940-11-git-send-email-aleksey.makarov@caviumnetworks.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Sunil Goutham <sgoutham@cavium.com>

Signed-off-by: Sunil Goutham <sgoutham@cavium.com>
Signed-off-by: Aleksey Makarov <aleksey.makarov@caviumnetworks.com>
---
 drivers/net/ethernet/cavium/thunder/nicvf_main.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/drivers/net/ethernet/cavium/thunder/nicvf_main.c b/drivers/net/ethernet/cavium/thunder/nicvf_main.c
index c7a29a3..3b90afb 100644
--- a/drivers/net/ethernet/cavium/thunder/nicvf_main.c
+++ b/drivers/net/ethernet/cavium/thunder/nicvf_main.c
@@ -1335,11 +1335,17 @@ static void nicvf_remove(struct pci_dev *pdev)
 	pci_disable_device(pdev);
 }
 
+static void nicvf_shutdown(struct pci_dev *pdev)
+{
+	nicvf_remove(pdev);
+}
+
 static struct pci_driver nicvf_driver = {
 	.name = DRV_NAME,
 	.id_table = nicvf_id_table,
 	.probe = nicvf_probe,
 	.remove = nicvf_remove,
+	.shutdown = nicvf_shutdown,
 };
 
 static int __init nicvf_init_module(void)
-- 
2.4.6
