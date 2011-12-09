From: festevam@gmail.com (Fabio Estevam)
Date: Fri,  9 Dec 2011 10:42:21 -0200
Subject: [PATCH 2/2] ARM: mach-mx27_3ds: Allow UART to be a source for wakeup.
In-Reply-To: <1323434541-27689-1-git-send-email-festevam@gmail.com>
References: <1323434541-27689-1-git-send-email-festevam@gmail.com>
Message-ID: <1323434541-27689-2-git-send-email-festevam@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Allow UART to be a source for wakeup.

Tested by doing:

echo mem > /sys/power/state

and then pressing a key in the console will wakeup the sytem.

Signed-off-by: Fabio Estevam <fabio.estevam@freescale.com>
---
 arch/arm/mach-imx/mach-mx27_3ds.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/arch/arm/mach-imx/mach-mx27_3ds.c b/arch/arm/mach-imx/mach-mx27_3ds.c
index ba232d7..ee57521 100644
--- a/arch/arm/mach-imx/mach-mx27_3ds.c
+++ b/arch/arm/mach-imx/mach-mx27_3ds.c
@@ -144,7 +144,7 @@ static const int mx27pdk_pins[] __initconst = {
 };
 
 static const struct imxuart_platform_data uart_pdata __initconst = {
-	.flags = IMXUART_HAVE_RTSCTS,
+	.flags = IMXUART_HAVE_RTSCTS | IMXUART_CANWAKE,
 };
 
 /*
-- 
1.7.1
