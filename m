From: t-kristo@ti.com (Tero Kristo)
Date: Tue, 21 Feb 2012 16:04:55 +0200
Subject: [PATCHv5 11/14] arm: omap: beagle: set oscillator startup time to
 10ms for rev c4
In-Reply-To: <1329833098-19900-1-git-send-email-t-kristo@ti.com>
References: <1329833098-19900-1-git-send-email-t-kristo@ti.com>
Message-ID: <1329833098-19900-12-git-send-email-t-kristo@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Based on the oscillator datasheet for this device.

Signed-off-by: Tero Kristo <t-kristo@ti.com>
---
 arch/arm/mach-omap2/board-omap3beagle.c |    3 +++
 1 files changed, 3 insertions(+), 0 deletions(-)

diff --git a/arch/arm/mach-omap2/board-omap3beagle.c b/arch/arm/mach-omap2/board-omap3beagle.c
index 97678e5..5489dbe 100644
--- a/arch/arm/mach-omap2/board-omap3beagle.c
+++ b/arch/arm/mach-omap2/board-omap3beagle.c
@@ -511,6 +511,9 @@ static void __init beagle_opp_init(void)
 			opp_disable(mpu_dev, 720000000);
 			opp_disable(iva_dev, 520000000);
 		}
+
+		/* Set oscillator startup time to 10ms, shutdown not used */
+		omap_pm_setup_oscillator(10000, ULONG_MAX);
 	}
 
 	/* Custom OPP enabled for all xM versions */
-- 
1.7.4.1
