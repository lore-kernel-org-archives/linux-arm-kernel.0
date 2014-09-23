From: jhovold@gmail.com (Johan Hovold)
Date: Tue, 23 Sep 2014 09:57:50 +0200
Subject: [PATCH v6 8/9] rtc: at91sam9: add DT bindings documentation
In-Reply-To: <1411400563-570-9-git-send-email-boris.brezillon@free-electrons.com>
References: <1411400563-570-1-git-send-email-boris.brezillon@free-electrons.com>
 <1411400563-570-9-git-send-email-boris.brezillon@free-electrons.com>
Message-ID: <20140923075750.GP5237@localhost>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Sep 22, 2014 at 05:42:42PM +0200, Boris BREZILLON wrote:
> Signed-off-by: Boris BREZILLON <boris.brezillon@free-electrons.com>
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

Just noticed: s/the the/to the/

> +- atmel,rtt-rtc-time-reg: should encode the GPBR register used to store
> +	the time base when the RTT is used as an RTC.
> +	The first cell should point to the GPBR node and the second one
> +	encode the offset within the GPBR block (or in other words, the
> +	GPBR register used to store the current time value).

s/current time value/time base/.

Looks good to me otherwise.

Thanks,
Johan
