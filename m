From: mad_soft@inbox.ru (Dmitry Artamonow)
Date: Wed, 21 Apr 2010 22:49:09 +0400
Subject: [PATCH 2/2] SA1100: add processor check to sa1110-cpufreq driver
In-Reply-To: <1271875749-2891-1-git-send-email-mad_soft@inbox.ru>
References: <1271875749-2891-1-git-send-email-mad_soft@inbox.ru>
Message-ID: <1271875749-2891-3-git-send-email-mad_soft@inbox.ru>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Just to make sure that this driver won't run on StrongArm SA1100
when both SA1100 and SA1110 cpufreq drivers are built in (usually
in multimachine config). SA1100 driver already has similar check.

Signed-off-by: Dmitry Artamonow <mad_soft@inbox.ru>
---
 arch/arm/mach-sa1100/cpu-sa1110.c |    3 +++
 1 files changed, 3 insertions(+), 0 deletions(-)

diff --git a/arch/arm/mach-sa1100/cpu-sa1110.c b/arch/arm/mach-sa1100/cpu-sa1110.c
index 63b32b6..7252874 100644
--- a/arch/arm/mach-sa1100/cpu-sa1110.c
+++ b/arch/arm/mach-sa1100/cpu-sa1110.c
@@ -363,6 +363,9 @@ static int __init sa1110_clk_init(void)
 	struct sdram_params *sdram;
 	const char *name = sdram_name;
 
+	if (!cpu_is_sa1110())
+		return -ENODEV;
+
 	if (!name[0]) {
 		if (machine_is_assabet())
 			name = "TC59SM716-CL3";
-- 
1.7.0.4
