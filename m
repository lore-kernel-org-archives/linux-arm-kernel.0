From: fabrice.gasnier@st.com (Fabrice GASNIER)
Date: Thu,  5 Mar 2015 14:05:06 +0100
Subject: [PATCH v2] ARM: STi: Add STiH410 SoC support
Message-ID: <1425560706-22907-1-git-send-email-fabrice.gasnier@st.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patch adds support to STiH410 SoC.

Please note "st,stih410" is already present in device tree.
The problem is that it is missing the entry in the match table,
and so the L2 cache and other cpus than 0 don't get initialized.

Signed-off-by: Fabrice Gasnier <fabrice.gasnier@st.com>
Acked-by: Maxime Coquelin <maxime.coquelin@st.com>
---
 Documentation/devicetree/bindings/arm/sti.txt | 4 ++++
 arch/arm/mach-sti/board-dt.c                  | 1 +
 2 files changed, 5 insertions(+)

diff --git a/Documentation/devicetree/bindings/arm/sti.txt b/Documentation/devicetree/bindings/arm/sti.txt
index d70ec35..8d27f6b 100644
--- a/Documentation/devicetree/bindings/arm/sti.txt
+++ b/Documentation/devicetree/bindings/arm/sti.txt
@@ -13,6 +13,10 @@ Boards with the ST STiH407 SoC shall have the following properties:
 Required root node property:
 compatible = "st,stih407";
 
+Boards with the ST STiH410 SoC shall have the following properties:
+Required root node property:
+compatible = "st,stih410";
+
 Boards with the ST STiH418 SoC shall have the following properties:
 Required root node property:
 compatible = "st,stih418";
diff --git a/arch/arm/mach-sti/board-dt.c b/arch/arm/mach-sti/board-dt.c
index b067390..b373aca 100644
--- a/arch/arm/mach-sti/board-dt.c
+++ b/arch/arm/mach-sti/board-dt.c
@@ -18,6 +18,7 @@ static const char *stih41x_dt_match[] __initdata = {
 	"st,stih415",
 	"st,stih416",
 	"st,stih407",
+	"st,stih410",
 	"st,stih418",
 	NULL
 };
-- 
1.9.1
