From: shawn.guo@linaro.org (Shawn Guo)
Date: Thu, 26 Apr 2012 23:38:30 +0800
Subject: [PATCH 02/17] ARM: at91: use machine specific hook for late init
In-Reply-To: <1335454725-13089-1-git-send-email-shawn.guo@linaro.org>
References: <1335454725-13089-1-git-send-email-shawn.guo@linaro.org>
Message-ID: <1335454725-13089-3-git-send-email-shawn.guo@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Cc: Andrew Victor <linux@maxim.org.za>
Cc: Nicolas Ferre <nicolas.ferre@atmel.com>
Cc: Jean-Christophe Plagniol-Villard <plagnioj@jcrosoft.com>
Signed-off-by: Shawn Guo <shawn.guo@linaro.org>
---
 arch/arm/mach-at91/board-1arm.c         |    1 +
 arch/arm/mach-at91/board-afeb-9260v1.c  |    1 +
 arch/arm/mach-at91/board-cam60.c        |    1 +
 arch/arm/mach-at91/board-carmeva.c      |    1 +
 arch/arm/mach-at91/board-cpu9krea.c     |    1 +
 arch/arm/mach-at91/board-cpuat91.c      |    1 +
 arch/arm/mach-at91/board-csb337.c       |    1 +
 arch/arm/mach-at91/board-csb637.c       |    1 +
 arch/arm/mach-at91/board-dt.c           |    1 +
 arch/arm/mach-at91/board-eb01.c         |    1 +
 arch/arm/mach-at91/board-eb9200.c       |    1 +
 arch/arm/mach-at91/board-ecbat91.c      |    1 +
 arch/arm/mach-at91/board-eco920.c       |    1 +
 arch/arm/mach-at91/board-flexibity.c    |    1 +
 arch/arm/mach-at91/board-foxg20.c       |    1 +
 arch/arm/mach-at91/board-gsia18s.c      |    1 +
 arch/arm/mach-at91/board-kafa.c         |    1 +
 arch/arm/mach-at91/board-kb9202.c       |    1 +
 arch/arm/mach-at91/board-neocore926.c   |    1 +
 arch/arm/mach-at91/board-pcontrol-g20.c |    1 +
 arch/arm/mach-at91/board-picotux200.c   |    1 +
 arch/arm/mach-at91/board-qil-a9260.c    |    1 +
 arch/arm/mach-at91/board-rm9200dk.c     |    1 +
 arch/arm/mach-at91/board-rm9200ek.c     |    1 +
 arch/arm/mach-at91/board-rsi-ews.c      |    1 +
 arch/arm/mach-at91/board-sam9-l9260.c   |    1 +
 arch/arm/mach-at91/board-sam9260ek.c    |    1 +
 arch/arm/mach-at91/board-sam9261ek.c    |    1 +
 arch/arm/mach-at91/board-sam9263ek.c    |    1 +
 arch/arm/mach-at91/board-sam9g20ek.c    |    1 +
 arch/arm/mach-at91/board-sam9m10g45ek.c |    1 +
 arch/arm/mach-at91/board-sam9rlek.c     |    1 +
 arch/arm/mach-at91/board-snapper9260.c  |    1 +
 arch/arm/mach-at91/board-stamp9g20.c    |    1 +
 arch/arm/mach-at91/board-usb-a926x.c    |    1 +
 arch/arm/mach-at91/board-yl-9200.c      |    1 +
 arch/arm/mach-at91/clock.c              |    3 +--
 arch/arm/mach-at91/generic.h            |    5 +++++
 arch/arm/mach-at91/setup.c              |    5 +++++
 39 files changed, 47 insertions(+), 2 deletions(-)

diff --git a/arch/arm/mach-at91/board-1arm.c b/arch/arm/mach-at91/board-1arm.c
index 2628384..0a9fb25 100644
--- a/arch/arm/mach-at91/board-1arm.c
+++ b/arch/arm/mach-at91/board-1arm.c
@@ -98,4 +98,5 @@ MACHINE_START(ONEARM, "Ajeco 1ARM single board computer")
 	.init_early	= onearm_init_early,
 	.init_irq	= at91_init_irq_default,
 	.init_machine	= onearm_board_init,
