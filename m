From: fabio.estevam@freescale.com (Fabio Estevam)
Date: Mon, 14 Mar 2011 15:21:09 -0300
Subject: [PATCH 2/2] ARM: mx5/mx53_evk: Remove unneeded gpio_set_value call
In-Reply-To: <1300126869-14587-1-git-send-email-fabio.estevam@freescale.com>
References: <1300126869-14587-1-git-send-email-fabio.estevam@freescale.com>
Message-ID: <1300126869-14587-2-git-send-email-fabio.estevam@freescale.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

gpio_direction_output has already set the port at low logical level, so it is not needed
to call gpio_set_value to set the port to 0 again.

Signed-off-by: Fabio Estevam <fabio.estevam@freescale.com>
---
 arch/arm/mach-mx5/board-mx53_evk.c |    1 -
 1 files changed, 0 insertions(+), 1 deletions(-)

diff --git a/arch/arm/mach-mx5/board-mx53_evk.c b/arch/arm/mach-mx5/board-mx53_evk.c
index 652e1e0..78abce6 100644
--- a/arch/arm/mach-mx5/board-mx53_evk.c
+++ b/arch/arm/mach-mx5/board-mx53_evk.c
@@ -90,7 +90,6 @@ static inline void mx53_evk_fec_reset(void)
 		return;
 	}
 	gpio_direction_output(SMD_FEC_PHY_RST, 0);
-	gpio_set_value(SMD_FEC_PHY_RST, 0);
 	msleep(1);
 	gpio_set_value(SMD_FEC_PHY_RST, 1);
 }
-- 
1.6.0.4
