From: festevam@gmail.com (Fabio Estevam)
Date: Thu, 28 Apr 2011 21:43:24 -0300
Subject: [PATCH v2 3/3] ARM: mx5/mx51_babbage: Fix the msleep placement
In-Reply-To: <1304037804-4411-2-git-send-email-festevam@gmail.com>
References: <1304037804-4411-1-git-send-email-festevam@gmail.com>
	<1304037804-4411-2-git-send-email-festevam@gmail.com>
Message-ID: <1304037804-4411-3-git-send-email-festevam@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Signed-off-by: Fabio Estevam <fabio.estevam@freescale.com>
---
 arch/arm/mach-mx5/board-mx51_babbage.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/arch/arm/mach-mx5/board-mx51_babbage.c b/arch/arm/mach-mx5/board-mx51_babbage.c
index 00203fb..1c4704a 100644
--- a/arch/arm/mach-mx5/board-mx51_babbage.c
+++ b/arch/arm/mach-mx5/board-mx51_babbage.c
@@ -186,8 +186,8 @@ static int gpio_usbh1_active(void)
 		pr_debug("failed to get MX51_PAD_USBH1_STP__GPIO_1_27: %d\n", ret);
 		return ret;
 	}
-	gpio_set_value(BABBAGE_USBH1_STP, 1);
 	msleep(100);
+	gpio_set_value(BABBAGE_USBH1_STP, 1);
 	gpio_free(BABBAGE_USBH1_STP);
 
 	/* De-assert USB PHY RESETB */
-- 
1.6.0.4