+	.init_late	= at91_init_late,
 MACHINE_END
diff --git a/arch/arm/mach-at91/board-afeb-9260v1.c b/arch/arm/mach-at91/board-afeb-9260v1.c
index 161efba..89461c3 100644
--- a/arch/arm/mach-at91/board-afeb-9260v1.c
+++ b/arch/arm/mach-at91/board-afeb-9260v1.c
@@ -219,5 +219,6 @@ MACHINE_START(AFEB9260, "Custom afeb9260 board")
 	.init_early	= afeb9260_init_early,
 	.init_irq	= at91_init_irq_default,
 	.init_machine	= afeb9260_board_init,
+	.init_late	= at91_init_late,
 MACHINE_END
 
diff --git a/arch/arm/mach-at91/board-cam60.c b/arch/arm/mach-at91/board-cam60.c
index c6d44ee..8ab5489 100644
--- a/arch/arm/mach-at91/board-cam60.c
+++ b/arch/arm/mach-at91/board-cam60.c
@@ -195,4 +195,5 @@ MACHINE_START(CAM60, "KwikByte CAM60")
 	.init_early	= cam60_init_early,
 	.init_irq	= at91_init_irq_default,
 	.init_machine	= cam60_board_init,
+	.init_late	= at91_init_late,
 MACHINE_END
diff --git a/arch/arm/mach-at91/board-carmeva.c b/arch/arm/mach-at91/board-carmeva.c
index 59d9cf9..e1c6c14 100644
--- a/arch/arm/mach-at91/board-carmeva.c
+++ b/arch/arm/mach-at91/board-carmeva.c
@@ -165,4 +165,5 @@ MACHINE_START(CARMEVA, "Carmeva")
 	.init_early	= carmeva_init_early,
 	.init_irq	= at91_init_irq_default,
 	.init_machine	= carmeva_board_init,
+	.init_late	= at91_init_late,
 MACHINE_END
diff --git a/arch/arm/mach-at91/board-cpu9krea.c b/arch/arm/mach-at91/board-cpu9krea.c
index 5f3680e..087d742 100644
--- a/arch/arm/mach-at91/board-cpu9krea.c
+++ b/arch/arm/mach-at91/board-cpu9krea.c
@@ -383,4 +383,5 @@ MACHINE_START(CPUAT9G20, "Eukrea CPU9G20")
 	.init_early	= cpu9krea_init_early,
 	.init_irq	= at91_init_irq_default,
 	.init_machine	= cpu9krea_board_init,
+	.init_late	= at91_init_late,
 MACHINE_END
diff --git a/arch/arm/mach-at91/board-cpuat91.c b/arch/arm/mach-at91/board-cpuat91.c
index e094cc8..c08079a 100644
--- a/arch/arm/mach-at91/board-cpuat91.c
+++ b/arch/arm/mach-at91/board-cpuat91.c
@@ -185,4 +185,5 @@ MACHINE_START(CPUAT91, "Eukrea")
 	.init_early	= cpuat91_init_early,
 	.init_irq	= at91_init_irq_default,
 	.init_machine	= cpuat91_board_init,
+	.init_late	= at91_init_late,
 MACHINE_END
diff --git a/arch/arm/mach-at91/board-csb337.c b/arch/arm/mach-at91/board-csb337.c
index 1a1547b..0d20af4 100644
--- a/arch/arm/mach-at91/board-csb337.c
+++ b/arch/arm/mach-at91/board-csb337.c
@@ -260,4 +260,5 @@ MACHINE_START(CSB337, "Cogent CSB337")
 	.init_early	= csb337_init_early,
 	.init_irq	= at91_init_irq_default,
 	.init_machine	= csb337_board_init,
+	.init_late	= at91_init_late,
 MACHINE_END
diff --git a/arch/arm/mach-at91/board-csb637.c b/arch/arm/mach-at91/board-csb637.c
index f650bf3..3716a7d 100644
--- a/arch/arm/mach-at91/board-csb637.c
+++ b/arch/arm/mach-at91/board-csb637.c
@@ -140,4 +140,5 @@ MACHINE_START(CSB637, "Cogent CSB637")
 	.init_early	= csb637_init_early,
 	.init_irq	= at91_init_irq_default,
 	.init_machine	= csb637_board_init,
