From: sergei.shtylyov@cogentembedded.com (Sergei Shtylyov)
Date: Mon, 19 Jan 2015 01:44:12 +0300
Subject: [PATCH 12/23] ohci-s3c2410: use HUB_CHAR_*
In-Reply-To: <4018572.5hhhepRR0W@wasted.cogentembedded.com>
References: <4018572.5hhhepRR0W@wasted.cogentembedded.com>
Message-ID: <2189806.lsQmK0PScD@wasted.cogentembedded.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Fix  using the  bare numbers to set the 'wHubCharacteristics' field of the Hub
Descriptor while the values are #define'd in <linux/usb/ch11.h>.

While at it, stop setting already set HUB_CHAR_INDV_PORT_LPSM once again.

Signed-off-by: Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>

---
 drivers/usb/host/ohci-s3c2410.c |    6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

Index: usb/drivers/usb/host/ohci-s3c2410.c
===================================================================
--- usb.orig/drivers/usb/host/ohci-s3c2410.c
+++ usb/drivers/usb/host/ohci-s3c2410.c
@@ -249,14 +249,14 @@ static int ohci_s3c2410_hub_control(
 		 */
 
 		desc->wHubCharacteristics &= ~cpu_to_le16(HUB_CHAR_LPSM);
-		desc->wHubCharacteristics |= cpu_to_le16(0x0001);
+		desc->wHubCharacteristics |= cpu_to_le16(
+			HUB_CHAR_INDV_PORT_LPSM);
 
 		if (info->enable_oc) {
 			desc->wHubCharacteristics &= ~cpu_to_le16(
 				HUB_CHAR_OCPM);
 			desc->wHubCharacteristics |=  cpu_to_le16(
-				0x0008 |
-				0x0001);
+				HUB_CHAR_INDV_PORT_OCPM);
 		}
 
 		dev_dbg(hcd->self.controller, "wHubCharacteristics after 0x%04x\n",
