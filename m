From: galak@codeaurora.org (Kumar Gala)
Date: Thu, 20 Feb 2014 15:58:53 -0600
Subject: [PATCH v3] hwrng: msm: switch Kconfig to ARCH_QCOM depends
Message-ID: <1392933533-10191-1-git-send-email-galak@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

We've split Qualcomm MSM support into legacy and multiplatform.  The RNG
driver is only relevant on the multiplatform supported SoCs so switch the
Kconfig depends to ARCH_QCOM.

CC: Herbert Xu <herbert@gondor.apana.org.au>
CC: Stanimir Varbanov <svarbanov@mm-sol.com>
Signed-off-by: Kumar Gala <galak@codeaurora.org>
---
Herbert,

If you can ack this I'll send it via linux-qcom/arm-soc tree's

thanks

v3:
* drop ARM references as the driver could be used on hexagon
v2:
* Updated help text to remove MSM references, made more generic

 drivers/char/hw_random/Kconfig | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/char/hw_random/Kconfig b/drivers/char/hw_random/Kconfig
index 2f2b084..244759b 100644
--- a/drivers/char/hw_random/Kconfig
+++ b/drivers/char/hw_random/Kconfig
@@ -342,11 +342,11 @@ config HW_RANDOM_TPM
 	  If unsure, say Y.
 
 config HW_RANDOM_MSM
-	tristate "Qualcomm MSM Random Number Generator support"
-	depends on HW_RANDOM && ARCH_MSM
+	tristate "Qualcomm SoCs Random Number Generator support"
+	depends on HW_RANDOM && ARCH_QCOM
 	---help---
 	  This driver provides kernel-side support for the Random Number
-	  Generator hardware found on Qualcomm MSM SoCs.
+	  Generator hardware found on Qualcomm SoCs.
 
 	  To compile this driver as a module, choose M here. the
 	  module will be called msm-rng.
-- 
The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum,
hosted by The Linux Foundation
