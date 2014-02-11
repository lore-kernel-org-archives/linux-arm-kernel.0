From: galak@codeaurora.org (Kumar Gala)
Date: Tue, 11 Feb 2014 14:21:45 -0600
Subject: [PATCH] hwrng: msm: switch Kconfig to ARCH_QCOM depends
Message-ID: <1392150105-21057-1-git-send-email-galak@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This is the splits the Qualcomm MSM platform into legacy support that we will
not try and convert to multiplatform and multiplatform support.

- k

Changes from v2:
* Dropped ARCH_MSM depends from CLKSRC_QCOM, since we select it
* Fixed some grammar/typo's in commit messages
* kept smp ops code in platsmp.c to match what other mach's do
* Kept mach-qcom/Kconfig sorted alphabetically

Changes from v1:
* Added patch to remove hotplug.c
* Added patch to rename msm_ to qcom_
* Changes the Kconfig to drop CPU_V7
* used wfi() in cpu_die function
* Added git tree to MAINTAINERS file

Kumar Gala (5):

We've split Qualcomm MSM support into legacy and multiplatform.  The RNG
driver is only relevant on the multiplatform supported SoCs so switch the
Kconfig depends to ARCH_QCOM.

CC: Herbert Xu <herbert@gondor.apana.org.au>
Signed-off-by: Kumar Gala <galak@codeaurora.org>
---
 drivers/char/hw_random/Kconfig | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/char/hw_random/Kconfig b/drivers/char/hw_random/Kconfig
index 2f2b084..289bd3a 100644
--- a/drivers/char/hw_random/Kconfig
+++ b/drivers/char/hw_random/Kconfig
@@ -343,7 +343,7 @@ config HW_RANDOM_TPM
 
 config HW_RANDOM_MSM
 	tristate "Qualcomm MSM Random Number Generator support"
-	depends on HW_RANDOM && ARCH_MSM
+	depends on HW_RANDOM && ARCH_QCOM
 	---help---
 	  This driver provides kernel-side support for the Random Number
 	  Generator hardware found on Qualcomm MSM SoCs.
-- 
The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum,
hosted by The Linux Foundation
