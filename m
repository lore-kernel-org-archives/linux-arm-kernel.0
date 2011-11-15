From: mcuos.com@gmail.com (Wan ZongShun)
Date: Tue, 15 Nov 2011 20:31:13 +0800
Subject: [PATCH] ARM: NUC900: add clock source select for ac97 and i2s
Message-ID: <4EC25B91.9050806@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patch is to add clock source select for ac97 and i2s,
since I will implement the i2s driver, so this "nuc900-audio" is not
yet specific for AC97.

Signed-off-by: Wan ZongShun <mcuos.com@gmail.com>

---
 arch/arm/mach-w90x900/clksel.c |    3 ++-
 1 files changed, 2 insertions(+), 1 deletions(-)

diff --git a/arch/arm/mach-w90x900/clksel.c b/arch/arm/mach-w90x900/clksel.c
index 3de4a52..76ccabe 100644
--- a/arch/arm/mach-w90x900/clksel.c
+++ b/arch/arm/mach-w90x900/clksel.c
@@ -48,7 +48,8 @@ static void clock_source_select(const char *dev_id,
unsigned int clkval)
 		offset = ATAOFFSET;
 	else if (strcmp(dev_id, "nuc900-lcd") == 0)
 		offset = LCDOFFSET;
-	else if (strcmp(dev_id, "nuc900-audio") == 0)
+	else if (strcmp(dev_id, "nuc900-audio-ac97") == 0 ||
+				strcmp(dev_id, "nuc900-audio-i2s") == 0)
 		offset = AUDOFFSET;
 	else
 		offset = CPUOFFSET;
-- 
1.7.0.4
