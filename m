From: mcuelenaere@gmail.com (Maurus Cuelenaere)
Date: Fri, 11 Jun 2010 21:48:56 +0200
Subject: [PATCH 4/9] ARM: S3C64XX: Add support for secur clock
In-Reply-To: <cover.1276284559.git.mcuelenaere@gmail.com>
References: <cover.1276284559.git.mcuelenaere@gmail.com>
Message-ID: <4C129328.7090400@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patch adds correct register definitions for the secur clock, used by the
Samsung crypto engine.

Signed-off-by: Maurus Cuelenaere <mcuelenaere@gmail.com>
---
 arch/arm/mach-s3c64xx/clock.c |    9 +++++++++
 1 files changed, 9 insertions(+), 0 deletions(-)

diff --git a/arch/arm/mach-s3c64xx/clock.c b/arch/arm/mach-s3c64xx/clock.c
index d3e11a1..8cbe949 100644
--- a/arch/arm/mach-s3c64xx/clock.c
+++ b/arch/arm/mach-s3c64xx/clock.c
@@ -716,6 +716,15 @@ static struct clksrc_clk clksrcs[] = {
 		.reg_div	= { .reg = S3C_CLK_DIV0, .shift = 20, .size = 4  },
 		.reg_src	= { .reg = NULL, .shift = 0, .size = 0  },
 		.sources	= &clkset_camif,
+	},  {
+		.clk	= {
+			.name		= "secur",
+			.id		= -1,
+			.ctrlbit	= S3C_CLKCON_SCLK_SECUR,
+			.enable		= s3c64xx_sclk_ctrl,
+			.parent		= &clk_h2,
+		},
+		.reg_div	= { .reg = S3C_CLK_DIV0, .shift = 18, .size = 2 },
 	},
 };
 
-- 
1.7.1