+	.init_late	= at91_init_late,
 MACHINE_END
diff --git a/arch/arm/mach-at91/board-dt.c b/arch/arm/mach-at91/board-dt.c
index c18d4d3..ce967f7 100644
--- a/arch/arm/mach-at91/board-dt.c
+++ b/arch/arm/mach-at91/board-dt.c
@@ -62,5 +62,6 @@ DT_MACHINE_START(at91sam_dt, "Atmel AT91SAM (Device Tree)")
 	.init_early	= at91_dt_initialize,
 	.init_irq	= at91_dt_init_irq,
 	.init_machine	= at91_dt_device_init,
+	.init_late	= at91_init_late,
 	.dt_compat	= at91_dt_board_compat,
 MACHINE_END
diff --git a/arch/arm/mach-at91/board-eb01.c b/arch/arm/mach-at91/board-eb01.c
index d2023f2..7448e11 100644
--- a/arch/arm/mach-at91/board-eb01.c
+++ b/arch/arm/mach-at91/board-eb01.c
@@ -45,5 +45,6 @@ MACHINE_START(AT91EB01, "Atmel AT91 EB01")
 	.timer		= &at91x40_timer,
 	.init_early	= at91eb01_init_early,
 	.init_irq	= at91eb01_init_irq,
+	.init_late	= at91_init_late,
 MACHINE_END
 
diff --git a/arch/arm/mach-at91/board-eb9200.c b/arch/arm/mach-at91/board-eb9200.c
index d302ca3..3cdf1e4 100644
--- a/arch/arm/mach-at91/board-eb9200.c
+++ b/arch/arm/mach-at91/board-eb9200.c
@@ -125,4 +125,5 @@ MACHINE_START(ATEB9200, "Embest ATEB9200")
 	.init_early	= eb9200_init_early,
 	.init_irq	= at91_init_irq_default,
 	.init_machine	= eb9200_board_init,
+	.init_late	= at91_init_late,
 MACHINE_END
diff --git a/arch/arm/mach-at91/board-ecbat91.c b/arch/arm/mach-at91/board-ecbat91.c
index 69966ce..cefbf18 100644
--- a/arch/arm/mach-at91/board-ecbat91.c
+++ b/arch/arm/mach-at91/board-ecbat91.c
@@ -177,4 +177,5 @@ MACHINE_START(ECBAT91, "emQbit's ECB_AT91")
 	.init_early	= ecb_at91init_early,
 	.init_irq	= at91_init_irq_default,
 	.init_machine	= ecb_at91board_init,
+	.init_late	= at91_init_late,
 MACHINE_END
diff --git a/arch/arm/mach-at91/board-eco920.c b/arch/arm/mach-at91/board-eco920.c
index f23aabe..2236fd5 100644
--- a/arch/arm/mach-at91/board-eco920.c
+++ b/arch/arm/mach-at91/board-eco920.c
@@ -140,4 +140,5 @@ MACHINE_START(ECO920, "eco920")
 	.init_early	= eco920_init_early,
 	.init_irq	= at91_init_irq_default,
 	.init_machine	= eco920_board_init,
+	.init_late	= at91_init_late,
 MACHINE_END
diff --git a/arch/arm/mach-at91/board-flexibity.c b/arch/arm/mach-at91/board-flexibity.c
index 1815152..28006fe 100644
--- a/arch/arm/mach-at91/board-flexibity.c
+++ b/arch/arm/mach-at91/board-flexibity.c
@@ -167,4 +167,5 @@ MACHINE_START(FLEXIBITY, "Flexibity Connect")
 	.init_early	= flexibity_init_early,
 	.init_irq	= at91_init_irq_default,
 	.init_machine	= flexibity_board_init,
+	.init_late	= at91_init_late,
 MACHINE_END
