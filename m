From: sergei.shtylyov@cogentembedded.com (Sergei Shtylyov)
Date: Sat, 27 Jul 2013 03:46:33 +0400
Subject: [PATCH] ARM: shmobile: BOCK-W: fix SDHI0 PFC settings
Message-ID: <201307270346.34002.sergei.shtylyov@cogentembedded.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The following message is printed on the BOCK-W kernel bootup: 

sh-pfc pfc-r8a7778: invalid group "sdhi0" for function "sdhi0" 

In addition, SD card cannot be detected.  The reason is apparently that commit
ca7bb309485e4ec89a9addd47bea (ARM: shmobile: bockw: add SDHI0 support) matched
the previous version of commit 564617d2f92473031d035deb273da5 (sh-pfc: r8a7778:
add SDHI support).

Add the missing pin groups according to the BOCK-W board schematics.

Signed-off-by: Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>

---
The patch is atop of Simon's 'renesas.git' repo, 'renesas-devel-20130726' tag.

 arch/arm/mach-shmobile/board-bockw.c |    8 +++++++-
 1 file changed, 7 insertions(+), 1 deletion(-)

Index: renesas/arch/arm/mach-shmobile/board-bockw.c
===================================================================
--- renesas.orig/arch/arm/mach-shmobile/board-bockw.c
+++ renesas/arch/arm/mach-shmobile/board-bockw.c
@@ -167,7 +167,13 @@ static const struct pinctrl_map bockw_pi
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
