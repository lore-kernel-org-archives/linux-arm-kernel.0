From: nsekhar@ti.com (Sekhar Nori)
Date: Wed, 10 Apr 2013 14:57:12 +0530
Subject: [PATCH 1/4] ARM: davinci: da850 evm: fix const qualifier placement
In-Reply-To: <1365586035-26583-1-git-send-email-nsekhar@ti.com>
References: <1365586035-26583-1-git-send-email-nsekhar@ti.com>
Message-ID: <1365586035-26583-2-git-send-email-nsekhar@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

const qualifier was misplaced in couple of definitions.
This fixes the sparse error:

  CHECK   arch/arm/mach-davinci/board-mityomapl138.c
arch/arm/mach-davinci/board-da850-evm.c:404:19: error: Just how const do you want this type to be?
arch/arm/mach-davinci/board-da850-evm.c:568:19: error: Just how const do you want this type to be?

Signed-off-by: Sekhar Nori <nsekhar@ti.com>
---
 arch/arm/mach-davinci/board-da850-evm.c |    4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/arm/mach-davinci/board-da850-evm.c b/arch/arm/mach-davinci/board-da850-evm.c
index c2dfe06..1f597b3 100644
--- a/arch/arm/mach-davinci/board-da850-evm.c
+++ b/arch/arm/mach-davinci/board-da850-evm.c
@@ -401,7 +401,7 @@ enum da850_evm_ui_exp_pins {
 	DA850_EVM_UI_EXP_PB1,
 };
 
-static const char const *da850_evm_ui_exp[] = {
+static const char * const da850_evm_ui_exp[] = {
 	[DA850_EVM_UI_EXP_SEL_C]        = "sel_c",
 	[DA850_EVM_UI_EXP_SEL_B]        = "sel_b",
 	[DA850_EVM_UI_EXP_SEL_A]        = "sel_a",
@@ -565,7 +565,7 @@ enum da850_evm_bb_exp_pins {
 	DA850_EVM_BB_EXP_USER_SW8
 };
 
-static const char const *da850_evm_bb_exp[] = {
+static const char * const da850_evm_bb_exp[] = {
 	[DA850_EVM_BB_EXP_DEEP_SLEEP_EN]	= "deep_sleep_en",
 	[DA850_EVM_BB_EXP_SW_RST]		= "sw_rst",
 	[DA850_EVM_BB_EXP_TP_23]		= "tp_23",
-- 
1.7.10.1
