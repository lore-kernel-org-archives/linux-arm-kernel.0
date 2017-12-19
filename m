From: okaya@codeaurora.org (Sinan Kaya)
Date: Tue, 19 Dec 2017 00:37:57 -0500
Subject: [PATCH V4 21/26] backlight: deprecate pci_get_bus_and_slot()
In-Reply-To: <1513661883-28662-1-git-send-email-okaya@codeaurora.org>
References: <1513661883-28662-1-git-send-email-okaya@codeaurora.org>
Message-ID: <1513661883-28662-22-git-send-email-okaya@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

pci_get_bus_and_slot() is restrictive such that it assumes domain=0 as
where a PCI device is present. This restricts the device drivers to be
reused for other domain numbers.

Getting ready to remove pci_get_bus_and_slot() function in favor of
pci_get_domain_bus_and_slot().

Hard-coding the domain as 0.

Signed-off-by: Sinan Kaya <okaya@codeaurora.org>
Acked-by: Jingoo Han <jingoohan1@gmail.com>
Acked-by: Daniel Thompson <daniel.thompson@linaro.org>
---
 drivers/video/backlight/apple_bl.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/video/backlight/apple_bl.c b/drivers/video/backlight/apple_bl.c
index d843296..6a34ab9 100644
--- a/drivers/video/backlight/apple_bl.c
+++ b/drivers/video/backlight/apple_bl.c
@@ -143,7 +143,7 @@ static int apple_bl_add(struct acpi_device *dev)
 	struct pci_dev *host;
 	int intensity;
 
-	host = pci_get_bus_and_slot(0, 0);
+	host = pci_get_domain_bus_and_slot(0, 0, 0);
 
 	if (!host) {
 		pr_err("unable to find PCI host\n");
-- 
1.9.1
