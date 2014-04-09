From: s.nawrocki@samsung.com (Sylwester Nawrocki)
Date: Wed, 09 Apr 2014 14:11:34 +0200
Subject: [PATCH] phy: exynos5-usbdrd: Add facility to toggle vbus gpio
 on/off
In-Reply-To: <1397044485-26483-1-git-send-email-gautam.vivek@samsung.com>
References: <1397044485-26483-1-git-send-email-gautam.vivek@samsung.com>
Message-ID: <534538F6.2010009@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Vivek,

On 09/04/14 13:54, Vivek Gautam wrote:
> Adding support to enable/disable VBUS hooked to a gpio
> to enable vbus supply on the port.

Does the GPIO control a fixed voltage regulator ? If so, shouldn't
it be modelled by the regulator API instead ?

> Signed-off-by: Vivek Gautam <gautam.vivek@samsung.com>
[...]
> +	/* Get required GPIO for vbus */
> +	phy_drd->gpio = of_get_named_gpio(dev->of_node,
> +					  "samsung,vbus-gpio", 0);
> +	if (!gpio_is_valid(phy_drd->gpio))
> +		dev_dbg(dev, "no usbdrd-phy vbus gpio defined\n");
> +
> +	if (devm_gpio_request(dev, phy_drd->gpio, "phydrd_vbus_gpio"))
> +		dev_dbg(dev, "can't request usbdrd-phy vbus gpio %d\n",
> +			phy_drd->gpio);

--
Regards,
Sylwester
