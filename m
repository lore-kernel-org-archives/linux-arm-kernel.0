From: Suravee.Suthikulpanit@amd.com (Suravee Suthikulpanit)
Date: Wed, 10 Jun 2015 11:08:58 -0500
Subject: [V6 PATCH 7/7] ufs: fix TRUE and FALSE re-define build error
In-Reply-To: <1433952538-22455-1-git-send-email-Suravee.Suthikulpanit@amd.com>
References: <1433952538-22455-1-git-send-email-Suravee.Suthikulpanit@amd.com>
Message-ID: <1433952538-22455-8-git-send-email-Suravee.Suthikulpanit@amd.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Signed-off-by: Suravee Suthikulpanit <Suravee.Suthikulpanit@amd.com>
Cc: Vinayak Holikatti <vinholikatti@gmail.com>
---
 drivers/scsi/ufs/unipro.h | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/drivers/scsi/ufs/unipro.h b/drivers/scsi/ufs/unipro.h
index 3fc3e21..816a8a4 100644
--- a/drivers/scsi/ufs/unipro.h
+++ b/drivers/scsi/ufs/unipro.h
@@ -198,6 +198,14 @@ enum ufs_hs_gear_tag {
 #define T_TC0TXMAXSDUSIZE	0x4060
 #define T_TC1TXMAXSDUSIZE	0x4061
 
+#ifdef FALSE
+#undef FALSE
+#endif
+
+#ifdef TRUE
+#undef TRUE
+#endif
+
 /* Boolean attribute values */
 enum {
 	FALSE = 0,
-- 
2.1.0
