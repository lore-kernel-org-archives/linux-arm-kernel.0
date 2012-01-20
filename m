From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Fri, 20 Jan 2012 10:22:14 +0000
Subject: [PATCH 15/19] PCMCIA: sa1111: pass along
 sa1111_pcmcia_configure_socket() failure code
In-Reply-To: <20120120101709.GE1068@n2100.arm.linux.org.uk>
References: <20120120101709.GE1068@n2100.arm.linux.org.uk>
Message-ID: <E1RoBbq-0005iQ-R7@rmk-PC.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Pass along the sa1111_pcmcia_configure_socket() failure code to
higher levels, rather than just returning zero.

Signed-off-by: Russell King <rmk+kernel@arm.linux.org.uk>
---
 drivers/pcmcia/sa1100_badge4.c   |    2 +-
 drivers/pcmcia/sa1100_neponset.c |    2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/pcmcia/sa1100_badge4.c b/drivers/pcmcia/sa1100_badge4.c
index ca97cb8..4d206f4 100644
--- a/drivers/pcmcia/sa1100_badge4.c
+++ b/drivers/pcmcia/sa1100_badge4.c
@@ -122,7 +122,7 @@ badge4_pcmcia_configure_socket(struct soc_pcmcia_socket *skt, const socket_state
 		local_irq_restore(flags);
 	}
 
-	return 0;
+	return ret;
 }
 
 static struct pcmcia_low_level badge4_pcmcia_ops = {
diff --git a/drivers/pcmcia/sa1100_neponset.c b/drivers/pcmcia/sa1100_neponset.c
index 1eac3fd..50f297d 100644
--- a/drivers/pcmcia/sa1100_neponset.c
+++ b/drivers/pcmcia/sa1100_neponset.c
@@ -103,7 +103,7 @@ neponset_pcmcia_configure_socket(struct soc_pcmcia_socket *skt, const socket_sta
 		sa1111_set_io(s->dev, pa_dwr_mask, pa_dwr_set);
 	}
 
-	return 0;
+	return ret;
 }
 
 static struct pcmcia_low_level neponset_pcmcia_ops = {
-- 
1.7.4.4
