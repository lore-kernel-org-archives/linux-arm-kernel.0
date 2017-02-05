From: shorne@gmail.com (Stafford Horne)
Date: Sun,  5 Feb 2017 16:07:33 +0900
Subject: [PATCH 2/2] staging: vchip_shim: Remove unneeded stddef.h include
In-Reply-To: <cover.1486276931.git.shorne@gmail.com>
References: <cover.1486276931.git.shorne@gmail.com>
Message-ID: <4d0f17e3fc7b9435b0f8fa9fd562b6774596252d.1486276931.git.shorne@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Building on openrisc musl toolchain this causes the allyesconfig build
to fail.

  drivers/staging/vc04_services/interface/vchiq_arm/vchiq_shim.c:42:20:
  fatal error: stddef.h: No such file or directory

Removing this causes no issues with the build.

Signed-off-by: Stafford Horne <shorne@gmail.com>
---
 drivers/staging/vc04_services/interface/vchiq_arm/vchiq_shim.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/drivers/staging/vc04_services/interface/vchiq_arm/vchiq_shim.c b/drivers/staging/vc04_services/interface/vchiq_arm/vchiq_shim.c
index d977139..70c530c 100644
--- a/drivers/staging/vc04_services/interface/vchiq_arm/vchiq_shim.c
+++ b/drivers/staging/vc04_services/interface/vchiq_arm/vchiq_shim.c
@@ -39,8 +39,6 @@
 
 #include "vchiq_util.h"
 
-#include <stddef.h>
-
 #define vchiq_status_to_vchi(status) ((int32_t)status)
 
 typedef struct {
-- 
2.9.3
