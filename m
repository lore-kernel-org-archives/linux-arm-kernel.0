From: ezequiel.garcia@imgtec.com (Ezequiel Garcia)
Date: Wed, 25 Feb 2015 08:45:13 -0300
Subject: [PATCH 1/7] soc: tegra: Add missing include linux/types.h
In-Reply-To: <1424864719-3390-1-git-send-email-ezequiel.garcia@imgtec.com>
References: <1424864719-3390-1-git-send-email-ezequiel.garcia@imgtec.com>
Message-ID: <1424864719-3390-2-git-send-email-ezequiel.garcia@imgtec.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The soc/tegra/fuse.h header makes use of kernel-specific types (u32, u8) and
therefore it needs a linux/types.h include.

Cc: Thierry Reding <treding@nvidia.com>
Cc: Stephen Warren <swarren@wwwdotorg.org>
Cc: Alexandre Courbot <gnurou@gmail.com>
Signed-off-by: Ezequiel Garcia <ezequiel.garcia@imgtec.com>
---
 include/soc/tegra/fuse.h | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/include/soc/tegra/fuse.h b/include/soc/tegra/fuse.h
index b5f7b5f..8459008 100644
--- a/include/soc/tegra/fuse.h
+++ b/include/soc/tegra/fuse.h
@@ -28,6 +28,8 @@
 
 #ifndef __ASSEMBLY__
 
+#include <linux/types.h>
+
 u32 tegra_read_chipid(void);
 u8 tegra_get_chip_id(void);
 
-- 
2.3.0
