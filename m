From: nicolas.ferre@atmel.com (Nicolas Ferre)
Date: Tue, 23 Sep 2014 10:24:39 +0200
Subject: [PATCH v6 8/9] rtc: at91sam9: add DT bindings documentation
In-Reply-To: <1411400563-570-9-git-send-email-boris.brezillon@free-electrons.com>
References: <1411400563-570-1-git-send-email-boris.brezillon@free-electrons.com>
 <1411400563-570-9-git-send-email-boris.brezillon@free-electrons.com>
Message-ID: <54212E47.9070300@atmel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 22/09/2014 17:42, Boris BREZILLON :
> Signed-off-by: Boris BREZILLON <boris.brezillon@free-electrons.com>

Yes, it's good for me:
Acked-by: Nicolas Ferre <nicolas.ferre@atmel.com>

Thanks, bye,

> ---
>  .../devicetree/bindings/rtc/atmel,at91sam9-rtc.txt | 23 ++++++++++++++++++++++
>  1 file changed, 23 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/rtc/atmel,at91sam9-rtc.txt
> 
> diff --git a/Documentation/devicetree/bindings/rtc/atmel,at91sam9-rtc.txt b/Documentation/devicetree/bindings/rtc/atmel,at91sam9-rtc.txt
> new file mode 100644
> index 0000000..e94e2ee
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/rtc/atmel,at91sam9-rtc.txt
> @@ -0,0 +1,23 @@
> +Atmel AT91SAM9260 Real Time Timer
> +
> +Required properties:
> +- compatible: should be: "atmel,at91sam9260-rtt"
> +- reg: should encode the memory region of the RTT controller
> +- interrupts: rtt alarm/event interrupt
> +- clocks: should contain one clock pointing the the slow clk
> +- atmel,rtt-rtc-time-reg: should encode the GPBR register used to store
> +	the time base when the RTT is used as an RTC.
> +	The first cell should point to the GPBR node and the second one
> +	encode the offset within the GPBR block (or in other words, the
> +	GPBR register used to store the current time value).
> +
> +
> +Example:
> +
> +rtt at fffffe00 {
> +	compatible = "atmel,at91sam9260-rtt";
> +	reg = <0xfffffd20 0x10>;
> +	interrupts = <1 4 7>;
> +	clocks = <&clk32k>;
> +	atmel,rtt-rtc-time-reg = <&gpbr 0x0>;
> +};
> 


-- 
Nicolas Ferre
