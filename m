From: maz@misterjones.org (Marc Zyngier)
Date: Sat, 26 Dec 2009 21:25:48 +0100
Subject: [PATCH 2/4] pxa/zeus: Make internal zeus_get_pcb_info static
In-Reply-To: <1261859150-17335-2-git-send-email-maz@misterjones.org>
References: <1261859150-17335-1-git-send-email-maz@misterjones.org>
	<1261859150-17335-2-git-send-email-maz@misterjones.org>
Message-ID: <1261859150-17335-3-git-send-email-maz@misterjones.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Signed-off-by: Marc Zyngier <maz@misterjones.org>
---
 arch/arm/mach-pxa/zeus.c |    4 ++--
 1 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/arm/mach-pxa/zeus.c b/arch/arm/mach-pxa/zeus.c
index 5b986a8..865df5d 100644
--- a/arch/arm/mach-pxa/zeus.c
+++ b/arch/arm/mach-pxa/zeus.c
@@ -626,8 +626,8 @@ static void zeus_power_off(void)
 	pxa27x_cpu_suspend(PWRMODE_DEEPSLEEP);
 }
 
-int zeus_get_pcb_info(struct i2c_client *client, unsigned gpio,
-		      unsigned ngpio, void *context)
+static int zeus_get_pcb_info(struct i2c_client *client, unsigned gpio,
+			     unsigned ngpio, void *context)
 {
 	int i;
 	u8 pcb_info = 0;
-- 
1.6.5.7
