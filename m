From: heiko@sntech.de (Heiko =?iso-8859-1?q?St=FCbner?=)
Date: Mon, 19 Dec 2011 14:25:25 +0100
Subject: [PATCH 3/7] s3c-hsudc: add missing otg_put_transceiver in probe
In-Reply-To: <201112191423.21461.heiko@sntech.de>
References: <201112191423.21461.heiko@sntech.de>
Message-ID: <201112191425.25602.heiko@sntech.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The number of get and put calls should always be equal.

Signed-off-by: Heiko Stuebner <heiko@sntech.de>
---
 drivers/usb/gadget/s3c-hsudc.c |    3 +++
 1 files changed, 3 insertions(+), 0 deletions(-)

diff --git a/drivers/usb/gadget/s3c-hsudc.c b/drivers/usb/gadget/s3c-hsudc.c
index 3e5673d..6c2b2ce 100644
--- a/drivers/usb/gadget/s3c-hsudc.c
+++ b/drivers/usb/gadget/s3c-hsudc.c
@@ -1366,6 +1366,9 @@ err_remap:
 	kfree(hsudc->mem_rsrc);
 
 err_res:
+	if (hsudc->transceiver)
+		otg_put_transceiver(hsudc->transceiver);
+
 	kfree(hsudc);
 	return ret;
 }
-- 
1.7.5.4
