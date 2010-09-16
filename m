From: tony@atomide.com (Tony Lindgren)
Date: Thu, 16 Sep 2010 10:44:31 -0700
Subject: [PATCH v6 6/7] omap: zoom: add fixed regulator device for wlan
In-Reply-To: <1284593529-30100-1-git-send-email-ohad@wizery.com>
References: <1284593529-30100-1-git-send-email-ohad@wizery.com>
Message-ID: <20100916174431.GC29610@atomide.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

* Ohad Ben-Cohen <ohad@wizery.com> [100915 16:23]:
> Add a fixed regulator vmmc device to enable power control
> of the wl1271 wlan device.

<snip>

> +static struct fixed_voltage_config zoom_vwlan = {
> +	.supply_name = "vwl1271",
> +	.microvolts = 1800000, /* 1.8V */
> +	.gpio = OMAP_ZOOM_WLAN_PMENA_GPIO,
> +	.startup_delay = 70000, /* 70msec */
> +	.enable_high = 1,
> +	.enabled_at_boot = 0,
> +	.init_data = &zoom_vmmc3,
> +};

These are usually aligned with tabs before the = sign.

> +static struct platform_device omap_vwlan_device = {
> +	.name		= "reg-fixed-voltage",
> +	.id		= 1,
> +	.dev = {
> +		.platform_data = &zoom_vwlan,
> +	},
> +};

Like in this struct.

After that's fixed, here's my ack for these to go via the
wireless tree:

Acked-by: Tony Lindgren <tony@atomide.com>
