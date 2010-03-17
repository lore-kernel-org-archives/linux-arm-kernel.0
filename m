From: khilman@deeprootsystems.com (Kevin Hilman)
Date: Wed, 17 Mar 2010 08:52:41 -0700
Subject: [PATCH 4/6] davinci: DM365: fix duplicate default IRQ priorities
In-Reply-To: <1268841163-5868-1-git-send-email-khilman@deeprootsystems.com>
References: <1268841163-5868-1-git-send-email-khilman@deeprootsystems.com>
Message-ID: <1268841163-5868-5-git-send-email-khilman@deeprootsystems.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

IRQ 29 has two possible interrupts DDRINT and RTC, but having both in
the default priority table is confusing (and triggers a warning from
sparse.)

This patch removes the lower priority DDRINT from the default priority
table leaving the RTC setting as the default.

Signed-off-by: Kevin Hilman <khilman@deeprootsystems.com>
---
 arch/arm/mach-davinci/dm365.c |    1 -
 1 files changed, 0 insertions(+), 1 deletions(-)

diff --git a/arch/arm/mach-davinci/dm365.c b/arch/arm/mach-davinci/dm365.c
index 27772e1..0d6ee58 100644
--- a/arch/arm/mach-davinci/dm365.c
+++ b/arch/arm/mach-davinci/dm365.c
@@ -758,7 +758,6 @@ static u8 dm365_default_priorities[DAVINCI_N_AINTC_IRQ] = {
 	[IRQ_MMCINT]			= 7,
 	[IRQ_DM365_MMCINT1]		= 7,
 	[IRQ_DM365_PWMINT3]		= 7,
-	[IRQ_DDRINT]			= 4,
 	[IRQ_AEMIFINT]			= 2,
 	[IRQ_DM365_SDIOINT1]		= 2,
 	[IRQ_TINT0_TINT12]		= 7,
-- 
1.7.0.2
