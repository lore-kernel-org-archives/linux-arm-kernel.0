From: horms+renesas@verge.net.au (Simon Horman)
Date: Wed, 31 Jul 2013 10:33:51 +0900
Subject: [PATCH 3/4] ARM: shmobile: BOCK-W: fix SDHI0 PFC settings
In-Reply-To: <cover.1375234088.git.horms+renesas@verge.net.au>
References: <cover.1375234088.git.horms+renesas@verge.net.au>
Message-ID: <fa3e0cee12fbdd9e0b03470b2b8cf968f537c161.1375234088.git.horms+renesas@verge.net.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>

The following message is printed on the BOCK-W kernel bootup:

sh-pfc pfc-r8a7778: invalid group "sdhi0" for function "sdhi0"

In addition, SD card cannot be detected.  The reason is apparently that commit
ca7bb309485e4ec89a9addd47bea (ARM: shmobile: bockw: add SDHI0 support) matched
the previous version of commit 564617d2f92473031d035deb273da5 (sh-pfc: r8a7778:
add SDHI support).

Add the missing pin groups according to the BOCK-W board schematics.

Signed-off-by: Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>
Acked-by: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Signed-off-by: Simon Horman <horms+renesas@verge.net.au>
---
 arch/arm/mach-shmobile/board-bockw.c | 8 +++++++-
 1 file changed, 7 insertions(+), 1 deletion(-)

diff --git a/arch/arm/mach-shmobile/board-bockw.c b/arch/arm/mach-shmobile/board-bockw.c
index d555464..3354a85 100644
--- a/arch/arm/mach-shmobile/board-bockw.c
+++ b/arch/arm/mach-shmobile/board-bockw.c
@@ -167,7 +167,13 @@ static const struct pinctrl_map bockw_pinctrl_map[] = {
 				  "usb1", "usb1"),
 	/* SDHI0 */
 	PIN_MAP_MUX_GROUP_DEFAULT("sh_mobile_sdhi.0", "pfc-r8a7778",
-				  "sdhi0", "sdhi0"),
+				  "sdhi0_data4", "sdhi0"),
+	PIN_MAP_MUX_GROUP_DEFAULT("sh_mobile_sdhi.0", "pfc-r8a7778",
+				  "sdhi0_ctrl", "sdhi0"),
+	PIN_MAP_MUX_GROUP_DEFAULT("sh_mobile_sdhi.0", "pfc-r8a7778",
+				  "sdhi0_cd", "sdhi0"),
+	PIN_MAP_MUX_GROUP_DEFAULT("sh_mobile_sdhi.0", "pfc-r8a7778",
+				  "sdhi0_wp", "sdhi0"),
 };
 
 #define FPGA	0x18200000
-- 
1.8.3.2
