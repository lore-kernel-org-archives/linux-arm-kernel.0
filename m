From: matthias.bgg@gmail.com (Matthias Brugger)
Date: Fri, 24 Jul 2015 10:40:31 +0200
Subject: [PATCH v6 1/3] dt-bindings: pwm: add MediaTek display PWM bindings
In-Reply-To: <1437380237-28961-2-git-send-email-yh.huang@mediatek.com>
References: <1437380237-28961-1-git-send-email-yh.huang@mediatek.com>
 <1437380237-28961-2-git-send-email-yh.huang@mediatek.com>
Message-ID: <8769951.Y5Edyg2WDJ@ubix>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Monday, July 20, 2015 04:17:15 PM YH Huang wrote:
> Document the device-tree binding of MediatTek display PWM.
> The PWM has one channel to control the backlight brightness for display.
> It supports MT8173 and MT6595.
> 
> Signed-off-by: YH Huang <yh.huang@mediatek.com>
> ---
>  .../devicetree/bindings/pwm/pwm-mtk-disp.txt       | 42
> ++++++++++++++++++++++ 1 file changed, 42 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/pwm/pwm-mtk-disp.txt
> 
> diff --git a/Documentation/devicetree/bindings/pwm/pwm-mtk-disp.txt
> b/Documentation/devicetree/bindings/pwm/pwm-mtk-disp.txt new file mode
> 100644
> index 0000000..f8f59ba
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/pwm/pwm-mtk-disp.txt
> @@ -0,0 +1,42 @@
> +MediaTek display PWM controller
> +
> +Required properties:
> + - compatible: should be "mediatek,<name>-disp-pwm":
> +   - "mediatek,mt8173-disp-pwm": found on mt8173 SoC.
> +   - "mediatek,mt6595-disp-pwm": found on mt6595 SoC.

I had another look on the mt6589 datasheet and for me it doesn't look like as 
if this drivers is compatible to mt6589.

DISP_PWM_CON_0 offset 0x10 maps to interrupt enable register and 
DISP_PWM_CON_1 offset 0x14 maps to interrupt status register.

This looks wrong to me, as you use both registers to write clock divider and 
clock period.

Regarding that this is v6 of the patch set, I would propose that you just drop 
the compatible string for mt6589 or you implement the register offset on basis 
of the compatible string so that mt6589 can you the driver as well.

Best regards,
Matthias
