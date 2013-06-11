From: grant.likely@linaro.org (Grant Likely)
Date: Tue, 11 Jun 2013 23:29:36 +0100
Subject: [RFC PATCH 2/4] watchdog: at91sam9_wdt: update device tree doc
In-Reply-To: <1370947890-954-3-git-send-email-b.brezillon@overkiz.com>
References: <1370947890-954-1-git-send-email-b.brezillon@overkiz.com>
 <1370947890-954-3-git-send-email-b.brezillon@overkiz.com>
Message-ID: <20130611222936.C23523E0D8D@localhost>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, 11 Jun 2013 12:51:27 +0200, Boris BREZILLON <b.brezillon@overkiz.com> wrote:
> Add new at91sam9 watchdog properties to the documentation.
> 
> Signed-off-by: Boris BREZILLON <b.brezillon@overkiz.com>

Looks reasonable,

Acked-by: Grant Likely <grant.likely@linaro.org>

> ---
>  .../devicetree/bindings/watchdog/atmel-wdt.txt     |   30 ++++++++++++++++++--
>  1 file changed, 28 insertions(+), 2 deletions(-)
> 
> diff --git a/Documentation/devicetree/bindings/watchdog/atmel-wdt.txt b/Documentation/devicetree/bindings/watchdog/atmel-wdt.txt
> index fcdd48f..e043106 100644
> --- a/Documentation/devicetree/bindings/watchdog/atmel-wdt.txt
> +++ b/Documentation/devicetree/bindings/watchdog/atmel-wdt.txt
> @@ -9,11 +9,37 @@ Required properties:
>  
>  Optional properties:
>  - timeout-sec: contains the watchdog timeout in seconds.
> +- interrupts : Should contain WDT interrupt.
> +- atmel,max-heartbeat-sec : Should contain the maximum heartbeat value in
> +	seconds. This value should be less than 16. It is used to compute the
> +	WDV field.
> +- atmel,max-heartbeat-sec : Should contain the minimum heartbeat value in
> +	seconds. This value should be less than 4 times the max-heartbeat-sec
> +	value. It is used to compute the WDD field.
> +- atmel,watchdog-type : Should be "hardware" or "software". Hardware watchdog
> +	use the at91 watchdog reset. Software watchdog use the watcdog interrup
> +	to trigger a software reset.
> +- atmel,reset-type : Should be "proc" or "all".
> +	"all" : assert peripherals and processor reset signals
> +	"proc" : assert the processor reset signal
> +	This is valid only when using "hardware" watchdog.
> +- atmel,disable : Should be present if you want to disable the watchdog.
> +- atmel,idle-halt : Should be present if you want to stop the watchdog when
> +	entering idle state.
> +- atmel,dbg-halt : Should be present if you want to stop the watchdog when
> +	entering debug state.
>  
>  Example:
> -
>  	watchdog at fffffd40 {
>  		compatible = "atmel,at91sam9260-wdt";
>  		reg = <0xfffffd40 0x10>;
> -		timeout-sec = <10>;
> +		interrupts = <1 IRQ_TYPE_LEVEL_HIGH 7>;
> +		timeout-sec = <15>;
> +		atmel,watchdog-type = "hardware";
> +		atmel,reset-type = "all";
> +		atmel,dbg-halt;
> +		atmel,idle-halt;
> +		atmel,max-heartbeat-sec = <16>;
> +		atmel,min-heartbeat-sec = <0>;
> +		status = "okay";
>  	};
> -- 
> 1.7.9.5
> 

-- 
Grant Likely, B.Sc, P.Eng.
Secret Lab Technologies, Ltd.
