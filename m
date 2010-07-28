From: gbean@codeaurora.org (Gregory Bean)
Date: Wed, 28 Jul 2010 10:22:13 -0700
Subject: [PATCH 2/2] video: msm: Fix section mismatch in mddi.c.
In-Reply-To: <1280337733-18707-1-git-send-email-gbean@codeaurora.org>
References: <1280337733-18707-1-git-send-email-gbean@codeaurora.org>
Message-ID: <1280337733-18707-2-git-send-email-gbean@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Repair a section mismatch between the mddi driver's
platform_driver structure and its probe method.

Signed-off-by: Gregory Bean <gbean@codeaurora.org>
---
 drivers/video/msm/mddi.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/drivers/video/msm/mddi.c b/drivers/video/msm/mddi.c
index 844eff3..7c316c3 100644
--- a/drivers/video/msm/mddi.c
+++ b/drivers/video/msm/mddi.c
@@ -668,7 +668,7 @@ static int __init mddi_rev_data_setup(struct mddi_info *mddi)
 	return 0;
 }
 
-static int __init mddi_probe(struct platform_device *pdev)
+static int __devinit mddi_probe(struct platform_device *pdev)
 {
 	struct msm_mddi_platform_data *pdata = pdev->dev.platform_data;
 	struct mddi_info *mddi = &mddi_info[pdev->id];
-- 
1.7.0.4

--
Employee of Qualcomm Innovation Center, Inc.
Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum.
