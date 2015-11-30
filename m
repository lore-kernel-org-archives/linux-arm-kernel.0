From: josh.wu@atmel.com (Josh Wu)
Date: Mon, 30 Nov 2015 17:20:15 +0800
Subject: [PATCH] media: atmel-isi: fix debug message which only show the first
 format
Message-ID: <1448875215-19097-1-git-send-email-josh.wu@atmel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Correct the debug output message to show correct format.

Signed-off-by: Josh Wu <josh.wu@atmel.com>
---

 drivers/media/platform/soc_camera/atmel-isi.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/media/platform/soc_camera/atmel-isi.c b/drivers/media/platform/soc_camera/atmel-isi.c
index f51e41e..d5a5119 100644
--- a/drivers/media/platform/soc_camera/atmel-isi.c
+++ b/drivers/media/platform/soc_camera/atmel-isi.c
@@ -795,7 +795,7 @@ static int isi_camera_get_formats(struct soc_camera_device *icd,
 			xlate->host_fmt	= &isi_camera_formats[i];
 			xlate->code	= code.code;
 			dev_dbg(icd->parent, "Providing format %s using code %d\n",
-				isi_camera_formats[0].name, code.code);
+				xlate->host_fmt->name, xlate->code);
 		}
 		break;
 	default:
-- 
1.9.1
