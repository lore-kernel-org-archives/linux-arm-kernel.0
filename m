From: davidb@codeaurora.org (David Brown)
Date: Tue, 12 Mar 2013 11:41:52 -0700
Subject: [PATCH v2 07/11] ssbi: Use regular init level
In-Reply-To: <1363113716-25897-1-git-send-email-davidb@codeaurora.org>
References: <1362616187-21089-1-git-send-email-davidb@codeaurora.org>
 <1363113716-25897-1-git-send-email-davidb@codeaurora.org>
Message-ID: <1363113716-25897-8-git-send-email-davidb@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

With device tree, and deferred probe, it is no longer necessary to
make sure that the ssbi bus driver is initialized very early.  Restore
to a regular module_init().

Signed-off-by: David Brown <davidb@codeaurora.org>
---
 drivers/ssbi/ssbi.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/ssbi/ssbi.c b/drivers/ssbi/ssbi.c
index 7ae8925..6878e55 100644
--- a/drivers/ssbi/ssbi.c
+++ b/drivers/ssbi/ssbi.c
@@ -379,7 +379,7 @@ static int __init msm_ssbi_init(void)
 {
 	return platform_driver_register(&msm_ssbi_driver);
 }
-postcore_initcall(msm_ssbi_init);
+module_init(msm_ssbi_init);
 
 static void __exit msm_ssbi_exit(void)
 {
-- 
The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum,
hosted by The Linux Foundation
