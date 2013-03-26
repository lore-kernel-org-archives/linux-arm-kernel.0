From: davidb@codeaurora.org (David Brown)
Date: Tue, 26 Mar 2013 11:20:17 -0700
Subject: [PATCH] mfd: pm8921: Disable driver until it gets fixed
In-Reply-To: <20130326151811.de958e38f0116334a62e1c8b@canb.auug.org.au>
Message-ID: <1364322017-21490-1-git-send-email-davidb@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The pm8921 driver has been broken for a while now, but was prevented
from compiling because the SSBI bus driver was missing.  Now that SSBI
is present, pm8921 causes compile fails.

Until the pm8921 driver is fixed, mark it as BROKEN to prevent
compiles from failing.

Cc: Greg KH <greg@kroah.com>
Cc: Stephen Rothwell <sfr@canb.auug.org.au>
Signed-off-by: David Brown <davidb@codeaurora.org>
---
Someone is working on the pm8921 driver, but we need to disable it
until those patches are posted.

 drivers/mfd/Kconfig | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/mfd/Kconfig b/drivers/mfd/Kconfig
index 5bfa7bb..b9723a8 100644
--- a/drivers/mfd/Kconfig
+++ b/drivers/mfd/Kconfig
@@ -990,7 +990,7 @@ config MFD_PM8XXX
 
 config MFD_PM8921_CORE
 	tristate "Qualcomm PM8921 PMIC chip"
-	depends on SSBI
+	depends on SSBI && BROKEN
 	select MFD_CORE
 	select MFD_PM8XXX
 	help
-- 
The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum,
hosted by The Linux Foundation
