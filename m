From: soren.brinkmann@xilinx.com (=?utf-8?B?U8O2cmVu?= Brinkmann)
Date: Wed, 14 May 2014 10:44:42 -0700
Subject: [PATCH v4 2/6] dt-bindings: add mtk-timer bindings
In-Reply-To: <1400087579-4250-3-git-send-email-matthias.bgg@gmail.com>
References: <1400087579-4250-1-git-send-email-matthias.bgg@gmail.com>
 <1400087579-4250-3-git-send-email-matthias.bgg@gmail.com>
Message-ID: <cebe44ba-c543-4f4a-9aeb-810156fe8250@BN1AFFO11FD036.protection.gbl>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Matthias,

On Wed, 2014-05-14 at 07:12PM +0200, Matthias Brugger wrote:
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
> index 0000000..938adf6
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/timer/mediatek,mtk-timer.txt
> @@ -0,0 +1,18 @@
> +Mediatek MT6589, MT6577 and MT6572 Timers
> +---------------------------------------
> +
> +Required properties:
> +- compatible: Should be "mediatek,mtk6589-timer"

Don't you want compatible strings for the other supported SOCs too?

> +- reg: Should contain location and length for timers register.
> +- clocks: Clocks driving the timer hardware. This list shoud include two
> +	clocks. The order is system clock and as second clock the RTC clock.

Sorry for being pedantic, but we had so many ugly bindings in our vendor
tree. I'm still getting caught up on the clocks. I have the feeling the SOC
has two clocks (system and rtc) which are used to drive this timer,
while the timer probably refers differently to its clock inputs.
If this was the case, the names 'rtc' and 'system' clock are SOC specific
names/implementation details. From the timer perspective it is probably
just important that it receives two clock inputs. Since the timer is
described here and not the SOC, these SOC specific names should
disappear and be replaced with the names the timer IP uses for its input
clocks.

The clock-names should be listed too, probably as optional properties.

> +
> +Examples:
> +
> +	timer {
> +		compatible = "mediatek,mtk6589-timer";
> +		reg = <0x10008000 0x80>;
> +		interrupts = <GIC_SPI 113 IRQ_TYPE_LEVEL_LOW>;
> +		clocks = <&system_clk>, <&rtc_clk>;
> +		clock-names = "system-clk", "rtc-clk";


	S?ren
