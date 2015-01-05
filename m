From: wangnan0@huawei.com (Wang Nan)
Date: Mon, 5 Jan 2015 19:29:14 +0800
Subject: [PATCH v19 02/11] ARM: kprobes: remove unused ARM decoder actions.
In-Reply-To: <1420457284-76923-1-git-send-email-wangnan0@huawei.com>
References: <1420457284-76923-1-git-send-email-wangnan0@huawei.com>
Message-ID: <1420457354-77099-1-git-send-email-wangnan0@huawei.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

There are 3 actions which is never used:

 PROBES_MOV_HALFWORD,
 PROBES_SEV,
 PROBES_WFE,

This patch removes them.

Signed-off-by: Wang Nan <wangnan0@huawei.com>
---
 arch/arm/probes/decode-arm.h          | 3 ---
 arch/arm/probes/kprobes/actions-arm.c | 3 ---
 arch/arm/probes/uprobes/actions-arm.c | 3 ---
 3 files changed, 9 deletions(-)

diff --git a/arch/arm/probes/decode-arm.h b/arch/arm/probes/decode-arm.h
index 9c56b40..f0dbc5a 100644
--- a/arch/arm/probes/decode-arm.h
+++ b/arch/arm/probes/decode-arm.h
@@ -38,9 +38,6 @@ enum probes_arm_action {
 	PROBES_MOV_IP_SP,
 	PROBES_DATA_PROCESSING_REG,
 	PROBES_DATA_PROCESSING_IMM,
-	PROBES_MOV_HALFWORD,
-	PROBES_SEV,
-	PROBES_WFE,
 	PROBES_SATURATE,
 	PROBES_REV,
 	PROBES_MMI,
diff --git a/arch/arm/probes/kprobes/actions-arm.c b/arch/arm/probes/kprobes/actions-arm.c
index 8797879..099aeb0 100644
--- a/arch/arm/probes/kprobes/actions-arm.c
+++ b/arch/arm/probes/kprobes/actions-arm.c
@@ -325,9 +325,6 @@ const union decode_action kprobes_arm_actions[NUM_PROBES_ARM_ACTIONS] = {
 		.handler = emulate_rd12rn16rm0rs8_rwflags},
 	[PROBES_DATA_PROCESSING_IMM] = {
 		.handler = emulate_rd12rn16rm0rs8_rwflags},
-	[PROBES_MOV_HALFWORD] = {.handler = emulate_rd12rm0_noflags_nopc},
-	[PROBES_SEV] = {.handler = probes_emulate_none},
-	[PROBES_WFE] = {.handler = probes_simulate_nop},
 	[PROBES_SATURATE] = {.handler = emulate_rd12rn16rm0_rwflags_nopc},
 	[PROBES_REV] = {.handler = emulate_rd12rm0_noflags_nopc},
 	[PROBES_MMI] = {.handler = emulate_rd12rn16rm0_rwflags_nopc},
diff --git a/arch/arm/probes/uprobes/actions-arm.c b/arch/arm/probes/uprobes/actions-arm.c
index 1dd4916..6a271d6 100644
--- a/arch/arm/probes/uprobes/actions-arm.c
+++ b/arch/arm/probes/uprobes/actions-arm.c
@@ -217,9 +217,6 @@ const union decode_action uprobes_probes_actions[] = {
 		.decoder = decode_rd12rn16rm0rs8_rwflags},
 	[PROBES_DATA_PROCESSING_IMM] = {
 		.decoder = decode_rd12rn16rm0rs8_rwflags},
-	[PROBES_MOV_HALFWORD] = {.handler = probes_simulate_nop},
-	[PROBES_SEV] = {.handler = probes_simulate_nop},
-	[PROBES_WFE] = {.handler = probes_simulate_nop},
 	[PROBES_SATURATE] = {.handler = probes_simulate_nop},
 	[PROBES_REV] = {.handler = probes_simulate_nop},
 	[PROBES_MMI] = {.handler = probes_simulate_nop},
-- 
1.8.4
