From: tony@atomide.com (Tony Lindgren)
Date: Thu, 17 Nov 2016 07:27:18 -0800
Subject: [PATCH -next] ARM: dts: omap5: replace gpio-key,wakeup with
 wakeup-source property
In-Reply-To: <1479138250-17780-1-git-send-email-sudeep.holla@arm.com>
References: <1479138250-17780-1-git-send-email-sudeep.holla@arm.com>
Message-ID: <20161117152717.GS4082@atomide.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

* Sudeep Holla <sudeep.holla@arm.com> [161114 07:44]:
> Though the keyboard driver for GPIO buttons(gpio-keys) will continue to
> check for/support the legacy "gpio-key,wakeup" boolean property to
> enable gpio buttons as wakeup source, "wakeup-source" is the new
> standard binding.
> 
> This patch replaces the legacy "gpio-key,wakeup" with the unified
> "wakeup-source" property in order to avoid any further copy-paste
> duplication.
> 
> Cc: "Beno?t Cousson" <bcousson@baylibre.com>
> Cc: Tony Lindgren <tony@atomide.com>
> Signed-off-by: Sudeep Holla <sudeep.holla@arm.com>
> ---
>  arch/arm/boot/dts/omap5-uevm.dts | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> Hi,
> 
> Inspite of getting rid of most of the legacy property almost a year ago,
> addition of new platforms have brought this back and over time it's
> now found again in few places. Just get rid of them *again*

Thanks for the annual check up :)

Acked-by: Tony Lindgren <tony@atomide.com>

Please let me know if you want me to pick this up instead.

> diff --git a/arch/arm/boot/dts/omap5-uevm.dts b/arch/arm/boot/dts/omap5-uevm.dts
> index 2fcdc516da45..a8c72611fbe3 100644
> --- a/arch/arm/boot/dts/omap5-uevm.dts
> +++ b/arch/arm/boot/dts/omap5-uevm.dts
> @@ -41,7 +41,7 @@
>  			label = "BTN1";
>  			linux,code = <169>;
>  			gpios = <&gpio3 19 GPIO_ACTIVE_LOW>;	/* gpio3_83 */
> -			gpio-key,wakeup;
> +			wakeup-source;
>  			autorepeat;
>  			debounce_interval = <50>;
>  		};
> --
> 2.7.4
> 
