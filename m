From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Fri, 04 Nov 2011 11:30:53 +0000
Subject: [PATCH 1/2] ARM: PXA: fix lubbock PCMCIA driver build error
In-Reply-To: <20111104113032.GY12913@n2100.arm.linux.org.uk>
References: <20111104113032.GY12913@n2100.arm.linux.org.uk>
Message-ID: <E1RMHz3-0001qe-3d@rmk-PC.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Fix:

ERROR: "pxa2xx_configure_sockets" [drivers/pcmcia/pxa2xx_lubbock_cs.ko] undefined!

by exporting the required function.

Signed-off-by: Russell King <rmk+kernel@arm.linux.org.uk>
---
 drivers/pcmcia/pxa2xx_base.c |    1 +
 1 files changed, 1 insertions(+), 0 deletions(-)

diff --git a/drivers/pcmcia/pxa2xx_base.c b/drivers/pcmcia/pxa2xx_base.c
index 2c54054..a87e272 100644
--- a/drivers/pcmcia/pxa2xx_base.c
+++ b/drivers/pcmcia/pxa2xx_base.c
@@ -231,6 +231,7 @@ void pxa2xx_configure_sockets(struct device *dev)
 
 	__raw_writel(mecr, MECR);
 }
+EXPORT_SYMBOL(pxa2xx_configure_sockets);
 
 static const char *skt_names[] = {
 	"PCMCIA socket 0",
-- 
1.7.4.4
