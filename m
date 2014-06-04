From: robherring2@gmail.com (Rob Herring)
Date: Wed, 4 Jun 2014 06:05:40 -0500
Subject: [PATCH v6 2/6] dt-bindings: add mtk-timer bindings
In-Reply-To: <1401468964-5307-3-git-send-email-matthias.bgg@gmail.com>
References: <1401468964-5307-1-git-send-email-matthias.bgg@gmail.com>
 <1401468964-5307-3-git-send-email-matthias.bgg@gmail.com>
Message-ID: <CAL_Jsq+SkzTsczhh-DWvsktmCVtgNBsBtK3QqK5Am7UxMPgURA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, May 30, 2014 at 11:56 AM, Matthias Brugger
<matthias.bgg@gmail.com> wrote:
> Add binding documentation for the General Porpose Timer driver of
> the Mediatek SoCs.
>
> Signed-off-by: Matthias Brugger <matthias.bgg@gmail.com>

Acked-by: Rob Herring <robh@kernel.org>

but one typo below:

> ---
>  .../bindings/timer/mediatek,mtk-timer.txt          |   18 ++++++++++++++++++
>  1 file changed, 18 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/timer/mediatek,mtk-timer.txt
>
> diff --git a/Documentation/devicetree/bindings/timer/mediatek,mtk-timer.txt b/Documentation/devicetree/bindings/timer/mediatek,mtk-timer.txt
> new file mode 100644
> index 0000000..0558ddd0
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/timer/mediatek,mtk-timer.txt
> @@ -0,0 +1,18 @@
> +Mediatek MT6577, MT6572 and MT6589 Timers
> +---------------------------------------
> +
> +Required properties:
> +- compatible: Should be "mediatek,mt6577-timer"
> +- reg: Should contain location and length for timers register.
> +- clocks: Clocks driving the timer hardware. This list shoud include two

s/shoud/should/

> +       clocks. The order is system clock and as second clock the RTC clock.
> +
> +Examples:
> +
> +       timer at 10008000 {
> +               compatible = "mediatek,mt6577-timer";
> +               reg = <0x10008000 0x80>;
> +               interrupts = <GIC_SPI 113 IRQ_TYPE_LEVEL_LOW>;
> +               clocks = <&system_clk>, <&rtc_clk>;
> +               clock-names = "system-clk", "rtc-clk";
> +       };
> --
> 1.7.9.5
>
