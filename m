From: nsekhar@ti.com (Sekhar Nori)
Date: Fri, 11 May 2018 20:51:36 +0530
Subject: [PATCH 3/3] ARM: davinci: board-dm646x-evm: set VPIF capture card name
In-Reply-To: <20180511152136.29515-1-nsekhar@ti.com>
References: <20180511152136.29515-1-nsekhar@ti.com>
Message-ID: <20180511152136.29515-4-nsekhar@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

VPIF capture driver expects card name to be set since it
uses it without checking for NULL. The commit which
introduced VPIF display and capture support added card
name only for display, not for capture.

Set it in platform data to probe driver successfully.

While at it, also fix the display card name to something more
appropriate.

Fixes: 85609c1ccda6 ("DaVinci: DM646x - platform changes for vpif capture and display drivers")
Signed-off-by: Sekhar Nori <nsekhar@ti.com>
---
 arch/arm/mach-davinci/board-dm646x-evm.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/arch/arm/mach-davinci/board-dm646x-evm.c b/arch/arm/mach-davinci/board-dm646x-evm.c
index bf6f85048d17..867ab2fa6cfd 100644
--- a/arch/arm/mach-davinci/board-dm646x-evm.c
+++ b/arch/arm/mach-davinci/board-dm646x-evm.c
@@ -538,7 +538,7 @@ static struct vpif_display_config dm646x_vpif_display_config = {
 		.outputs = dm6467_ch0_outputs,
 		.output_count = ARRAY_SIZE(dm6467_ch0_outputs),
 	},
-	.card_name	= "DM646x EVM",
+	.card_name	= "DM646x EVM Video Display",
 };
 
 /**
@@ -697,6 +697,7 @@ static struct vpif_capture_config dm646x_vpif_capture_cfg = {
 			.fid_pol = 0,
 		},
 	},
+	.card_name = "DM646x EVM Video Capture",
 };
 
 static void __init evm_init_video(void)
-- 
2.16.2
