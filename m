From: horms+renesas@verge.net.au (Simon Horman)
Date: Thu,  6 Feb 2014 15:18:56 +0900
Subject: [PATCH 04/21] ARM: shmobile: bockw: add USB Func DMAEngine support
In-Reply-To: <cover.1391665225.git.horms+renesas@verge.net.au>
References: <cover.1391665225.git.horms+renesas@verge.net.au>
Message-ID: <f3ffa47c8d563d8ea3e378fa59aca5dde9624a01.1391665225.git.horms+renesas@verge.net.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>

Signed-off-by: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Signed-off-by: Simon Horman <horms+renesas@verge.net.au>
---
 arch/arm/mach-shmobile/board-bockw.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/arch/arm/mach-shmobile/board-bockw.c b/arch/arm/mach-shmobile/board-bockw.c
index 24b4161..684a529 100644
--- a/arch/arm/mach-shmobile/board-bockw.c
+++ b/arch/arm/mach-shmobile/board-bockw.c
@@ -168,6 +168,8 @@ static struct renesas_usbhs_platform_info usbhs_info __initdata = {
 	},
 	.driver_param = {
 		.buswait_bwait	= 4,
+		.d0_tx_id	= HPBDMA_SLAVE_USBFUNC_TX,
+		.d1_rx_id	= HPBDMA_SLAVE_USBFUNC_RX,
 	},
 };
 
-- 
1.8.5.2
