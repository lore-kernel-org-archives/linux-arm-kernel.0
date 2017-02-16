From: broonie@kernel.org (Mark Brown)
Date: Thu, 16 Feb 2017 19:04:51 +0000
Subject: Applied "ASoC: mediatek: add power-domains for mt2701-afe-pcm.txt" to
 the asoc tree
In-Reply-To: <1487222836-21174-3-git-send-email-garlic.tseng@mediatek.com>
Message-ID: <E1ceRMJ-0007hQ-44@debutante>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The patch

   ASoC: mediatek: add power-domains for mt2701-afe-pcm.txt

has been applied to the asoc tree at

   git://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git 

All being well this means that it will be integrated into the linux-next
tree (usually sometime in the next 24 hours) and sent to Linus during
the next merge window (or sooner if it is a bug fix), however if
problems are discovered then the patch may be dropped or reverted.  

You may get further e-mails resulting from automated or manual testing
and review of the tree, please engage with people reporting problems and
send followup patches addressing any issues that are reported if needed.

If any updates are required or you are submitting further changes they
should be sent as incremental updates against current git, existing
patches will not be replaced.

Please add any relevant lists and maintainers to the CCs when replying
to this mail.

Thanks,
Mark

>From ee9dc31962ac7141df6926b8696edf8831dde76c Mon Sep 17 00:00:00 2001
From: Garlic Tseng <garlic.tseng@mediatek.com>
Date: Thu, 16 Feb 2017 13:27:16 +0800
Subject: [PATCH] ASoC: mediatek: add power-domains for mt2701-afe-pcm.txt

This add power-domains for mt2701-afe-pcm

Signed-off-by: Garlic Tseng <garlic.tseng@mediatek.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 Documentation/devicetree/bindings/sound/mt2701-afe-pcm.txt | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/Documentation/devicetree/bindings/sound/mt2701-afe-pcm.txt b/Documentation/devicetree/bindings/sound/mt2701-afe-pcm.txt
index 3e623a724e55..9800a560e0c2 100644
--- a/Documentation/devicetree/bindings/sound/mt2701-afe-pcm.txt
+++ b/Documentation/devicetree/bindings/sound/mt2701-afe-pcm.txt
@@ -4,6 +4,7 @@ Required properties:
 - compatible = "mediatek,mt2701-audio";
 - reg: register location and size
 - interrupts: Should contain AFE interrupt
+- power-domains: should define the power domain
 - clock-names: should have these clock names:
 		"infra_sys_audio_clk",
 		"top_audio_mux1_sel",
@@ -58,6 +59,7 @@ Example:
 		      <0 0x112A0000 0 0x20000>;
 		interrupts = <GIC_SPI 104 IRQ_TYPE_LEVEL_LOW>,
 			     <GIC_SPI 132 IRQ_TYPE_LEVEL_LOW>;
+		power-domains = <&scpsys MT2701_POWER_DOMAIN_IFR_MSC>;
 		clocks = <&infracfg CLK_INFRA_AUDIO>,
 			 <&topckgen CLK_TOP_AUD_MUX1_SEL>,
 			 <&topckgen CLK_TOP_AUD_MUX2_SEL>,
-- 
2.11.0
