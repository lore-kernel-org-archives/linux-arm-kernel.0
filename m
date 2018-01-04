From: ryder.lee@mediatek.com (Ryder Lee)
Date: Thu, 4 Jan 2018 15:44:21 +0800
Subject: [PATCH v1 5/6] clk: mediatek: update missing clock data for MT7622
 audsys
In-Reply-To: <cover.1515038387.git.ryder.lee@mediatek.com>
References: <cover.1515038387.git.ryder.lee@mediatek.com>
Message-ID: <296e97ad8720d575918657e821bb2a01a2d31c49.1515038387.git.ryder.lee@mediatek.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Add missing clock data 'CLK_AUDIO_AFE_CONN' for MT7622 audsys.

Signed-off-by: Ryder Lee <ryder.lee@mediatek.com>
---
 drivers/clk/mediatek/clk-mt7622-aud.c  | 3 ++-
 include/dt-bindings/clock/mt7622-clk.h | 3 ++-
 2 files changed, 4 insertions(+), 2 deletions(-)

diff --git a/drivers/clk/mediatek/clk-mt7622-aud.c b/drivers/clk/mediatek/clk-mt7622-aud.c
index fad7d9f..96959ad 100644
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
@@ -146,7 +147,7 @@ static int clk_mt7622_audiosys_init(struct platform_device *pdev)
 	clk_data = mtk_alloc_clk_data(CLK_AUDIO_NR_CLK);
 
 	mtk_clk_register_gates(node, audio_clks, ARRAY_SIZE(audio_clks),
-			       clk_data);
+				   clk_data);
 
 	r = of_clk_add_provider(node, of_clk_src_onecell_get, clk_data);
 	if (r)
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
