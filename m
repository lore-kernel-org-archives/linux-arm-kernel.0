From: fabio.estevam@freescale.com (Fabio Estevam)
Date: Mon, 14 Mar 2011 15:21:08 -0300
Subject: [PATCH 1/2] ARM: mx5/babbage: Remove unneeded gpio_set_value call
Message-ID: <1300126869-14587-1-git-send-email-fabio.estevam@freescale.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

gpio_direction_output has already set the port at low logical level, so it is not needed
to call gpio_set_value to set the port to 0 again.

Signed-off-by: Fabio Estevam <fabio.estevam@freescale.com>
---
 arch/arm/mach-mx5/board-mx51_babbage.c |    1 -
 1 files changed, 0 insertions(+), 1 deletions(-)

diff --git a/arch/arm/mach-mx5/board-mx51_babbage.c b/arch/arm/mach-mx5/board-mx51_babbage.c
index b2ecd19..9b6c868 100644
--- a/arch/arm/mach-mx5/board-mx51_babbage.c
+++ b/arch/arm/mach-mx5/board-mx51_babbage.c
@@ -234,7 +234,6 @@ static inline void babbage_fec_reset(void)
 		return;
 	}
 	gpio_direction_output(BABBAGE_FEC_PHY_RESET, 0);
-	gpio_set_value(BABBAGE_FEC_PHY_RESET, 0);
 	msleep(1);
 	gpio_set_value(BABBAGE_FEC_PHY_RESET, 1);
 }
-- 
1.6.0.4
