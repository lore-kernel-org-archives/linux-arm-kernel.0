From: linux@rasmusvillemoes.dk (Rasmus Villemoes)
Date: Tue, 21 Oct 2014 16:53:31 +0200
Subject: [PATCH] ARM: davinci: Remove redundant casts
Message-ID: <1413903211-3143-1-git-send-email-linux@rasmusvillemoes.dk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

These casts to char* are unnecessary and slightly confusing, since
both operands actually have type const char*.

Signed-off-by: Rasmus Villemoes <linux@rasmusvillemoes.dk>
---
 arch/arm/mach-davinci/board-da850-evm.c | 9 +++------
 1 file changed, 3 insertions(+), 6 deletions(-)

diff --git a/arch/arm/mach-davinci/board-da850-evm.c b/arch/arm/mach-davinci/board-da850-evm.c
index fa11415..6b5a97d 100644
--- a/arch/arm/mach-davinci/board-da850-evm.c
+++ b/arch/arm/mach-davinci/board-da850-evm.c
@@ -452,8 +452,7 @@ static void da850_evm_ui_keys_init(unsigned gpio)
 	for (i = 0; i < DA850_N_UI_PB; i++) {
 		button = &da850_evm_ui_keys[i];
 		button->code = KEY_F8 - i;
-		button->desc = (char *)
-				da850_evm_ui_exp[DA850_EVM_UI_EXP_PB8 + i];
+		button->desc = da850_evm_ui_exp[DA850_EVM_UI_EXP_PB8 + i];
 		button->gpio = gpio + DA850_EVM_UI_EXP_PB8 + i;
 	}
 }
@@ -628,15 +627,13 @@ static void da850_evm_bb_keys_init(unsigned gpio)
 	struct gpio_keys_button *button;
 
 	button = &da850_evm_bb_keys[0];
-	button->desc = (char *)
-		da850_evm_bb_exp[DA850_EVM_BB_EXP_USER_PB1];
+	button->desc = da850_evm_bb_exp[DA850_EVM_BB_EXP_USER_PB1];
 	button->gpio = gpio + DA850_EVM_BB_EXP_USER_PB1;
 
 	for (i = 0; i < DA850_N_BB_USER_SW; i++) {
 		button = &da850_evm_bb_keys[i + 1];
 		button->code = SW_LID + i;
-		button->desc = (char *)
-				da850_evm_bb_exp[DA850_EVM_BB_EXP_USER_SW1 + i];
+		button->desc = da850_evm_bb_exp[DA850_EVM_BB_EXP_USER_SW1 + i];
 		button->gpio = gpio + DA850_EVM_BB_EXP_USER_SW1 + i;
 	}
 }
-- 
2.0.4
