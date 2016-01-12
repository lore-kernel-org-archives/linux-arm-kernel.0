From: lee.jones@linaro.org (Lee Jones)
Date: Tue, 12 Jan 2016 12:46:15 +0000
Subject: [PATCH v5 1/7] remoteproc: debugfs: Check of invalid 'count' value
In-Reply-To: <1452602781-22424-1-git-send-email-lee.jones@linaro.org>
References: <1452602781-22424-1-git-send-email-lee.jones@linaro.org>
Message-ID: <1452602781-22424-2-git-send-email-lee.jones@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

If 'count' value is invalid, return early with an error.

Signed-off-by: Lee Jones <lee.jones@linaro.org>
---
 drivers/remoteproc/remoteproc_debugfs.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/remoteproc/remoteproc_debugfs.c b/drivers/remoteproc/remoteproc_debugfs.c
index 9d30809..f63464c 100644
--- a/drivers/remoteproc/remoteproc_debugfs.c
+++ b/drivers/remoteproc/remoteproc_debugfs.c
@@ -156,8 +156,8 @@ rproc_recovery_write(struct file *filp, const char __user *user_buf,
 	char buf[10];
 	int ret;
 
-	if (count > sizeof(buf))
-		return count;
+	if (count > sizeof(buf) || count <= 0)
+		return -EINVAL;
 
 	ret = copy_from_user(buf, user_buf, count);
 	if (ret)
-- 
1.9.1
