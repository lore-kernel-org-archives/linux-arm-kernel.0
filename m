From: chunfeng.yun@mediatek.com (Chunfeng Yun)
Date: Wed, 7 Dec 2016 15:24:13 +0800
Subject: [PATCH] usb: mtu3: enable auto switch from U3 to U2
Message-ID: <1481095453-23497-1-git-send-email-chunfeng.yun@mediatek.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

inform mac2 to build U2 link automatically after U3 detect
fail without software setting soft_connect.

Signed-off-by: Chunfeng Yun <chunfeng.yun@mediatek.com>
---
 drivers/usb/mtu3/mtu3_core.c |    2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/usb/mtu3/mtu3_core.c b/drivers/usb/mtu3/mtu3_core.c
index af3e531..ca05021 100644
--- a/drivers/usb/mtu3/mtu3_core.c
+++ b/drivers/usb/mtu3/mtu3_core.c
@@ -568,6 +568,8 @@ static void mtu3_regs_init(struct mtu3 *mtu)
 				SW_U1_REQUEST_ENABLE | SW_U2_REQUEST_ENABLE);
 		/* device responses to u3_exit from host automatically */
 		mtu3_clrbits(mbase, U3D_LTSSM_CTRL, SOFT_U3_EXIT_EN);
+		/* automatically build U2 link when U3 detect fail */
+		mtu3_setbits(mbase, U3D_USB2_TEST_MODE, U2U3_AUTO_SWITCH);
 	}
 
 	mtu3_set_speed(mtu);
-- 
1.7.9.5
