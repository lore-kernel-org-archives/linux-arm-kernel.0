From: dwalter@google.com (Daniel Walter)
Date: Sat, 21 Jun 2014 13:05:14 +0100
Subject: [PATCH 4/9] [arch/arm/mach-w90x900] replace obsolete strict_strto
Message-ID: <20140621120514.GA6988@google.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Replace obsolete strict_strto with kstrto calls

Signed-off-by: Daniel Walter <dwalter@google.com>
---
 arch/arm/mach-w90x900/cpu.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/arch/arm/mach-w90x900/cpu.c b/arch/arm/mach-w90x900/cpu.c
index b1eabaa..213230ee 100644
--- a/arch/arm/mach-w90x900/cpu.c
+++ b/arch/arm/mach-w90x900/cpu.c
@@ -178,7 +178,8 @@ static int __init nuc900_set_cpufreq(char *str)
 	if (!*str)
 		return 0;
 
-	strict_strtoul(str, 0, &cpufreq);
+	if (kstrtoul(str, 0, &cpufreq))
+		return 0;
 
 	nuc900_clock_source(NULL, "ext");
 
-- 
2.0.0.526.g5318336
