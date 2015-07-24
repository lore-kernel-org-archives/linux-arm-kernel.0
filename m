From: ulf.hansson@linaro.org (Ulf Hansson)
Date: Fri, 24 Jul 2015 11:24:56 +0200
Subject: [PATCH] amba: Remove unused callbacks for legacy system PM
Message-ID: <1437729896-12183-1-git-send-email-ulf.hansson@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Signed-off-by: Ulf Hansson <ulf.hansson@linaro.org>
---

This patch depends on the following commit cee3d8ccbecb
Input: ambakmi - fix system PM by converting to modern callbacks

That patch was recently queued through Dmitry's tree. I suggest that $subject
patch also goes via Dmitry's tree, with Russell's ack of course.

---
 include/linux/amba/bus.h | 2 --
 1 file changed, 2 deletions(-)

diff --git a/include/linux/amba/bus.h b/include/linux/amba/bus.h
index 50fc668..9006c4e 100644
--- a/include/linux/amba/bus.h
+++ b/include/linux/amba/bus.h
@@ -41,8 +41,6 @@ struct amba_driver {
 	int			(*probe)(struct amba_device *, const struct amba_id *);
 	int			(*remove)(struct amba_device *);
 	void			(*shutdown)(struct amba_device *);
-	int			(*suspend)(struct amba_device *, pm_message_t);
-	int			(*resume)(struct amba_device *);
 	const struct amba_id	*id_table;
 };
 
-- 
1.9.1
