From: aaro.koskinen@nokia.com (Aaro Koskinen)
Date: Thu,  9 Dec 2010 18:39:23 +0200
Subject: [PATCH 7/8] arm: omap: sdram-nokia: add 97.6/195.2 MHz timing data
In-Reply-To: <1291912764-12823-1-git-send-email-aaro.koskinen@nokia.com>
References: <1291912764-12823-1-git-send-email-aaro.koskinen@nokia.com>
Message-ID: <1291912764-12823-8-git-send-email-aaro.koskinen@nokia.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Introduce 97.6/195.2 MHz memory timing data. Based on patches by Eduardo
Valentin, Igor Dmitriev and Juha Keski-Saari.

Signed-off-by: Aaro Koskinen <aaro.koskinen@nokia.com>
Cc: Eduardo Valentin <eduardo.valentin@nokia.com>
Cc: Igor Dmitriev <ext-dmitriev.igor@nokia.com>
---
 arch/arm/mach-omap2/sdram-nokia.c |   44 +++++++++++++++++++++++++++++++++++++
 1 files changed, 44 insertions(+), 0 deletions(-)

diff --git a/arch/arm/mach-omap2/sdram-nokia.c b/arch/arm/mach-omap2/sdram-nokia.c
index baf83ec..14caa22 100644
--- a/arch/arm/mach-omap2/sdram-nokia.c
+++ b/arch/arm/mach-omap2/sdram-nokia.c
@@ -44,6 +44,27 @@ struct sdram_timings {
 	u32 tWTR;
 };
 
+static const struct sdram_timings nokia_97dot6mhz_timings[] = {
+	{
+		.casl = 3,
+		.tDAL = 30725,
+		.tDPL = 15362,
+		.tRRD = 10241,
+		.tRCD = 20483,
+		.tRP = 15362,
+		.tRAS = 40967,
+		.tRC = 56330,
+		.tRFC = 138266,
+		.tXSR = 204839,
+
+		.tREF = 7798,
+
+		.tXP = 2,
+		.tCKE = 4,
+		.tWTR = 2,
+	},
+};
+
 static const struct sdram_timings nokia_166mhz_timings[] = {
 	{
 		.casl = 3,
@@ -65,12 +86,35 @@ static const struct sdram_timings nokia_166mhz_timings[] = {
 	},
 };
 
+static const struct sdram_timings nokia_195dot2mhz_timings[] = {
+	{
+		.casl = 3,
+		.tDAL = 30725,
+		.tDPL = 15362,
+		.tRRD = 10241,
+		.tRCD = 20483,
+		.tRP = 15362,
+		.tRAS = 40967,
+		.tRC = 56330,
+		.tRFC = 138266,
+		.tXSR = 204839,
+
+		.tREF = 7752,
+
+		.tXP = 2,
+		.tCKE = 4,
+		.tWTR = 2,
+	},
+};
+
 static const struct {
 	long rate;
 	struct sdram_timings const *data;
 } nokia_timings[] = {
 	{ 83000000, nokia_166mhz_timings },
+	{ 97600000, nokia_97dot6mhz_timings },
 	{ 166000000, nokia_166mhz_timings },
+	{ 195200000, nokia_195dot2mhz_timings },
 };
 static struct omap_sdrc_params nokia_sdrc_params[ARRAY_SIZE(nokia_timings) + 1];
 
-- 
1.5.6.5
