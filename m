From: lkundrak@v3.sk (Lubomir Rintel)
Date: Wed, 22 Aug 2018 22:42:59 +0200
Subject: [PATCH 06/14] ARM: aspenite: add an instance of pxa-usb-phy
In-Reply-To: <20180822204307.13251-1-lkundrak@v3.sk>
References: <20180822204307.13251-1-lkundrak@v3.sk>
Message-ID: <20180822204307.13251-7-lkundrak@v3.sk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This will replace the pxa168_sph_pdata.phy_{de,}init().

Signed-off-by: Lubomir Rintel <lkundrak@v3.sk>
---
 arch/arm/mach-mmp/aspenite.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/arch/arm/mach-mmp/aspenite.c b/arch/arm/mach-mmp/aspenite.c
index 6c2ebf01893a..23f99976b5f5 100644
--- a/arch/arm/mach-mmp/aspenite.c
+++ b/arch/arm/mach-mmp/aspenite.c
@@ -256,6 +256,10 @@ static void __init common_init(void)
 	/* off-chip devices */
 	platform_device_register(&smc91x_device);
 
+#if IS_ENABLED(CONFIG_PHY_PXA_USB)
+	platform_device_register(&pxa168_device_usb_phy);
+#endif
+
 #if IS_ENABLED(CONFIG_USB_EHCI_MV)
 	pxa168_add_usb_host(&pxa168_sph_pdata);
 #endif
-- 
2.17.1
