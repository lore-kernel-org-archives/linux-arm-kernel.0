From: gbean@codeaurora.org (Gregory Bean)
Date: Wed, 28 Jul 2010 10:22:12 -0700
Subject: [PATCH 1/2] arm: msm: Fix section mismatch in smd.c.
Message-ID: <1280337733-18707-1-git-send-email-gbean@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Repair a section mismatch between the smd driver's
platform_driver structure and its probe method.

Signed-off-by: Gregory Bean <gbean@codeaurora.org>
---
 arch/arm/mach-msm/smd.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/arch/arm/mach-msm/smd.c b/arch/arm/mach-msm/smd.c
index cf11d41..f07dc7c 100644
--- a/arch/arm/mach-msm/smd.c
+++ b/arch/arm/mach-msm/smd.c
@@ -997,7 +997,7 @@ int smd_core_init(void)
 	return 0;
 }
 
-static int __init msm_smd_probe(struct platform_device *pdev)
+static int __devinit msm_smd_probe(struct platform_device *pdev)
 {
 	pr_info("smd_init()\n");
 
-- 
1.7.0.4

--
Employee of Qualcomm Innovation Center, Inc.
Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum.
