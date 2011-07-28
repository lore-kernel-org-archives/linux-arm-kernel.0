From: e.voevodin@samsung.com (Evgeny Voevodin)
Date: Thu, 28 Jul 2011 10:20:59 +0400
Subject: [PATCH] arm: exynos4: Fix write to nonexistent TCMPB4 PWM register
	on samsung exynos4 platform
In-Reply-To: <4E3004E3.80003@ru.mvista.com>
References: <20110727032718.GA17800@july> <4E3004E3.80003@ru.mvista.com>
Message-ID: <4E30FFCB.50201@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Evgeny Voevodin <e.voevodin@samsung.com>

There is no TCMPB register for Pulse Width Modulation timer4 on samsung 
exynos4 board. Remove unsupported register write.

Signed-off-by: Evgeny Voevodin <e.voevodin@samsung.com>
---
  arch/arm/mach-exynos4/time.c |    1 -
  1 files changed, 0 insertions(+), 1 deletions(-)

diff --git a/arch/arm/mach-exynos4/time.c b/arch/arm/mach-exynos4/time.c
index 86b9fa0..48389bf 100644
--- a/arch/arm/mach-exynos4/time.c
+++ b/arch/arm/mach-exynos4/time.c
@@ -77,7 +77,6 @@ static void exynos4_pwm_init(unsigned int pwm_id, 
unsigned long tcnt)
  		tcon |= S3C2410_TCON_T4MANUALUPD;

  		__raw_writel(tcnt, S3C2410_TCNTB(4));
-		__raw_writel(tcnt, S3C2410_TCMPB(4));
  		__raw_writel(tcon, S3C2410_TCON);

  		break;
-- 
1.7.4.1
