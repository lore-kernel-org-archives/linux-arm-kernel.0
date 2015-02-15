From: ykaneko0929@gmail.com (Yoshihiro Kaneko)
Date: Sun, 15 Feb 2015 23:49:04 +0900
Subject: [PATCH/RFC] ARM: shmobile: lager: Fix audio clk master to SSI and
 change audio data interface format type
Message-ID: <1424011746-3787-1-git-send-email-ykaneko0929@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Biju Das <biju.das@bp.renesas.com>

Signed-off-by: Biju Das <biju.das@bp.renesas.com>
Signed-off-by: Yoshihiro Kaneko <ykaneko0929@gmail.com>
---

This patch is based on devel branch of Simon Horman's renesas tree.

 arch/arm/boot/dts/r8a7790-lager.dts | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/arch/arm/boot/dts/r8a7790-lager.dts b/arch/arm/boot/dts/r8a7790-lager.dts
index 0c3b678..e7dda8a 100644
--- a/arch/arm/boot/dts/r8a7790-lager.dts
+++ b/arch/arm/boot/dts/r8a7790-lager.dts
@@ -177,9 +177,7 @@
 	sound {
 		compatible = "simple-audio-card";
 
-		simple-audio-card,format = "left_j";
-		simple-audio-card,bitclock-master = <&sndcodec>;
-		simple-audio-card,frame-master = <&sndcodec>;
+		simple-audio-card,format = "i2s";
 
 		sndcpu: simple-audio-card,cpu {
 			sound-dai = <&rcar_sound>;
-- 
1.9.1