diff --git a/arch/arm/mach-at91/board-foxg20.c b/arch/arm/mach-at91/board-foxg20.c
index caf017f..892ccee 100644
--- a/arch/arm/mach-at91/board-foxg20.c
+++ b/arch/arm/mach-at91/board-foxg20.c
@@ -270,4 +270,5 @@ MACHINE_START(ACMENETUSFOXG20, "Acme Systems srl FOX Board G20")
 	.init_early	= foxg20_init_early,
 	.init_irq	= at91_init_irq_default,
 	.init_machine	= foxg20_board_init,
+	.init_late	= at91_init_late,
 MACHINE_END
diff --git a/arch/arm/mach-at91/board-gsia18s.c b/arch/arm/mach-at91/board-gsia18s.c
index 230e719..9a1e6be 100644
--- a/arch/arm/mach-at91/board-gsia18s.c
+++ b/arch/arm/mach-at91/board-gsia18s.c
@@ -579,4 +579,5 @@ MACHINE_START(GSIA18S, "GS_IA18_S")
 	.init_early	= gsia18s_init_early,
 	.init_irq	= at91_init_irq_default,
 	.init_machine	= gsia18s_board_init,
+	.init_late	= at91_init_late,
 MACHINE_END
diff --git a/arch/arm/mach-at91/board-kafa.c b/arch/arm/mach-at91/board-kafa.c
index efde1b2..fafc29b 100644
--- a/arch/arm/mach-at91/board-kafa.c
+++ b/arch/arm/mach-at91/board-kafa.c
@@ -100,4 +100,5 @@ MACHINE_START(KAFA, "Sperry-Sun KAFA")
 	.init_early	= kafa_init_early,
 	.init_irq	= at91_init_irq_default,
 	.init_machine	= kafa_board_init,
+	.init_late	= at91_init_late,
 MACHINE_END
diff --git a/arch/arm/mach-at91/board-kb9202.c b/arch/arm/mach-at91/board-kb9202.c
index 59b92aa..524f975 100644
--- a/arch/arm/mach-at91/board-kb9202.c
+++ b/arch/arm/mach-at91/board-kb9202.c
@@ -140,4 +140,5 @@ MACHINE_START(KB9200, "KB920x")
 	.init_early	= kb9202_init_early,
 	.init_irq	= at91_init_irq_default,
 	.init_machine	= kb9202_board_init,
+	.init_late	= at91_init_late,
 MACHINE_END
diff --git a/arch/arm/mach-at91/board-neocore926.c b/arch/arm/mach-at91/board-neocore926.c
index 57d5f6a..f43fa3e 100644
--- a/arch/arm/mach-at91/board-neocore926.c
+++ b/arch/arm/mach-at91/board-neocore926.c
@@ -385,4 +385,5 @@ MACHINE_START(NEOCORE926, "ADENEO NEOCORE 926")
 	.init_early	= neocore926_init_early,
 	.init_irq	= at91_init_irq_default,
 	.init_machine	= neocore926_board_init,
+	.init_late	= at91_init_late,
 MACHINE_END
diff --git a/arch/arm/mach-at91/board-pcontrol-g20.c b/arch/arm/mach-at91/board-pcontrol-g20.c
index b4a12fc..2de2dff 100644
--- a/arch/arm/mach-at91/board-pcontrol-g20.c
+++ b/arch/arm/mach-at91/board-pcontrol-g20.c
@@ -222,4 +222,5 @@ MACHINE_START(PCONTROL_G20, "PControl G20")
 	.init_early	= pcontrol_g20_init_early,
 	.init_irq	= at91_init_irq_default,
 	.init_machine	= pcontrol_g20_board_init,
+	.init_late	= at91_init_late,
 MACHINE_END
diff --git a/arch/arm/mach-at91/board-picotux200.c b/arch/arm/mach-at91/board-picotux200.c
index 59e35dd..0f99e1b 100644
--- a/arch/arm/mach-at91/board-picotux200.c
+++ b/arch/arm/mach-at91/board-picotux200.c
@@ -127,4 +127,5 @@ MACHINE_START(PICOTUX2XX, "picotux 200")
 	.init_early	= picotux200_init_early,
 	.init_irq	= at91_init_irq_default,
 	.init_machine	= picotux200_board_init,
