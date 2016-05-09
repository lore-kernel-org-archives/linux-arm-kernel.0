From: robh@kernel.org (Rob Herring)
Date: Mon, 9 May 2016 15:38:31 -0500
Subject: [PATCH 1/2] doc/devicetree: Add Aspeed watchdog timer bindings
In-Reply-To: <1462797277-14969-2-git-send-email-joel@jms.id.au>
References: <1462797277-14969-1-git-send-email-joel@jms.id.au>
 <1462797277-14969-2-git-send-email-joel@jms.id.au>
Message-ID: <20160509203831.GA20352@rob-hp-laptop>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, May 09, 2016 at 10:04:36PM +0930, Joel Stanley wrote:
> Signed-off-by: Joel Stanley <joel@jms.id.au>
> ---
>  Documentation/devicetree/bindings/watchdog/aspeed-wdt.txt | 14 ++++++++++++++
>  1 file changed, 14 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/watchdog/aspeed-wdt.txt
> 
> diff --git a/Documentation/devicetree/bindings/watchdog/aspeed-wdt.txt b/Documentation/devicetree/bindings/watchdog/aspeed-wdt.txt
> new file mode 100644
> index 000000000000..58184b161e0d
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/watchdog/aspeed-wdt.txt
> @@ -0,0 +1,14 @@
> +Aspeed Watchdog Timer
> +
> +Required properties:
> + - compatible: must be "aspeed,wdt"

This should have the specific SOCs listed.

Rob

> + - reg: physical base address of the controller and length of memory mapped
> +   region
> +
> +Example:
> +
> +	wdt1: wdt at 1e785000 {

IIRC, "watchdog at ..." is the correct generic name.

> +		compatible = "aspeed,wdt";
> +		reg = <0x1e785000 0x1c>;
> +		interrupts = <27>;
> +	};
> -- 
> 2.8.1
> 
> --
> To unsubscribe from this list: send the line "unsubscribe devicetree" in
> the body of a message to majordomo at vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
