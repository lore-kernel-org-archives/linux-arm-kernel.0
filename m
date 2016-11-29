From: vladimir.murzin@arm.com (Vladimir Murzin)
Date: Tue, 29 Nov 2016 12:40:03 +0000
Subject: [RFC v2 PATCH 21/23] cnic: add dependency on MMU
In-Reply-To: <1480423205-48436-1-git-send-email-vladimir.murzin@arm.com>
References: <1480423205-48436-1-git-send-email-vladimir.murzin@arm.com>
Message-ID: <1480423205-48436-22-git-send-email-vladimir.murzin@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

CNIC selects UIO framework which has dependency on MMU, so for NOMMU
builds following warning shows up:

warning: (CNIC) selects UIO which has unmet direct dependencies (MMU)

Fix it with making CNIC dependant on MMU.

Signed-off-by: Vladimir Murzin <vladimir.murzin@arm.com>
---
 drivers/net/ethernet/broadcom/Kconfig |    1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/net/ethernet/broadcom/Kconfig b/drivers/net/ethernet/broadcom/Kconfig
index bd8c80c..ea04b36 100644
--- a/drivers/net/ethernet/broadcom/Kconfig
+++ b/drivers/net/ethernet/broadcom/Kconfig
@@ -83,6 +83,7 @@ config BNX2
 config CNIC
 	tristate "QLogic CNIC support"
 	depends on PCI && (IPV6 || IPV6=n)
+	depends on MMU
 	select BNX2
 	select UIO
 	---help---
-- 
1.7.9.5
