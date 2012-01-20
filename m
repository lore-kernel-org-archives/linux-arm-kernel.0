From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Fri, 20 Jan 2012 10:21:54 +0000
Subject: [PATCH 14/19] PCMCIA: soc_common: remove explicit wrprot
 initialization in socket drivers
In-Reply-To: <20120120101709.GE1068@n2100.arm.linux.org.uk>
References: <20120120101709.GE1068@n2100.arm.linux.org.uk>
Message-ID: <E1RoBbW-0005iM-DV@rmk-PC.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

soc_common already initializes state.wrprot to zero, so explicitly
setting wrprot to zero in the socket drivers has no additional effect.

Signed-off-by: Russell King <rmk+kernel@arm.linux.org.uk>
---
 drivers/pcmcia/pxa2xx_balloon3.c   |    1 -
 drivers/pcmcia/pxa2xx_cm_x255.c    |    1 -
 drivers/pcmcia/pxa2xx_cm_x270.c    |    1 -
 drivers/pcmcia/pxa2xx_colibri.c    |    1 -
 drivers/pcmcia/pxa2xx_e740.c       |    1 -
 drivers/pcmcia/pxa2xx_mainstone.c  |    1 -
 drivers/pcmcia/pxa2xx_palmld.c     |    1 -
 drivers/pcmcia/pxa2xx_palmtc.c     |    1 -
 drivers/pcmcia/pxa2xx_palmtx.c     |    1 -
 drivers/pcmcia/pxa2xx_stargate2.c  |    1 -
 drivers/pcmcia/pxa2xx_trizeps4.c   |    2 --
 drivers/pcmcia/pxa2xx_viper.c      |    1 -
 drivers/pcmcia/pxa2xx_vpac270.c    |    1 -
 drivers/pcmcia/sa1100_assabet.c    |    1 -
 drivers/pcmcia/sa1100_cerf.c       |    1 -
 drivers/pcmcia/sa1100_h3600.c      |    1 -
 drivers/pcmcia/sa1100_nanoengine.c |    1 -
 drivers/pcmcia/sa1100_shannon.c    |    2 --
 drivers/pcmcia/sa1100_simpad.c     |    1 -
 19 files changed, 0 insertions(+), 21 deletions(-)

