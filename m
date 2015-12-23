From: geliangtang@163.com (Geliang Tang)
Date: Wed, 23 Dec 2015 21:26:52 +0800
Subject: [PATCH 3/4] USB: host: use to_platform_device
In-Reply-To: <41e4a06ba4bb1f35c195c7ea66071953600ca930.1450876612.git.geliangtang@163.com>
References: <41e4a06ba4bb1f35c195c7ea66071953600ca930.1450876612.git.geliangtang@163.com>
Message-ID: <2c8996d8e9f072f4d6db6ba1651d81730232c12e.1450876612.git.geliangtang@163.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Use to_platform_device() instead of open-coding it.

Signed-off-by: Geliang Tang <geliangtang@163.com>
---
 drivers/usb/host/ehci-platform.c | 6 ++----
 drivers/usb/host/ehci-st.c       | 6 ++----
 drivers/usb/host/ohci-platform.c | 6 ++----
 drivers/usb/host/ohci-st.c       | 6 ++----
 4 files changed, 8 insertions(+), 16 deletions(-)

diff --git a/drivers/usb/host/ehci-platform.c b/drivers/usb/host/ehci-platform.c
index bd7082f2..1757ebb 100644
--- a/drivers/usb/host/ehci-platform.c
+++ b/drivers/usb/host/ehci-platform.c
@@ -345,8 +345,7 @@ static int ehci_platform_suspend(struct device *dev)
 {
 	struct usb_hcd *hcd = dev_get_drvdata(dev);
 	struct usb_ehci_pdata *pdata = dev_get_platdata(dev);
-	struct platform_device *pdev =
-		container_of(dev, struct platform_device, dev);
+	struct platform_device *pdev = to_platform_device(dev);
 	bool do_wakeup = device_may_wakeup(dev);
 	int ret;
 
@@ -364,8 +363,7 @@ static int ehci_platform_resume(struct device *dev)
 {
 	struct usb_hcd *hcd = dev_get_drvdata(dev);
 	struct usb_ehci_pdata *pdata = dev_get_platdata(dev);
-	struct platform_device *pdev =
-		container_of(dev, struct platform_device, dev);
+	struct platform_device *pdev = to_platform_device(dev);
 	struct ehci_platform_priv *priv = hcd_to_ehci_priv(hcd);
 
 	if (pdata->power_on) {
diff --git a/drivers/usb/host/ehci-st.c b/drivers/usb/host/ehci-st.c
index b7c5cfa..a94ed67 100644
--- a/drivers/usb/host/ehci-st.c
+++ b/drivers/usb/host/ehci-st.c
@@ -287,8 +287,7 @@ static int st_ehci_suspend(struct device *dev)
 {
 	struct usb_hcd *hcd = dev_get_drvdata(dev);
 	struct usb_ehci_pdata *pdata = dev_get_platdata(dev);
-	struct platform_device *pdev =
-		container_of(dev, struct platform_device, dev);
+	struct platform_device *pdev = to_platform_device(dev);
 	bool do_wakeup = device_may_wakeup(dev);
 	int ret;
 
@@ -308,8 +307,7 @@ static int st_ehci_resume(struct device *dev)
 {
 	struct usb_hcd *hcd = dev_get_drvdata(dev);
 	struct usb_ehci_pdata *pdata = dev_get_platdata(dev);
-	struct platform_device *pdev =
-		container_of(dev, struct platform_device, dev);
+	struct platform_device *pdev = to_platform_device(dev);
 	int err;
 
 	pinctrl_pm_select_default_state(dev);
diff --git a/drivers/usb/host/ohci-platform.c b/drivers/usb/host/ohci-platform.c
index c2669f18..ae1c988 100644
--- a/drivers/usb/host/ohci-platform.c
+++ b/drivers/usb/host/ohci-platform.c
@@ -310,8 +310,7 @@ static int ohci_platform_suspend(struct device *dev)
 {
 	struct usb_hcd *hcd = dev_get_drvdata(dev);
 	struct usb_ohci_pdata *pdata = dev->platform_data;
-	struct platform_device *pdev =
-		container_of(dev, struct platform_device, dev);
+	struct platform_device *pdev = to_platform_device(dev);
 	bool do_wakeup = device_may_wakeup(dev);
 	int ret;
 
@@ -329,8 +328,7 @@ static int ohci_platform_resume(struct device *dev)
 {
 	struct usb_hcd *hcd = dev_get_drvdata(dev);
 	struct usb_ohci_pdata *pdata = dev_get_platdata(dev);
-	struct platform_device *pdev =
-		container_of(dev, struct platform_device, dev);
+	struct platform_device *pdev = to_platform_device(dev);
 
 	if (pdata->power_on) {
 		int err = pdata->power_on(pdev);
diff --git a/drivers/usb/host/ohci-st.c b/drivers/usb/host/ohci-st.c
index df9028e..acf2eb2 100644
--- a/drivers/usb/host/ohci-st.c
+++ b/drivers/usb/host/ohci-st.c
@@ -270,8 +270,7 @@ static int st_ohci_suspend(struct device *dev)
 {
 	struct usb_hcd *hcd = dev_get_drvdata(dev);
 	struct usb_ohci_pdata *pdata = dev->platform_data;
-	struct platform_device *pdev =
-		container_of(dev, struct platform_device, dev);
+	struct platform_device *pdev = to_platform_device(dev);
 	bool do_wakeup = device_may_wakeup(dev);
 	int ret;
 
@@ -289,8 +288,7 @@ static int st_ohci_resume(struct device *dev)
 {
 	struct usb_hcd *hcd = dev_get_drvdata(dev);
 	struct usb_ohci_pdata *pdata = dev_get_platdata(dev);
-	struct platform_device *pdev =
-		container_of(dev, struct platform_device, dev);
+	struct platform_device *pdev = to_platform_device(dev);
 	int err;
 
 	if (pdata->power_on) {
-- 
2.5.0