+	.init_late	= at91_init_late,
 MACHINE_END
diff --git a/arch/arm/mach-at91/board-qil-a9260.c b/arch/arm/mach-at91/board-qil-a9260.c
index b6ed5ed..b846954 100644
--- a/arch/arm/mach-at91/board-qil-a9260.c
+++ b/arch/arm/mach-at91/board-qil-a9260.c
@@ -266,4 +266,5 @@ MACHINE_START(QIL_A9260, "CALAO QIL_A9260")
 	.init_early	= ek_init_early,
 	.init_irq	= at91_init_irq_default,
 	.init_machine	= ek_board_init,
+	.init_late	= at91_init_late,
 MACHINE_END
diff --git a/arch/arm/mach-at91/board-rm9200dk.c b/arch/arm/mach-at91/board-rm9200dk.c
index 01332aa..c65bcc1 100644
--- a/arch/arm/mach-at91/board-rm9200dk.c
+++ b/arch/arm/mach-at91/board-rm9200dk.c
@@ -230,4 +230,5 @@ MACHINE_START(AT91RM9200DK, "Atmel AT91RM9200-DK")
 	.init_early	= dk_init_early,
 	.init_irq	= at91_init_irq_default,
 	.init_machine	= dk_board_init,
+	.init_late	= at91_init_late,
 MACHINE_END
diff --git a/arch/arm/mach-at91/board-rm9200ek.c b/arch/arm/mach-at91/board-rm9200ek.c
index b2e4fe2..822ed37 100644
--- a/arch/arm/mach-at91/board-rm9200ek.c
+++ b/arch/arm/mach-at91/board-rm9200ek.c
@@ -197,4 +197,5 @@ MACHINE_START(AT91RM9200EK, "Atmel AT91RM9200-EK")
 	.init_early	= ek_init_early,
 	.init_irq	= at91_init_irq_default,
 	.init_machine	= ek_board_init,
+	.init_late	= at91_init_late,
 MACHINE_END
diff --git a/arch/arm/mach-at91/board-rsi-ews.c b/arch/arm/mach-at91/board-rsi-ews.c
index af0750f..79b46f4 100644
--- a/arch/arm/mach-at91/board-rsi-ews.c
+++ b/arch/arm/mach-at91/board-rsi-ews.c
@@ -232,4 +232,5 @@ MACHINE_START(RSI_EWS, "RSI EWS")
 	.init_early	= rsi_ews_init_early,
 	.init_irq	= at91_init_irq_default,
 	.init_machine	= rsi_ews_board_init,
+	.init_late	= at91_init_late,
 MACHINE_END
diff --git a/arch/arm/mach-at91/board-sam9-l9260.c b/arch/arm/mach-at91/board-sam9-l9260.c
index e8b116b..7c5fddb 100644
--- a/arch/arm/mach-at91/board-sam9-l9260.c
+++ b/arch/arm/mach-at91/board-sam9-l9260.c
@@ -209,4 +209,5 @@ MACHINE_START(SAM9_L9260, "Olimex SAM9-L9260")
 	.init_early	= ek_init_early,
 	.init_irq	= at91_init_irq_default,
 	.init_machine	= ek_board_init,
+	.init_late	= at91_init_late,
 MACHINE_END
diff --git a/arch/arm/mach-at91/board-sam9260ek.c b/arch/arm/mach-at91/board-sam9260ek.c
index d5aec55..b2c4f00 100644
--- a/arch/arm/mach-at91/board-sam9260ek.c
+++ b/arch/arm/mach-at91/board-sam9260ek.c
@@ -351,4 +351,5 @@ MACHINE_START(AT91SAM9260EK, "Atmel AT91SAM9260-EK")
 	.init_early	= ek_init_early,
 	.init_irq	= at91_init_irq_default,
 	.init_machine	= ek_board_init,
+	.init_late	= at91_init_late,
 MACHINE_END
