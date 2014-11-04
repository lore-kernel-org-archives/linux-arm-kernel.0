From: horms+renesas@verge.net.au (Simon Horman)
Date: Tue,  4 Nov 2014 10:49:49 +0900
Subject: [PATCH 01/11] ARM: shmobile: r8a7740: Add missing A3SP pm domain
 devices
In-Reply-To: <cover.1415058794.git.horms+renesas@verge.net.au>
References: <cover.1415058794.git.horms+renesas@verge.net.au>
Message-ID: <80f643b39346768878317eb04bd4b1deb4551537.1415058794.git.horms+renesas@verge.net.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Geert Uytterhoeven <geert+renesas@glider.be>

Commit 802a5639aa7041b2 ("ARM: shmobile: r8a7740: add A3SP pm domain
support") added the A3SP power domain, but forgot to hook up the IPPMU,
DMAC0/1/2, and USBDMAC hardware blocks.

Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
Signed-off-by: Simon Horman <horms+renesas@verge.net.au>
---
 arch/arm/mach-shmobile/setup-r8a7740.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/arch/arm/mach-shmobile/setup-r8a7740.c b/arch/arm/mach-shmobile/setup-r8a7740.c
index 8894e1b..6992d40 100644
--- a/arch/arm/mach-shmobile/setup-r8a7740.c
+++ b/arch/arm/mach-shmobile/setup-r8a7740.c
@@ -756,6 +756,11 @@ void __init r8a7740_add_standard_devices(void)
 		{ "A3SP", &scif7_device },
 		{ "A3SP", &scif8_device },
 		{ "A3SP", &i2c1_device },
+		{ "A3SP", &ipmmu_device },
+		{ "A3SP", &dma0_device },
+		{ "A3SP", &dma1_device },
+		{ "A3SP", &dma2_device },
+		{ "A3SP", &usb_dma_device },
 	};
 
 	/* I2C work-around */
-- 
2.1.1
