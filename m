From: lkp@intel.com (kbuild test robot)
Date: Tue, 3 Apr 2018 20:13:03 +0800
Subject: [RFC PATCH] Bluetooth: hci_mediatek: mtk_recv_frame() can be static
In-Reply-To: <f0e0a0b7f1dc3845dc6eafb4ccd60284d1675f8d.1522736996.git.sean.wang@mediatek.com>
References: <f0e0a0b7f1dc3845dc6eafb4ccd60284d1675f8d.1522736996.git.sean.wang@mediatek.com>
Message-ID: <20180403121303.GA72575@lkp-sb04>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org


Fixes: 9f2aacacb185 ("Bluetooth: hci_mediatek: Add protocol support for MediaTek serial devices")
Signed-off-by: Fengguang Wu <fengguang.wu@intel.com>
---
 hci_mediatek.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/bluetooth/hci_mediatek.c b/drivers/bluetooth/hci_mediatek.c
index 7ac1e7aa..ab02b8b 100644
--- a/drivers/bluetooth/hci_mediatek.c
+++ b/drivers/bluetooth/hci_mediatek.c
@@ -319,7 +319,7 @@ static int mtk_close(struct hci_uart *hu)
 	return 0;
 }
 
-int mtk_recv_frame(struct hci_dev *hdev, struct sk_buff *skb)
+static int mtk_recv_frame(struct hci_dev *hdev, struct sk_buff *skb)
 {
 	struct hci_event_hdr *hdr = (void *)skb->data;
 	struct hci_uart *hu = hci_get_drvdata(hdev);
