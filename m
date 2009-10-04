From: rmk@arm.linux.org.uk (Russell King)
Date: Sun, 04 Oct 2009 16:09:07 +0100
Subject: [RFC PATCH 07/10] PCMCIA: soc_common: constify soc_pcmcia_socket ops
	member
In-Reply-To: <6cc18319511869ba8c46bf1d1b20553baa170904.1253722954.git.rmk+kernel@arm.linux.org.uk>
References: <6cc18319511869ba8c46bf1d1b20553baa170904.1253722954.git.rmk+kernel@arm.linux.org.uk>
Message-ID: <7eb4678dbe8cd2693c83de14613c687bd5499c06.1253722954.git.rmk+kernel@arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

No one should modify the ops structure supplied to soc_pcmcia_socket
so make it const.

Signed-off-by: Russell King <rmk+kernel@arm.linux.org.uk>
---
 drivers/pcmcia/soc_common.h |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/drivers/pcmcia/soc_common.h b/drivers/pcmcia/soc_common.h
index 8a755c1..f7533dc 100644
--- a/drivers/pcmcia/soc_common.h
+++ b/drivers/pcmcia/soc_common.h
@@ -37,7 +37,7 @@ struct soc_pcmcia_socket {
 	/*
 	 * Core PCMCIA state
 	 */
-	struct pcmcia_low_level *ops;
+	const struct pcmcia_low_level *ops;
 
 	unsigned int		status;
 	socket_state_t		cs_state;
-- 
1.6.2.5
