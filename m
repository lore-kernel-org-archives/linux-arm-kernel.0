From: chunfeng.yun@mediatek.com (Chunfeng Yun)
Date: Wed, 23 May 2018 16:53:17 +0800
Subject: [next, PATCH 3/6] usb: mtu3: clear test_mode flag when reset
In-Reply-To: <1291b13a362eaa0cccd30cb8dd4f56d33e1d172d.1527065109.git.chunfeng.yun@mediatek.com>
References: <1291b13a362eaa0cccd30cb8dd4f56d33e1d172d.1527065109.git.chunfeng.yun@mediatek.com>
Message-ID: <613f22070f3f5be49a4405e53032da485ef35e8c.1527065109.git.chunfeng.yun@mediatek.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Clear test_mode flag when the gadget is reset by host, otherwise
will affect the next test item.

Signed-off-by: Chunfeng Yun <chunfeng.yun@mediatek.com>
---
 drivers/usb/mtu3/mtu3_gadget.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/usb/mtu3/mtu3_gadget.c b/drivers/usb/mtu3/mtu3_gadget.c
index de0de01..5c60a8c 100644
--- a/drivers/usb/mtu3/mtu3_gadget.c
+++ b/drivers/usb/mtu3/mtu3_gadget.c
@@ -719,4 +719,5 @@ void mtu3_gadget_reset(struct mtu3 *mtu)
 	mtu->u1_enable = 0;
 	mtu->u2_enable = 0;
 	mtu->delayed_status = false;
+	mtu->test_mode = false;
 }
-- 
1.9.1