diff --git a/drivers/pcmcia/pxa2xx_balloon3.c b/drivers/pcmcia/pxa2xx_balloon3.c
index 12e38b4..2ef576c 100644
--- a/drivers/pcmcia/pxa2xx_balloon3.c
+++ b/drivers/pcmcia/pxa2xx_balloon3.c
@@ -81,7 +81,6 @@ static void balloon3_pcmcia_socket_state(struct soc_pcmcia_socket *skt,
 	state->bvd2	= 0;	/* not available */
 	state->vs_3v	= 1;	/* Always true its a CF card */
 	state->vs_Xv	= 0;	/* not available */
-	state->wrprot	= 0;	/* not available */
 }
 
 static int balloon3_pcmcia_configure_socket(struct soc_pcmcia_socket *skt,
diff --git a/drivers/pcmcia/pxa2xx_cm_x255.c b/drivers/pcmcia/pxa2xx_cm_x255.c
index f90e7b1..da40908 100644
--- a/drivers/pcmcia/pxa2xx_cm_x255.c
+++ b/drivers/pcmcia/pxa2xx_cm_x255.c
@@ -58,7 +58,6 @@ static void cmx255_pcmcia_socket_state(struct soc_pcmcia_socket *skt,
 {
 	state->vs_3v  = 0;
 	state->vs_Xv  = 0;
-	state->wrprot = 0;  /* not available */
 }
 
 
diff --git a/drivers/pcmcia/pxa2xx_cm_x270.c b/drivers/pcmcia/pxa2xx_cm_x270.c
index efb5f13..f59223f 100644
--- a/drivers/pcmcia/pxa2xx_cm_x270.c
+++ b/drivers/pcmcia/pxa2xx_cm_x270.c
@@ -48,7 +48,6 @@ static void cmx270_pcmcia_socket_state(struct soc_pcmcia_socket *skt,
 {
 	state->vs_3v  = 0;
 	state->vs_Xv  = 0;
-	state->wrprot = 0;  /* not available */
 }
 
 
diff --git a/drivers/pcmcia/pxa2xx_colibri.c b/drivers/pcmcia/pxa2xx_colibri.c
index 3565169..4dee7b2 100644
--- a/drivers/pcmcia/pxa2xx_colibri.c
+++ b/drivers/pcmcia/pxa2xx_colibri.c
@@ -84,7 +84,6 @@ static void colibri_pcmcia_socket_state(struct soc_pcmcia_socket *skt,
 	state->ready  = !!gpio_get_value(colibri_pcmcia_gpios[READY].gpio);
 	state->bvd1   = !!gpio_get_value(colibri_pcmcia_gpios[BVD1].gpio);
 	state->bvd2   = !!gpio_get_value(colibri_pcmcia_gpios[BVD2].gpio);
-	state->wrprot = 0;
 	state->vs_3v  = 1;
 	state->vs_Xv  = 0;
 }
diff --git a/drivers/pcmcia/pxa2xx_e740.c b/drivers/pcmcia/pxa2xx_e740.c
index 24e00a5..8751a32 100644
--- a/drivers/pcmcia/pxa2xx_e740.c
+++ b/drivers/pcmcia/pxa2xx_e740.c
@@ -44,7 +44,6 @@ static void e740_pcmcia_socket_state(struct soc_pcmcia_socket *skt,
 					struct pcmcia_state *state)
 {
 	state->vs_3v  = 1;
-	state->wrprot = 0;
 	state->vs_Xv  = 0;
 }
 
diff --git a/drivers/pcmcia/pxa2xx_mainstone.c b/drivers/pcmcia/pxa2xx_mainstone.c
index b0ea4d3..7e32e25 100644
--- a/drivers/pcmcia/pxa2xx_mainstone.c
+++ b/drivers/pcmcia/pxa2xx_mainstone.c
@@ -83,7 +83,6 @@ static void mst_pcmcia_socket_state(struct soc_pcmcia_socket *skt,
 	state->bvd2   = (status & MST_PCMCIA_nSPKR_BVD2) ? 1 : 0;
 	state->vs_3v  = (status & MST_PCMCIA_nVS1) ? 0 : 1;
 	state->vs_Xv  = (status & MST_PCMCIA_nVS2) ? 0 : 1;
-	state->wrprot = 0;  /* not available */
 }
 
 static int mst_pcmcia_configure_socket(struct soc_pcmcia_socket *skt,
diff --git a/drivers/pcmcia/pxa2xx_palmld.c b/drivers/pcmcia/pxa2xx_palmld.c
index 4bf6814..ed7d4db 100644
--- a/drivers/pcmcia/pxa2xx_palmld.c
+++ b/drivers/pcmcia/pxa2xx_palmld.c
@@ -47,7 +47,6 @@ static void palmld_pcmcia_socket_state(struct soc_pcmcia_socket *skt,
 					struct pcmcia_state *state)
 {
 	state->detect = 1; /* always inserted */
-	state->wrprot = 0;
 	state->vs_3v  = 1;
 	state->vs_Xv  = 0;
 }
diff --git a/drivers/pcmcia/pxa2xx_palmtc.c b/drivers/pcmcia/pxa2xx_palmtc.c
index b32d05f..81225a7 100644
--- a/drivers/pcmcia/pxa2xx_palmtc.c
+++ b/drivers/pcmcia/pxa2xx_palmtc.c
@@ -51,7 +51,6 @@ static void palmtc_pcmcia_socket_state(struct soc_pcmcia_socket *skt,
 					struct pcmcia_state *state)
 {
 	state->detect = 1; /* always inserted */
-	state->wrprot = 0;
 	state->vs_3v  = 1;
 	state->vs_Xv  = 0;
 }
diff --git a/drivers/pcmcia/pxa2xx_palmtx.c b/drivers/pcmcia/pxa2xx_palmtx.c
index ee024ff..069b6bb 100644
--- a/drivers/pcmcia/pxa2xx_palmtx.c
+++ b/drivers/pcmcia/pxa2xx_palmtx.c
@@ -47,7 +47,6 @@ static void palmtx_pcmcia_socket_state(struct soc_pcmcia_socket *skt,
 					struct pcmcia_state *state)
 {
 	state->detect = 1; /* always inserted */
-	state->wrprot = 0;
 	state->vs_3v  = 1;
 	state->vs_Xv  = 0;
 }
diff --git a/drivers/pcmcia/pxa2xx_stargate2.c b/drivers/pcmcia/pxa2xx_stargate2.c
index e7c7eb5..1d73c44 100644
--- a/drivers/pcmcia/pxa2xx_stargate2.c
+++ b/drivers/pcmcia/pxa2xx_stargate2.c
@@ -54,7 +54,6 @@ static void sg2_pcmcia_socket_state(struct soc_pcmcia_socket *skt,
 	state->bvd2   = 0; /* not available */
 	state->vs_3v  = 1; /* not available - voltage detect for card */
 	state->vs_Xv  = 0; /* not available */
-	state->wrprot = 0; /* not available - write protect */
 }
 
 static int sg2_pcmcia_configure_socket(struct soc_pcmcia_socket *skt,
diff --git a/drivers/pcmcia/pxa2xx_trizeps4.c b/drivers/pcmcia/pxa2xx_trizeps4.c
index aeda98e..2c31422 100644
--- a/drivers/pcmcia/pxa2xx_trizeps4.c
+++ b/drivers/pcmcia/pxa2xx_trizeps4.c
@@ -76,7 +76,6 @@ static void trizeps_pcmcia_socket_state(struct soc_pcmcia_socket *skt,
 		state->bvd2   = (status & ConXS_CFSR_BVD2) ? 1 : 0;
 		state->vs_3v  = (status & ConXS_CFSR_VS1) ? 0 : 1;
 		state->vs_Xv  = (status & ConXS_CFSR_VS2) ? 0 : 1;
-		state->wrprot = 0;	/* not available */
 		break;
 
 #ifndef CONFIG_MACH_TRIZEPS_CONXS
@@ -88,7 +87,6 @@ static void trizeps_pcmcia_socket_state(struct soc_pcmcia_socket *skt,
 		state->bvd2   = 0;
 		state->vs_3v  = 0;
 		state->vs_Xv  = 0;
-		state->wrprot = 0;
 		break;
 
 #endif
diff --git a/drivers/pcmcia/pxa2xx_viper.c b/drivers/pcmcia/pxa2xx_viper.c
index 6100ef8..adfae49 100644
--- a/drivers/pcmcia/pxa2xx_viper.c
+++ b/drivers/pcmcia/pxa2xx_viper.c
@@ -81,7 +81,6 @@ static void viper_pcmcia_hw_shutdown(struct soc_pcmcia_socket *skt)
 static void viper_pcmcia_socket_state(struct soc_pcmcia_socket *skt,
 				      struct pcmcia_state *state)
 {
-	state->wrprot = 0;
 	state->vs_3v  = 1; /* Can only apply 3.3V */
 	state->vs_Xv  = 0;
 }
diff --git a/drivers/pcmcia/pxa2xx_vpac270.c b/drivers/pcmcia/pxa2xx_vpac270.c
index cf07d88..a47dcd2 100644
--- a/drivers/pcmcia/pxa2xx_vpac270.c
+++ b/drivers/pcmcia/pxa2xx_vpac270.c
@@ -69,7 +69,6 @@ static void vpac270_pcmcia_hw_shutdown(struct soc_pcmcia_socket *skt)
 static void vpac270_pcmcia_socket_state(struct soc_pcmcia_socket *skt,
 					struct pcmcia_state *state)
 {
-	state->wrprot = 0;
 	state->vs_3v  = 1;
 	state->vs_Xv  = 0;
 }
diff --git a/drivers/pcmcia/sa1100_assabet.c b/drivers/pcmcia/sa1100_assabet.c
index 618f546..ba8557e 100644
--- a/drivers/pcmcia/sa1100_assabet.c
+++ b/drivers/pcmcia/sa1100_assabet.c
@@ -34,7 +34,6 @@ static int assabet_pcmcia_hw_init(struct soc_pcmcia_socket *skt)
 static void
 assabet_pcmcia_socket_state(struct soc_pcmcia_socket *skt, struct pcmcia_state *state)
 {
-	state->wrprot = 0; /* Not available on Assabet. */
 	state->vs_3v  = 1; /* Can only apply 3.3V on Assabet. */
 	state->vs_Xv  = 0;
 }
diff --git a/drivers/pcmcia/sa1100_cerf.c b/drivers/pcmcia/sa1100_cerf.c
index 50df0e6..c59c449 100644
--- a/drivers/pcmcia/sa1100_cerf.c
+++ b/drivers/pcmcia/sa1100_cerf.c
@@ -48,7 +48,6 @@ static void cerf_pcmcia_hw_shutdown(struct soc_pcmcia_socket *skt)
 static void
 cerf_pcmcia_socket_state(struct soc_pcmcia_socket *skt, struct pcmcia_state *state)
 {
-	state->wrprot	= 0;
 	state->vs_3v	= 1;
 	state->vs_Xv	= 0;
 }
diff --git a/drivers/pcmcia/sa1100_h3600.c b/drivers/pcmcia/sa1100_h3600.c
index 410a636..d9c7337 100644
--- a/drivers/pcmcia/sa1100_h3600.c
+++ b/drivers/pcmcia/sa1100_h3600.c
@@ -96,7 +96,6 @@ h3600_pcmcia_socket_state(struct soc_pcmcia_socket *skt, struct pcmcia_state *st
 {
 	state->bvd1 = 0;
 	state->bvd2 = 0;
-	state->wrprot = 0; /* Not available on H3600. */
 	state->vs_3v = 0;
 	state->vs_Xv = 0;
 }
diff --git a/drivers/pcmcia/sa1100_nanoengine.c b/drivers/pcmcia/sa1100_nanoengine.c
index cb43e39..35c30ff 100644
--- a/drivers/pcmcia/sa1100_nanoengine.c
+++ b/drivers/pcmcia/sa1100_nanoengine.c
@@ -106,7 +106,6 @@ static void nanoengine_pcmcia_socket_state(
 
 	state->bvd1 = 1;
 	state->bvd2 = 1;
-	state->wrprot = 0; /* Not available */
 	state->vs_3v = 1; /* Can only apply 3.3V */
 	state->vs_Xv = 0;
 }
diff --git a/drivers/pcmcia/sa1100_shannon.c b/drivers/pcmcia/sa1100_shannon.c
index 7337cbc..6796e4b 100644
--- a/drivers/pcmcia/sa1100_shannon.c
+++ b/drivers/pcmcia/sa1100_shannon.c
@@ -47,7 +47,6 @@ shannon_pcmcia_socket_state(struct soc_pcmcia_socket *skt,
 	switch (skt->nr) {
 	case 0:
 		state->ready  = (levels & SHANNON_GPIO_RDY_0) ? 1 : 0;
-		state->wrprot = 0; /* Not available on Shannon. */
 		state->bvd1   = 1; 
 		state->bvd2   = 1; 
 		state->vs_3v  = 1; /* FIXME Can only apply 3.3V on Shannon. */
@@ -56,7 +55,6 @@ shannon_pcmcia_socket_state(struct soc_pcmcia_socket *skt,
 
 	case 1:
 		state->ready  = (levels & SHANNON_GPIO_RDY_1) ? 1 : 0;
-		state->wrprot = 0; /* Not available on Shannon. */
 		state->bvd1   = 1; 
 		state->bvd2   = 1; 
 		state->vs_3v  = 1; /* FIXME Can only apply 3.3V on Shannon. */
diff --git a/drivers/pcmcia/sa1100_simpad.c b/drivers/pcmcia/sa1100_simpad.c
index 39d2241..8647b17 100644
--- a/drivers/pcmcia/sa1100_simpad.c
+++ b/drivers/pcmcia/sa1100_simpad.c
@@ -46,7 +46,6 @@ simpad_pcmcia_socket_state(struct soc_pcmcia_socket *skt,
 
 	state->bvd1 = 1; /* Might be cs3reg & PCMCIA_BVD1 */
 	state->bvd2 = 1; /* Might be cs3reg & PCMCIA_BVD2 */
-	state->wrprot=0; /* Not available on Simpad. */
 
 	if ((cs3reg & (PCMCIA_VS1|PCMCIA_VS2)) ==
 			(PCMCIA_VS1|PCMCIA_VS2)) {
-- 
1.7.4.4