diff --git a/arch/arm/mach-at91/board-sam9261ek.c b/arch/arm/mach-at91/board-sam9261ek.c
index 065fed3..78db782 100644
--- a/arch/arm/mach-at91/board-sam9261ek.c
+++ b/arch/arm/mach-at91/board-sam9261ek.c
@@ -622,4 +622,5 @@ MACHINE_START(AT91SAM9G10EK, "Atmel AT91SAM9G10-EK")
 	.init_early	= ek_init_early,
 	.init_irq	= at91_init_irq_default,
 	.init_machine	= ek_board_init,
+	.init_late	= at91_init_late,
 MACHINE_END
diff --git a/arch/arm/mach-at91/board-sam9263ek.c b/arch/arm/mach-at91/board-sam9263ek.c
index 2ffe50f..3c0271e 100644
--- a/arch/arm/mach-at91/board-sam9263ek.c
+++ b/arch/arm/mach-at91/board-sam9263ek.c
@@ -450,4 +450,5 @@ MACHINE_START(AT91SAM9263EK, "Atmel AT91SAM9263-EK")
 	.init_early	= ek_init_early,
 	.init_irq	= at91_init_irq_default,
 	.init_machine	= ek_board_init,
+	.init_late	= at91_init_late,
 MACHINE_END
diff --git a/arch/arm/mach-at91/board-sam9g20ek.c b/arch/arm/mach-at91/board-sam9g20ek.c
index 8923ec9..1ea04e2 100644
--- a/arch/arm/mach-at91/board-sam9g20ek.c
+++ b/arch/arm/mach-at91/board-sam9g20ek.c
@@ -415,4 +415,5 @@ MACHINE_START(AT91SAM9G20EK_2MMC, "Atmel AT91SAM9G20-EK 2 MMC Slot Mod")
 	.init_early	= ek_init_early,
 	.init_irq	= at91_init_irq_default,
 	.init_machine	= ek_board_init,
+	.init_late	= at91_init_late,
 MACHINE_END
diff --git a/arch/arm/mach-at91/board-sam9m10g45ek.c b/arch/arm/mach-at91/board-sam9m10g45ek.c
index c88e908..a6f683b 100644
--- a/arch/arm/mach-at91/board-sam9m10g45ek.c
+++ b/arch/arm/mach-at91/board-sam9m10g45ek.c
@@ -498,4 +498,5 @@ MACHINE_START(AT91SAM9M10G45EK, "Atmel AT91SAM9M10G45-EK")
 	.init_early	= ek_init_early,
 	.init_irq	= at91_init_irq_default,
 	.init_machine	= ek_board_init,
+	.init_late	= at91_init_late,
 MACHINE_END
diff --git a/arch/arm/mach-at91/board-sam9rlek.c b/arch/arm/mach-at91/board-sam9rlek.c
index b109ce2..5811150 100644
--- a/arch/arm/mach-at91/board-sam9rlek.c
+++ b/arch/arm/mach-at91/board-sam9rlek.c
@@ -326,4 +326,5 @@ MACHINE_START(AT91SAM9RLEK, "Atmel AT91SAM9RL-EK")
 	.init_early	= ek_init_early,
 	.init_irq	= at91_init_irq_default,
 	.init_machine	= ek_board_init,
+	.init_late	= at91_init_late,
 MACHINE_END
diff --git a/arch/arm/mach-at91/board-snapper9260.c b/arch/arm/mach-at91/board-snapper9260.c
index ebc9d01..967b376 100644
--- a/arch/arm/mach-at91/board-snapper9260.c
+++ b/arch/arm/mach-at91/board-snapper9260.c
@@ -183,6 +183,7 @@ MACHINE_START(SNAPPER_9260, "Bluewater Systems Snapper 9260/9G20 module")
 	.init_early	= snapper9260_init_early,
 	.init_irq	= at91_init_irq_default,
 	.init_machine	= snapper9260_board_init,
+	.init_late	= at91_init_late,
 MACHINE_END
 
 
diff --git a/arch/arm/mach-at91/board-stamp9g20.c b/arch/arm/mach-at91/board-stamp9g20.c
index 7640049..d077653 100644
--- a/arch/arm/mach-at91/board-stamp9g20.c
+++ b/arch/arm/mach-at91/board-stamp9g20.c
@@ -315,4 +315,5 @@ MACHINE_START(STAMP9G20, "taskit Stamp9G20")
 	.init_early	= stamp9g20evb_init_early,
 	.init_irq	= at91_init_irq_default,
 	.init_machine	= stamp9g20evb_board_init,
