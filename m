From: chunfeng.yun@mediatek.com (Chunfeng Yun)
Date: Tue, 25 Jul 2017 16:10:23 +0800
Subject: [PATCH 2/3] usb: mtu3: clear u1/u2_enable to 0 in mtu3_gadget_reset
In-Reply-To: <1500970224-23791-1-git-send-email-chunfeng.yun@mediatek.com>
References: <1500970224-23791-1-git-send-email-chunfeng.yun@mediatek.com>
Message-ID: <1500970224-23791-2-git-send-email-chunfeng.yun@mediatek.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

when the device is reset by host, the status of u1_enable and
u2_enable should also be restored to default value.

Signed-off-by: Chunfeng Yun <chunfeng.yun@mediatek.com>
---
 drivers/usb/mtu3/mtu3_gadget.c |    2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/usb/mtu3/mtu3_gadget.c b/drivers/usb/mtu3/mtu3_gadget.c
index a4ad67c..434fca5 100644
--- a/drivers/usb/mtu3/mtu3_gadget.c
+++ b/drivers/usb/mtu3/mtu3_gadget.c
@@ -728,5 +728,7 @@ void mtu3_gadget_reset(struct mtu3 *mtu)
 	mtu->address = 0;
 	mtu->ep0_state = MU3D_EP0_STATE_SETUP;
 	mtu->may_wakeup = 0;
+	mtu->u1_enable = 0;
+	mtu->u2_enable = 0;
 	mtu->delayed_status = false;
 }
-- 
1.7.9.5
