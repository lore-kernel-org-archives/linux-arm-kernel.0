From: Suravee.Suthikulpanit@amd.com (Suravee Suthikulpanit)
Date: Wed, 10 Jun 2015 11:08:57 -0500
Subject: [V6 PATCH 6/7] megaraid_sas: fix TRUE and FALSE re-define build error
In-Reply-To: <1433952538-22455-1-git-send-email-Suravee.Suthikulpanit@amd.com>
References: <1433952538-22455-1-git-send-email-Suravee.Suthikulpanit@amd.com>
Message-ID: <1433952538-22455-7-git-send-email-Suravee.Suthikulpanit@amd.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Signed-off-by: Suravee Suthikulpanit <Suravee.Suthikulpanit@amd.com>
Cc: Kashyap Desai <kashyap.desai@avagotech.com>
Cc: Sumit Saxena <sumit.saxena@avagotech.com>
Cc: Uday Lingala <uday.lingala@avagotech.com>
---
 drivers/scsi/megaraid/megaraid_sas_fp.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/drivers/scsi/megaraid/megaraid_sas_fp.c b/drivers/scsi/megaraid/megaraid_sas_fp.c
index 4f72287..e8b7a69 100644
--- a/drivers/scsi/megaraid/megaraid_sas_fp.c
+++ b/drivers/scsi/megaraid/megaraid_sas_fp.c
@@ -66,7 +66,15 @@ MODULE_PARM_DESC(lb_pending_cmds, "Change raid-1 load balancing outstanding "
 
 #define ABS_DIFF(a, b)   (((a) > (b)) ? ((a) - (b)) : ((b) - (a)))
 #define MR_LD_STATE_OPTIMAL 3
+
+#ifdef FALSE
+#undef FALSE
+#endif
 #define FALSE 0
+
+#ifdef TRUE
+#undef TRUE
+#endif
 #define TRUE 1
 
 #define SPAN_DEBUG 0
-- 
2.1.0
