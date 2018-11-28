From: rmk+kernel@armlinux.org.uk (Russell King)
Date: Wed, 28 Nov 2018 11:12:08 +0000
Subject: [PATCH 7/8] pcmcia: sa1100*: remove redundant bvd1/bvd2 setting
In-Reply-To: <20181128111041.GG30658@n2100.armlinux.org.uk>
Message-ID: <E1gRxlI-0001vY-HP@rmk-PC.armlinux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

bvd1 and bvd2 both default to 1 in the generic soc_common code, so
having a driver repeat this is redundant.  Remove it.

Signed-off-by: Russell King <rmk+kernel@armlinux.org.uk>
---
 drivers/pcmcia/sa1100_simpad.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/pcmcia/sa1100_simpad.c b/drivers/pcmcia/sa1100_simpad.c
index e235ee14eaa6..e2e8729afd9d 100644
--- a/drivers/pcmcia/sa1100_simpad.c
+++ b/drivers/pcmcia/sa1100_simpad.c
@@ -39,8 +39,8 @@ simpad_pcmcia_socket_state(struct soc_pcmcia_socket *skt,
 {
 	long cs3reg = simpad_get_cs3_ro();
 
-	state->bvd1 = 1; /* Might be cs3reg & PCMCIA_BVD1 */
-	state->bvd2 = 1; /* Might be cs3reg & PCMCIA_BVD2 */
+	/* bvd1 might be cs3reg & PCMCIA_BVD1 */
+	/* bvd2 might be cs3reg & PCMCIA_BVD2 */
 
 	if ((cs3reg & (PCMCIA_VS1|PCMCIA_VS2)) ==
 			(PCMCIA_VS1|PCMCIA_VS2)) {
-- 
2.7.4
