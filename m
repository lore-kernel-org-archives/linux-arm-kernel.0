From: rogerq@ti.com (Roger Quadros)
Date: Thu, 10 Jan 2013 18:51:26 +0200
Subject: [PATCH 06/14] mfd: omap-usb-host: update nports in platform_data
In-Reply-To: <1357836694-30788-1-git-send-email-rogerq@ti.com>
References: <1357836694-30788-1-git-send-email-rogerq@ti.com>
Message-ID: <1357836694-30788-7-git-send-email-rogerq@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

EHCI driver would need to know the number of ports available
on the platform. We set the nports parameter of platform_data
based on IP version if it was not already provided.

Signed-off-by: Roger Quadros <rogerq@ti.com>
---
 drivers/mfd/omap-usb-host.c |    1 +
 1 files changed, 1 insertions(+), 0 deletions(-)

diff --git a/drivers/mfd/omap-usb-host.c b/drivers/mfd/omap-usb-host.c
index 7180b00..5c1c3ae 100644
--- a/drivers/mfd/omap-usb-host.c
+++ b/drivers/mfd/omap-usb-host.c
@@ -564,6 +564,7 @@ static int usbhs_omap_probe(struct platform_device *pdev)
 			 omap->usbhs_rev, omap->nports);
 			break;
 		}
+		pdata->nports = omap->nports;
 	}
 
 	i = sizeof(struct clk *) * omap->nports;
-- 
1.7.4.1
