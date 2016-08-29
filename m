From: rmk+kernel@armlinux.org.uk (Russell King)
Date: Mon, 29 Aug 2016 11:03:05 +0100
Subject: [PATCH 2/3] pcmcia: sa11xx_base: add units to the timing information
In-Reply-To: <20160829100232.GC1041@n2100.armlinux.org.uk>
References: <20160829100232.GC1041@n2100.armlinux.org.uk>
Message-ID: <E1beJPF-0005Ed-PM@rmk-PC.armlinux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Add units to the timing information, so we know that the numbers are
nanoseconds.  The output changes from:

I/O      : 165 (172)
attribute: 300 (316)
common   : 300 (316)

to:

I/O      : 165ns (172ns)
attribute: 300ns (316ns)
common   : 300ns (316ns)

Signed-off-by: Russell King <rmk+kernel@armlinux.org.uk>
---
 drivers/pcmcia/sa11xx_base.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/pcmcia/sa11xx_base.c b/drivers/pcmcia/sa11xx_base.c
index af37b7ec1c73..48140ac73ed6 100644
--- a/drivers/pcmcia/sa11xx_base.c
+++ b/drivers/pcmcia/sa11xx_base.c
@@ -150,13 +150,13 @@ sa1100_pcmcia_show_timing(struct soc_pcmcia_socket *skt, char *buf)
 
 	soc_common_pcmcia_get_timing(skt, &timing);
 
-	p+=sprintf(p, "I/O      : %u (%u)\n", timing.io,
+	p+=sprintf(p, "I/O      : %uns (%uns)\n", timing.io,
 		   sa1100_pcmcia_cmd_time(clock, MECR_BSIO_GET(mecr, skt->nr)));
 
-	p+=sprintf(p, "attribute: %u (%u)\n", timing.attr,
+	p+=sprintf(p, "attribute: %uns (%uns)\n", timing.attr,
 		   sa1100_pcmcia_cmd_time(clock, MECR_BSA_GET(mecr, skt->nr)));
 
-	p+=sprintf(p, "common   : %u (%u)\n", timing.mem,
+	p+=sprintf(p, "common   : %uns (%uns)\n", timing.mem,
 		   sa1100_pcmcia_cmd_time(clock, MECR_BSM_GET(mecr, skt->nr)));
 
 	return p - buf;
-- 
2.1.0
