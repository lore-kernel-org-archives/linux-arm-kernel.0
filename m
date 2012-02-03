From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Fri, 03 Feb 2012 19:55:55 +0000
Subject: [PATCH 04/20] ARM: sa1111: add .owner initializer to sa1111 driver
 structures
In-Reply-To: <20120203195419.GH14129@n2100.arm.linux.org.uk>
References: <20120203195419.GH14129@n2100.arm.linux.org.uk>
Message-ID: <E1RtPEh-00043m-28@rmk-PC.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Add a .owner initializer to the sa1111 driver structures to allow
allow the modules to be associated with their driver structures.

Signed-off-by: Russell King <rmk+kernel@arm.linux.org.uk>
---
 drivers/input/serio/sa1111ps2.c |    1 +
 drivers/usb/host/ohci-sa1111.c  |    1 +
 2 files changed, 2 insertions(+), 0 deletions(-)

diff --git a/drivers/input/serio/sa1111ps2.c b/drivers/input/serio/sa1111ps2.c
index 44fc8b4..40ec545 100644
--- a/drivers/input/serio/sa1111ps2.c
+++ b/drivers/input/serio/sa1111ps2.c
@@ -330,6 +330,7 @@ static int __devexit ps2_remove(struct sa1111_dev *dev)
 static struct sa1111_driver ps2_driver = {
 	.drv = {
 		.name	= "sa1111-ps2",
+		.owner	= THIS_MODULE,
 	},
 	.devid		= SA1111_DEVID_PS2,
 	.probe		= ps2_probe,
diff --git a/drivers/usb/host/ohci-sa1111.c b/drivers/usb/host/ohci-sa1111.c
index 4bde4f9..7d2aa62 100644
--- a/drivers/usb/host/ohci-sa1111.c
+++ b/drivers/usb/host/ohci-sa1111.c
@@ -262,6 +262,7 @@ static int ohci_hcd_sa1111_drv_remove(struct sa1111_dev *dev)
 static struct sa1111_driver ohci_hcd_sa1111_driver = {
 	.drv = {
 		.name	= "sa1111-ohci",
+		.owner	= THIS_MODULE,
 	},
 	.devid		= SA1111_DEVID_USB,
 	.probe		= ohci_hcd_sa1111_drv_probe,
-- 
1.7.4.4
