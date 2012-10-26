From: paul@pwsan.com (Paul Walmsley)
Date: Fri, 26 Oct 2012 21:28:58 +0000 (UTC)
Subject: [PATCH v2] ARM: OMAP1: usb: fix sparse warnings
In-Reply-To: <20121026212059.GV11908@atomide.com>
References: <alpine.DEB.2.00.1210262051290.11258@utopia.booyaka.com>
 <20121026212059.GV11908@atomide.com>
Message-ID: <alpine.DEB.2.00.1210262128050.11258@utopia.booyaka.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org


Resolve the following sparse warnings:

arch/arm/mach-omap1/usb.c:304:12: warning: symbol 'omap1_usb0_init' was not declared. Should it be static?
arch/arm/mach-omap1/usb.c:412:12: warning: symbol 'omap1_usb1_init' was not declared. Should it be static?
arch/arm/mach-omap1/usb.c:478:12: warning: symbol 'omap1_usb2_init' was not declared. Should it be static?

by declaring those functions as static.

Signed-off-by: Paul Walmsley <paul@pwsan.com>
Cc: Tony Lindgren <tony@atomide.com>
Cc: Felipe Balbi <balbi@ti.com>
---

Applies on linux-omap/omap-for-v3.8/cleanup-headers.

 arch/arm/mach-omap1/usb.c |    6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/arch/arm/mach-omap1/usb.c b/arch/arm/mach-omap1/usb.c
index 84267ed..104fed3 100644
--- a/arch/arm/mach-omap1/usb.c
+++ b/arch/arm/mach-omap1/usb.c
@@ -301,7 +301,7 @@ static inline void otg_device_init(struct omap_usb_config *pdata)
 
 #endif
 
-u32 __init omap1_usb0_init(unsigned nwires, unsigned is_device)
+static u32 __init omap1_usb0_init(unsigned nwires, unsigned is_device)
 {
 	u32	syscon1 = 0;
 
@@ -409,7 +409,7 @@ u32 __init omap1_usb0_init(unsigned nwires, unsigned is_device)
 	return syscon1 << 16;
 }
 
-u32 __init omap1_usb1_init(unsigned nwires)
+static u32 __init omap1_usb1_init(unsigned nwires)
 {
 	u32	syscon1 = 0;
 
@@ -475,7 +475,7 @@ bad:
 	return syscon1 << 20;
 }
 
-u32 __init omap1_usb2_init(unsigned nwires, unsigned alt_pingroup)
+static u32 __init omap1_usb2_init(unsigned nwires, unsigned alt_pingroup)
 {
 	u32	syscon1 = 0;
 
-- 
1.7.10.4
