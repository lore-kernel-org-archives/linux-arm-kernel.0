From: lee.jones@linaro.org (Lee Jones)
Date: Thu, 28 Aug 2014 14:14:13 +0100
Subject: [PATCH 07/11] mfd: wm5102: Insert missing break in case statement
In-Reply-To: <1409231657-18294-1-git-send-email-lee.jones@linaro.org>
References: <1409231657-18294-1-git-send-email-lee.jones@linaro.org>
Message-ID: <1409231657-18294-7-git-send-email-lee.jones@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Chip identifier wm5102_reva_patch is always overwritten with
wm5102_revb_patch, even when the code is run on a Rev-A chip.  Place
in the missing break to force the code into doing something sensible
instead.

Signed-off-by: Lee Jones <lee.jones@linaro.org>
---
 drivers/mfd/wm5102-tables.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/mfd/wm5102-tables.c b/drivers/mfd/wm5102-tables.c
index fb4d4bb..a219888 100644
--- a/drivers/mfd/wm5102-tables.c
+++ b/drivers/mfd/wm5102-tables.c
@@ -87,6 +87,7 @@ int wm5102_patch(struct arizona *arizona)
 	case 0:
 		wm5102_patch = wm5102_reva_patch;
 		patch_size = ARRAY_SIZE(wm5102_reva_patch);
+		break;
 	default:
 		wm5102_patch = wm5102_revb_patch;
 		patch_size = ARRAY_SIZE(wm5102_revb_patch);
-- 
1.9.1
