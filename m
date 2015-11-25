From: robh@kernel.org (Rob Herring)
Date: Wed, 25 Nov 2015 16:46:27 -0600
Subject: [PATCH 2/3] i2c: at91: add DT property "atmel,twd-hold-cycles"
 to binding
In-Reply-To: <1448372862-11912-2-git-send-email-ludovic.desroches@atmel.com>
References: <1448372862-11912-1-git-send-email-ludovic.desroches@atmel.com>
 <1448372862-11912-2-git-send-email-ludovic.desroches@atmel.com>
Message-ID: <20151125224627.GA16821@rob-hp-laptop>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Nov 24, 2015 at 02:47:41PM +0100, Ludovic Desroches wrote:
> From: Wenyou Yang <wenyou.yang@atmel.com>
> 
> Add a DT property "atmel,twd-hold-cycles" to specify the HOLD
> filed of TWIHS_CWGR register to increase the TWD hold time.
> 
> Signed-off-by: Wenyou Yang <wenyou.yang@atmel.com>
> Signed-off-by: Ludovic Desroches <ludovic.desroches@atmel.com>

Acked-by: Rob Herring <robh@kernel.org>

> ---
>  Documentation/devicetree/bindings/i2c/i2c-at91.txt | 4 ++++
>  1 file changed, 4 insertions(+)
> 
> diff --git a/Documentation/devicetree/bindings/i2c/i2c-at91.txt b/Documentation/devicetree/bindings/i2c/i2c-at91.txt
> index 6e81dc1..c81a0cb 100644
> --- a/Documentation/devicetree/bindings/i2c/i2c-at91.txt
> +++ b/Documentation/devicetree/bindings/i2c/i2c-at91.txt
> @@ -17,6 +17,9 @@ Optional properties:
>  - dma-names: should contain "tx" and "rx".
>  - atmel,fifo-size: maximum number of data the RX and TX FIFOs can store for FIFO
>    capable I2C controllers.
> +- atmel,twd-hold-cycles: number of cycles for TWD hold time whose value is
> +  determinated by (atmel,twd-hold-cycles + 3) x t_peripheral_clock,
> +  maximum value is 0x1f.
>  - Child nodes conforming to i2c bus binding
>  
>  Examples :
> @@ -29,6 +32,7 @@ i2c0: i2c at fff84000 {
>  	#size-cells = <0>;
>  	clocks = <&twi0_clk>;
>  	clock-frequency = <400000>;
> +	atmel,twd-hold-cycles = <2>;
>  
>  	24c512 at 50 {
>  		compatible = "24c512";
> -- 
> 2.5.0
> 
> --
> To unsubscribe from this list: send the line "unsubscribe devicetree" in
> the body of a message to majordomo at vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
