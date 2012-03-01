From: alan@signal11.us (Alan Ott)
Date: Thu,  1 Mar 2012 14:26:50 -0500
Subject: [PATCH 8/8] ARM: tegra: HACK: remove set_irq_flags() from driver
In-Reply-To: <1330630010-11241-1-git-send-email-alan@signal11.us>
References: <1330630010-11241-1-git-send-email-alan@signal11.us>
Message-ID: <1330630010-11241-9-git-send-email-alan@signal11.us>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Arnd Bergmann <arnd@arndb.de>

The driver should not call set_irq_flags itself, and
cannot do this from a loadable module.

Remove the call for now, which might break the driver
but at least lets the kernel link again.

Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
 drivers/usb/host/ehci-tegra.c |    1 -
 1 files changed, 0 insertions(+), 1 deletions(-)

diff --git a/drivers/usb/host/ehci-tegra.c b/drivers/usb/host/ehci-tegra.c
index dbc7fe8..ab91f26 100644
--- a/drivers/usb/host/ehci-tegra.c
+++ b/drivers/usb/host/ehci-tegra.c
@@ -729,7 +729,6 @@ static int tegra_ehci_probe(struct platform_device *pdev)
 		err = -ENODEV;
 		goto fail;
 	}
-	set_irq_flags(irq, IRQF_VALID);
 
 #ifdef CONFIG_USB_OTG_UTILS
 	if (pdata->operating_mode == TEGRA_USB_OTG) {
-- 
1.7.0.4
