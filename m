From: LW@KARO-electronics.de (=?UTF-8?q?Lothar=20Wa=C3=9Fmann?=)
Date: Fri, 18 Jul 2014 11:31:24 +0200
Subject: [PATCH 3/9] usb: musb_am335x: source cleanup
In-Reply-To: <1405675890-8802-3-git-send-email-LW@KARO-electronics.de>
References: <1405675890-8802-1-git-send-email-LW@KARO-electronics.de>
 <1405675890-8802-2-git-send-email-LW@KARO-electronics.de>
 <1405675890-8802-3-git-send-email-LW@KARO-electronics.de>
Message-ID: <1405675890-8802-4-git-send-email-LW@KARO-electronics.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

- remove comma after end of list delimiter
  The empty entry must always be the last item in the list, thus there
  is no point in having a trailing comma to facilitate adding
  succeding entries.
  Remove the comma, so that inadvertedly adding an entry after the end
  of list sentinel will produce a compile time error rather than an
  unreachable entry in the list.
- consistently use tabs for indentation

Signed-off-by: Lothar Wa?mann <LW@KARO-electronics.de>
---
 drivers/usb/musb/musb_am335x.c |    6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/usb/musb/musb_am335x.c b/drivers/usb/musb/musb_am335x.c
index 1e58ed2..164c868 100644
--- a/drivers/usb/musb/musb_am335x.c
+++ b/drivers/usb/musb/musb_am335x.c
@@ -21,14 +21,14 @@ err:
 
 static const struct of_device_id am335x_child_of_match[] = {
 	{ .compatible = "ti,am33xx-usb" },
-	{  },
+	{  }
 };
 MODULE_DEVICE_TABLE(of, am335x_child_of_match);
 
 static struct platform_driver am335x_child_driver = {
 	.probe		= am335x_child_probe,
-	.driver         = {
-		.name   = "am335x-usb-childs",
+	.driver		= {
+		.name	= "am335x-usb-childs",
 		.of_match_table	= am335x_child_of_match,
 	},
 };
-- 
1.7.10.4
