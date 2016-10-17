From: yamada.masahiro@socionext.com (Masahiro Yamada)
Date: Mon, 17 Oct 2016 20:11:59 +0900
Subject: [PATCH] usb: ehci-platform: increase EHCI_MAX_RSTS to 4
Message-ID: <1476702719-10337-1-git-send-email-yamada.masahiro@socionext.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Socionext LD11 SoC (arch/arm64/boot/dts/socionext/uniphier-ld11.dtsi)
needs to handle 4 reset lines for EHCI.

Signed-off-by: Masahiro Yamada <yamada.masahiro@socionext.com>
---

 drivers/usb/host/ehci-platform.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/usb/host/ehci-platform.c b/drivers/usb/host/ehci-platform.c
index 876dca4..a268d9e 100644
--- a/drivers/usb/host/ehci-platform.c
+++ b/drivers/usb/host/ehci-platform.c
@@ -39,7 +39,7 @@
 
 #define DRIVER_DESC "EHCI generic platform driver"
 #define EHCI_MAX_CLKS 4
-#define EHCI_MAX_RSTS 3
+#define EHCI_MAX_RSTS 4
 #define hcd_to_ehci_priv(h) ((struct ehci_platform_priv *)hcd_to_ehci(h)->priv)
 
 struct ehci_platform_priv {
-- 
1.9.1
