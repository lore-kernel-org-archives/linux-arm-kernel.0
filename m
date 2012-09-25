From: plagnioj@jcrosoft.com (Jean-Christophe PLAGNIOL-VILLARD)
Date: Tue, 25 Sep 2012 10:10:57 +0200
Subject: [PATCH v3 1/2] watchdog: at91sam9_wdt: add device tree support
In-Reply-To: <1348558114-31750-2-git-send-email-fabio.porcedda@gmail.com>
References: <1348558114-31750-1-git-send-email-fabio.porcedda@gmail.com>
 <1348558114-31750-2-git-send-email-fabio.porcedda@gmail.com>
Message-ID: <20120925081057.GH17667@game.jcrosoft.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 09:28 Tue 25 Sep     , Fabio Porcedda wrote:
> Tested on an at91sam9260 board (evk-pro3)
> 
> Signed-off-by: Fabio Porcedda <fabio.porcedda@gmail.com>
> ---
>  .../devicetree/bindings/watchdog/atmel-wdt.txt      | 19 +++++++++++++++++++
>  drivers/watchdog/at91sam9_wdt.c                     | 21 +++++++++++++++++++++
>  2 files changed, 40 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/watchdog/atmel-wdt.txt
> 
> diff --git a/Documentation/devicetree/bindings/watchdog/atmel-wdt.txt b/Documentation/devicetree/bindings/watchdog/atmel-wdt.txt
> new file mode 100644
> index 0000000..724fad1
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/watchdog/atmel-wdt.txt
> @@ -0,0 +1,19 @@
> +* Atmel Watchdog Timers
> +
> +** at91sam9-wdt
> +
> +Required properties:
> +- compatible: must be "atmel,at91sam9-wdt".
> +- reg: physical base address of the controller and length of memory mapped
> +  region.
> +
> +Optional properties:
> +- heartbeat: contains the watchdog heartbeats in seconds.
> +
> +Example:
> +
> +	watchdog at fffffd40 {
> +		compatible = "atmel,at91sam9-wdt";
for the secind time atmel,at91sam9260-watchdog

you need to put the first soc that use it in the compatible
> +		reg = <0xfffffd40 0x10>;
> +		heartbeat = <10>;
need put second in the property name so need to read the doc

Best Regards,
J.
