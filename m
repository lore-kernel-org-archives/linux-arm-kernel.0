From: carlo@caione.org (Carlo Caione)
Date: Sun, 29 Mar 2015 12:56:41 +0200
Subject: [PATCH v4 2/3] documentation: Extend pinctrl docs for Meson8b
In-Reply-To: <1427626602-9656-1-git-send-email-carlo@caione.org>
References: <1427626602-9656-1-git-send-email-carlo@caione.org>
Message-ID: <1427626602-9656-3-git-send-email-carlo@caione.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Carlo Caione <carlo@endlessm.com>

Add the compatible string for Meson8b in Meson pinctrl documentation
and add new information for Meson8b in source code comments.

Acked-by: Beniamino Galvani <b.galvani@gmail.com>
Signed-off-by: Carlo Caione <carlo@endlessm.com>
---
 Documentation/devicetree/bindings/pinctrl/meson,pinctrl.txt | 2 +-
 drivers/pinctrl/meson/pinctrl-meson.c                       | 5 +++--
 2 files changed, 4 insertions(+), 3 deletions(-)

diff --git a/Documentation/devicetree/bindings/pinctrl/meson,pinctrl.txt b/Documentation/devicetree/bindings/pinctrl/meson,pinctrl.txt
index 17e7240..3f6a524 100644
--- a/Documentation/devicetree/bindings/pinctrl/meson,pinctrl.txt
+++ b/Documentation/devicetree/bindings/pinctrl/meson,pinctrl.txt
@@ -1,7 +1,7 @@
 == Amlogic Meson pinmux controller ==
 
 Required properties for the root node:
- - compatible: "amlogic,meson8-pinctrl"
+ - compatible: "amlogic,meson8-pinctrl" or "amlogic,meson8b-pinctrl"
  - reg: address and size of registers controlling irq functionality
 
 === GPIO sub-nodes ===
diff --git a/drivers/pinctrl/meson/pinctrl-meson.c b/drivers/pinctrl/meson/pinctrl-meson.c
index a2bf49c..e0195c1 100644
--- a/drivers/pinctrl/meson/pinctrl-meson.c
+++ b/drivers/pinctrl/meson/pinctrl-meson.c
@@ -13,8 +13,9 @@
 
 /*
  * The available pins are organized in banks (A,B,C,D,E,X,Y,Z,AO,
- * BOOT,CARD for meson6 and X,Y,DV,H,Z,AO,BOOT,CARD for meson8) and
- * each bank has a variable number of pins.
+ * BOOT,CARD for meson6, X,Y,DV,H,Z,AO,BOOT,CARD for meson8 and
+ * X,Y,DV,H,AO,BOOT,CARD,DIF for meson8b) and each bank has a
+ * variable number of pins.
  *
  * The AO bank is special because it belongs to the Always-On power
  * domain which can't be powered off; the bank also uses a set of
-- 
1.9.1
