From: shuahkh@osg.samsung.com (Shuah Khan)
Date: Fri, 24 Mar 2017 18:05:05 -0600
Subject: [PATCH 7/7] usb: dwc3: host: change goto labels in this file to
 meaningful names
In-Reply-To: <cover.1490387086.git.shuahkh@osg.samsung.com>
References: <cover.1490387086.git.shuahkh@osg.samsung.com>
Message-ID: <4e0781e13ff14f44c3b57bc4262538a2e780a6db.1490387086.git.shuahkh@osg.samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Change goto labels in this file to meaningful names.

Signed-off-by: Shuah Khan <shuahkh@osg.samsung.com>
---
 drivers/usb/dwc3/host.c | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/drivers/usb/dwc3/host.c b/drivers/usb/dwc3/host.c
index 76f0b0d..eb264a9 100644
--- a/drivers/usb/dwc3/host.c
+++ b/drivers/usb/dwc3/host.c
@@ -93,7 +93,7 @@ int dwc3_host_init(struct dwc3 *dwc)
 						DWC3_XHCI_RESOURCES_NUM);
 	if (ret) {
 		dev_err(dwc->dev, "couldn't add resources to xHCI device\n");
-		goto err1;
+		goto put_device;
 	}
 
 	memset(props, 0, sizeof(struct property_entry) * ARRAY_SIZE(props));
@@ -117,7 +117,7 @@ int dwc3_host_init(struct dwc3 *dwc)
 		ret = platform_device_add_properties(xhci, props);
 		if (ret) {
 			dev_err(dwc->dev, "failed to add properties to xHCI\n");
-			goto err1;
+			goto put_device;
 		}
 	}
 
@@ -129,16 +129,16 @@ int dwc3_host_init(struct dwc3 *dwc)
 	ret = platform_device_add(xhci);
 	if (ret) {
 		dev_err(dwc->dev, "failed to register xHCI device\n");
-		goto err2;
+		goto remove_lookup;
 	}
 
 	return 0;
-err2:
+remove_lookup:
 	phy_remove_lookup(dwc->usb2_generic_phy, "usb2-phy",
 			  dev_name(dwc->dev));
 	phy_remove_lookup(dwc->usb3_generic_phy, "usb3-phy",
 			  dev_name(dwc->dev));
-err1:
+put_device:
 	platform_device_put(xhci);
 	return ret;
 }
-- 
2.7.4
