From: nsekhar@ti.com (Sekhar Nori)
Date: Tue, 15 Nov 2011 01:42:08 +0530
Subject: [PATCH 3/4] ARM: davinci: dm646x does not have a DSP domain
In-Reply-To: <1321301529-7582-2-git-send-email-nsekhar@ti.com>
References: <1321301529-7582-1-git-send-email-nsekhar@ti.com>
 <1321301529-7582-2-git-send-email-nsekhar@ti.com>
Message-ID: <1321301529-7582-3-git-send-email-nsekhar@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Fix the incorrect classification of DSP clock into a
seperate DSP domain on DM646x.

Per the reference guide (http://www.ti.com/lit/ug/spruep9e/spruep9e.pdf)
there is only one "AlwaysON" power domain on DM6467.

Signed-off-by: Sekhar Nori <nsekhar@ti.com>
---
This patch has not been tested on DM6467 yet.

 arch/arm/mach-davinci/dm646x.c |    1 -
 1 files changed, 0 insertions(+), 1 deletions(-)

diff --git a/arch/arm/mach-davinci/dm646x.c b/arch/arm/mach-davinci/dm646x.c
index b0c350a..d73f9f9 100644
--- a/arch/arm/mach-davinci/dm646x.c
+++ b/arch/arm/mach-davinci/dm646x.c
@@ -161,7 +161,6 @@ static struct clk dsp_clk = {
 	.name = "dsp",
 	.parent = &pll1_sysclk1,
 	.lpsc = DM646X_LPSC_C64X_CPU,
-	.flags = PSC_DSP,
 	.usecount = 1,			/* REVISIT how to disable? */
 };
 
-- 
1.6.2.4
