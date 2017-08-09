From: jeffy.chen@rock-chips.com (Jeffy Chen)
Date: Wed,  9 Aug 2017 20:19:39 +0800
Subject: [PATCH 3/3] dt-bindings: ASoC: rockchip: Add rockchip,
 codec-names property
In-Reply-To: <1502281179-15916-1-git-send-email-jeffy.chen@rock-chips.com>
References: <1502281179-15916-1-git-send-email-jeffy.chen@rock-chips.com>
Message-ID: <1502281179-15916-4-git-send-email-jeffy.chen@rock-chips.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Add a new rockchip,codec-names property, so that the driver can parse
the codecs by name.

Signed-off-by: Jeffy Chen <jeffy.chen@rock-chips.com>
---

 Documentation/devicetree/bindings/sound/rockchip,rk3399-gru-sound.txt | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/Documentation/devicetree/bindings/sound/rockchip,rk3399-gru-sound.txt b/Documentation/devicetree/bindings/sound/rockchip,rk3399-gru-sound.txt
index eac91db..aa951a7 100644
--- a/Documentation/devicetree/bindings/sound/rockchip,rk3399-gru-sound.txt
+++ b/Documentation/devicetree/bindings/sound/rockchip,rk3399-gru-sound.txt
@@ -11,6 +11,7 @@ Optional properties:
   If this option is specified, which means it's required dmic need
   delay for DMIC to ready so that rt5514 can avoid recording before
   DMIC send valid data
+- rockchip,codec-names: The names of the MAX98357A/RT5514/DA7219 codecs
 
 Example:
 
@@ -18,5 +19,6 @@ sound {
 	compatible = "rockchip,rk3399-gru-sound";
 	rockchip,cpu = <&i2s0>;
 	rockchip,codec = <&max98357a &rt5514 &da7219>;
+	rockchip,codec-names = "MAX98357A", "RT5514", "DA7219";
 	dmic-wakeup-delay-ms = <20>;
 };
-- 
2.1.4
