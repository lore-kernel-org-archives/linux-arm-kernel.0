From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Tue, 27 Oct 2009 23:12:59 -0000
Subject: [RFC PATCH 07/10] PCMCIA: soc_common: constify soc_pcmcia_socket ops
	member
In-Reply-To: <925a8da0d92cdf1f37aaef988fcc63bf9744576e.1256684685.git.rmk+kernel@arm.linux.org.uk>
References: <925a8da0d92cdf1f37aaef988fcc63bf9744576e.1256684685.git.rmk+kernel@arm.linux.org.uk>
Message-ID: <00f5050f2fd4a61a208ebb9210ba6306f2ac5db7.1256684685.git.rmk+kernel@arm.linux.org.uk>
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
