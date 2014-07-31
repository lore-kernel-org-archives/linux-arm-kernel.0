From: afaerber@suse.de (=?UTF-8?B?QW5kcmVhcyBGw6RyYmVy?=)
Date: Thu, 31 Jul 2014 11:26:02 +0200
Subject: [PATCH v3 4/4] ARM: dts: Add exynos5250-spring device tree
In-Reply-To: <1406728244-5105-5-git-send-email-afaerber@suse.de>
References: <1406728244-5105-1-git-send-email-afaerber@suse.de>
 <1406728244-5105-5-git-send-email-afaerber@suse.de>
Message-ID: <53DA0BAA.8090000@suse.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Am 30.07.2014 15:50, schrieb Andreas F?rber:
> diff --git a/arch/arm/boot/dts/exynos5250-spring.dts b/arch/arm/boot/dts/exynos5250-spring.dts
> new file mode 100644
> index 000000000000..bcca892bf2ff
> --- /dev/null
> +++ b/arch/arm/boot/dts/exynos5250-spring.dts
[...]
> +&pinctrl_0 {
> +	dp_hpd_gpio: dp-hpd-gpio {
> +		samsung,pins = "gpc3-0";
> +		samsung,pin-function = <1>;

Not sure where this 1 came from... Both Ajay and my 3.8 DT have 0.

> +		samsung,pin-pud = <3>;
> +		samsung,pin-drv = <0>;
> +	};

Seeing that Ajay called this node dp-hdp, it should probably be an override?

&dp_hpd {
	...
};

Andreas

-- 
SUSE LINUX Products GmbH, Maxfeldstr. 5, 90409 N?rnberg, Germany
GF: Jeff Hawn, Jennifer Guild, Felix Imend?rffer; HRB 16746 AG N?rnberg
