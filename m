From: sergei.shtylyov@cogentembedded.com (Sergei Shtylyov)
Date: Sat, 7 Sep 2013 04:31:35 +0400
Subject: [PATCH v2 4/4] ARM: shmobile: BOCK-W reference: add Ether PFC settings
In-Reply-To: <201309070423.30672.sergei.shtylyov@cogentembedded.com>
References: <201309070423.30672.sergei.shtylyov@cogentembedded.com>
Message-ID: <201309070431.35908.sergei.shtylyov@cogentembedded.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Add the Ether pin group to bockw_pinctrl_map[].

Signed-off-by: Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>

---
 arch/arm/mach-shmobile/board-bockw-reference.c |    3 +++
 1 file changed, 3 insertions(+)

Index: renesas/arch/arm/mach-shmobile/board-bockw-reference.c
===================================================================
--- renesas.orig/arch/arm/mach-shmobile/board-bockw-reference.c
+++ renesas/arch/arm/mach-shmobile/board-bockw-reference.c
@@ -29,6 +29,9 @@
  */
 
 static const struct pinctrl_map bockw_pinctrl_map[] = {
+	/* Ether */
+	PIN_MAP_MUX_GROUP_DEFAULT("fde00000.ethernet", "pfc-r8a7778",
+				  "ether_rmii", "ether"),
 	/* SCIF0 */
 	PIN_MAP_MUX_GROUP_DEFAULT("sh-sci.0", "pfc-r8a7778",
 				  "scif0_data_a", "scif0"),
