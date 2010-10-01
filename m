From: tony@atomide.com (Tony Lindgren)
Date: Fri, 01 Oct 2010 16:34:15 -0700
Subject: [PATCH 4/8] omap: pandora: enable twl4030 charger
In-Reply-To: <20101001233315.31894.49599.stgit@baageli.muru.com>
References: <20101001233315.31894.49599.stgit@baageli.muru.com>
Message-ID: <20101001233415.31894.50639.stgit@baageli.muru.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Grazvydas Ignotas <notasas@gmail.com>

Add platform data to make use of newly added charging driver.

Signed-off-by: Grazvydas Ignotas <notasas@gmail.com>
Signed-off-by: Tony Lindgren <tony@atomide.com>
---
 arch/arm/mach-omap2/board-omap3pandora.c |    3 +++
 1 files changed, 3 insertions(+), 0 deletions(-)

diff --git a/arch/arm/mach-omap2/board-omap3pandora.c b/arch/arm/mach-omap2/board-omap3pandora.c
index 7c222ba..7192635 100644
--- a/arch/arm/mach-omap2/board-omap3pandora.c
+++ b/arch/arm/mach-omap2/board-omap3pandora.c
@@ -533,6 +533,8 @@ static struct twl4030_codec_data omap3pandora_codec_data = {
 	.audio = &omap3pandora_audio_data,
 };
 
+static struct twl4030_bci_platform_data pandora_bci_data;
+
 static struct twl4030_platform_data omap3pandora_twldata = {
 	.irq_base	= TWL4030_IRQ_BASE,
 	.irq_end	= TWL4030_IRQ_END,
@@ -548,6 +550,7 @@ static struct twl4030_platform_data omap3pandora_twldata = {
 	.vaux4		= &pandora_vaux4,
 	.vsim		= &pandora_vsim,
 	.keypad		= &pandora_kp_data,
+	.bci		= &pandora_bci_data,
 };
 
 static struct i2c_board_info __initdata omap3pandora_i2c_boardinfo[] = {
