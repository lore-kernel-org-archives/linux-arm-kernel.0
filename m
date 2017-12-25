From: ryder.lee@mediatek.com (Ryder Lee)
Date: Mon, 25 Dec 2017 16:27:51 +0800
Subject: [PATCH 1/2] clk: mediatek: update clock data for MT7622 audsys
Message-ID: <b36f38f4b9f780529046a3c2c76a1e59561e9ff1.1514190088.git.ryder.lee@mediatek.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Add missing clock gate "CLK_AUDIO_AFE_CONN" for MT7622 audsys.

Signed-off-by: Ryder Lee <ryder.lee@mediatek.com>
---
 drivers/clk/mediatek/clk-mt7622-aud.c  | 1 +
 include/dt-bindings/clock/mt7622-clk.h | 3 ++-
 2 files changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/clk/mediatek/clk-mt7622-aud.c b/drivers/clk/mediatek/clk-mt7622-aud.c
index fad7d9f..13f752d 100644
--- a/drivers/clk/mediatek/clk-mt7622-aud.c
+++ b/drivers/clk/mediatek/clk-mt7622-aud.c
@@ -106,6 +106,7 @@
 	GATE_AUDIO1(CLK_AUDIO_INTDIR, "audio_intdir", "intdir_sel", 20),
 	GATE_AUDIO1(CLK_AUDIO_A1SYS, "audio_a1sys", "a1sys_hp_sel", 21),
 	GATE_AUDIO1(CLK_AUDIO_A2SYS, "audio_a2sys", "a2sys_hp_sel", 22),
+	GATE_AUDIO1(CLK_AUDIO_AFE_CONN, "audio_afe_conn", "a1sys_hp_sel", 23),
 	/* AUDIO2 */
 	GATE_AUDIO2(CLK_AUDIO_UL1, "audio_ul1", "a1sys_hp_sel", 0),
 	GATE_AUDIO2(CLK_AUDIO_UL2, "audio_ul2", "a1sys_hp_sel", 1),
diff --git a/include/dt-bindings/clock/mt7622-clk.h b/include/dt-bindings/clock/mt7622-clk.h
index 3e514ed..e9d77f0 100644
--- a/include/dt-bindings/clock/mt7622-clk.h
+++ b/include/dt-bindings/clock/mt7622-clk.h
@@ -235,7 +235,8 @@
 #define CLK_AUDIO_MEM_ASRC3		43
 #define CLK_AUDIO_MEM_ASRC4		44
 #define CLK_AUDIO_MEM_ASRC5		45
-#define CLK_AUDIO_NR_CLK		46
+#define CLK_AUDIO_AFE_CONN		46
+#define CLK_AUDIO_NR_CLK		47
 
 /* SSUSBSYS */
 
-- 
1.9.1
