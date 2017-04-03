From: labbott@redhat.com (Laura Abbott)
Date: Mon,  3 Apr 2017 11:58:03 -0700
Subject: [PATCHv3 21/22] staging: android: ion: Set query return value
In-Reply-To: <1491245884-15852-1-git-send-email-labbott@redhat.com>
References: <1491245884-15852-1-git-send-email-labbott@redhat.com>
Message-ID: <1491245884-15852-22-git-send-email-labbott@redhat.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This never got set in the ioctl. Properly set a return value of 0 on
success.

Signed-off-by: Laura Abbott <labbott@redhat.com>
---
 drivers/staging/android/ion/ion.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/staging/android/ion/ion.c b/drivers/staging/android/ion/ion.c
index 9eeb06f..d6fd350 100644
--- a/drivers/staging/android/ion/ion.c
+++ b/drivers/staging/android/ion/ion.c
@@ -498,6 +498,7 @@ int ion_query_heaps(struct ion_heap_query *query)
 	}
 
 	query->cnt = cnt;
+	ret = 0;
 out:
 	up_read(&dev->lock);
 	return ret;
-- 
2.7.4
