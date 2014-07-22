From: lee.jones@linaro.org (Lee Jones)
Date: Tue, 22 Jul 2014 12:11:23 +0100
Subject: [PATCH 17/19] mfd: ipaq-micro: Fix coding style errors/warnings
 reported by checkpatch
In-Reply-To: <1406027485-15657-1-git-send-email-lee.jones@linaro.org>
References: <1406027485-15657-1-git-send-email-lee.jones@linaro.org>
Message-ID: <1406027485-15657-18-git-send-email-lee.jones@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This is part of an effort to clean-up the MFD subsystem.

ERROR: space required before the open parenthesis '('
+                       if(!micro->msg)

WARNING: unnecessary whitespace before a quoted newline
+                       dev_dbg(micro->dev, "key message ignored, no handle \n");

WARNING: unnecessary whitespace before a quoted newline
+                       dev_dbg(micro->dev, "touchscreen message ignored, no handle \n");

WARNING: space prohibited before semicolon
+               rx->id = (ch & 0xf0) >> 4 ;

total: 1 errors, 3 warnings, 482 lines checked

Signed-off-by: Lee Jones <lee.jones@linaro.org>
---
 drivers/mfd/ipaq-micro.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/mfd/ipaq-micro.c b/drivers/mfd/ipaq-micro.c
index 7e50fe0..8df3266 100644
--- a/drivers/mfd/ipaq-micro.c
+++ b/drivers/mfd/ipaq-micro.c
@@ -115,7 +115,7 @@ static void micro_rx_msg(struct ipaq_micro *micro, u8 id, int len, u8 *data)
 		} else {
 			dev_err(micro->dev,
 				"out of band RX message 0x%02x\n", id);
-			if(!micro->msg)
+			if (!micro->msg)
 				dev_info(micro->dev, "no message queued\n");
 			else
 				dev_info(micro->dev, "expected message %02x\n",
@@ -126,13 +126,13 @@ static void micro_rx_msg(struct ipaq_micro *micro, u8 id, int len, u8 *data)
 		if (micro->key)
 			micro->key(micro->key_data, len, data);
 		else
-			dev_dbg(micro->dev, "key message ignored, no handle \n");
+			dev_dbg(micro->dev, "key message ignored, no handle\n");
 		break;
 	case MSG_TOUCHSCREEN:
 		if (micro->ts)
 			micro->ts(micro->ts_data, len, data);
 		else
-			dev_dbg(micro->dev, "touchscreen message ignored, no handle \n");
+			dev_dbg(micro->dev, "touchscreen message ignored, no handle\n");
 		break;
 	default:
 		dev_err(micro->dev,
@@ -154,7 +154,7 @@ static void micro_process_char(struct ipaq_micro *micro, u8 ch)
 			rx->state = STATE_ID; /* Next byte is the id and len */
 		break;
 	case STATE_ID: /* Looking for id and len byte */
-		rx->id = (ch & 0xf0) >> 4 ;
+		rx->id = (ch & 0xf0) >> 4;
 		rx->len = (ch & 0x0f);
 		rx->index = 0;
 		rx->chksum = ch;
-- 
1.8.3.2
