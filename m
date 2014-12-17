From: hdegoede@redhat.com (Hans de Goede)
Date: Wed, 17 Dec 2014 15:39:37 +0100
Subject: [PATCH] phy-sun4i-usb: Change disconnect threshold value for sun6i
Message-ID: <1418827177-13182-1-git-send-email-hdegoede@redhat.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The allwinner SDK uses a value of 3 for the disconnect threshold setting on
sun6i, do the same in the kernel.

In my previous experience with sun5i problems getting the threshold right
is important to avoid usb2 devices being unplugged sometimes going unnoticed.

Signed-off-by: Hans de Goede <hdegoede@redhat.com>
---
 drivers/phy/phy-sun4i-usb.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/phy/phy-sun4i-usb.c b/drivers/phy/phy-sun4i-usb.c
index fb02a67..a2b08f3c 100644
--- a/drivers/phy/phy-sun4i-usb.c
+++ b/drivers/phy/phy-sun4i-usb.c
@@ -244,7 +244,8 @@ static int sun4i_usb_phy_probe(struct platform_device *pdev)
 	else
 		data->num_phys = 3;
 
-	if (of_device_is_compatible(np, "allwinner,sun4i-a10-usb-phy"))
+	if (of_device_is_compatible(np, "allwinner,sun4i-a10-usb-phy") ||
+	    of_device_is_compatible(np, "allwinner,sun6i-a31-usb-phy"))
 		data->disc_thresh = 3;
 	else
 		data->disc_thresh = 2;
-- 
2.1.0
