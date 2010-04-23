From: tony@atomide.com (Tony Lindgren)
Date: Fri, 23 Apr 2010 16:11:39 -0700
Subject: [PATCH 15/28] AM3517: initialize i2c subsystem after mux subsystem
In-Reply-To: <20100423230829.31953.17334.stgit@baageli.muru.com>
References: <20100423230829.31953.17334.stgit@baageli.muru.com>
Message-ID: <20100423231139.31953.25536.stgit@baageli.muru.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: stanley.miao <stanley.miao@windriver.com>

The initialize of i2c subsystem will set pinmux, so it should be done
after the initialize of mux subsystem initialization.

Signed-off-by: Stanley.Miao <stanley.miao@windriver.com>
Signed-off-by: Tony Lindgren <tony@atomide.com>
---
 arch/arm/mach-omap2/board-am3517evm.c |    4 ++--
 1 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/arm/mach-omap2/board-am3517evm.c b/arch/arm/mach-omap2/board-am3517evm.c
index 6ae8805..c1c4389 100644
--- a/arch/arm/mach-omap2/board-am3517evm.c
+++ b/arch/arm/mach-omap2/board-am3517evm.c
@@ -294,9 +294,9 @@ static struct omap_board_mux board_mux[] __initdata = {
 
 static void __init am3517_evm_init(void)
 {
-	am3517_evm_i2c_init();
-
 	omap3_mux_init(board_mux, OMAP_PACKAGE_CBB);
+
+	am3517_evm_i2c_init();
 	platform_add_devices(am3517_evm_devices,
 				ARRAY_SIZE(am3517_evm_devices));
 
