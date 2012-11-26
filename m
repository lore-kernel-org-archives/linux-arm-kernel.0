From: richardcochran@gmail.com (Richard Cochran)
Date: Mon, 26 Nov 2012 13:07:18 +0100
Subject: [PATCH net-next] cpts: add missing kconfig dependency
Message-ID: <1353931638-1023-1-git-send-email-richardcochran@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The Common Platform Time Sync function of the CPSW does not depend the
CPSW configuration option as it should. This patch fixes the issue by
adding the dependency.

Signed-off-by: Richard Cochran <richardcochran@gmail.com>
---
 drivers/net/ethernet/ti/Kconfig |    1 +
 1 files changed, 1 insertions(+), 0 deletions(-)

diff --git a/drivers/net/ethernet/ti/Kconfig b/drivers/net/ethernet/ti/Kconfig
index 48fcb5e..4426151 100644
--- a/drivers/net/ethernet/ti/Kconfig
+++ b/drivers/net/ethernet/ti/Kconfig
@@ -62,6 +62,7 @@ config TI_CPSW
 
 config TI_CPTS
 	boolean "TI Common Platform Time Sync (CPTS) Support"
+	depends on TI_CPSW
 	select PTP_1588_CLOCK
 	---help---
 	  This driver supports the Common Platform Time Sync unit of
-- 
1.7.2.5
