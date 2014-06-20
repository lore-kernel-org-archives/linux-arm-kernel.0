From: mark.rutland@arm.com (Mark Rutland)
Date: Fri, 20 Jun 2014 13:36:02 +0100
Subject: [PATCH v9 3/3] dt-bindings: add mtk-timer bindings
In-Reply-To: <1403264929-21325-4-git-send-email-matthias.bgg@gmail.com>
References: <1403264929-21325-1-git-send-email-matthias.bgg@gmail.com>
 <1403264929-21325-4-git-send-email-matthias.bgg@gmail.com>
Message-ID: <20140620123602.GK30188@leverpostej>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Jun 20, 2014 at 12:48:49PM +0100, Matthias Brugger wrote:
> Add binding documentation for the General Porpose Timer driver of
> the Mediatek SoCs.
> 
> Signed-off-by: Matthias Brugger <matthias.bgg@gmail.com>
> Acked-by: S?ren Brinkmann <soren.brinkmann@xilinx.com>
> Acked-by: Rob Herring <robh@kernel.org>
> ---
>  .../bindings/timer/mediatek,mtk-timer.txt          |   18 ++++++++++++++++++
>  1 file changed, 18 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/timer/mediatek,mtk-timer.txt
> 
> diff --git a/Documentation/devicetree/bindings/timer/mediatek,mtk-timer.txt b/Documentation/devicetree/bindings/timer/mediatek,mtk-timer.txt
> new file mode 100644
> index 0000000..10b7e09
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/timer/mediatek,mtk-timer.txt
> @@ -0,0 +1,18 @@
> +Mediatek MT6577, MT6572 and MT6589 Timers
> +---------------------------------------
> +
> +Required properties:
> +- compatible: Should be "mediatek,mt6577-timer"
> +- reg: Should contain location and length for timers register.
> +- clocks: Clocks driving the timer hardware. This list should include two
> +	clocks. The order is system clock and as second clock the RTC clock.
> +
> +Examples:
> +
> +	timer at 10008000 {
> +		compatible = "mediatek,mt6577-timer";
> +		reg = <0x10008000 0x80>;
> +		interrupts = <GIC_SPI 113 IRQ_TYPE_LEVEL_LOW>;
> +		clocks = <&system_clk>, <&rtc_clk>;
> +		clock-names = "system-clk", "rtc-clk";

These names should be mentioned above, or removed.

This looks fine otherwise.

Mark.
