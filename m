From: cw00.choi@samsung.com (Chanwoo Choi)
Date: Thu, 03 Aug 2017 17:20:48 +0900
Subject: [PATCH v2 5/5] extcon: Remove deprecated extcon_set/get_cable_state_()
In-Reply-To: <1501748448-26821-1-git-send-email-cw00.choi@samsung.com>
References: <1501748448-26821-1-git-send-email-cw00.choi@samsung.com>
 <CGME20170803082050epcas1p38d70b5df911a855708c891b659a56fce@epcas1p3.samsung.com>
Message-ID: <1501748448-26821-6-git-send-email-cw00.choi@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The commit 575c2b867ee0 ("extcon: Rename the extcon_set/get_state()
to maintain the function naming pattern") renames the extcon function as
following: But, the extcon just keeps the old API to prevent the build error.
This patch removes the deprecatd extcon API.

- extcon_get_cable_state_() -> extcon_get_state()
- extcon_set_cable_state_() -> extcon_set_state_sync()

Signed-off-by: Chanwoo Choi <cw00.choi@samsung.com>
---
 include/linux/extcon.h | 11 -----------
 1 file changed, 11 deletions(-)

diff --git a/include/linux/extcon.h b/include/linux/extcon.h
index 7e206a9f88db..3ba02eecba2e 100644
--- a/include/linux/extcon.h
+++ b/include/linux/extcon.h
@@ -422,15 +422,4 @@ static inline int extcon_unregister_interest(struct extcon_specific_cable_nb
 {
 	return -EINVAL;
 }
-
-static inline int extcon_get_cable_state_(struct extcon_dev *edev, unsigned int id)
-{
-	return extcon_get_state(edev, id);
-}
-
-static inline int extcon_set_cable_state_(struct extcon_dev *edev, unsigned int id,
-				   bool cable_state)
-{
-	return extcon_set_state_sync(edev, id, cable_state);
-}
 #endif /* __LINUX_EXTCON_H__ */
-- 
1.9.1
