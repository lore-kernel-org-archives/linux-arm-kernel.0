From: arnd@arndb.de (Arnd Bergmann)
Date: Mon, 28 May 2018 17:48:39 +0200
Subject: [PATCH] PCI: versatile: include pci.h
Message-ID: <20180528154850.2647019-1-arnd@arndb.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Two patches for PCI host drivers clashed recently, leading to a broken
build for versatile-pci:

drivers/pci/host/pci-versatile.c: In function 'versatile_pci_parse_request_of_pci_ranges':
drivers/pci/host/pci-versatile.c:70:8: error: implicit declaration of function 'devm_of_pci_get_host_bridge_resources'; did you mean 'pci_get_host_bridge_device'? [-Werror=implicit-function-declaration]

This adds the missing header inclusion that became necessary now.

Fixes: 9e2aee80c78d ("PCI: Move private DT related functions into private header")
Fixes: 64720fd1f630 ("PCI: Rework of_pci_get_host_bridge_resources() to devm_of_pci_get_host_bridge_resources()")
Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
 drivers/pci/host/pci-versatile.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/pci/host/pci-versatile.c b/drivers/pci/host/pci-versatile.c
index ff2cd12b3978..994f32061b32 100644
--- a/drivers/pci/host/pci-versatile.c
+++ b/drivers/pci/host/pci-versatile.c
@@ -15,6 +15,8 @@
 #include <linux/pci.h>
 #include <linux/platform_device.h>
 
+#include "../pci.h"
+
 static void __iomem *versatile_pci_base;
 static void __iomem *versatile_cfg_base[2];
 
-- 
2.9.0
