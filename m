From: kefeng.wang@linaro.org (Kefeng Wang)
Date: Mon, 21 Apr 2014 18:11:04 +0800
Subject: [PATCH] arm: oprofile: add ARMv7 cortex-a15 support
Message-ID: <1398075064-4906-1-git-send-email-kefeng.wang@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

ARMv7 cortex-a15 supports Performance Monitor Units, and
it could be used by oprofile, add perf_pmu_name pair.

Simply tested on hisilicon hip04 soc.

Signed-off-by: Kefeng Wang <kefeng.wang@linaro.org>
---
 arch/arm/oprofile/common.c |    1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm/oprofile/common.c b/arch/arm/oprofile/common.c
index 99c63d4b..9ede34b 100644
--- a/arch/arm/oprofile/common.c
+++ b/arch/arm/oprofile/common.c
@@ -39,6 +39,7 @@ static struct op_perf_name {
 	{ "v6mpcore",		"arm/mpcore"	},
 	{ "ARMv7 Cortex-A8",	"arm/armv7"	},
 	{ "ARMv7 Cortex-A9",	"arm/armv7-ca9"	},
+	{ "ARMv7 Cortex-A15",	"arm/armv7-ca15"},
 };
 
 char *op_name_from_perf_id(void)
-- 
1.7.9.5
