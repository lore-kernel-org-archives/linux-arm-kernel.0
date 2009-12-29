From: felipe.balbi@nokia.com (Felipe Balbi)
Date: Wed, 30 Dec 2009 00:59:27 +0200
Subject: [patch-v2.6.34 9/9] arm: omap: musb: get rid of dyn_fifo
In-Reply-To: <1262127567-15202-1-git-send-email-felipe.balbi@nokia.com>
References: <1262127567-15202-1-git-send-email-felipe.balbi@nokia.com>
Message-ID: <1262127567-15202-10-git-send-email-felipe.balbi@nokia.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

that's deprecated as we can check dyn_fifo from
CONFIGDATA register.

Cc: linux-usb at vger.kernel.org
Signed-off-by: Felipe Balbi <felipe.balbi@nokia.com>
---
 arch/arm/mach-omap2/usb-musb.c |    1 -
 1 files changed, 0 insertions(+), 1 deletions(-)

diff --git a/arch/arm/mach-omap2/usb-musb.c b/arch/arm/mach-omap2/usb-musb.c
index f102d5a..57debb2 100644
--- a/arch/arm/mach-omap2/usb-musb.c
+++ b/arch/arm/mach-omap2/usb-musb.c
@@ -49,7 +49,6 @@ static struct resource musb_resources[] = {
 
 static struct musb_hdrc_config musb_config = {
 	.multipoint	= 1,
-	.dyn_fifo	= 1,
 	.num_eps	= 16,
 	.ram_bits	= 12,
 };
-- 
1.6.6.35.g1d85d
