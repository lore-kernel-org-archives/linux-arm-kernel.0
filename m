From: awallis@codeaurora.org (Adam Wallis)
Date: Tue, 21 Nov 2017 12:18:10 -0500
Subject: [PATCH 2/2] usb: host: xhci-plat: check relaxed timing quirk bit
In-Reply-To: <1511284690-3878-1-git-send-email-awallis@codeaurora.org>
References: <1511284690-3878-1-git-send-email-awallis@codeaurora.org>
Message-ID: <1511284690-3878-3-git-send-email-awallis@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Check sysdev to see if the relaxed timing quirk ("quirk-relaxed-timing")
is set.

Signed-off-by: Adam Wallis <awallis@codeaurora.org>
---
 drivers/usb/host/xhci-plat.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/usb/host/xhci-plat.c b/drivers/usb/host/xhci-plat.c
index 09f164f..ea221f3 100644
--- a/drivers/usb/host/xhci-plat.c
+++ b/drivers/usb/host/xhci-plat.c
@@ -266,6 +266,9 @@ static int xhci_plat_probe(struct platform_device *pdev)
 	if (device_property_read_bool(sysdev, "usb3-lpm-capable"))
 		xhci->quirks |= XHCI_LPM_SUPPORT;
 
+	if (device_property_read_bool(sysdev, "quirk-relaxed-timing"))
+		xhci->quirks |= XHCI_RELAXED_TIMING_QUIRK;
+
 	if (device_property_read_bool(&pdev->dev, "quirk-broken-port-ped"))
 		xhci->quirks |= XHCI_BROKEN_PORT_PED;
 
-- 
Qualcomm Datacenter Technologies as an affiliate of Qualcomm Technologies, Inc.
Qualcomm Technologies, Inc. is a member of the
Code Aurora Forum, a Linux Foundation Collaborative Project.
