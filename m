From: maxime.ripard@free-electrons.com (Maxime Ripard)
Date: Sat, 26 Apr 2014 18:03:51 +0200
Subject: [RFC 2/5] clk: berlin: add berlin clock groups DT bindings
 documentation
In-Reply-To: <1398456024-27876-4-git-send-email-alexandre.belloni@free-electrons.com>
References: <1398456024-27876-1-git-send-email-alexandre.belloni@free-electrons.com>
 <1398456024-27876-4-git-send-email-alexandre.belloni@free-electrons.com>
Message-ID: <20140426160351.GE24905@lukather>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Apr 25, 2014 at 10:00:21PM +0200, Alexandre Belloni wrote:
> Document the device tree for the clocks sharing a common set of registers
> 
> Signed-off-by: Alexandre Belloni <alexandre.belloni@free-electrons.com>
> ---
> Cc: devicetree at vger.kernel.org
>  .../devicetree/bindings/clock/berlin-clock.txt     | 29 ++++++++++++++++++++++
>  1 file changed, 29 insertions(+)
> 
> diff --git a/Documentation/devicetree/bindings/clock/berlin-clock.txt b/Documentation/devicetree/bindings/clock/berlin-clock.txt
> index 49bc229827a0..6d374066d6b9 100644
> --- a/Documentation/devicetree/bindings/clock/berlin-clock.txt
> +++ b/Documentation/devicetree/bindings/clock/berlin-clock.txt
> @@ -11,10 +11,18 @@ Required properties:
>  		CPU PLL and System PLL
>  	"marvell,berlin2-clk":
>  		simple clocks
> +	"marvell,berlin2-clkgrp":
> +		clocks sharing a common set of registers
>  - reg: Address and length of the clock register set.

Judging from your code, you expect two arrays in reg. You should
document it and in which order you expect them.

Also, you'd probably want to use reg-names, which is much more
flexible from a DT point of view.

>  - #clock-cells: from common clock binding; shall be set to 0.
>  - clocks: from common clock binding
>  
> +For the clock groups:
> +- marvell,clk-switch-offset: offset in bits to the first bit related to the
> +  clock in the switch registers
> +- marvell,clk-select-offset: offset in bits to the first bit related to the
> +  clock in the selection registers.

Encoding bit offsets and/or register addresses in the DT is usually a
bad idea. You should more likely use different compatibles here.

Maxime

-- 
Maxime Ripard, Free Electrons
Embedded Linux, Kernel and Android engineering
http://free-electrons.com
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 836 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20140426/9c293463/attachment-0001.sig>
