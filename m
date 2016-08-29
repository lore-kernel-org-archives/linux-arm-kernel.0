From: rmk+kernel@armlinux.org.uk (Russell King)
Date: Mon, 29 Aug 2016 11:25:42 +0100
Subject: [PATCH 19/33] pcmcia: sa1111: add driver-data pointer
In-Reply-To: <20160829102328.GA28796@n2100.armlinux.org.uk>
References: <20160829102328.GA28796@n2100.armlinux.org.uk>
Message-ID: <E1beJl8-0000nZ-SH@rmk-PC.armlinux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Add a driver-data pointer so that low level drivers can add additional
data to the sa1111 pcmcia socket structure.

Signed-off-by: Russell King <rmk+kernel@armlinux.org.uk>
---
 drivers/pcmcia/sa1111_generic.h | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/pcmcia/sa1111_generic.h b/drivers/pcmcia/sa1111_generic.h
index e74ecfdc1b26..0bfc82080c16 100644
--- a/drivers/pcmcia/sa1111_generic.h
+++ b/drivers/pcmcia/sa1111_generic.h
@@ -5,6 +5,7 @@ struct sa1111_pcmcia_socket {
 	struct soc_pcmcia_socket soc;
 	struct sa1111_dev *dev;
 	struct sa1111_pcmcia_socket *next;
+	void *driver_data;
 };
 
 static inline struct sa1111_pcmcia_socket *to_skt(struct soc_pcmcia_socket *s)
-- 
2.1.0
