From: linux@roeck-us.net (Guenter Roeck)
Date: Mon, 22 Apr 2013 06:44:08 -0700
Subject: [PATCH 09/23] watchdog: coh901327: devicetree support
In-Reply-To: <1366624505-6437-1-git-send-email-linus.walleij@stericsson.com>
References: <1366624505-6437-1-git-send-email-linus.walleij@stericsson.com>
Message-ID: <20130422134408.GA28711@roeck-us.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Apr 22, 2013 at 11:55:05AM +0200, Linus Walleij wrote:
> From: Linus Walleij <linus.walleij@linaro.org>
> 
> This adds support for probing the COH 901 327 watchdog from
> the device tree and also adds associated bindings.
> 
> Cc: Wim Van Sebroeck <wim@iguana.be>
> Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
> ---
> Hi Wim, I'm seeking an ACK on this patch to take it into
> ARM SoC along with the patches making use of this new
> binding.
> ---
>  .../devicetree/bindings/watchdog/stericsson-coh901327.txt | 15 +++++++++++++++
>  drivers/watchdog/coh901327_wdt.c                          |  6 ++++++
>  2 files changed, 21 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/watchdog/stericsson-coh901327.txt
> 
> diff --git a/Documentation/devicetree/bindings/watchdog/stericsson-coh901327.txt b/Documentation/devicetree/bindings/watchdog/stericsson-coh901327.txt
> new file mode 100644
> index 0000000..3d7c958
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/watchdog/stericsson-coh901327.txt
> @@ -0,0 +1,15 @@
> +ST-Ericsson COH 901 327 Watchdog timer
> +
> +Required properties:
> +- compatible: must be "stericsson,coh901327".
> +- reg: physical base address of the controller and length of memory mapped
> +  region.
> +- interrupts: the interrupt used for the watchdog timeout warning.
> +
> +Example:
> +
> +watchdog: watchdog at c0012000 {
> +	compatible = "stericsson,coh901327";
> +	reg = <0xc0012000 0x1000>;
> +	interrupts = <3>;
> +};

If you add a call to watchdog_init_timeout(), it would also support
setting the timeout through the timeout-sec property.

Guenter
