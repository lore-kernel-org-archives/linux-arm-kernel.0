From: swarren@nvidia.com (Stephen Warren)
Date: Fri, 15 Jul 2011 10:10:28 -0700
Subject: [PATCH 3/3] ARM: tegra: paz00: enable wifi led
In-Reply-To: <1310725464-2524-4-git-send-email-marvin24@gmx.de>
References: <1310725464-2524-1-git-send-email-marvin24@gmx.de>
	<1310725464-2524-4-git-send-email-marvin24@gmx.de>
Message-ID: <74CDBE0F657A3D45AFBB94109FB122FF049E834C43@HQMAIL01.nvidia.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Marc Dietrich wrote at Friday, July 15, 2011 4:24 AM:
> This adds support for the wifi led. It is automaticly triggered by
> the rfkill0 event.
...
> +static struct gpio_led gpio_leds[] = {
> +	{
> +		.name                   = "wifi-led",
> +		.default_trigger        = "rfkill0",
> +		.gpio                   = TEGRA_WIFI_LED,
> +	},
> +};

How does this work given that the previous patch simply exports the actual
GPIO to user-space, rather than registering it through an rfkill driver;
Does the WiFi driver itself register directly with the rfkill system? 

(what model of device is the AC100's WiFi? I assume it's on USB.)

-- 
nvpublic
