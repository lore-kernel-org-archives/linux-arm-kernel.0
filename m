From: djkurtz@chromium.org (Daniel Kurtz)
Date: Fri, 24 Jul 2015 17:00:13 +0800
Subject: [PATCH v6 1/3] dt-bindings: pwm: add MediaTek display PWM bindings
In-Reply-To: <8769951.Y5Edyg2WDJ@ubix>
References: <1437380237-28961-1-git-send-email-yh.huang@mediatek.com>
 <1437380237-28961-2-git-send-email-yh.huang@mediatek.com>
 <8769951.Y5Edyg2WDJ@ubix>
Message-ID: <CAGS+omAzhfCAoGArK8XUMhNFuqiErPcvGh0q=+Se1dHeBnJyUg@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Jul 24, 2015 at 4:40 PM, Matthias Brugger
<matthias.bgg@gmail.com> wrote:
> On Monday, July 20, 2015 04:17:15 PM YH Huang wrote:
>> Document the device-tree binding of MediatTek display PWM.
>> The PWM has one channel to control the backlight brightness for display.
>> It supports MT8173 and MT6595.
>>
>> Signed-off-by: YH Huang <yh.huang@mediatek.com>
>> ---
>>  .../devicetree/bindings/pwm/pwm-mtk-disp.txt       | 42
>> ++++++++++++++++++++++ 1 file changed, 42 insertions(+)
>>  create mode 100644 Documentation/devicetree/bindings/pwm/pwm-mtk-disp.txt
>>
>> diff --git a/Documentation/devicetree/bindings/pwm/pwm-mtk-disp.txt
>> b/Documentation/devicetree/bindings/pwm/pwm-mtk-disp.txt new file mode
>> 100644
>> index 0000000..f8f59ba
>> --- /dev/null
>> +++ b/Documentation/devicetree/bindings/pwm/pwm-mtk-disp.txt
>> @@ -0,0 +1,42 @@
>> +MediaTek display PWM controller
>> +
>> +Required properties:
>> + - compatible: should be "mediatek,<name>-disp-pwm":
>> +   - "mediatek,mt8173-disp-pwm": found on mt8173 SoC.
>> +   - "mediatek,mt6595-disp-pwm": found on mt6595 SoC.
>
> I had another look on the mt6589 datasheet and for me it doesn't look like as
> if this drivers is compatible to mt6589.

Matthias - the compatible is "mt6595", not mt6589 :-).
Which datasheet did you check?

-Dan


>
> DISP_PWM_CON_0 offset 0x10 maps to interrupt enable register and
> DISP_PWM_CON_1 offset 0x14 maps to interrupt status register.
>
> This looks wrong to me, as you use both registers to write clock divider and
> clock period.
>
> Regarding that this is v6 of the patch set, I would propose that you just drop
> the compatible string for mt6589 or you implement the register offset on basis
> of the compatible string so that mt6589 can you the driver as well.
>
> Best regards,
> Matthias
> --
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo at vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
