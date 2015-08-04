From: skarajga@visteon.com (Karajgaonkar, Saurabh (S.))
Date: Tue, 4 Aug 2015 14:05:03 +0000
Subject: [PATCH v2 9/9] usb: misc: ftdi-elan: Simplify return statement
In-Reply-To: <cover.1438695318.git.skarajga@visteon.com>
References: <cover.1438695318.git.skarajga@visteon.com>
Message-ID: <f700d830ae520cbf953f9ba76202eb592af3bb81.1438695318.git.skarajga@visteon.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Saurabh Karajgaonkar <skarajga@visteon.com>

Replace redundant variable use in return statement.

Signed-off-by: Saurabh Karajgaonkar <skarajga@visteon.com>
---
 drivers/usb/misc/ftdi-elan.c | 12 ++----------
 1 file changed, 2 insertions(+), 10 deletions(-)

diff --git a/drivers/usb/misc/ftdi-elan.c b/drivers/usb/misc/ftdi-elan.c
index 8ab1f8f..52c27ca 100644
--- a/drivers/usb/misc/ftdi-elan.c
+++ b/drivers/usb/misc/ftdi-elan.c
@@ -2568,11 +2568,7 @@ static int ftdi_elan_close_controller(struct usb_ftdi *ftdi, int fn)
 					    0x00);
 	if (UxxxStatus)
 		return UxxxStatus;
-	UxxxStatus = ftdi_elan_read_config(ftdi, activePCIfn | reg, 0,
-					   &pcidata);
-	if (UxxxStatus)
-		return UxxxStatus;
-	return 0;
+	return ftdi_elan_read_config(ftdi, activePCIfn | reg, 0, &pcidata);
 }
 
 static int ftdi_elan_found_controller(struct usb_ftdi *ftdi, int fn, int quirk)
@@ -2695,11 +2691,7 @@ static int ftdi_elan_setupOHCI(struct usb_ftdi *ftdi)
 		}
 	}
 	if (ftdi->function > 0) {
-		UxxxStatus = ftdi_elan_setup_controller(ftdi,
-							ftdi->function - 1);
-		if (UxxxStatus)
-			return UxxxStatus;
-		return 0;
+		return ftdi_elan_setup_controller(ftdi,	ftdi->function - 1);
 	} else if (controllers > 0) {
 		return -ENXIO;
 	} else if (unrecognized > 0) {
-- 
1.9.1