+	.init_late	= at91_init_late,
 MACHINE_END
diff --git a/arch/arm/mach-at91/board-usb-a926x.c b/arch/arm/mach-at91/board-usb-a926x.c
index b7483a3..6ed2625 100644
--- a/arch/arm/mach-at91/board-usb-a926x.c
+++ b/arch/arm/mach-at91/board-usb-a926x.c
@@ -379,4 +379,5 @@ MACHINE_START(USB_A9G20, "CALAO USB_A92G0")
 	.init_early	= ek_init_early,
 	.init_irq	= at91_init_irq_default,
 	.init_machine	= ek_board_init,
+	.init_late	= at91_init_late,
 MACHINE_END
diff --git a/arch/arm/mach-at91/board-yl-9200.c b/arch/arm/mach-at91/board-yl-9200.c
index 38dd279..4804a86 100644
--- a/arch/arm/mach-at91/board-yl-9200.c
+++ b/arch/arm/mach-at91/board-yl-9200.c
@@ -597,4 +597,5 @@ MACHINE_START(YL9200, "uCdragon YL-9200")
 	.init_early	= yl9200_init_early,
 	.init_irq	= at91_init_irq_default,
 	.init_machine	= yl9200_board_init,
+	.init_late	= at91_init_late,
 MACHINE_END
diff --git a/arch/arm/mach-at91/clock.c b/arch/arm/mach-at91/clock.c
index 6b69282..f0ec583 100644
--- a/arch/arm/mach-at91/clock.c
+++ b/arch/arm/mach-at91/clock.c
@@ -852,7 +852,7 @@ int __init at91_clock_init(unsigned long main_clock)
 /*
  * Several unused clocks may be active.  Turn them off.
  */
-static int __init at91_clock_reset(void)
+int __init at91_clock_reset(void)
 {
 	unsigned long pcdr = 0;
 	unsigned long scdr = 0;
@@ -876,7 +876,6 @@ static int __init at91_clock_reset(void)
 
 	return 0;
 }
-late_initcall(at91_clock_reset);
 
 void at91sam9_idle(void)
 {
diff --git a/arch/arm/mach-at91/generic.h b/arch/arm/mach-at91/generic.h
index dd9b346..c328118 100644
--- a/arch/arm/mach-at91/generic.h
+++ b/arch/arm/mach-at91/generic.h
@@ -54,8 +54,10 @@ extern void __init at91sam9g45_set_console_clock(int id);
 #ifdef CONFIG_AT91_PMC_UNIT
 extern int __init at91_clock_init(unsigned long main_clock);
 extern int __init at91_dt_clock_init(void);
+extern int at91_clock_reset(void);
 #else
 static int inline at91_clock_init(unsigned long main_clock) { return 0; }
+static inline int at91_clock_reset(void) { return 0; }
 #endif
 struct device;
 
@@ -80,6 +82,9 @@ extern void at91_ioremap_matrix(u32 base_addr);
 /* Ram Controler */
 extern void at91_ioremap_ramc(int id, u32 addr, u32 size);
 
+/* late init */
+extern void at91_init_late(void);
+
  /* GPIO */
 #define AT91RM9200_PQFP		3	/* AT91RM9200 PQFP package has 3 banks */
 #define AT91RM9200_BGA		4	/* AT91RM9200 BGA package has 4 banks */
diff --git a/arch/arm/mach-at91/setup.c b/arch/arm/mach-at91/setup.c
index f44a2e7..b17199f 100644
--- a/arch/arm/mach-at91/setup.c
+++ b/arch/arm/mach-at91/setup.c
@@ -458,3 +458,8 @@ void __init at91_initialize(unsigned long main_clock)
 
 	at91_boot_soc.init();
 }
+
+void __init at91_init_late(void)
+{
+	at91_clock_reset();
+}
-- 
1.7.5.4
