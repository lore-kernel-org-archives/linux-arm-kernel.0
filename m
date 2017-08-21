From: sugar.zhang@rock-chips.com (Sugar Zhang)
Date: Mon, 21 Aug 2017 16:25:07 +0800
Subject: [PATCH v2 2/2] ASoC: rockchip: separate pinctrl pins from each other
In-Reply-To: <1503303907-57630-1-git-send-email-sugar.zhang@rock-chips.com>
References: <1503303907-57630-1-git-send-email-sugar.zhang@rock-chips.com>
Message-ID: <1503303907-57630-3-git-send-email-sugar.zhang@rock-chips.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

pdm sdi0~3 pins are optional, for example, if 4ch required,
only sdi0~1 need to be enabled.

Signed-off-by: Sugar Zhang <sugar.zhang@rock-chips.com>
---

Changes in v2: None

 Documentation/devicetree/bindings/sound/rockchip,pdm.txt | 7 +++++--
 1 file changed, 5 insertions(+), 2 deletions(-)

diff --git a/Documentation/devicetree/bindings/sound/rockchip,pdm.txt b/Documentation/devicetree/bindings/sound/rockchip,pdm.txt
index 921729d..2ad66f6 100644
--- a/Documentation/devicetree/bindings/sound/rockchip,pdm.txt
+++ b/Documentation/devicetree/bindings/sound/rockchip,pdm.txt
@@ -29,11 +29,14 @@ pdm: pdm at ff040000 {
 	dma-names = "rx";
 	pinctrl-names = "default", "sleep";
 	pinctrl-0 = <&pdmm0_clk
-		     &pdmm0_fsync
 		     &pdmm0_sdi0
 		     &pdmm0_sdi1
 		     &pdmm0_sdi2
 		     &pdmm0_sdi3>;
-	pinctrl-1 = <&pdmm0_sleep>;
+	pinctrl-1 = <&pdmm0_clk_sleep
+		     &pdmm0_sdi0_sleep
+		     &pdmm0_sdi1_sleep
+		     &pdmm0_sdi2_sleep
+		     &pdmm0_sdi3_sleep>;
 	status = "disabled";
 };
-- 
2.7.4
