From: zhi.mao@mediatek.com (Zhi Mao)
Date: Wed, 21 Jun 2017 16:11:11 +0800
Subject: [PATCH RESEND 3/4] pwm: bindings: add MT2712/MT7622 information
In-Reply-To: <1498032672-7172-1-git-send-email-zhi.mao@mediatek.com>
References: <1498032672-7172-1-git-send-email-zhi.mao@mediatek.com>
Message-ID: <1498032672-7172-4-git-send-email-zhi.mao@mediatek.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

add MT2712/MT7622 pwm information

Signed-off-by: Zhi Mao <zhi.mao@mediatek.com>
---
 .../devicetree/bindings/pwm/pwm-mediatek.txt       |    6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/Documentation/devicetree/bindings/pwm/pwm-mediatek.txt b/Documentation/devicetree/bindings/pwm/pwm-mediatek.txt
index 54c59b0..ef8bd3c 100644
--- a/Documentation/devicetree/bindings/pwm/pwm-mediatek.txt
+++ b/Documentation/devicetree/bindings/pwm/pwm-mediatek.txt
@@ -2,6 +2,8 @@ MediaTek PWM controller
 
 Required properties:
  - compatible: should be "mediatek,<name>-pwm":
+   - "mediatek,mt2712-pwm": found on mt2712 SoC.
+   - "mediatek,mt7622-pwm": found on mt7622 SoC.
    - "mediatek,mt7623-pwm": found on mt7623 SoC.
  - reg: physical base address and length of the controller's registers.
  - #pwm-cells: must be 2. See pwm.txt in this directory for a description of
@@ -10,7 +12,9 @@ Required properties:
  - clock-names: must contain the following:
    - "top": the top clock generator
    - "main": clock used by the PWM core
-   - "pwm1-5": the five per PWM clocks
+   - "pwm1-8": the eight per PWM clocks for mt2712
+   - "pwm1-6": the six per PWM clocks for mt7622
+   - "pwm1-5": the five per PWM clocks for mt7623
  - pinctrl-names: Must contain a "default" entry.
  - pinctrl-0: One property must exist for each entry in pinctrl-names.
    See pinctrl/pinctrl-bindings.txt for details of the property values.
-- 
1.7.9.5
