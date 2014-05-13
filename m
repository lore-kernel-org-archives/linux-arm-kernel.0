From: soren.brinkmann@xilinx.com (=?utf-8?B?U8O2cmVu?= Brinkmann)
Date: Tue, 13 May 2014 06:08:07 -0700
Subject: [PATCH v3 2/6] dt-bindings: add mtk-timer bindings
In-Reply-To: <1399938570-11356-3-git-send-email-matthias.bgg@gmail.com>
References: <1399938570-11356-1-git-send-email-matthias.bgg@gmail.com>
 <1399938570-11356-3-git-send-email-matthias.bgg@gmail.com>
Message-ID: <2e93c984-96d9-4504-bb9a-672a247fb710@BL2FFO11FD034.protection.gbl>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Matthias,

On Tue, 2014-05-13 at 01:49AM +0200, Matthias Brugger wrote:
> Add binding documentation for the General Porpose Timer driver of
> the Mediatek SoCs.
> 
> Signed-off-by: Matthias Brugger <matthias.bgg@gmail.com>
> ---
>  .../devicetree/bindings/timer/mediatek,mtk-timer.txt   | 18 ++++++++++++++++++
>  1 file changed, 18 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/timer/mediatek,mtk-timer.txt
> 
> diff --git a/Documentation/devicetree/bindings/timer/mediatek,mtk-timer.txt b/Documentation/devicetree/bindings/timer/mediatek,mtk-timer.txt
> new file mode 100644
> index 0000000..d0f2df3
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/timer/mediatek,mtk-timer.txt
> @@ -0,0 +1,18 @@
> +Mediatek MT6589, MT6577 and MT6572 Timers
> +---------------------------------------
> +
> +Required properties:
> +- compatible: Should be "mediatek,mtk6589-timer"
> +- reg: Should contain location and length for timers register.
> +- clocks: phandle to the clock source; the first refers to a 13 MHz fixed
> +		system clock and the second handle to a 32 KHz fixed RTC
> +		clock.

Are these frequencies mandatory to the timer or an implementation
detail of the SOC you're working with? I suspect, it might be possible
to see the same timer in a different SOC implementation with different
frequencies? In that case - or probably in general - the frequencies
should not be part of the binding, IMHO.

> +
> +Examples:
> +
> +	timer {
> +		compatible = "mediatek,mtk6589-timer";
> +		reg = <0x10008000 0x80>;
> +		interrupts = <GIC_SPI 113 IRQ_TYPE_LEVEL_LOW>;
> +		clocks = <&system_clk>, <&rtc_clk>;

Might be just my personal preference, but you could also add the clock-names
property which would relax the ordering requirement a bit and would
clearly  identify the IP's clocks.

	S?ren
