From: consul.kautuk@gmail.com (Kautuk Consul)
Date: Fri,  3 Feb 2012 09:26:57 +0530
Subject: [PATCH 1/1] arm/vfp: vfp_pm_suspend: Use local variable instead of
 rereading from register
In-Reply-To: <y>
References: <y>
Message-ID: <1328241417-27043-1-git-send-email-consul.kautuk@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The fpexc variable already stores the value in the FPEXC register.

Use this instead of reading the value again from the register.

Signed-off-by: Kautuk Consul <consul.kautuk@gmail.com>
---
 arch/arm/vfp/vfpmodule.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/arch/arm/vfp/vfpmodule.c b/arch/arm/vfp/vfpmodule.c
index 8f3ccdd..71cd21a 100644
--- a/arch/arm/vfp/vfpmodule.c
+++ b/arch/arm/vfp/vfpmodule.c
@@ -448,7 +448,7 @@ static int vfp_pm_suspend(void)
 		vfp_save_state(&ti->vfpstate, fpexc);
 
 		/* disable, just in case */
-		fmxr(FPEXC, fmrx(FPEXC) & ~FPEXC_EN);
+		fmxr(FPEXC, fpexc & ~FPEXC_EN);
 	}
 
 	/* clear any information we had about last context state */
-- 
1.7.6
