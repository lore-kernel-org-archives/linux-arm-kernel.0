From: tharvey@gateworks.com (Tim Harvey)
Date: Tue, 22 Oct 2013 22:12:18 -0700
Subject: [PATCH] PCI: imx6: increase link startup
Message-ID: <1382505138-23286-1-git-send-email-tharvey@gateworks.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

An increase link startup delay is required when certain PCI switches are
attached to the root complex.  This was tested with a Pericom switch
and a PLX switch.

From: Marek Vasut <marex@denx.de>
Signed-off-by: Marek Vasut <marex@denx.de>
Acked-by: Tim Harvey <tharvey@gateworks.com>
---
 drivers/pci/host/pci-imx6.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/pci/host/pci-imx6.c b/drivers/pci/host/pci-imx6.c
index 90fce05..34c571a 100644
--- a/drivers/pci/host/pci-imx6.c
+++ b/drivers/pci/host/pci-imx6.c
@@ -318,7 +318,7 @@ static void imx6_pcie_host_init(struct pcie_port *pp)
 	while (!dw_pcie_link_up(pp)) {
 		usleep_range(100, 1000);
 		count++;
-		if (count >= 10) {
+		if (count >= 200) {
 			dev_err(pp->dev, "phy link never came up\n");
 			dev_dbg(pp->dev,
 				"DEBUG_R0: 0x%08x, DEBUG_R1: 0x%08x\n",
-- 
1.7.9.5
