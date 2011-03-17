From: Hong-Xing.Zhu@freescale.com (Richard Zhu)
Date: Thu, 17 Mar 2011 15:10:58 +0800
Subject: [PATCH V1 1/3] ahci_platform: add two clk pointer member into
	ahci_platform_data struct
Message-ID: <1300345860-16574-1-git-send-email-Hong-Xing.Zhu@freescale.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Signed-off-by: Richard Zhu <Hong-Xing.Zhu@freescale.com>
---
 include/linux/ahci_platform.h |    2 ++
 1 files changed, 2 insertions(+), 0 deletions(-)

diff --git a/include/linux/ahci_platform.h b/include/linux/ahci_platform.h
index be3d9a7..86b5e24 100644
--- a/include/linux/ahci_platform.h
+++ b/include/linux/ahci_platform.h
@@ -26,6 +26,8 @@ struct ahci_platform_data {
 	const struct ata_port_info *ata_port_info;
 	unsigned int force_port_map;
 	unsigned int mask_port_map;
+	struct clk *sata_clk;
+	struct clk *sata_ref_clk;
 };
 
 #endif /* _AHCI_PLATFORM_H */
-- 
1.7.1
