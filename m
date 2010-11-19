From: AMartin@nvidia.com (Allen Martin)
Date: Fri, 19 Nov 2010 14:15:34 -0800
Subject: [PATCH] usb: host: tegra: protect bus suspend with CONFIG_PM
Message-ID: <3C7A7ACA8617D24290826EC008B5CD0817D747F9E5@HQMAIL03.nvidia.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Protect the bus suspend/resume functions behind #ifdef CONFIG_PM.
This prevents a compile error if CONFIG_PM is turned off.

Signed-off-by: Allen Martin <amartin@nvidia.com>
---
 drivers/usb/host/ehci-tegra.c |    2 ++
 1 files changed, 2 insertions(+), 0 deletions(-)

diff --git a/drivers/usb/host/ehci-tegra.c b/drivers/usb/host/ehci-tegra.c
index e566a97..02087c8 100644
--- a/drivers/usb/host/ehci-tegra.c
+++ b/drivers/usb/host/ehci-tegra.c
@@ -334,6 +334,7 @@ static int tegra_ehci_setup(struct usb_hcd *hcd)
        return retval;
 }

+#ifdef CONFIG_PM
 static int tegra_ehci_bus_suspend(struct usb_hcd *hcd)
 {
        struct tegra_ehci_hcd *tegra = dev_get_drvdata(hcd->self.controller);
@@ -359,6 +360,7 @@ static int tegra_ehci_bus_resume(struct usb_hcd *hcd)

        return ehci_bus_resume(hcd);
 }
+#endif

 static const struct hc_driver tegra_ehci_hc_driver = {
        .description            = hcd_name,
--
1.7.2.3
