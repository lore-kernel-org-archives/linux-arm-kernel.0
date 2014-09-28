From: shawn.guo@linaro.org (Shawn Guo)
Date: Sun, 28 Sep 2014 16:58:41 +0800
Subject: [PATCH 3/3] Documentation:spi:fsl-dspi:add DSPI tcf transfer
 support
In-Reply-To: <1411640665-20671-3-git-send-email-b44548@freescale.com>
References: <1411640665-20671-1-git-send-email-b44548@freescale.com>
 <1411640665-20671-3-git-send-email-b44548@freescale.com>
Message-ID: <20140928085839.GB2383@dragon>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Sep 25, 2014 at 06:24:25PM +0800, Chao Fu wrote:
> From: Chao Fu <B44548@freescale.com>
> 
> Add bool value tcfq-mode or eoq-mode.
> The bool will determine DSPI transfer data mode (tcfq or eoq)
> in a platform.
> 
> Signed-off-by: Chao Fu      <b44548@freescale.com>
> ---
>  Documentation/devicetree/bindings/spi/spi-fsl-dspi.txt | 3 +++
>  1 file changed, 3 insertions(+)
> 
> diff --git a/Documentation/devicetree/bindings/spi/spi-fsl-dspi.txt b/Documentation/devicetree/bindings/spi/spi-fsl-dspi.txt
> index cbbe16e..635387c 100644
> --- a/Documentation/devicetree/bindings/spi/spi-fsl-dspi.txt
> +++ b/Documentation/devicetree/bindings/spi/spi-fsl-dspi.txt
> @@ -10,6 +10,8 @@ Required properties:
>  - pinctrl-names: must contain a "default" entry.
>  - spi-num-chipselects : the number of the chipselect signals.
>  - bus-num : the slave chip chipselect signal number.
> +- eoq-mode/tcfq-mode: enable EOQ/TCFQ interrupt to receive data
> +	according to different platform.

Does the "platform" mean board or SoC?  Since I see you specify the
property in SoC level dtsi file, I assume you mean it as SoC.  So here
comes to the question - is it a DSPI property decided by SoC design?
IOW, for given SoC like vf610, which mode should be chosen is decided at
vf610 SoC design time?

You specify eoq-mode in vf610.dtsi.  Does that mean tcfq-mode will not
work on VF610?

Shawn

>  
>  Optional property:
>  - big-endian: If present the dspi device's registers are implemented
> @@ -28,6 +30,7 @@ dspi0 at 4002c000 {
>  	clock-names = "dspi";
>  	spi-num-chipselects = <5>;
>  	bus-num = <0>;
> +	eoq-mode;
>  	pinctrl-names = "default";
>  	pinctrl-0 = <&pinctrl_dspi0_1>;
>  	big-endian;
> -- 
> 1.8.4
> 
