From: maramaopercheseimorto@gmail.com (Alberto Panizzo)
Date: Thu, 15 Oct 2009 19:29:05 +0200
Subject: [PATCH 2/4] [MXC] Armadillo500 Correct bus length for SMSC9118
	on board chip.
In-Reply-To: <20091015192451.50ee35c5@Marramao-laptop>
References: <20091015191325.74ba24fb@Marramao-laptop>
	<20091015192451.50ee35c5@Marramao-laptop>
Message-ID: <20091015192905.2fa228f9@Marramao-laptop>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Armadillo500 Correct bus length for SMSC9118 on board chip.

The SMSC9118 network chip is connected to the data bus with a 16 bit
interface, not 32 as early suggested.

Signed-off-by: Alberto Panizzo <maramaopercheseimorto@gmail.com>
---
 arch/arm/mach-mx3/armadillo5x0.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/arch/arm/mach-mx3/armadillo5x0.c b/arch/arm/mach-mx3/armadillo5x0.c
index 309fa7a..bd4a0f9 100644
--- a/arch/arm/mach-mx3/armadillo5x0.c
+++ b/arch/arm/mach-mx3/armadillo5x0.c
@@ -310,7 +310,7 @@ static struct resource armadillo5x0_smc911x_resources[] = {
 };
 
 static struct smsc911x_platform_config smsc911x_info = {
-	.flags		= SMSC911X_USE_32BIT,
+	.flags		= SMSC911X_USE_16BIT,
 	.irq_polarity   = SMSC911X_IRQ_POLARITY_ACTIVE_LOW,
 	.irq_type       = SMSC911X_IRQ_TYPE_PUSH_PULL,
 };
-- 
1.5.4.3
