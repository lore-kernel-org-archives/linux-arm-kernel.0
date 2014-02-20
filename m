From: t.figa@samsung.com (Tomasz Figa)
Date: Thu, 20 Feb 2014 19:06:47 +0100
Subject: [PATCH RFC 1/5] dtc: Add helpers for various message levels
In-Reply-To: <1392919611-10746-1-git-send-email-t.figa@samsung.com>
References: <1392919611-10746-1-git-send-email-t.figa@samsung.com>
Message-ID: <1392919611-10746-2-git-send-email-t.figa@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patch adds three helper macros to print errors, warnings and
informational messages using standard format.

Signed-off-by: Tomasz Figa <t.figa@samsung.com>
---
 dtc.h | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/dtc.h b/dtc.h
index 20de073..e95bed7 100644
--- a/dtc.h
+++ b/dtc.h
@@ -43,6 +43,9 @@
 #define debug(fmt,args...)
 #endif
 
+#define pr_err(...)	fprintf (stderr, "ERROR: " __VA_ARGS__)
+#define pr_warn(...)	fprintf (stderr, "WARNING: " __VA_ARGS__)
+#define pr_info(...)	fprintf (stderr, "INFO: " __VA_ARGS__)
 
 #define DEFAULT_FDT_VERSION	17
 
-- 
1.8.5.2
