From: lee.jones@linaro.org (Lee Jones)
Date: Mon,  6 Jun 2016 16:56:53 +0100
Subject: [PATCH 5/7] reset: TRIVIAL: Add line break at same place for similar
 APIs
In-Reply-To: <20160606155655.10860-1-lee.jones@linaro.org>
References: <20160606155655.10860-1-lee.jones@linaro.org>
Message-ID: <20160606155655.10860-6-lee.jones@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Standardise the way inline functions:

  devm_reset_control_get_shared_by_index
  devm_reset_control_get_exclusive_by_index

... are formatted.

Signed-off-by: Lee Jones <lee.jones@linaro.org>
---
 include/linux/reset.h | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/include/linux/reset.h b/include/linux/reset.h
index c358106..45a4abe 100644
--- a/include/linux/reset.h
+++ b/include/linux/reset.h
@@ -310,8 +310,8 @@ devm_reset_control_get_exclusive_by_index(struct device *dev, int index)
  * this function, reset_control_put() is called automatically on driver detach.
  * See reset_control_get_shared() for more information.
  */
-static inline struct reset_control *devm_reset_control_get_shared_by_index(
-					struct device *dev, int index)
+static inline struct reset_control *
+devm_reset_control_get_shared_by_index(struct device *dev, int index)
 {
 	return __devm_reset_control_get(dev, NULL, index, 1);
 }
-- 
2.8.3
