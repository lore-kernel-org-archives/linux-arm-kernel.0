From: tony@atomide.com (Tony Lindgren)
Date: Fri, 19 Feb 2010 15:30:36 -0800
Subject: [PATCH 10/11] omap: musb: get rid of dyn_fifo
In-Reply-To: <20100219232648.10559.380.stgit@baageli.muru.com>
References: <20100219232648.10559.380.stgit@baageli.muru.com>
Message-ID: <20100219233036.10559.29778.stgit@baageli.muru.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Felipe Balbi <felipe.balbi@nokia.com>

that's deprecated as we can check dyn_fifo from
CONFIGDATA register.

Cc: linux-usb at vger.kernel.org
Signed-off-by: Felipe Balbi <felipe.balbi@nokia.com>
Signed-off-by: Tony Lindgren <tony@atomide.com>
---
 arch/arm/mach-omap2/usb-musb.c |    1 -
 1 files changed, 0 insertions(+), 1 deletions(-)

diff --git a/arch/arm/mach-omap2/usb-musb.c b/arch/arm/mach-omap2/usb-musb.c
index 2221a6c..85feb60 100644
--- a/arch/arm/mach-omap2/usb-musb.c
+++ b/arch/arm/mach-omap2/usb-musb.c
@@ -49,7 +49,6 @@ static struct resource musb_resources[] = {
 
 static struct musb_hdrc_config musb_config = {
 	.multipoint	= 1,
-	.dyn_fifo	= 1,
 	.num_eps	= 16,
 	.ram_bits	= 12,
 };
