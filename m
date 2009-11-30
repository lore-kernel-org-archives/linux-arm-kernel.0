From: s.hauer@pengutronix.de (Sascha Hauer)
Date: Mon, 30 Nov 2009 13:31:29 +0100
Subject: [PATCH] i.MX27 audmux: Fix register offsets
Message-ID: <mailman.57.1259597040.2170.linux-arm-kernel@lists.infradead.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The PPCR registers start at 0x10, not 0xc. Fix this.

Signed-off-by: Sascha Hauer <s.hauer@pengutronix.de>
---
 arch/arm/plat-mxc/audmux-v1.c |    4 ++++
 1 files changed, 4 insertions(+), 0 deletions(-)

diff --git a/arch/arm/plat-mxc/audmux-v1.c b/arch/arm/plat-mxc/audmux-v1.c
index 70ab5af..8fbce7b 100644
--- a/arch/arm/plat-mxc/audmux-v1.c
+++ b/arch/arm/plat-mxc/audmux-v1.c
@@ -37,6 +37,10 @@ int mxc_audmux_v1_configure_port(unsigned int port, unsigned int pcr)
 		return -ENOSYS;
 	}
 
+	/* handle hole in the register space */
+	if (port > 2)
+		port++;
+
 	writel(pcr, audmux_base + MXC_AUDMUX_V1_PCR(port));
 
 	return 0;
-- 
1.6.5.2

-- 
Pengutronix e.K.                           |                             |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
Peiner Str. 6-8, 31137 Hildesheim, Germany | Phone: +49-5121-206917-0    |
Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-5555 |
